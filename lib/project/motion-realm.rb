module MotionRealm
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def create(opts={})
      # # Does not work correct in current version of RM or Realm:
      # self.alloc.initWithValue opts

      # object = self.new
      object = self.alloc.init
      opts.each do |key, value|
        method_name = "set" + key.to_s.capitalize
        method_name = key.to_s + "="

        # object.performSelector method_name, withObject: value
        object.send(method_name, value)
      end

      object

    end

    def count
      all.count
    end

    def first
      all.first
    end

    def last
      all.last
    end

    # def defaultPropertyValues
    #   # set all properties to nil
    #   values = {}

    #   self.schema.properties_by_name.each do |name, property|
    #     mp "Name: #{name}/#{name.name}/#{name.type}; property: #{property}"
    #     values[name] = if default_values[name]
    #       default_values[name]
    #     elsif property.nil?
    #       nil
    #     elsif property.bool?
    #       false
    #     elsif property.number? || property.mixed?
    #       0
    #     elsif property.array?
    #       []
    #     else
    #       nil
    #     end
    #   end

    #   values
    # end

    # def default_values
    #   {}
    # end

    def indexedProperties
      indexes
    end

    def indexes
      []
    end

    def primaryKey
      primary_key
    end

    def primary_key
      nil
    end

    def where(query)
      self.objectsWhere(query)
    end

    def create_or_update(object, realm=nil)
      if realm.nil?
        realm = RLMRealm.default
      end

      self.createOrUpdateInRealm realm, withValue: object
    end

    def delete_all
      RLMRealm.write do |realm|
        self.all.each { |object| realm.delete(object) }
      end
    end
  end

  def delete
    RLMRealm.write do |realm|
      realm.delete(self)
    end
  end
end