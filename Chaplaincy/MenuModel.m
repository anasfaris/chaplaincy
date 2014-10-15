//
//  MenuModel.m
//  Chaplaincy
//
//  Created by Anas Faris on 2014-06-02.
//  Copyright (c) 2014 mcuoft. All rights reserved.
//

#import "MenuModel.h"
#import "MenuItem.h"

@implementation MenuModel

- (NSArray *)getMenuItems {
    NSMutableArray *menuItemArray = [[NSMutableArray alloc] init];
    
    MenuItem *item1 = [[MenuItem alloc] init];
    item1.menuTitle = @"HOME";
    item1.menuIcon = @"IconHome";
    item1.screenType = ScreenTypeHome;
    [menuItemArray addObject:item1];
    
    MenuItem *item2 = [[MenuItem alloc] init];
    item2.menuTitle = @"COUNSELLING";
    item2.menuIcon = @"IconCounselling";
    item2.screenType = ScreenTypeCounselling;
    [menuItemArray addObject:item2];
    
    MenuItem *item3 = [[MenuItem alloc] init];
    item3.menuTitle = @"PROGRAMS";
    item3.menuIcon = @"IconPrograms";
    item3.screenType = ScreenTypePrograms;
    [menuItemArray addObject:item3];
    
    MenuItem *item4 = [[MenuItem alloc] init];
    item4.menuTitle = @"SERMONS";
    item4.menuIcon = @"IconSermons";
    item4.screenType = ScreenTypeSermons;
    [menuItemArray addObject:item4];
    
    MenuItem *item5 = [[MenuItem alloc] init];
    item5.menuTitle = @"30 LIVES";
    item5.menuIcon = @"Icon30Lives";
    item5.screenType = ScreenType30Lives;
    [menuItemArray addObject:item5];
    
    MenuItem *item6 = [[MenuItem alloc] init];
    item6.menuTitle = @"DONATE";
    item6.menuIcon = @"IconDonate";
    item6.screenType = ScreenTypeDonate;
    [menuItemArray addObject:item6];
    
    return menuItemArray;
    
}

@end
