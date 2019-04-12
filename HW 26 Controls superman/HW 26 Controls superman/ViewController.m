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
    SegmentStateTanya,
    SegmentStateKitana,
    SegmentStateJade
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
        case SegmentStateTanya:
            self.heroImageView.image = self.tanyaPicture;
            break;
        case SegmentStateKitana:
            self.heroImageView.image = self.kitanaPicture;
            break;
        case SegmentStateJade:
            self.heroImageView.image = self.jadePicture;
            break;
        default:
            break;
    }
}

- (void)startPictureRotation:(UISwitch *)sender {
    [UIView animateWithDuration:self.animationSpeed
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.heroImageView.transform = CGAffineTransformRotate(self.heroImageView.transform, M_PI_4);
                     }
                     completion:^(BOOL finished) {
                         if (sender.isOn) {
                             [self startPictureRotation:sender];
                         }
                     }];
}

- (void)startPictureChangeScale:(UISwitch *)sender {
    self.isHeroIncrease = !self.isHeroIncrease;
    [UIView animateWithDuration:self.animationSpeed
                          delay:0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.heroImageView.transform = CGAffineTransformScale(self.heroImageView.transform,
                                                                               self.isHeroIncrease ? 2 : 0.5,
                                                                               self.isHeroIncrease ? 2 : 0.5);
                     }
                     completion:^(BOOL finished) {
                         if (sender.isOn) {
                             [self startPictureChangeScale:sender];
                         }
                     }];
}

- (void)startPictureTranslation:(UISwitch *)sender {
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
                              if (sender.isOn) {
                                  [self startPictureTranslation:sender];
                              }
                          }];
}

#pragma - Control elements

- (IBAction)didChangeRotationState:(UISwitch *)sender {
    if (sender.isOn) {  // можно было бы ыубрать иф в метод, но мне кажется так логичнее если вкл. тогда старт ротации
        [self startPictureRotation:sender];
    }
}

- (IBAction)didChangeScaleState:(UISwitch *)sender {
    if (sender.isOn) {
        [self startPictureChangeScale:sender];
    }
}

- (IBAction)didChangeTranslationState:(UISwitch *)sender {
    if (sender.isOn) {
        [self startPictureTranslation:sender];
    }
}

- (IBAction)speedSlider:(UISlider *)sender {
    self.speedLabel.text = [NSString stringWithFormat:@"Speed: %.02f", sender.value];
}
@end
