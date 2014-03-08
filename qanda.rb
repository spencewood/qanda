class QandA
  attr_reader :word_dict

  def questions
    @word_dict.select{ |key,value| value.length == 1 }
      .keys
  end

  def answers
    @word_dict.select{ |key,value| value.length == 1 }
      .values
      .map{ |answer| answer.pop }
  end

  def load(file_name)
    @words_file = File.new(file_name, "r")
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
      while line.length >= 4
        add_word(line.slice(0, 4), orig)
        line.slice!(0)
      end
    end
  end

  private
  def add_word(key, orig)
    @word_dict[key] = [] unless @word_dict.has_key?(key)
    @word_dict[key].push(orig)
  end
end