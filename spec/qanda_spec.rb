require_relative "../qanda"

describe QandA do
  describe "#load" do
    it "should be able to load the word list" do
      qanda = QandA.new
      qanda.load("spec/words")
    end
  end
end