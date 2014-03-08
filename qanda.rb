class QandA
  FRAGMENT_SIZE = 4

  attr_accessor :ignore_case, :skip_apos, :skip_num

  def questions
    @word_dict.select{ |key,value| value.length == 1 }
      .keys
  end

  def answers
    @word_dict.select{ |key,value| value.length == 1 }
      .values
      .map{ |answer| answer.first }
  end

  def load(file_name)
    @words_file = File.new(file_name, "r")
  end

  def load?(file_name)
    load(file_name)
    true
  rescue
    false
  end

  def process
    raise "Words file not loaded" if @words_file == nil
    arr = []
    @word_dict = {}

    @words_file.each_line do |line|
      line.chomp!
      orig = line.clone
      while line.length >= FRAGMENT_SIZE
        add_word(line.slice(0, FRAGMENT_SIZE), orig)
        line.slice!(0)
      end
    end
  end

  def generate_questions
    File.open("questions", "w") do |f|
      f.puts(questions)
    end
  end

  def generate_answers
    File.open("answers", "w") do |f|
      f.puts(answers)
    end
  end

  private
  def add_word(key, orig)
    if @ignore_case
      key.downcase!
    end
    if @skip_apos and orig.include?("'")
      return
    end
    if @skip_num and orig =~ /\d/
      return
    end

    @word_dict[key] = [] unless @word_dict.has_key?(key)
    @word_dict[key].push(orig)
  end
end