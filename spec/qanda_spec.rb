require_relative "../qanda"

describe QandA do
  describe "#load?" do
    it "should return true when a word list is loaded" do
      File.should_receive(:new).with("spec/spec_words", "r")
      qanda = QandA.new
      expect(qanda.load?("spec/spec_words")).to eq(true)
    end
    it "should return false when passed in name is not found" do
      qanda = QandA.new
      expect(qanda.load?("spec/foo")).to eq(false)
    end
  end

  describe "#process" do
    it "should throw an error if a word list is not loaded" do
      qanda = QandA.new
      expect {qanda.process}.to raise_error
    end
  end

  describe "#generate_questions" do
    it "should create a file called questions" do
      File.should_receive(:open).with("questions", "w")
      qanda = QandA.new
      qanda.generate_questions
    end
  end

  describe "#generate_answers" do
    it "should create a file called answers" do
      File.should_receive(:open).with("answers", "w")
      qanda = QandA.new
      qanda.generate_answers
    end
  end

  context "with spec word list" do
    qanda = QandA.new
    qanda.load("spec/spec_words")
    qanda.process

    questions = qanda.questions
    context "questions" do
      it "should contain carr" do
        expect(questions.include?("carr")).to eq(true)
      end
      it "should contain give" do
        expect(questions.include?("give")).to eq(true)
      end
      it "should contain rots" do
        expect(questions.include?("rots")).to eq(true)
      end
      it "should contain rows" do
        expect(questions.include?("rows")).to eq(true)
      end
      it "should contain rrot" do
        expect(questions.include?("rrot")).to eq(true)
      end
      it "should contain rrow" do
        expect(questions.include?("rrow")).to eq(true)
      end
      it "should not contain arro" do
        expect(questions.include?("arro")).to eq(false)
      end
    end

    answers = qanda.answers
    context "answers" do
      it "should contain carrots three times" do
        expect(answers.count("carrots")).to eq(3)
      end
      it "should contain give" do
        expect(answers.include?("give")).to eq(true)
      end
      it "should contain arrows two times" do
        expect(answers.count("arrows")).to eq(2)
      end
    end

    context "ordering of generated lists" do
      it "should have rrow fragment and arrows word in the same position" do
        expect(questions.index("rrow")).to eq(answers.index("arrows"))
      end
      it "should have carr fragment and carrots word in the same position" do
        expect(questions.index("carr")).to eq(answers.index("carrots"))
      end
      it "should have give fragment and give word in the same position" do
        expect(questions.index("give")).to eq(answers.index("give"))
      end
    end

    context "#generate_questions" do
      qanda.generate_questions
      it "should generate a file with the same number of lines as questions" do
        file = File.new("questions", "r")
        expect(file.readlines.size).to eq(qanda.questions.size)
      end
    end

    context "#generate_answers" do
      qanda.generate_answers
      it "should generate a file with the same number of lines as answers" do
        file = File.new("answers", "r")
        expect(file.readlines.size).to eq(qanda.answers.size)
      end
    end
  end

  context "extra rules" do
    it "should ignore case of fragments if @ignore_case is true" do
      qanda = QandA.new
      qanda.load("spec/extra_words")
      qanda.ignore_case = true
      qanda.process
      expect(qanda.questions.include?("test")).to eq(false)
    end

    it "should skip fragments with ' if @skip_apos is true" do
      qanda = QandA.new
      qanda.load("spec/extra_words")
      qanda.skip_apos = true
      qanda.process
      expect(qanda.questions.include?("a'po")).to eq(false)
    end

    it "should skip fragments with numbers if @skip_num is true" do
      qanda = QandA.new
      qanda.load("spec/extra_words")
      qanda.skip_num = true
      qanda.process
      expect(qanda.questions.include?("123a")).to eq(false)
    end
  end
end