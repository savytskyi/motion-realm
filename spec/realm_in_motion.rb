describe "MotionRealm" do
  before do
    RLMRealm.write do |realm|
      realm.delete_all
    end
  end

  it 'should be able to create objects with `create` method' do
    name = "John"
    parent = Parent.create name: name
    parent.name.should.be.equal name
  end

  it 'should be able to get first, last and count values' do
    RLMRealm.write do |realm|
      realm << Parent.create({name: "1"})
      realm << Parent.create({name: "2"})
    end
    Parent.count.should.be.equal(2)
    Parent.first.is_a?(Parent).should.be.equal(true)
    Parent.last.is_a?(Parent).should.be.equal(true)
  end

  # it 'should be able to assign default properies for an empty objects' do
  #   child1 = Child.new
  #   child1.likes_math = false
  #   child1.setLikes_math = false
  #   child2 = Child.create({likes_math: false})

  #   child1.likes_math.should.be.equal true
  #   child2.likes_math.should.be.equal false
  # end

  it 'should be able to set indexes' do
    Child.schema.properties_by_name["name"].indexed.should.be.equal(true)
    Child.schema.properties_by_name["favourite_number"].indexed.should.be.equal(true)
    Child.schema.properties_by_name["sex"].indexed.should.be.equal(false)
    Parent.schema.properties_by_name["name"].indexed.should.be.equal(false)
  end

  it 'should be able to set primary keys' do
    Child.schema.properties_by_name["name"].isPrimary.should.be.equal(true)
    Child.schema.properties_by_name["favourite_number"].isPrimary.should.be.equal(false)
    Child.schema.properties_by_name["sex"].isPrimary.should.be.equal(false)
    Parent.schema.properties_by_name["name"].isPrimary.should.be.equal(false)
  end

  it 'gets objects with `where` method' do
    RLMRealm.write do |realm|
      realm << Parent.create({name: "John", apps_in_appstore: 5})
      realm << Parent.create({name: "Mike", apps_in_appstore: 10})
    end

    result = Parent.where "apps_in_appstore > 5"
    result.count.should.be.equal(1)

    result = Parent.where "apps_in_appstore > 2"
    result.count.should.be.equal(2)
  end

  it 'can create a new or update existing object by primary key' do
    Child.count.should.be.equal(0)
    RLMRealm.write do |realm|
      realm << Child.create({name: "John", favourite_number: 10})
    end
    Child.count.should.be.equal(1)

    RLMRealm.write do |realm|
      child = Child.create({name: "John", favourite_number: 20})
      realm << Child.create_or_update(child)
    end

    Child.count.should.be.equal(1)
    Child.first.favourite_number.should.be.equal(20)
  end

  it 'can delete all objects for a given class' do
    RLMRealm.write do |realm|
      realm << Parent.new
      realm << Parent.new
      realm << Parent.new
    end

    Parent.count.should.be.equal(3)
    Parent.delete_all
    Parent.count.should.be.equal(0)
  end

  it 'can delete given object' do
    RLMRealm.write do |realm|
      realm << Parent.new
      realm << Parent.new
      realm << Parent.new
    end

    parent = Parent.last
    parent.delete
    Parent.count.should.be.equal(2)
  end
end
