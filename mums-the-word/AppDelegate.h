//
//  AppDelegate.h
//  mums-the-word
//
//  Created by Saad Ismail on 3/28/14.
//  Copyright (c) 2014 squarestaq. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSMenu *statusBarMenu;

@end
