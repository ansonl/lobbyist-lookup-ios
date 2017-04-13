//
//  UIView+FindFirstResponder.m
//  Lobbyist Lookup
//
//  Created by Anson Liu on 6/19/14.
//  Copyright (c) 2014 Apparent Etch. All rights reserved.
//

#import "UIView+FindFirstResponder.h"

@implementation UIView (FindFirstResponder)

- (id)findFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        id responder = [subView findFirstResponder];
        if (responder) return responder;
    }
    return nil;
}

@end
