//
//  ViewController.h
//  Dice
//
//  Created by Jonathan Bobrow on 11/29/14.
//  Copyright (c) 2014 Jonathan Bobrow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLModelView.h"

#import "RFduinoDelegate.h"
#import "RFduino.h"


@interface AppViewController : UIViewController < RFduinoDelegate >

@property (strong, nonatomic) IBOutlet GLModelView *modelView;
@property (strong, nonatomic) RFduino *rfduino;

@end

