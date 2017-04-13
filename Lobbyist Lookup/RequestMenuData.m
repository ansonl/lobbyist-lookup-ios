//
//  RequestMenuData.m
//  Next Meal
//
//  Created by Anson Liu on 5/28/14.
//  Copyright (c) 2014 Apparent Etch. All rights reserved.
//

#import "RequestMenuData.h"

@implementation RequestMenuData

-(NSString *)serializeParams:(NSDictionary *)params {
    NSMutableArray* pairs = [NSMutableArray array];
    for (NSString* key in [params keyEnumerator]) {
        id value = [params objectForKey:key];
        if ([value isKindOfClass:[NSDictionary class]]) {
            for (NSString *subKey in value) {
                NSString* escaped_value = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)[value objectForKey:subKey],NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));
                [pairs addObject:[NSString stringWithFormat:@"%@[%@]=%@", key, subKey, escaped_value]];
            }
        } else if ([value isKindOfClass:[NSArray class]]) {
            for (NSString *subValue in value) {
                NSString* escaped_value = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)subValue,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));
                [pairs addObject:[NSString stringWithFormat:@"%@[]=%@", key, escaped_value]];
            }
        } else {
            NSString* escaped_value = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)[params objectForKey:key],NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));
            [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, escaped_value]];
        }
    }
    return [pairs componentsJoinedByString:@"&"];
}

- (void)getData:(id)target withParams:(NSDictionary *)params {
    //NSLog(@"request %@", [NSString stringWithFormat:@"%@%@",sourceURL, [self serializeParams:params]]);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",sourceURL, [self serializeParams:params]]] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0];
    
    ParseMenuJSON *parse = [[ParseMenuJSON alloc] initWithTarget:target];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:parse];
    [connection start];
}

@end
