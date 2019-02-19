//
//  Kenguru.h
//  HW Lesson 7 - Protocols
//
//  Created by Daria on 26/01/2019.
//  Copyright © 2019 KirillFedorov. All rights reserved.
//

#import "Animals.h"
#import "Jumpers.h"

NS_ASSUME_NONNULL_BEGIN

@interface Kenguru : Animals <Jumpers>

@property (assign, nonatomic) NSInteger maxSpeed;

@property (strong, nonatomic) NSString *country;

- (void) jump;

@end

NS_ASSUME_NONNULL_END
