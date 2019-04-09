//
//  ViewController.m
//  HW 26 Controls superman
//
//  Created by Kirill Fedorov on 08/04/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (assign, nonatomic) BOOL isHeroIncrease;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.heroImageView.image = [UIImage imageNamed:@"Tanya"];
}

- (IBAction)changeHeroSegmentedControler:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.heroImageView.image = [UIImage imageNamed:@"Tanya"];
            break;
        case 1:
            self.heroImageView.image = [UIImage imageNamed:@"Kitana"];
            break;
        case 2:
            self.heroImageView.image = [UIImage imageNamed:@"Jade"];
            break;
        default:
            break;
    }
}

- (IBAction)rotationSwitch:(UISwitch *)sender {
    if (sender.isOn) {
        [UIView animateWithDuration:self.speedSlider.value
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.heroImageView.transform = CGAffineTransformRotate(self.heroImageView.transform, M_PI_4);
                         } completion:^(BOOL finished) {
                             [self rotationSwitch:sender];
                         }];
    }
}

- (IBAction)scaleSwitch:(UISwitch *)sender {
    self.isHeroIncrease = self.isHeroIncrease ? false : true;

    if (sender.isOn) {
        [UIView animateWithDuration:self.speedSlider.value
                              delay:0
                            options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             self.heroImageView.transform = CGAffineTransformScale(self.heroImageView.transform,
                                                                              self.isHeroIncrease == true ? 2 : 0.5,
                                                                              self.isHeroIncrease == true ? 2 : 0.5);
                         } completion:^(BOOL finished) {
                             [self scaleSwitch:sender];
                         }];
    }
}

- (IBAction)translationSwitch:(UISwitch *)sender {
    if (sender.isOn) {
        int lowerBoundX = CGRectGetWidth(self.heroImageView.bounds) / 2;
        int lowerBoundY = CGRectGetHeight(self.heroImageView.bounds) / 2;

        int upperBoundX = CGRectGetMaxX(self.screenImageView.bounds) - lowerBoundX;
        int upperBoundY = CGRectGetMaxY(self.screenImageView.bounds) - lowerBoundY;
        
        CGFloat x = lowerBoundX + arc4random() % (upperBoundX - lowerBoundX);
        CGFloat y = lowerBoundY + arc4random() % (upperBoundY - lowerBoundY);
        
    [UIImageView animateWithDuration:self.speedSlider.value
                               delay:0
                             options:UIViewAnimationOptionCurveLinear
                          animations:^{
                              self.heroImageView.center = CGPointMake(x, y);
                          } completion:^(BOOL finished) {
                              [self translationSwitch:sender];
                          }];
    }
}

- (IBAction)speedSlider:(UISlider *)sender {
    self.speedLabel.text = [NSString stringWithFormat:@"Speed: %.02f", sender.maximumValue - sender.value + sender.minimumValue];
}
@end
