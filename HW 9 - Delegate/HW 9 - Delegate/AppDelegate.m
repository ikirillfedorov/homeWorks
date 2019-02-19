//
//  AppDelegate.m
//  HW 9 - Delegate
//
//  Created by Daria on 27/01/2019.
//  Copyright © 2019 KirillFedorov. All rights reserved.
//

#import "AppDelegate.h"
#import "Patient.h"
#import "Doctor.h"
#import "Friend.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    Patient *patient1 = [[Patient alloc] init];
    Patient *patient2 = [[Patient alloc] init];
    Patient *patient3 = [[Patient alloc] init];
    Patient *patient4 = [[Patient alloc] init];
    Patient *patient5 = [[Patient alloc] init];

    Doctor *doctor = [[Doctor alloc] init];
    Friend *friend1 = [[Friend alloc] init];
    Friend *friend2 = [[Friend alloc] init];

    patient1.name = @"Vova"; patient1.temperature = 37.5f; patient1.ache = stomach; patient1.delegate = doctor;
    patient2.name = @"Masha"; patient2.temperature = 38.2f; patient2.ache = head; patient2.delegate = doctor;
    patient3.name = @"Mark"; patient3.temperature = 36.6f; patient3.ache = stomach; patient3.delegate = friend1;
    patient4.name = @"Nasty"; patient4.temperature = 39.9f; patient4.ache = leg; patient4.delegate = friend1;
    patient5.name = @"Anton"; patient5.temperature = 37.2f; patient5.ache = head; patient5.delegate = friend2;

    NSArray *patients = [NSArray arrayWithObjects:patient1, patient2, patient3, patient4, patient5, nil];
    
    NSLog(@"-----------------------------DAY 1----------------------- ");

    for (Patient *patient in patients) {
        NSLog(@"%@ your feeling worse? %@", patient.name, [patient feelingWorse] ? @"YES" : @"NO, I'M OK");
    }
    
    
    NSLog(@"-----------------------------DOCTOR RAPORT----------------------- ");

    [doctor showRaport];
    [doctor cleanRaport];


    NSLog(@"-----------------------------CHEACK SATISFIED----------------------- ");

    for (Patient *patient in patients) {
        if (patient.doctorMark < 3) {
            NSLog(@"%@ dissatisfied", patient.name);
            if (patient.delegate == doctor) {
                patient.delegate = friend1;
                NSLog(@"Patient %@ chenge doctor", patient.name);
            } else {
                patient.delegate = doctor;
                NSLog(@"Patient %@ chenge doctor", patient.name);
            }
        } else {
            NSLog(@"%@ satisfied", patient.name);
        }
    }

    NSLog(@"-----------------------------DAY 2----------------------- ");

    for (Patient *patient in patients) {
        NSLog(@"%@ your feeling worse? %@", patient.name, [patient feelingWorse] ? @"YES" : @"NO, I'M OK");
    }

    NSLog(@"-----------------------------DOCTOR RAPORT----------------------- ");
    
    [doctor showRaport];
    [doctor cleanRaport];

    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
