//
//  ProgramModel.m
//  Chaplaincy
//
//  Created by Anas Faris on 2014-06-02.
//  Copyright (c) 2014 mcuoft. All rights reserved.
//

#import "ProgramModel.h"
#import "Program.h"

@implementation ProgramModel

- (NSMutableArray *)getProgramItems {
    NSMutableArray *programItemArray = [[NSMutableArray alloc] init];
    
    // Download the json file
    NSURL *jsonFileUrl = [NSURL URLWithString:@"http://sifoo.org/programData.json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfURL:jsonFileUrl];
    
    // Parse the json file
    NSError *error;
    NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    
    // Check if there's an error
    if (error != nil) {
        // There was an error, handle it gracefully
        NSLog(@"got some error");
    }
    
    // Loop through Json objects, create questions objects and add them to our questions array
    for (int i = 0; i < jsonObject.count; i++) {
        NSDictionary *jsonElement = jsonObject[i];
    
        Program *item1 = [[Program alloc] init];
        item1.title = jsonElement[@"programName"];
        item1.startingDate = jsonElement[@"programDate"];
        item1.dayAndTime = jsonElement[@"programDay"];
        item1.location = jsonElement[@"programLocation"];
        item1.desc = jsonElement[@"programDescription"];
        item1.img = jsonElement[@"programImage"];
        [programItemArray addObject:item1];
    }
    
    return programItemArray;
}

@end
