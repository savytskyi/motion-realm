class RLMMigration
  def enumerate(class_name, &block)
    # block should accept two variables: old_object and new_object
    self.enumerateObjects class_name, block: block
  end
end