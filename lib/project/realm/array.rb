class RLMArray
  alias :first :firstObject
  alias :last  :lastObject
  def <<(object)
    self.addObject(object)
  end

  def empty?
    count == 0
  end
end