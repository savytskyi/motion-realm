describe "Realm Arrays" do
  before do
    RLMRealm.write do |realm|
      realm.delete_all
    end
  end

  it "creates new parent and adds a children to it" do
    child = Child.new
    parent = Parent.new
    parent.children.should.be.empty
    parent.children << child
    parent.children.should.not.be.empty

    RLMRealm.write do |realm|
      realm << parent
      realm << child
    end

    Parent.first.children.count.should == 1
  end
end
