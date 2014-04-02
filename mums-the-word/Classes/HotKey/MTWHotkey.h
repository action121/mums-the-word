//
//  MTWHotkey.h
//  mums-the-word
//
//  Created by Saad Ismail on 4/1/14.
//  Copyright (c) 2014 squarestaq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MASShortcut.h"

@interface MTWHotkey : NSObject
typedef NS_ENUM(NSUInteger, KeyOption)
{
    MenuItem_ControlKey = 59,
    MenuItem_OptionKey = 58,
    MenuItem_CommandKey = 55,
    MenuItem_CustomCombination = 100
};

+ (MTWHotkey *)sharedInstance;
+ (NSString *)getGlobalPreferenceShortcut;

@property (nonatomic) KeyOption selectedHotkey;

-(void)unregisterHotkey;
-(BOOL)registerHotkey: (MASShortcut *)shortcut;
@end
