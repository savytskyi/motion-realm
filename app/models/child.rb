class Child
  include MotionRealm

  def self.default_values
    {
      likes_math: true,
    }
  end

  def self.indexes
    ["name", "favourite_number"]
  end

  def self.primary_key
    "name"
  end
end