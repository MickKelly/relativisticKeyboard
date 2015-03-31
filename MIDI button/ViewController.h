//
//  ViewController.h
//  MIDI button
//
//  Created by Michael Kelly on 27/03/2015.
//  Copyright (c) 2015 Michael Kelly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "butPressMe.h"
#include <AudioToolbox/AudioToolbox.h> //for AUGraph

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet butPressMe *aName;

@end

