//
//  AECredits.m
//  Lobbyist Lookup
//
//  Created by Anson Liu on 6/30/14.
//  Copyright (c) 2014 Apparent Etch. All rights reserved.
//

#import "AECredits.h"

@implementation AECredits

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //[self setBackgroundColor:[UIColor redColor]];
        
        /*
        UIImageView *ndochLogo = [[UIImageView alloc] initWithFrame:CGRectMake(58, 15, 204, 37)];
        [ndochLogo setImage:[UIImage imageWithContentsOfFile:@"national-day-of-civic-hacking"]];
        
        [self addSubview:ndochLogo];
        [self setNeedsDisplay];
        [self setBackgroundColor:[UIColor redColor]];
         */
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
        
        title.text = [NSString stringWithFormat:@"Lobbyist Lookup v%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
        title.textAlignment = NSTextAlignmentCenter;
        title.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:title];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
