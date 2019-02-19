//
//  Student.m
//  HW MultiThreading
//
//  Created by Kirill Fedorov on 10/02/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

#import "Student.h"
#import <UIKit/UIKit.h>

@interface Student ()

+ (dispatch_queue_t) studentQueue;

@end

@implementation Student


- (instancetype)initWithName: (NSString *) name {
    self = [super init];
    if (self) {
        self.name = name;
    }
    return self;
}


- (void) guessNumber:(NSInteger) number range:(NSRange) range andResultBlock:(void(^)(NSInteger, NSString *, NSInteger, double)) resultBlock {
    
//    dispatch_queue_t studentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async([Student studentQueue], ^{
        NSInteger answer = 0;
        NSInteger tryCount = 0;
        double startTime = CACurrentMediaTime();
        do {
            answer = arc4random() % range.length;
            tryCount += 1;
        } while (answer != number);
        double finishTime = CACurrentMediaTime() - startTime;
        resultBlock(number, self.name, tryCount, finishTime);
    });
}

+ (dispatch_queue_t) studentQueue {
    static dispatch_queue_t queue;
    static dispatch_once_t task;
    dispatch_once(&task, ^{
        queue = dispatch_queue_create("fedorov.testTheards.queue", DISPATCH_QUEUE_CONCURRENT);
    });
    return queue;
}

- (void) dealloc {
    NSLog(@"%@ deallocated", self.name);
}

@end
