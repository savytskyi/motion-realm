describe "RLMObjectSchema" do
  it "should be able to get schema properties" do
    properties = Parent.schema.properties_by_name
    properties.class.name.should.be.equal Hash.name
    properties.should.include "name"
  end
end
