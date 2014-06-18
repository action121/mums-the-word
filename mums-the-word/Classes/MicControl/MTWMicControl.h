//
//  MTWMicControl.h
//  mums-the-word
//
//  Created by Saad Ismail on 4/1/14.
//  Copyright (c) 2014 squarestaq. All rights reserved.
//

#import <Foundation/Foundation.h>

//http://apple.stackexchange.com/questions/66190/why-does-this-applescript-not-actually-set-the-input-volume-to-zero

@interface MTWMicControl : NSObject
+ (id)sharedInstance;
- (void)setInputVolume:(float)inputVolumeValue;

-(void)unmuteMic;
-(void)muteMic;
@end
