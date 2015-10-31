class RLMRealm
  class << self
    alias :default :defaultRealm
  end

  alias :start_writing :beginWriteTransaction

  alias :delete_all :deleteAllObjects


  def end_writing(error_ptr=nil)
    self.commitWriteTransaction(error_ptr)
  end

  def delete(object)
    self.deleteObject(object)
  end

  def add_notification(&block)
    self.addNotificationBlock(block)
  end

  def remove_notification(token)
    self.removeNotification(token)
  end

  def self.write(&block)
    realm = RLMRealm.defaultRealm
    error_ptr = Pointer.new(:object)

    realm.start_writing
    block.call(realm)
    saved = realm.end_writing(error_ptr)

    { saved: saved, error: error_ptr[0] }
  end

  def <<(object)
    self.addObject(object)
  end
end