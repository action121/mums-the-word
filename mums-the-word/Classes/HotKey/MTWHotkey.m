//
//  MTWHotkey.m
//  mums-the-word
//
//  Created by Saad Ismail on 4/1/14.
//  Copyright (c) 2014 squarestaq. All rights reserved.
//

#import "MTWHotkey.h"
#import "MASShortcut+UserDefaults.h"
#import "MASShortcut+Monitoring.h"
#import "MTWMicControl.h"

@interface MTWHotkey()

//for monitoring global modifier keys
@property (nonatomic) id eventMonitor;
@property (nonatomic) NSInteger modifiersFlagsMask;

@end

@implementation MTWHotkey
#pragma mark Class Methods
+ (MTWHotkey *)sharedInstance {
    static MTWHotkey *sharedInnerInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInnerInstance = [[self alloc] init];
    });
    return sharedInnerInstance;
}

+(NSString *)getGlobalPreferenceShortcut
{
    static NSString *const kPreferenceGlobalShortcut = @"MTWGlobalShortcut";
    return kPreferenceGlobalShortcut;
}

#pragma mark Register MTWHotkey
/**
 Register to listen in to that hotkey. Shortcut is optional.
 
 @param shortcut If shortcut is passed, and custom combination is selected in selected hotkey then this hotkey will be registered.
 */
-(BOOL)registerHotkey: (MASShortcut *)shortcut
{
    switch(self.selectedHotkey)
    {
        case MenuItem_ControlKey:
        {
            self.modifiersFlagsMask = NSControlKeyMask;
            [self registerModifierKeys];
            break;
        }
        case MenuItem_CommandKey:
        {
            self.modifiersFlagsMask = NSCommandKeyMask;
            [self registerModifierKeys];
            break;
        }
        case MenuItem_OptionKey:
        {
            self.modifiersFlagsMask = NSAlternateKeyMask;
            [self registerModifierKeys];
            break;
        }
        case MenuItem_CustomCombination:
        {
            if(!shortcut)
                return NO;
            [self registerMASShortcut:shortcut];
            break;
        }
        default:
        {
            return NO;
            break;
        }
    }
    return YES;
}

-(void)unregisterHotkey
{
    [[MTWMicControl sharedInstance] unmuteMic];
    //[[MTWMicControl sharedInstance] setInputVolume:100];
    [self unregisterMASShortcut];
    [self unregisterModifierKeys];
}

#pragma mark Private - Register Shortcuts MAS
-(void)registerMASShortcut: (MASShortcut *)shortcut
{
    [MASShortcut setGlobalShortcut:shortcut forUserDefaultsKey:[MTWHotkey getGlobalPreferenceShortcut]];
    // Execute your block of code automatically when user triggers a shortcut from preferences
    [MASShortcut registerGlobalShortcutWithUserDefaultsKey:[MTWHotkey getGlobalPreferenceShortcut] handler:^{
        // Let me know if you find a better or more convenient API.
        NSLog(@"Shortcut Pressed");
    }];
}

-(void)unregisterMASShortcut
{
    [MASShortcut unregisterGlobalShortcutWithUserDefaultsKey:[MTWHotkey getGlobalPreferenceShortcut]];
}


#pragma mark Private - Register Modifier Keys
- (void)registerModifierKeys
{
    self.eventMonitor = [NSEvent addGlobalMonitorForEventsMatchingMask:NSFlagsChangedMask handler: ^(NSEvent *event) {
        NSLog(@"%ld was Pressed. Key Code: %hu", (long)self.modifiersFlagsMask, event.keyCode);
        NSUInteger flags = [event modifierFlags] & NSDeviceIndependentModifierFlagsMask;
        if(flags & self.modifiersFlagsMask){
            [[MTWMicControl sharedInstance] unmuteMic];
            //[[MTWMicControl sharedInstance] setInputVolume:100];
        }
        else if(event.keyCode == self.selectedHotkey)
        {
            [[MTWMicControl sharedInstance] muteMic];
            //[[MTWMicControl sharedInstance] setInputVolume:0];
        }
    }];
}

- (void)unregisterModifierKeys
{
    if(self.eventMonitor)
    {
        [NSEvent removeMonitor:self.eventMonitor];
        self.eventMonitor = nil;
    }
}

@end
