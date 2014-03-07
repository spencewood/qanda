class QandA
  def load(file_name)
    @words = File.new(file_name, "r")
  end
end