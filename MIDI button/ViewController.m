//
//  ViewController.m
//  MIDI button
//
//  Created by Michael Kelly on 27/03/2015.
//  Copyright (c) 2015 Michael Kelly. All rights reserved.
//

#import "ViewController.h"
@import AudioToolbox;
#import "playStuff.h"

@interface ViewController ()

@end

@implementation ViewController



- (IBAction)aName:(id)sender {
    // not quite sure what to do - can I log this?
    printf("\nButton Pressed now");
//    playNoteOn(0x90);
    sleep(10);
 //   playNoteOff(0x90);
        printf("\nButton Pressed exit");
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
