//
//  Runner.h
//  HW Lesson 7 - Protocols
//
//  Created by Daria on 26/01/2019.
//  Copyright © 2019 KirillFedorov. All rights reserved.
//

#import "Human.h"
#import "Runners.h"

NS_ASSUME_NONNULL_BEGIN

@interface Runner : Human <Runners>

@property (assign, nonatomic) NSInteger maxSpeed;

@property (strong, nonatomic) NSString *country;

- (void) run;


@end

NS_ASSUME_NONNULL_END
