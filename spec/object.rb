describe "RLMObject" do
  before do
    RLMRealm.write do |realm|
      realm.delete_all
    end
  end

  it "should be able to get schema" do
    Parent.schema.class.name.should.equal RLMObjectSchema.name
  end

  it 'should get all objects of a given class' do
    Parent.all.is_a?(RLMTableResults).should.be.equal(true)
  end

  it 'should be able to use predicates for searching' do
    RLMRealm.write do |realm|
      parent = Parent.create(name: "some cool name")
      realm << parent
    end

    predicate = NSPredicate.predicateWithFormat "name == %@", "some cool name"
    result = Parent.with_predicate predicate
    result.count.should.be.equal 1
  end

  it 'should be able to use `save` method on object' do
    Parent.all.count.should.be.equal 0
    parent = Parent.new
    Parent.all.count.should.be.equal 0
    parent.save
    Parent.all.count.should.be.equal 1
  end
end
