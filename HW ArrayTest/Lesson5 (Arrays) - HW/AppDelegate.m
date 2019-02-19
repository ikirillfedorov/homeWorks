//
//  AppDelegate.m
//  Lesson5 (Arrays) - HW
//
//  Created by Daria on 20/01/2019.
//  Copyright © 2019 KirillFedorov. All rights reserved.
//

#import "AppDelegate.h"
#import "Human.h"
#import "Cyclist.h"
#import "Runner.h"
#import "Swimmer.h"
#import "Jumper.h"
#import "Animal.h"
#import "Snake.h"
#import "Bird.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    Human *human = [[Human alloc] init];
    human.name = @"Kolyan - Ne sportsmen";
    human.gender = @"Man";
    human.height = 1.8f;
    human.weight = 90.f;

    Cyclist *cyclist = [[Cyclist alloc] init];
    cyclist.name = @"Vasya - VeloCyclist";
    cyclist.gender = @"Man";
    cyclist.height = 1.65f;
    cyclist.weight = 55.3f;

    Runner *runner = [[Runner alloc] init];
    runner.name = @"Nastya - Runner";
    runner.gender = @"Woman";
    runner.height = 1.75f;
    runner.weight = 49.3f;

    Swimmer *swimmer = [[Swimmer alloc] init];
    [swimmer setName:@"Alena - Swimmer"];
    [swimmer setGender:@"Woman"];
    [swimmer setHeight:1.82f];
    [swimmer setWeight:65.6f];
    
    Jumper *jumper = [[Jumper alloc] init];
    jumper.name = @"Olga - Jumper";
    jumper.gender = @"Woman";
    jumper.height = 195.f;
    jumper.weight = 60.f;
    jumper.lastName = @"Petrova";
    jumper.record = 22;
    
    Animal *dog = [[Animal alloc] init];
    dog.nickname = @"Dog";
    dog.legs = 4;
    
    Snake *snake = [[Snake alloc] init];
    snake.nickname = @"Ka";
    snake.legs = 0;
    
    Bird *bird = [[Bird alloc] init];
    bird.nickname = @"Bird";
    bird.legs = 2;
    
    NSArray *livingCreators = [NSArray arrayWithObjects:human, cyclist, runner, swimmer, jumper, dog, snake, bird, nil];
    
    
    for (NSInteger i = [livingCreators count] - 1; i >= 0; i -= 1) {
        
        if ([[livingCreators objectAtIndex:i] isKindOfClass:[Animal class]]) {
            NSLog(@"-----ANIMAL-----");
            Animal *animal = (Animal*)[livingCreators objectAtIndex:i];
            NSLog(@"Nickname = %@", animal.nickname);
            NSLog(@"Legs = %ld", (long)animal.legs);
            [animal move];
        } else {
            NSLog(@"-----HUMAN-----");
            NSLog(@"Name = %@", [[livingCreators objectAtIndex:i] name]);
            NSLog(@"Gender = %@", [[livingCreators objectAtIndex:i] gender]);
            NSLog(@"Weight = %f", [[livingCreators objectAtIndex:i] weight]);
//            NSLog(@"Height = %f", [[livingCreators objectAtIndex:i] height]);
            
            [[livingCreators objectAtIndex:i] move];
            
            if ([[livingCreators objectAtIndex:i] isKindOfClass:[Jumper class]]) {
                Jumper *jumper = (Jumper*)[livingCreators objectAtIndex:i];
                NSLog(@"Last name = %@", jumper.lastName);
                NSLog(@"Record = %ld", (long)jumper.record);
            }
        }
    }
    
    NSLog(@"-----------------------------------------STAR--------------------------------------");

    NSArray *animals = [NSArray arrayWithObjects:dog, snake, bird, nil];
    NSArray *humans = [NSArray arrayWithObjects:human, cyclist, runner, swimmer, jumper, nil];

    for (int i = 0; i < fmax([animals count], [humans count]); i += 1) {
        if (i <= [humans count] - 1) {
            NSLog(@"-----HUMAN-----");
            NSLog(@"Name = %@", [[humans objectAtIndex:i] name]);
            NSLog(@"Gender = %@", [[humans objectAtIndex:i] gender]);
            NSLog(@"Weight = %f", [[humans objectAtIndex:i] weight]);
            [[humans objectAtIndex:i] move];
            if ([[humans objectAtIndex:i] isKindOfClass:[Jumper class]]) {
                Jumper *jumper = (Jumper*)[humans objectAtIndex:i];
                NSLog(@"Last name = %@", jumper.lastName);
                NSLog(@"Record = %ld", (long)jumper.record);
            }
        }
        if (i <= [animals count] - 1) {
            NSLog(@"-----ANIMAL-----");
            NSLog(@"Nickname = %@", [[animals objectAtIndex:i] nickname]);
            NSLog(@"Legs = %ld", [[animals objectAtIndex:i] legs]);
            [[animals objectAtIndex:i] move];
        }
    }
    
    NSLog(@"-----------------------------------------SUPERMAN--------------------------------------");

//    14. Соединить животных и людей в одном массиве.
//    15. Используя нужный метод класса NSArray отсортировать массив (как результат будет другой массив).
//    16. Сортировать так: сначала люди, а потом животные, люди отсортированы по имени, а животные по кличкам
//    17. Реально требует разобраться с сортировкой самому, тяжело, но достойно уважения

    NSSortDescriptor *humanSortDescriptor;
    humanSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortedArrayHumans = [humans sortedArrayUsingDescriptors:@[humanSortDescriptor]];

    NSSortDescriptor *animalSortDescriptor;
    animalSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nickname" ascending:YES];
    NSArray *sortedArrayAnimals = [animals sortedArrayUsingDescriptors:@[animalSortDescriptor]];

    NSArray *creators = [sortedArrayHumans arrayByAddingObjectsFromArray:sortedArrayAnimals];

    for (NSInteger i = 0; i < [creators count]; i += 1) {
        if ([[creators objectAtIndex:i] isKindOfClass:[Animal class]]) {
            NSLog(@"-----ANIMAL-----");
            Animal *animal = (Animal*)[creators objectAtIndex:i];
            NSLog(@"Nickname = %@", animal.nickname);
        } else {
            NSLog(@"-----HUMAN-----");
            Human *human = (Human*)[creators objectAtIndex:i];
            NSLog(@"Nickname = %@", human.name);
        }
    }
    

    NSLog(@"----------------------------------SUPERMAN (WITH CLOUSERS)-----------------------------");

    NSArray *sortedLivingCreators = [livingCreators sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([obj1 isKindOfClass:[Human class]] && [obj2 isKindOfClass:[Human class]]) {
            return [[(Human*)obj1 name] compare:[(Human*)obj2 name]];
        } else if ([obj1 isKindOfClass:[Animal class]] && [obj2 isKindOfClass:[Animal class]]) {
            return [[(Animal*)obj1 nickname] compare:[(Animal*)obj2 nickname]];
        } else if ([obj1 isKindOfClass:[Human class]]) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
    }];
    
    for (NSInteger i = 0; i < [sortedLivingCreators count]; i += 1) {
        if ([[sortedLivingCreators objectAtIndex:i] isKindOfClass:[Animal class]]) {
            NSLog(@"-----ANIMAL-----");
            Animal *animal = (Animal*)[sortedLivingCreators objectAtIndex:i];
            NSLog(@"Nickname = %@", animal.nickname);
        } else {
            NSLog(@"-----HUMAN-----");
            Human *human = (Human*)[sortedLivingCreators objectAtIndex:i];
            NSLog(@"Nickname = %@", human.name);
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
