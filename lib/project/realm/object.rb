class RLMObject
  class << self
    alias :schema :sharedSchema
    alias :all :allObjects
  end

  def self.with_predicate(predicate)
    self.objectsWithPredicate(predicate)
  end

  def save
    RLMRealm.write do |realm|
      realm << self
    end
  end
end