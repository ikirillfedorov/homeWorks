//
//  Swimmer.m
//  HW Lesson 7 - Protocols
//
//  Created by Daria on 26/01/2019.
//  Copyright © 2019 KirillFedorov. All rights reserved.
//

#import "Swimmer.h"

@implementation Swimmer

- (void) swim {
    NSLog(@"%@ SWIM!", self.name);
}

- (void) work {
    NSLog(@"%@ WORK!", self.name);
}


@end
