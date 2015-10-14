//
//  User.h
//  
//
//  Created by 王辉平 on 15/6/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSNumber * userid;
@property (nonatomic, retain) NSString * sex;

@end
