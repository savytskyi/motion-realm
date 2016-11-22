class RLMArray
  alias :first :firstObject
  alias :last  :lastObject
  def <<(object)
    self.addObject(object)
  end
end