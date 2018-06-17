require "ranran"

module Kotodama
  class Generator
    def initialize
      @zipf = 1
      @categories = {}
      @syllables = Ranran::Bucket.new
    end

    def zipf
      @zipf
    end

    def zipf= s
      @categories.each_pair do |category, bucket|
        bucket.zipf! s
      end
      @syllables.zipf! s
      @zipf = s
    end

    def categories
      @categories.keys
    end

    def add_category name, graphs
      raise TypeError, "Graphs are not enumerable" unless graphs.is_a? Enumerable
      @categories[name] = graphs.inject(Ranran::Bucket.new) do |bucket, graph|
        bucket.add graph, 1
      end
      @categories[name].zipf! @zipf
      self
    end

    def syllables
      @syllables.items.map {|n| n[0] }
    end

    def add_syllable pattern
      @syllables.add pattern, 1
      @syllables.zipf! @zipf
      self
    end

    def generate_syllable
      @syllables.choose.split('').map do |n|
        @categories.key?(n) ? @categories[n].choose : n
      end.join
    end

    def generate_word syls, del = ''
      syls.times.map { generate_syllable }.join del
    end
  end
end