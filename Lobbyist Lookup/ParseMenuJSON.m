//
//  ParseMenuJSON.m
//  Next Meal
//
//  Created by Anson Liu on 5/28/14.
//  Copyright (c) 2014 Apparent Etch. All rights reserved.
//

#import "ParseMenuJSON.h"

@implementation ParseMenuJSON

#pragma mark - Custom init

- (ParseMenuJSON*)initWithTarget:(id)obj {
    self = [super init];
    if (self) {
        target = obj;
    }
    return self;
}

#pragma mark - NSURLConnectionDelegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //NSLog(@"connection success");
    
    NSError *error = nil;
    NSArray* responseArray = [[NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error] objectForKey:@"array"];
    
    responseArray = [self sortResultsByYear:[self stripArrayDuplicates:responseArray]];
    
    if (error) {
        NSLog(@"Error parsing data %@", [error localizedDescription]);
        if ([target respondsToSelector:@selector(dataFailed:)]) {
            NSString *errorPrompt = [NSString stringWithFormat:@"%@", [error localizedDescription]];
            [target performSelector:@selector(dataFailed:) withObject:errorPrompt];
            return;
        }
    }
    
    else {
        if ([target respondsToSelector:@selector(dataReady:)])
            [target performSelector:@selector(dataReady:) withObject:responseArray];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connetion failed with error: %@", [error localizedDescription]);
    if ([target respondsToSelector:@selector(dataFailed:)]) {
        NSString *errorPrompt = [NSString stringWithFormat:@"%@", [error localizedDescription]];
        [target performSelector:@selector(dataFailed:) withObject:errorPrompt];
    }
}

#pragma mark - Array Parsing

- (NSArray *)stripArrayDuplicates:(NSArray *)originalArray {
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithArray:originalArray];
    NSInteger index = [originalArray count] - 1;
    for (id object in [originalArray reverseObjectEnumerator]) {
        if ([mutableArray indexOfObject:object inRange:NSMakeRange(0, index)] != NSNotFound) {
            [mutableArray removeObjectAtIndex:index];
        }
        index--;
    }
    return (NSArray *)mutableArray;
}

- (NSArray *)sortResultsByYear:(NSArray *)originalArray {
    NSArray *sortedArray = [originalArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        //cehck if both objects are dictionaries and have an integerizable year key value
        if ([obj1 isKindOfClass:[NSDictionary class]] && [[obj1 objectForKey:reportYearKey] integerValue]) {
            if ([obj2 isKindOfClass:[NSDictionary class]] && [[obj2 objectForKey:reportYearKey] integerValue]) {
                NSInteger firstYear = [[obj1 objectForKey:reportYearKey] integerValue];
                NSInteger secondYear = [[obj2 objectForKey:reportYearKey] integerValue];
                
                //http://commandshift.co.uk/blog/2013/08/28/understanding-compare/ we do the opposite because we want the final order to be descending instead of final ascending!
                if (firstYear < secondYear)
                    return NSOrderedDescending;
                if (secondYear < firstYear)
                    return NSOrderedAscending;
                return NSOrderedSame;
            } else {
                return NSOrderedAscending;
            }
        } else {
            return NSOrderedDescending;
        }
    }];
    
    return sortedArray;
}

@end
