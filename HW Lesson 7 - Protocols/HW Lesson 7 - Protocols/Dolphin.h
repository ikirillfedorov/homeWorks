//
//  Dolphin.h
//  HW Lesson 7 - Protocols
//
//  Created by Daria on 26/01/2019.
//  Copyright © 2019 KirillFedorov. All rights reserved.
//

#import "Animals.h"
#import "Swimmers.h"

NS_ASSUME_NONNULL_BEGIN

@interface Dolphin : Animals <Swimmers>

@property (assign, nonatomic) NSInteger maxSpeed;

@property (strong, nonatomic) NSString *country;

- (void) swim;

@end

NS_ASSUME_NONNULL_END
