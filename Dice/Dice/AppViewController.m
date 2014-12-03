//
//  ViewController.m
//  Dice
//
//  Created by Jonathan Bobrow on 11/29/14.
//  Copyright (c) 2014 Jonathan Bobrow. All rights reserved.
//

#import "AppViewController.h"

// MACROS
#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)

// CONSTANTS
#define kAccelerometerFrequency		100.0 // Hz
#define kFilteringFactor			0.1

@interface AppViewController ()

@end


@implementation AppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // set rfduino delegate
    self.rfduino.delegate = self;
    
    //set model
    self.modelView.texture = nil;
    self.modelView.backgroundColor = [UIColor blackColor];
    self.modelView.blendColor = [UIColor whiteColor];   //colorWithRed:0.f green:.5f blue:1.f alpha:1.f];
    self.modelView.frame = self.view.frame;
    self.modelView.model = [GLModel modelWithContentsOfFile:@"dice_round.obj"];
    
    //set default transform
    CATransform3D transform = CATransform3DMakeTranslation(0.f, 0.f, -5.0f);
    transform = CATransform3DRotate(transform, (CGFloat)DEGREES_TO_RADIANS(0), 1.f, 0.f, 0.f); // rotate around x
    self.modelView.modelTransform = transform;
    transform = CATransform3DRotate(transform, (CGFloat)DEGREES_TO_RADIANS(0), 0.f, 1.f, 0.f); // rotate around y
    self.modelView.modelTransform = transform;


}

-(void)viewDidLayoutSubviews {
    self.modelView.frame = self.view.frame;
    self.modelView.center = self.view.center;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didReceive:(NSData *)data
{
//    NSLog(@"RecievedData");
    
    const uint8_t *value = [data bytes];
    
//    for(int i = 0; i < [data length]; i++ ) {
//        NSLog(@"value = %c", value[i]);
//    }
    
    NSInteger x_val = [[NSString stringWithFormat:@"%c", value[1]] intValue] * 100
                    + [[NSString stringWithFormat:@"%c", value[2]] intValue] * 10
                    + [[NSString stringWithFormat:@"%c", value[3]] intValue];

    NSInteger y_val = [[NSString stringWithFormat:@"%c", value[5]] intValue] * 100
                    + [[NSString stringWithFormat:@"%c", value[6]] intValue] * 10
                    + [[NSString stringWithFormat:@"%c", value[7]] intValue];

    NSInteger z_val = [[NSString stringWithFormat:@"%c", value[9]] intValue] * 100
                    + [[NSString stringWithFormat:@"%c", value[10]] intValue] * 10
                    + [[NSString stringWithFormat:@"%c", value[11]] intValue];

    [self updateDiceToOrientationWithX:x_val Y:y_val Z:z_val];
}

-(void)updateDiceToOrientationWithX:(NSInteger)x_degrees Y:(NSInteger)y_degrees Z:(NSInteger)z_degrees
{
    CGFloat x_rad = x_degrees * M_PI / 180.f;
    CGFloat y_rad = y_degrees * M_PI / 180.f;
    CGFloat z_rad = z_degrees * M_PI / 180.f;
    
    [UIView animateWithDuration:.2f
                     animations:^{
                         CATransform3D transform = CATransform3DMakeTranslation(0.f, 0.f, -5.0f);
                         transform = CATransform3DRotate(transform, x_rad, 1.f, 0.f, 0.f); // rotate around x
                         self.modelView.modelTransform = transform;
                         transform = CATransform3DRotate(transform, y_rad, 0.f, 1.f, 0.f); // rotate around y
                         self.modelView.modelTransform = transform;
                         transform = CATransform3DRotate(transform, z_rad, 0.f, 0.f, 1.f); // rotate around z
                         self.modelView.modelTransform = transform;
                     }];

}

@end
