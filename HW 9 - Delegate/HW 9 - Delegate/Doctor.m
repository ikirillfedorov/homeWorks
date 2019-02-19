//
//  Doctor.m
//  HW 9 - Delegate
//
//  Created by Daria on 27/01/2019.
//  Copyright © 2019 KirillFedorov. All rights reserved.
//

#import "Doctor.h"
@implementation Doctor

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.raport = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void) heal: (Patient *) patient {
    switch (patient.ache) {
        case leg:
            NSLog(@"Patient %@ ache leg!", patient.name);
            [patient doGypsum];
            [self.raport setObject:@"Leg ache" forKey: patient.name];
            break;
        case stomach:
            NSLog(@"Patient %@ ache stomach!", patient.name);
            [patient doEnema];
            [self.raport setObject:@"Stomach ache" forKey: patient.name];
            break;
        default:
            NSLog(@"Patient %@ ache head!", patient.name);
            [self.raport setObject:@"Head ache" forKey: patient.name];
            if (patient.temperature > 37.f && patient.temperature <= 38.f) {
                [patient takePill];
            } else if (patient.temperature > 38.f && patient.temperature <= 39.f) {
                [patient makeShot];
            } else if (patient.temperature > 39.f) {
                [patient goHospital];
            } else {
                NSLog(@"Patient %@ need a rest", patient.name);
            }
            patient.doctorMark = arc4random() % 6;
    }
}
    
- (void) showRaport {
    NSLog(@"%lu", (unsigned long)[self.raport count]);
    NSLog(@"%@", self.raport);
}
    
- (void) cleanRaport {
    self.raport = [NSMutableDictionary dictionary];
}
@end
