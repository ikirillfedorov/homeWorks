//
//  Patient.h
//  HW 9 - Delegate
//
//  Created by Daria on 27/01/2019.
//  Copyright © 2019 KirillFedorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

typedef enum {
    head,
    leg,
    stomach
} Organ;

@protocol PatientDelegate;

@interface Patient : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) CGFloat temperature;
@property (assign, nonatomic) Organ ache;
@property (assign,nonatomic) NSInteger doctorMark;

@property (weak, nonatomic) id <PatientDelegate> delegate;

- (void) takePill;
- (void) makeShot;
- (void) goHospital;

- (void) doEnema;
- (void) doGypsum;

- (BOOL) feelingWorse;

@end

@protocol PatientDelegate

- (void) heal: (Patient *) patient;

@end

NS_ASSUME_NONNULL_END
