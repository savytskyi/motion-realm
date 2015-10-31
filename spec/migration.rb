# describe "RLMMigration" do
#   before do
#     RLMRealm.write do |realm|
#       realm.delete_all
#       realm << Parent.new
#     end
#   end

#   it "should enumberate over all objects" do
#     Parent.all.count.should == 1
#     iterations = 0

#     wait do
#       iterations.should == 1
#     end

#     RLMRealmConfiguration.migrate_to_version(3) do |migration, old_version|
#       migration.enumerate "Parent" do |old_object, new_object|
#         iterations += 1
#       end
#       resume
#     end
#   end
# end
