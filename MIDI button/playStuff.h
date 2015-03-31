//
//  playStuff.h
//  MIDI button
//
//  Created by Michael Kelly on 27/03/2015.
//  Copyright (c) 2015 Michael Kelly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface playStuff : NSObject

@property (readwrite) AUGraph processingGraph;
@property (readwrite) AUNode samplerNode;
@property (readwrite) AUNode ioNode;
@property (readwrite) AudioUnit samplerUnit;
@property (readwrite) AudioUnit ioUnit;

- (void)playNoteOn:(UInt32)noteNum :(UInt32)velocity;
- (void)playNoteOff:(UInt32)noteNum;

OSStatus NewAUGraph ( AUGraph *outGraph );


@end
