//
//  CoreDataUtil.h
//  CoreDataDemo
//
//  Created by 王辉平 on 15/6/16.
//  Copyright (c) 2015年 王辉平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface CoreDataUtil : NSObject
//被管理的对象模型  相当于实体，不过它包含 了实体间的关系
@property(nonatomic,strong,readonly)NSManagedObjectModel*managedObjectModel;

//持久化存储助理 相当于数据库的连接器
@property(nonatomic,strong,readonly)NSPersistentStoreCoordinator* persistentStoreCoordinator;

//被管理的对象上下文 操作实际内容
//作用：插入数据  查询  更新  删除
@property(nonatomic,strong,readonly)NSManagedObjectContext* managedObjectContext;

//插入数据 message
-(void)insertMessage;
//查询数据
-(void)selectMessageIsNotHaveInfo;
//删除数据
-(void)deleteMessage;
@end
