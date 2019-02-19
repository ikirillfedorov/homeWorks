//
//  NewStudent.m
//  HW MultiThreading
//
//  Created by Kirill Fedorov on 11/02/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

#import "NewStudent.h"
#import <UIKit/UIKit.h>

@interface NewStudent ()

+ (NSOperationQueue *) studentQueue;

@end

@implementation NewStudent

- (instancetype)initWithName: (NSString *) name {
    self = [super init];
    if (self) {
        self.name = name;
    }
    return self;
}

- (void) guessNumber:(NSInteger) number range:(NSRange) range andResultBlock:(void(^)(NSInteger, NSString *, NSInteger, double)) resultBlock {
    
    [[NewStudent studentQueue] addOperationWithBlock:^{
        NSInteger answer = 0;
        NSInteger tryCount = 0;
        double startTime = CACurrentMediaTime();
        do {
            answer = arc4random() % range.length;
            tryCount += 1;
        } while (answer != number);
        double finishTime = CACurrentMediaTime() - startTime;
        resultBlock(number, self.name, tryCount, finishTime);
    }];
}

+ (NSOperationQueue *) studentQueue {
    static NSOperationQueue *queue;
    static dispatch_once_t task;
    dispatch_once(&task, ^{
        queue = [[NSOperationQueue alloc] init];
    });
    return queue;
}
- (void) dealloc {
    NSLog(@"%@ deallocated", self.name);
}


@end
