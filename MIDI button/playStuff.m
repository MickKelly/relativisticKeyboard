//
//  playStuff.m
//  MIDI button
//
//  Created by Michael Kelly on 27/03/2015.
//  Copyright (c) 2015 Michael Kelly. All rights reserved.
//

#import "playStuff.h"

@implementation playStuff

@synthesize processingGraph = _processingGraph;

- (BOOL) createAUGraph
{
    // Create a sampler (cd)

    AudioComponentDescription cd;
    cd.componentType = kAudioUnitType_MusicDevice;
    cd.componentSubType = kAudioUnitSubType_Sampler;
    cd.componentManufacturer = kAudioUnitManufacturer_Apple;
    cd.componentFlags = 0;
    cd.componentFlagsMask = 0;
    CheckError(AUGraphAddNode(self.processingGraph, &cd, &_samplerNode), "AUGraphAddNode");
    
    // Create the I/O unit (iOUnitDescription)
    
    AudioComponentDescription iOUnitDescription;
    iOUnitDescription.componentType          = kAudioUnitType_Output;
    iOUnitDescription.componentSubType       = kAudioUnitSubType_RemoteIO;
    iOUnitDescription.componentManufacturer  = kAudioUnitManufacturer_Apple;
    iOUnitDescription.componentFlags         = 0;
    iOUnitDescription.componentFlagsMask     = 0;
    CheckError(AUGraphAddNode(self.processingGraph, &iOUnitDescription, &_ioNode), "AUGraphAddNode");
    
    
    // instantiate the audio unit
    
    CheckError(AUGraphOpen(self.processingGraph), "AUGraphOpen");  // open the AU Graph
    CheckError(AUGraphNodeInfo(self.processingGraph, self.samplerNode, NULL, &_samplerUnit),
               "AUGraphNodeInfo");
    CheckError(AUGraphNodeInfo(self.processingGraph, self.ioNode, NULL, &_ioUnit),
               "AUGraphNodeInfo");
    
    // connect the nodes together
    
    AudioUnitElement ioUnitOutputElement = 0;
    AudioUnitElement samplerOutputElement = 0;
    CheckError(AUGraphConnectNodeInput(self.processingGraph,
                                       self.samplerNode, samplerOutputElement, // srcnode, inSourceOutputNumber
                                       self.ioNode, ioUnitOutputElement), // destnode, inDestInputNumber
               "AUGraphConnectNodeInput");
    
    return YES;
}


- (void) startGraph
{
    if (self.processingGraph) {
        Boolean outIsInitialized;
        CheckError(AUGraphIsInitialized(self.processingGraph,
                                        &outIsInitialized), "AUGraphIsInitialized");
        if(!outIsInitialized)
            CheckError(AUGraphInitialize(self.processingGraph), "AUGraphInitialize");
        
        Boolean isRunning;
        CheckError(AUGraphIsRunning(self.processingGraph,
                                    &isRunning), "AUGraphIsRunning");
        if(!isRunning)
            CheckError(AUGraphStart(self.processingGraph), "AUGraphStart");
   //     self.playing = YES;
    }
}


- (void)playNoteOn:(UInt32)noteNum :(UInt32)velocity
{
    UInt32 noteCommand = 0x90;
    NSLog(@"playNoteOn %lu %lu cmd %lx", noteNum, velocity, noteCommand);
    CheckError(MusicDeviceMIDIEvent(self.samplerUnit, noteCommand, noteNum, velocity, 0), "NoteOn");
}

- (void)playNoteOff:(UInt32)noteNum
{
    UInt32 noteCommand = 0x80;
    CheckError(MusicDeviceMIDIEvent(self.samplerUnit, noteCommand, noteNum, 0, 0), "NoteOff");
}


void CheckError(OSStatus error, const char *operation)
{
 	if (error == noErr) return;
    // this handles any errors we may find. For me, just print it...
    printf("\nError %d, (int)error)");
}
@end
