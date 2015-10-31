class RLMProperty

  # Primitives

  def int?
    type == RLMPropertyTypeInt
  end

  def bool?
    type == RLMPropertyTypeBool
  end

  def float?
    type == RLMPropertyTypeFloat
  end

  def double?
    type == RLMPropertyTypeDouble
  end

  def number?
    int? || float? || double?
  end

  # Objects

  def string?
    type == RLMPropertyTypeString
  end

  def data?
    type == RLMPropertyTypeData
  end

  def mixed?
    type == RLMPropertyTypeAny
  end

  def date?
    type == RLMPropertyTypeDate
  end

  # Arrays/Linked types

  def object?
    type == RLMPropertyTypeObject
  end

  def array?
    type == RLMPropertyTypeArray
  end

  def type_name
    if int?
      :int
    elsif bool?
      :bool
    elsif float?
      :float
    elsif double?
      :double
    elsif string?
      :string
    elsif data?
      :data
    elsif mixed?
      :mixed
    elsif date?
      :date
    elsif object?
      :object
    elsif array?
      :array
    else
      nil
    end
  end
end