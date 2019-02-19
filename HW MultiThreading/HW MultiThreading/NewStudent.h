//
//  NewStudent.h
//  HW MultiThreading
//
//  Created by Kirill Fedorov on 11/02/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewStudent : NSObject

- (instancetype)initWithName: (NSString *) name;

@property (strong, nonatomic) NSString *name;

- (void) guessNumber:(NSInteger) number range:(NSRange) range andResultBlock:(void(^)(NSInteger, NSString *, NSInteger, double)) resultBlock;

@end

NS_ASSUME_NONNULL_END
