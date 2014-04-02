//
//  AppDelegate.m
//  mums-the-word
//
//  Created by Saad Ismail on 3/28/14.
//  Copyright (c) 2014 squarestaq. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"
@interface AppDelegate()
@property (nonatomic,strong) IBOutlet MasterViewController *masterViewController;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // 1. Create the master View Controller
    self.masterViewController = [[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:nil];
    
    // 2. Add the view controller to the Window's content view
    [self.window.contentView addSubview:self.masterViewController.view];
    self.masterViewController.view.frame = ((NSView*)self.window.contentView).bounds;
}

@end
