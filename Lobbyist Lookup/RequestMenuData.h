//
//  RequestMenuData.h
//  Next Meal
//
//  Created by Anson Liu on 5/28/14.
//  Copyright (c) 2014 Apparent Etch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParseMenuJSON.h"
#import "Constants.h"

@interface RequestMenuData : NSObject <NSURLConnectionDelegate>
{
   
}

- (void)getData:(id)target withParams:(NSDictionary *)params;

@end
