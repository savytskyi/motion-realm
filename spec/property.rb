describe "RLMProperty" do
  it "should have property class specifier methods" do
    properties = Parent.schema.properties_by_name
    properties["name"].string?.should.be.equal true
    properties["birthday"].date?.should.be.equal true
    properties["likes_ruby"].bool?.should.be.equal true
    properties["apps_in_appstore"].int?.should.be.equal true

    # all other properies:
    properties["name"].int?.should.be.equal false
    properties["name"].bool?.should.be.equal false
    properties["name"].float?.should.be.equal false
    properties["name"].double?.should.be.equal false
    properties["name"].number?.should.be.equal false
    properties["name"].data?.should.be.equal false
    properties["name"].mixed?.should.be.equal false
    properties["name"].date?.should.be.equal false
    properties["name"].object?.should.be.equal false
    properties["name"].array?.should.be.equal false
  end
end
