//
//  Student.m
//  HW Blocks
//
//  Created by Daria on 07/02/2019.
//  Copyright © 2019 KirillFedorov. All rights reserved.
//

#import "Student.h"

@implementation Student

- (instancetype)initWithName:(NSString *) name lastName:(NSString *) lastName {
    self = [super init];
    if (self) {
        self.name = name;
        self.lastName = lastName;
        self.achingOrgan = arc4random() % 4; 
        self.feeling = arc4random() % 2;
    }
    return self;
}

- (instancetype)initWithBlock:(void(^)(Student *patient)) block name:(NSString *) name lastName:(NSString *) lastName {
    self = [super init];
    if (self) {
        self.name = name;
        self.lastName = lastName;
        self.achingOrgan = arc4random() % 4;
        self.feeling = arc4random() % 2;
        [self performSelector:@selector(feelingWorse:) withObject:block afterDelay:arc4random() % 10 + 5];
    }
    return self;
}

- (void) takePill {
    NSLog(@"%@ %@ take a pill", self.name, self.lastName);
}

- (void) makeShot {
    NSLog(@"%@ %@ make a shot", self.name, self.lastName);
}

- (void) doGypsum {
    NSLog(@"%@ %@ do gypsum", self.name, self.lastName);
}

- (void) takeEyeDrops {
    NSLog(@"%@ %@ dripping eye drops", self.name, self.lastName);
}

- (void) feelingWorse:(void (^)(Student *)) block {
    NSLog(@"%@ %@ feeling worse", self.name, self.lastName);
    block(self);
}

//- (void)dealloc {
//    NSLog(@"%@ %@ DEALLOCATED", self.name, self.lastName);
//}

@end
