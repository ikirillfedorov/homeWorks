//
//  ViewController.h
//  HW 26 Controls superman
//
//  Created by Kirill Fedorov on 08/04/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *screenImageView;
@property (weak, nonatomic) IBOutlet UIImageView *heroImageView;
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;

- (IBAction)changeHeroSegmentedControl:(UISegmentedControl *)sender;

- (IBAction)startAndStopRotationSwitch:(UISwitch *)sender;
- (IBAction)startandStopScaleSwitch:(UISwitch *)sender;
- (IBAction)startAndStopTranslationSwitch:(UISwitch *)sender;
- (IBAction)speedSlider:(UISlider *)sender;

@end

