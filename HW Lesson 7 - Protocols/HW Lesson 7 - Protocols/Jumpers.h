//
//  Jumpers.h
//  HW Lesson 7 - Protocols
//
//  Created by Daria on 26/01/2019.
//  Copyright © 2019 KirillFedorov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Jumpers <NSObject>

@required
@property (assign, nonatomic) NSInteger maxSpeed;

@property (strong, nonatomic) NSString *country;

- (void) jump;

@optional

@property (assign, nonatomic) NSInteger record;

- (void) sing;

@end

NS_ASSUME_NONNULL_END
