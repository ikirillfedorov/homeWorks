//
//  Doctor.h
//  HW 9 - Delegate
//
//  Created by Daria on 27/01/2019.
//  Copyright © 2019 KirillFedorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Patient.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PatientDelegate;

@interface Doctor : NSObject <PatientDelegate>

@property (strong, nonatomic) NSMutableDictionary *raport;

- (void) showRaport;
- (void) cleanRaport;

@end

NS_ASSUME_NONNULL_END
