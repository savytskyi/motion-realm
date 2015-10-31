describe "RLMRealm" do
  before do
    RLMRealm.write do |realm|
      realm.delete_all
    end
  end

  it "should be able to get default realm with default method" do
    RLMRealm.default.path.should.be.equal(RLMRealm.defaultRealm.path)
  end

  it "should be able to start and end writing with rubyfied methods" do
    Parent.all.count.should.be.equal 0
    p = Parent.new
    Parent.all.count.should.be.equal 0

    RLMRealm.default.start_writing
    RLMRealm.default << p
    RLMRealm.default.end_writing

    Parent.all.count.should.be.equal 1
  end

  it "should be able to remove all objects with `delete_all`" do
    Parent.all.count.should.be.equal 0

    RLMRealm.write do |realm|
      realm << Parent.new
    end

    Parent.all.count.should.be.equal 1

    RLMRealm.write do |realm|
      realm.delete_all
    end

    Parent.all.count.should.be.equal 0
  end

  it "should be able to end writing and return a result Hash" do
    Parent.all.count.should.be.equal 0
    p = Parent.new
    Parent.all.count.should.be.equal 0

    error_ptr = Pointer.new(:object)

    RLMRealm.default.start_writing
    RLMRealm.default << p
    saved = RLMRealm.default.end_writing(error_ptr)

    saved.should.be.equal true
    error_ptr[0].nil?.should.be.equal true
    Parent.all.count.should.be.equal 1
  end

  it "should be able to delete object with `delete` method" do
    Parent.all.count.should.be.equal 0
    parent = Parent.new

    RLMRealm.write do |realm|
      realm << parent
    end

    Parent.all.count.should.be.equal 1

    RLMRealm.write do |realm|
      realm.delete parent
    end

    Parent.all.count.should.be.equal 0
  end

  it "should be able to add and remove notification" do
    Parent.all.count.should.be.equal 0
    parent = Parent.new
    notification_called = 0
    @token = RLMRealm.default.add_notification do |notification, realm|
      notification_called += 1
    end

    RLMRealm.write do |realm|
      realm << parent
    end
    notification_called.should.be.equal 1

    RLMRealm.default.remove_notification @token

    RLMRealm.write do |realm|
      realm.delete parent
    end

    Parent.all.count.should.be.equal 0
    notification_called.should.be.equal 1
  end

  it "should be able to use << to add object to realm" do
    Parent.all.count.should.be.equal 0
    parent = Parent.new

    RLMRealm.write do |realm|
      realm << parent
    end

    Parent.all.count.should.be.equal 1
  end
end
