//
//  Student.h
//  HW Blocks
//
//  Created by Daria on 07/02/2019.
//  Copyright © 2019 KirillFedorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    AchingOrganHead,
    AchingOrganLeg,
    AchingOrganHeadHand,
    AchingOrganEyes
} AchingOrgan;

@interface Student : NSObject

- (instancetype)initWithName:(NSString *) name lastName:(NSString *) lastName;

- (instancetype)initWithBlock:(void(^)(Student *patient)) block name:(NSString *) name lastName:(NSString *) lastName;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *lastName;
@property (assign, nonatomic) AchingOrgan achingOrgan;
@property (assign, nonatomic) BOOL feeling;

- (void) takePill;
- (void) makeShot;
- (void) doGypsum;
- (void) takeEyeDrops;

- (void) feelingWorse:(void (^)(Student *)) block;

@end

NS_ASSUME_NONNULL_END
