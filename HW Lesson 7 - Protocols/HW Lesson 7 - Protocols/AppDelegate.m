//
//  AppDelegate.m
//  HW Lesson 7 - Protocols
//
//  Created by Daria on 26/01/2019.
//  Copyright © 2019 KirillFedorov. All rights reserved.
//

#import "AppDelegate.h"
#import "Jumpers.h"
#import "Swimmers.h"
#import "Runners.h"
#import "Human.h"
#import "Animals.h"
#import "Kenguru.h"
#import "Gepard.h"
#import "Dolphin.h"
#import "Jumper.h"
#import "Runner.h"
#import "Swimmer.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    Human *human = [[Human alloc] init];
    Animals *animal = [[Animals alloc] init];
    Kenguru *kenguru = [[Kenguru alloc] init];
    Gepard *gepard = [[Gepard alloc] init];
    Dolphin *dolphin = [[Dolphin alloc] init];
    Jumper *jumper = [[Jumper alloc] init];
    Runner *runner = [[Runner alloc] init];
    Swimmer *swimmer = [[Swimmer alloc] init];

    human.name = @"Human";
    jumper.name = @"Jumaper"; jumper.maxSpeed = 30; jumper.record = 5;
    runner.name = @"Runner"; runner.maxSpeed = 45; runner.country = @"Russia";
    swimmer.name = @"Swimmer"; swimmer.maxSpeed = 20; swimmer.trainingPlace = @"Pool";
    animal.nickName = @"Animal";
    kenguru.nickName = @"Kenguru"; kenguru.maxSpeed = 35; kenguru.country = @"Austalia";
    gepard.nickName = @"Gepard"; gepard.maxSpeed = 100; gepard.country = @"Africa";
    dolphin.nickName = @"Dolphin"; dolphin.maxSpeed = 70; dolphin.country = @"Ocean";
    
    NSArray *livingCreators = [NSArray arrayWithObjects:human, animal, kenguru, gepard, dolphin, jumper, runner, swimmer, nil];
    
    for (id creature in livingCreators) {
        if ([creature isKindOfClass:[Human class]]) {
            if ([creature conformsToProtocol:@protocol(Jumpers)]) {
                [creature sing];
                NSLog(@"My name is %@, my max speed %ld, my record %ld meters", [creature name], [creature maxSpeed], [creature record]);
            } else if ([creature conformsToProtocol:@protocol(Runners)]) {
                [creature run];
                NSLog(@"My name is %@, my max speed %ld, i'm from %@", [creature name], [creature maxSpeed], [creature country]);
            } else if ([creature conformsToProtocol:@protocol(Swimmers)]) {
                [creature work];
                NSLog(@"My name is %@, my max speed %ld, my traingng place %@", [creature name], [creature maxSpeed], [creature trainingPlace]);
            } else {
                NSLog(@"My name is %@, i'm LODAR", [creature name]);
            }
        } else if ([creature isKindOfClass:[Animals class]]) {
            if ([creature conformsToProtocol:@protocol(Jumpers)]) {
                [creature jump];
                NSLog(@"My name is %@, my max speed %ld, i'm from %@", [creature nickName], [creature maxSpeed], [creature country]);
            } else if ([creature conformsToProtocol:@protocol(Runners)]) {
                [creature run];
                NSLog(@"My name is %@, my max speed %ld, i'm from %@", [creature nickName], [creature maxSpeed], [creature country]);
            } else if ([creature conformsToProtocol:@protocol(Swimmers)]) {
                [creature swim];
                NSLog(@"My name is %@, my max speed %ld, i'm from %@", [creature nickName], [creature maxSpeed], [creature country]);
            } else {
                NSLog(@"My name is %@, i'm LODAR", [creature nickName]);
            }
        }
    }
    
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
