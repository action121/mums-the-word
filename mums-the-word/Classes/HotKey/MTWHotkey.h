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
    MenuItem_ControlKey = 0,
    MenuItem_OptionKey,
    MenuItem_CommandKey,
    MenuItem_CustomCombination
};

+ (MTWHotkey *)sharedInstance;
+ (NSString *)getGlobalPreferenceShortcut;

@property (nonatomic) KeyOption selectedHotkey;

-(void)unregisterHotkey;
-(BOOL)registerHotkey: (MASShortcut *)shortcut;
@end
