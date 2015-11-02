describe "RLMResults" do
  it "can get first and last objects" do
    RLMRealm.write do |realm|
      realm.delete_all
      realm << Parent.create({name: "John", apps_in_appstore: 1})
      realm << Parent.create({name: "Jack", apps_in_appstore: 2})
      realm << Parent.create({name: "Joe", apps_in_appstore: 3})
    end

    parents = Parent.all
    parents.first.is_a?(Parent).should.be.equal(true)
    parents.last.is_a?(Parent).should.be.equal(true)
  end

  it "can get use `where` method" do
    all = Parent.all
    result = all.where("apps_in_appstore >= 3")
    result.count.should.be.equal(1)
  end

  it "can get an object by a given index" do
    parents = Parent.all
    parents[0].is_a?(Parent).should.be.equal(true)
    parents[1].is_a?(Parent).should.be.equal(true)
    parents[2].is_a?(Parent).should.be.equal(true)
    # parents[3].should.raise(NSException)
  end

  it "can sort objects by given property" do
    parents = Parent.all
    result = parents.sort_by :apps_in_appstore
    correct = result.first.apps_in_appstore < result.last.apps_in_appstore
    correct.should.be.equal(true)
  end

  it "can be converted to array" do
    parents = Parent.all.to_a
    parents.is_a?(Array).should.be.equal(true)
    parents.count.should.be.equal(Parent.count)
  end
end
