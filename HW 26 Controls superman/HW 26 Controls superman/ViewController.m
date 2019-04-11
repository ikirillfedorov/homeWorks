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
@property (strong, nonatomic) UIImage *tanyaPicture;
@property (strong, nonatomic) UIImage *kitanaPicture;
@property (strong, nonatomic) UIImage *jadePicture;

typedef enum {
    SegmentTanya,
    SegmentKitana,
    SegmentJade
} SegmentState;

@end

@implementation ViewController

- (float)animationSpeed {
    return self.speedSlider.maximumValue + self.speedSlider.minimumValue - self.speedSlider.value;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tanyaPicture = [UIImage imageNamed:@"Tanya"];
    self.kitanaPicture = [UIImage imageNamed:@"Kitana"];
    self.jadePicture = [UIImage imageNamed:@"Jade"];
    
    self.heroImageView.image = self.tanyaPicture;
}

- (IBAction)changeHeroSegmentedControl:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case SegmentTanya:
            self.heroImageView.image = self.tanyaPicture;
            break;
        case SegmentKitana:
            self.heroImageView.image = self.kitanaPicture;
            break;
        case SegmentJade:
            self.heroImageView.image = self.jadePicture;
            break;
        default:
            break;
    }
}

- (IBAction)didChangeRotationState:(UISwitch *)sender {
    if (sender.isOn) {
        [UIView animateWithDuration:self.animationSpeed
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.heroImageView.transform = CGAffineTransformRotate(self.heroImageView.transform, M_PI_4);
                         }
                         completion:^(BOOL finished) {
                             [self didChangeRotationState:sender];
                         }];
    }
}

- (IBAction)didChangeSscaleState:(UISwitch *)sender {
    self.isHeroIncrease = !self.isHeroIncrease;
    
    if (sender.isOn) {
        [UIView animateWithDuration:self.animationSpeed
                              delay:0
                            options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             self.heroImageView.transform = CGAffineTransformScale(self.heroImageView.transform,
                                                                                   self.isHeroIncrease == true ? 2 : 0.5,
                                                                                   self.isHeroIncrease == true ? 2 : 0.5);
                         }
                         completion:^(BOOL finished) {
                             [self didChangeSscaleState:sender];
                         }];
    }
}

- (IBAction)didChangeTranslationState:(UISwitch *)sender {
    if (sender.isOn) {
        int lowerBoundX = CGRectGetWidth(self.heroImageView.bounds) / 2;
        int lowerBoundY = CGRectGetHeight(self.heroImageView.bounds) / 2;
        
        int upperBoundX = CGRectGetMaxX(self.screenImageView.bounds) - lowerBoundX;
        int upperBoundY = CGRectGetMaxY(self.screenImageView.bounds) - lowerBoundY;
        
        CGFloat x = lowerBoundX + arc4random() % (upperBoundX - lowerBoundX);
        CGFloat y = lowerBoundY + arc4random() % (upperBoundY - lowerBoundY);
        
        [UIImageView animateWithDuration:self.animationSpeed
                                   delay:0
                                 options:UIViewAnimationOptionCurveLinear
                              animations:^{
                                  self.heroImageView.center = CGPointMake(x, y);
                              }
                              completion:^(BOOL finished) {
                                  [self didChangeTranslationState:sender];
                              }];
    }
}

- (IBAction)speedSlider:(UISlider *)sender {
    self.speedLabel.text = [NSString stringWithFormat:@"Speed: %.02f", sender.value];
}
@end
