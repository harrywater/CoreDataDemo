//
//  ViewController.m
//  CoreDataDemo
//
//  Created by 王辉平 on 15/6/16.
//  Copyright (c) 2015年 王辉平. All rights reserved.
//

#import "ViewController.h"
#import "CoreDataUtil.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor redColor];
    CoreDataUtil* dataUtil=[[CoreDataUtil alloc]init];
//    [dataUtil insertMessage];
    
  //  [dataUtil deleteMessage];
    
    [dataUtil selectMessageIsNotHaveInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
