//
//  ThirtyLivesModel.m
//  Chaplaincy
//
//  Created by Anas Faris on 2014-06-04.
//  Copyright (c) 2014 mcuoft. All rights reserved.
//

#import "ThirtyLivesModel.h"
#import "ThirtyLives.h"
#import "AFHTTPRequestOperation.h"

@implementation ThirtyLivesModel

- (NSMutableArray *)getThirtyItems {
    NSMutableArray *thirtyItemArray = [[NSMutableArray alloc] init];
    
    // Download the json file
    NSURL *jsonFileUrl = [NSURL URLWithString:@"http://sifoo.org/lives30.json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfURL:jsonFileUrl];
    
    //AFNetworking Method
    NSURL *url = [[NSURL alloc] initWithString:@"https://s3.amazonaws.com/mcuoft/programData.json"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"success: %@", operation.responseString);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@",  operation.responseString);
    }];
    
    [operation start];
    
    
    
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
        
        ThirtyLives *live = [[ThirtyLives alloc] init];
        live.name = jsonElement[@"livesName"];
        live.caption = jsonElement[@"livesCaption"];
        live.desc = jsonElement[@"livesStory"];
        live.imageName = jsonElement[@"livesPicture"];
        
        [thirtyItemArray addObject:live];
    }
    
    return thirtyItemArray;
    
}

@end
