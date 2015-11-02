class RLMResults
  alias :first :firstObject
  alias :last :lastObject
  alias :where :objectsWhere

  def [](index)
    self.objectAtIndex(index)
  end

  def sort_by(property, opts={})
    ascending = if opts[:asc].nil?
      true
    else
      opts[:asc]
    end

    self.sortedResultsUsingProperty property, ascending: ascending
  end

  def to_a
    arr = []
    self.each do |object|
      arr << object
    end

    arr
  end
end