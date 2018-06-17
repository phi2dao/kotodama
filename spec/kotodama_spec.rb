RSpec.describe Kotodama::Generator do
  before(:example) do
    @generator = Kotodama::Generator.new
  end

  it "has a default zipf value" do
    expect(@generator.zipf).to eql(1)
  end

  it "allows changing the zipf value" do
    @generator.zipf = 0.5

    expect(@generator.zipf).to eql(0.5)
  end

  context "categories" do
    it "is empty when first created" do
      expect(@generator.categories).to be_empty
    end

    it "allows categories to be added" do
      @generator.add_category 'C', []

      expect(@generator.categories).to_not be_empty
    end
  end

  context "syllables" do
    it "is empty when first created" do
      expect(@generator.syllables).to be_empty
    end

    it "allows syllables to be added" do
      @generator.add_syllable 'CV'

      expect(@generator.syllables).to_not be_empty
    end
  end

  context "generation" do
    before(:example) do
      @generator.add_category 'C', %w[p t k b d g]
      @generator.add_category 'V', %w[a e i o u]
      @generator.add_syllable 'CV'
    end

    it "generates syllables" do
      expect(@generator.generate_syllable).to_not be_nil
    end

    it "generates words" do
      expect(@generator.generate_word 2).to_not be_nil
    end
  end
end
