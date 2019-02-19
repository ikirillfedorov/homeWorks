//
//  Swimmer.h
//  HW Lesson 7 - Protocols
//
//  Created by Daria on 26/01/2019.
//  Copyright © 2019 KirillFedorov. All rights reserved.
//

#import "Human.h"
#import "Swimmers.h"


NS_ASSUME_NONNULL_BEGIN

@interface Swimmer : Human <Swimmers>

@property (assign, nonatomic) NSInteger maxSpeed;

@property (strong, nonatomic) NSString *country;

@property (strong, nonatomic) NSString *trainingPlace;

- (void) swim;

@end

NS_ASSUME_NONNULL_END
