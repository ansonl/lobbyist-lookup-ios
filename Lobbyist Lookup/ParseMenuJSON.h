//
//  ParseMenuJSON.h
//  Next Meal
//
//  Created by Anson Liu on 5/28/14.
//  Copyright (c) 2014 Apparent Etch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AEViewController.h"
#import "Constants.h"

@interface ParseMenuJSON : NSObject <NSURLConnectionDelegate> {
    id target;
    
    NSMutableData* responseData;
}

- (ParseMenuJSON *)initWithTarget:(id)obj;

@end
