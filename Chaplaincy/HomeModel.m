//
//  HomeModel.m
//  Chaplaincy
//
//  Created by Anas Faris on 2014-06-03.
//  Copyright (c) 2014 mcuoft. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

-(NSArray *)getHomeItems {
    NSMutableArray *homeItemArray = [[NSMutableArray alloc] init];
    
    HomeItem *item1 = [[HomeItem alloc] init];
    item1.title = @"KNOWING THE ONE";
    item1.secondaryTitle = @"Shaykh Ramzy Ajem";
    item1.imageName = @"ImageHome1";
    [homeItemArray addObject:item1];
    
    HomeItem *item2 = [[HomeItem alloc] init];
    item2.title = @"SOULFOOD";
    item2.secondaryTitle = @"If You Really Knew Me";
    item2.imageName = @"ImageHome2";
    [homeItemArray addObject:item2];
    
    HomeItem *item3 = [[HomeItem alloc] init];
    item3.title = @"FRIDAY SERMON";
    item3.secondaryTitle = @"Lessons from Ta'if";
    item3.imageName = @"ImageHome3";
    [homeItemArray addObject:item3];
    
    HomeItem *item4 = [[HomeItem alloc] init];
    item4.title = @"UNMOSQUED SCREENING";
    item4.imageName = @"ImageHome4";
    [homeItemArray addObject:item4];
    
    HomeItem *item5 = [[HomeItem alloc] init];
    item5.title = @"KNOWING WHAT IS KNOWING";
    item5.secondaryTitle = @"Shaykh Ramzy Ajem";
    item5.imageName = @"ImageHome5";
    [homeItemArray addObject:item5];
    
    return homeItemArray;
}

@end
