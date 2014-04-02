//
//  MTWMicControl.h
//  mums-the-word
//
//  Created by Saad Ismail on 4/1/14.
//  Copyright (c) 2014 squarestaq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTWMicControl : NSObject
+ (id)sharedInstance;
- (void)setInputVolume:(NSInteger)inputVolumeValue;
@end
