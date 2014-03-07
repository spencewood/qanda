require_relative "../qanda"

describe QandA do
  describe "#load" do
    it "should return true when a word list is loaded" do
      qanda = QandA.new
      expect(qanda.load("spec/words")).to eq(true)
    end
    it "should return false when passed in name is not found" do
      qanda = QandA.new
      expect(qanda.load("spec/foo")).to eq(false)
    end
  end

  describe "#process" do
    it "should throw an error if a word list is not loaded" do
      qanda = QandA.new
      expect {qanda.process}.to raise_error
    end
  end

  context "with word list" do
    qanda = QandA.new
    qanda.load("spec/words")
    qanda.process
    p qanda.questions
    p qanda.answers
  end
end