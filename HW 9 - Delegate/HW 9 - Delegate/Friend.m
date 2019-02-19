//
//  Friend.m
//  HW 9 - Delegate
//
//  Created by Daria on 27/01/2019.
//  Copyright © 2019 KirillFedorov. All rights reserved.
//

#import "Friend.h"

@implementation Friend

- (void) heal: (Patient *) patient {
    NSLog(@"Patient %@ feeling worse", patient.name);
    if (patient.temperature > 37.f && patient.temperature <= 38.f) {
        NSLog(@"%@ everything's going to be OK", patient.name);
    } else if (patient.temperature > 38.f && patient.temperature <= 39.f) {
        NSLog(@"%@ take lechebnogo lescha!", patient.name);
    } else if (patient.temperature > 39.f) {
        NSLog(@"%@ rest in peace, Bro!", patient.name);
    } else {
        [patient goHospital];
    }
}

@end
