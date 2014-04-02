    //
//  MasterViewController.m
//  mums-the-word
//
//  Created by Saad Ismail on 3/29/14.
//  Copyright (c) 2014 squarestaq. All rights reserved.
//

#import "MasterViewController.h"
#import "AppDelegate.h"
#import "MASShortcut.h"
#import "MASShortcutView.h"
#import "MASShortcutView+UserDefaults.h"
#import "MASShortcut+UserDefaults.h"
#import "MASShortcut+Monitoring.h"

#define OptionsList_SelectShortcutKey "Select Shortcut Key"
#define OptionsList_ControlKey "Control Key"
#define OptionsList_OptionKey "Options Key"
#define OptionsList_CommandKey "Command Key"
#define OptionsList_CustomCombination "Custom Combination"

@interface MasterViewController ()
{
    NSStatusItem * statusItem;
    BOOL mtwEnabled;
    
    //for monitoring global keys
    id eventMonitor;
    
    NSArray *menuItems;
}
@property (weak) IBOutlet NSTextField *labelStatus;
@property (weak) IBOutlet NSButton *buttonEnable;
@property (weak) IBOutlet NSPopUpButton *optionsList;
@property (nonatomic, weak) IBOutlet MASShortcutView *shortcutView;
@end

@implementation MasterViewController
// Think up a preference key to store a global shortcut between launches
NSString *const kPreferenceGlobalShortcut = @"MTWGlobalShortcut";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        // Assign the preference key and the shortcut view will take care of persistence
        self.shortcutView.associatedUserDefaultsKey = kPreferenceGlobalShortcut;
        mtwEnabled = NO;
        menuItems = @[@OptionsList_SelectShortcutKey, @OptionsList_ControlKey, @OptionsList_OptionKey, @OptionsList_CommandKey, @OptionsList_CustomCombination];
    }
    return self;
}

- (void)awakeFromNib
{
    AppDelegate *delegate = (AppDelegate *)[NSApplication sharedApplication].delegate;
    
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:delegate.statusBarMenu];
    [statusItem setTitle:@"MTW"];
    [statusItem setHighlightMode:YES];
    
    [self.labelStatus setStringValue:@"Status: MTW is disabled."];
    
    [self.optionsList addItemsWithTitles:menuItems];
    [[self.optionsList menu] setDelegate:self];
    
    [self.shortcutView setHidden:YES];
}

- (IBAction)toggleMTWAction:(id)sender
{
    mtwEnabled = !mtwEnabled;
    if(mtwEnabled)
    {
        [self.labelStatus setStringValue:@"Status: MTW is enabled."];
        [self.buttonEnable setTitle:@"Disable"];
        [self registerGlobalHotKey];
    }
    else
    {
        [self.labelStatus setStringValue:@"Status: MTW is disabled."];
        [self.buttonEnable setTitle:@"Enable"];
        [self unregisterGlobalHotkey];
    }
}

- (void)registerGlobalHotKey
{
    eventMonitor = [NSEvent addGlobalMonitorForEventsMatchingMask:NSFlagsChangedMask handler: ^(NSEvent *event) {
        NSUInteger flags = [event modifierFlags] & NSDeviceIndependentModifierFlagsMask;
        if(flags == NSControlKeyMask){
            NSLog(@"Control Key Pressed!");
        }
    }];
}

- (void)unregisterGlobalHotkey
{
    [NSEvent removeMonitor:eventMonitor];
    eventMonitor = nil;
}

- (IBAction)toggleMicAction:(id)sender {
    NSInteger micEnabled = ((NSButton *)sender).state;
    if(micEnabled)
    {
        [MASShortcut setGlobalShortcut:self.shortcutView.shortcutValue forUserDefaultsKey:kPreferenceGlobalShortcut];
        // Execute your block of code automatically when user triggers a shortcut from preferences
        [MASShortcut registerGlobalShortcutWithUserDefaultsKey:kPreferenceGlobalShortcut handler:^{
            // Let me know if you find a better or more convenient API.
            NSLog(@"Shortcut Pressed");
        }];
        
    }
    else
    {
        [MASShortcut unregisterGlobalShortcutWithUserDefaultsKey:kPreferenceGlobalShortcut];
    }
}

#pragma mark NSMenu Actions
- (IBAction)shortcutOptionsAction:(NSPopUpButton *)sender {
    NSLog(@"Selected Item: %@", sender.selectedItem.title);
    NSString *selectedItemTitle = sender.selectedItem.title;
    
    if([selectedItemTitle isEqualToString:@OptionsList_ControlKey])
    {
        [self.shortcutView setHidden:YES];
    }
    else if([selectedItemTitle isEqualToString:@OptionsList_OptionKey])
    {
        [self.shortcutView setHidden:YES];
    }
    else if([selectedItemTitle isEqualToString:@OptionsList_CommandKey])
    {
        [self.shortcutView setHidden:YES];
    }
    else if([selectedItemTitle isEqualToString:@OptionsList_CustomCombination])
    {
        [self.shortcutView setHidden:NO];
    }
    else if([selectedItemTitle isEqualToString:@OptionsList_SelectShortcutKey])
    {
        [self.shortcutView setHidden:YES];
    }
}

@end
