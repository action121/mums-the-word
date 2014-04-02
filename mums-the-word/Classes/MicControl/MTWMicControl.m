//
//  MTWMicControl.m
//  mums-the-word
//
//  Created by Saad Ismail on 4/1/14.
//  Copyright (c) 2014 squarestaq. All rights reserved.
//

#import "MTWMicControl.h"
#import "ERInputVolumeControl.h"
#import <AVFoundation/AVFoundation.h>

@interface MTWMicControl()
{
    AVCaptureDevice *selectedAudioDevice;
}

@property (strong, nonatomic) ERInputVolumeControl *volumeController;
@property (strong, nonatomic) NSArray *audioDeviceList;
@property (strong, nonatomic) NSArray *audioDeviceListStrings;
@end

@implementation MTWMicControl
+ (id)sharedInstance {
    static MTWMicControl *sharedInnerInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInnerInstance = [[self alloc] init];
    });
    return sharedInnerInstance;
}

-(id)init
{
    if(self = [super init])
    {
        _volumeController = [[ERInputVolumeControl alloc] init];
        
        //GETS THE AUDIO DEVICES.
        _audioDeviceList = [AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio];
        
        //CREATES A PARALLEL ARRAY IN WHICH WE STORE THE LOCALIZED STRINGS (THE ONES WE SEND TO ERInputDeviceVolume)
        NSMutableArray *avdeviceArray = [NSMutableArray array];
        for(AVCaptureDevice *incDevice in _audioDeviceList){
            [avdeviceArray addObject:[incDevice localizedName]];
        }
        _audioDeviceListStrings = [NSArray arrayWithArray:avdeviceArray];
    }
    return self;
}

- (void)setInputVolume:(NSInteger)inputVolumeValue
{
    for(NSString *deviceStr in self.audioDeviceListStrings)
    {
        NSString *selectedInputAudioDeviceString = deviceStr;
        
        if(![self.volumeController selectInputDevice:selectedInputAudioDeviceString])
        {
            NSLog(@"Error - unable to select this audio device. Check what is being sent in debug.");
        }
        else
        {
            [self.volumeController setInputDeviceVolume:inputVolumeValue];
        }
    }
}
#pragma mark Private Helpers
@end
