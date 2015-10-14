//
//  Message.h
//  
//
//  Created by 王辉平 on 15/6/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Message : NSManagedObject

@property (nonatomic, retain) NSString * msg;
@property (nonatomic, retain) NSString * time;

@end
