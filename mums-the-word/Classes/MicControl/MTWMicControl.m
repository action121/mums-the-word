//
//  MTWMicControl.m
//  mums-the-word
//
//  Created by Saad Ismail on 4/1/14.
//  Copyright (c) 2014 squarestaq. All rights reserved.
//

#import "MTWMicControl.h"

@implementation MTWMicControl
+ (id)sharedInstance {
    static MTWMicControl *sharedInnerInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInnerInstance = [[self alloc] init];
    });
    return sharedInnerInstance;
}
@end
