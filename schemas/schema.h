#import <Realm/Realm.h>

@class Parent;

@interface Child : RLMObject

@property BOOL          likes_math;
@property NSInteger     favourite_number;
@property NSString     *name;
@property NSString     *sex;
@property NSDate       *birthday;

@property Parent *mother;
@property Parent *father;

@end

RLM_ARRAY_TYPE(Child)

@interface Parent : RLMObject

@property NSString     *job;
@property NSString     *name;
@property NSString     *sex;
@property NSDate       *birthday;
@property BOOL          likes_ruby;
@property NSInteger     apps_in_appstore;

@property RLMArray<Child *> <Child> *children;

@end