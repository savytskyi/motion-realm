describe "RLMRealmConfiguration" do
  it 'should be able to get default configuration' do
    path = RLMRealmConfiguration.defaultConfiguration.path
    RLMRealmConfiguration.default.path.should.be.equal path
  end

  it 'should be able to get and set schema versions' do
    conf = RLMRealmConfiguration.default
    conf.schema_version.class.name.should.be.equal Fixnum.name
  end

  # it 'should be able to migrate schamas' do

  # end
end
