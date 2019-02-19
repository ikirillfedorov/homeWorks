//
//  Jumper.m
//  HW Lesson 7 - Protocols
//
//  Created by Daria on 26/01/2019.
//  Copyright © 2019 KirillFedorov. All rights reserved.
//

#import "Jumper.h"

@implementation Jumper

- (void) jump {
    NSLog(@"%@ JUMP!", self.name);
}

- (void) sing {
    NSLog(@"%@ SING!", self.name);
}


@end
