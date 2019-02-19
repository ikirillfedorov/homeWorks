//
//  Patient.m
//  HW 9 - Delegate
//
//  Created by Daria on 27/01/2019.
//  Copyright © 2019 KirillFedorov. All rights reserved.
//

#import "Patient.h"

@implementation Patient

- (void) takePill {
    NSLog(@"%@ takes a pill", self.name);
}
- (void) makeShot {
    NSLog(@"%@ makes a shot", self.name);

}
- (void) goHospital {
    NSLog(@"%@ go to hospital", self.name);
}

- (void) doEnema {
    NSLog(@"%@ do enema", self.name);
}
- (void) doGypsum {
    NSLog(@"%@ do gypsum", self.name);
}

- (BOOL) feelingWorse {
//    BOOL isFeelingWorse = arc4random() % 2;
    BOOL isFeelingWorse = YES;

    if (isFeelingWorse) {
        [self.delegate heal: self];
    }
    return isFeelingWorse;
}

@end
