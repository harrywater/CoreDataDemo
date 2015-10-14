//
//  CoreDataUtil.m
//  CoreDataDemo
//
//  Created by 王辉平 on 15/6/16.
//  Copyright (c) 2015年 王辉平. All rights reserved.
//

#import "CoreDataUtil.h"
#import "Message.h"

@implementation CoreDataUtil
@synthesize managedObjectContext=_managedObjectContext;
@synthesize managedObjectModel=_managedObjectModel;
@synthesize persistentStoreCoordinator=_persistentStoreCoordinator;
//==========step 1========
//托管对象
-(NSManagedObjectModel*)managedObjectModel{
    if (_managedObjectModel!=nil) {
        return  _managedObjectModel;
    }
    NSURL* modelURL=[[NSBundle mainBundle] URLForResource:@"CoreDataModel" withExtension:@"momd"];
    _managedObjectModel=[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}
//===========step 2=========
//持久化存储协调器 相当于数据库的连接器
-(NSPersistentStoreCoordinator*)persistentStoreCoordinator{
    if (_persistentStoreCoordinator!=nil) {
        return _persistentStoreCoordinator;
    }
    NSString* docs=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSURL* storeURL=[NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"CoreDataModel.sqlite"]];
    NSLog(@"path is %@",storeURL);
    NSError* error=nil;
    _persistentStoreCoordinator=[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }
    return _persistentStoreCoordinator;
}
//============step 3============
//创建上下文
-(NSManagedObjectContext*)managedObjectContext{
    if (_managedObjectContext!=nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator* coordinator=[self persistentStoreCoordinator];
    if (coordinator!=nil) {
        _managedObjectContext=[[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

//插入数据 message
-(void)insertMessage{

    Message* msg=[NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:self.managedObjectContext];
    [msg setMsg:@"你好121 coreData"];
    [msg setTime:@"2015-06-16 19:00"];
    //保存
    NSError* error=nil;
    BOOL isSave=[self.managedObjectContext save:&error];
    if (isSave) {
        NSLog(@"save success");
    }else{
        NSLog(@"error=%@  errorInfo=%@",error,[error userInfo]);
    }
}
//查询数据
-(void)selectMessageIsNotHaveInfo{

    //创建取回数据请求
    NSFetchRequest* fetchRequest=[[NSFetchRequest alloc]init];
    //设置要检索哪种类型的实体对象
    NSEntityDescription* entity=[NSEntityDescription entityForName:@"Message" inManagedObjectContext:self.managedObjectContext];
    //设置请求实体
    [fetchRequest setEntity:entity];
    //指定对结果的排序方式 对msg
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"msg"ascending:NO];
//    NSArray *sortDescriptions = [[NSArray alloc]initWithObjects:sortDescriptor, nil];
//    [fetchRequest setSortDescriptors:sortDescriptions];
    //执行获取数据请求，返回数组
    NSError *error = nil;
    NSMutableArray *mutableFetchResult = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];
    if (mutableFetchResult == nil) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }
    NSArray* resultArray = mutableFetchResult;
    for (Message *message in resultArray) {
        NSLog(@"msg:%@---time:%@-",message.msg,message.time);
    }
}
//删除数据
-(void)deleteMessage{
    //要找出上下文中操作的一张表
    NSFetchRequest *FectchRequest=[NSFetchRequest fetchRequestWithEntityName:@"Message"];
    FectchRequest.predicate=[NSPredicate predicateWithFormat:@"msg ='你好121 coreData'"];
    NSArray *arr=[self.managedObjectContext executeFetchRequest:FectchRequest error:nil];
    NSLog(@"ARR==%@  \n  arr count=%ld",arr,[arr count]);
    for (NSManagedObject *obj in arr) {
        [self.managedObjectContext deleteObject:obj];
    }
    //一定要   同步数据库
    [self.managedObjectContext save:nil];
}
@end
