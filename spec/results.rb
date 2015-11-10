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

  it "can get max value" do
    max_value = Parent.all.max_property("apps_in_appstore")

    max = 0
    Parent.all.to_a.each do |parent|
      if max < parent.apps_in_appstore
        max = parent.apps_in_appstore
      end
    end

    max_value.should.be.equal(max)
  end

  it "can get min value" do
    min_value = Parent.all.min_property("apps_in_appstore")

    min = Parent.first.apps_in_appstore
    Parent.all.to_a.each do |parent|
      if min > parent.apps_in_appstore
        min = parent.apps_in_appstore
      end
    end

    min_value.should.be.equal(min)
  end

  it "can get avg value" do
    avg_value = Parent.all.avg_property("apps_in_appstore")

    total = 0
    Parent.all.to_a.each do |parent|
      total += parent.apps_in_appstore
    end


    (total.to_f / Parent.count).should.be.equal(avg_value)
  end

  it "can get sum value" do
    total_value = Parent.all.sum_property("apps_in_appstore")

    total = 0
    Parent.all.to_a.each do |parent|
      total += parent.apps_in_appstore
    end


    (total).should.be.equal(total_value)
  end

  it "can use empty? method" do
    Parent.all.empty?.should.be.equal(false)
    Child.all.empty?.should.be.equal(true)
  end
end
