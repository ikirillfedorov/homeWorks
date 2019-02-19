//
//  AppDelegate.m
//  HW MultiThreading
//
//  Created by Kirill Fedorov on 10/02/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

#import "AppDelegate.h"
#import "Student.h"
#import "NewStudent.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    NSLog(@"--------------------------------------- LEARNER / STUDENT ---------------------------------------");
//    Ученик.
//    1. Создайте класс студент. У него должен быть метод - угадать ответ :)
//    2. В метод передается случайное целое число например в диапазоне от 0 - 100 (или больше) и сам диапазон, чтобы студент знал где угадывать
//    3. Студент генерирует случайное число в том же диапазоне пока оно не будет искомым
//    4. Весь процесс угадывания реализуется в потоке в классе студент
//    5. Когда студент досчитал то пусть пишет в НСЛог
//    6. Создайте 5 студентов и дайте им одну и туже задачу и посмотрите кто справился с ней лучше
//    7. Задача та же, но вместе с условием передавайте студенту блок, в котором вы и объявите результаты
//    8. Блок должен определяться в томже классе, где и определялись студенты
//    9. Блок должен быть вызван на главном потоке

    Student *student1 = [[Student alloc] initWithName:@"Student1"];
    Student *student2 = [[Student alloc] initWithName:@"Student2"];
    Student *student3 = [[Student alloc] initWithName:@"Student3"];
    Student *student4 = [[Student alloc] initWithName:@"Student4"];
    Student *student5 = [[Student alloc] initWithName:@"Student5"];

    NSArray *students = [[NSArray alloc] initWithObjects:student1, student2, student3, student4, student5, nil];
    
//    NSLog(@"Thread is main? %@", [NSThread isMainThread] ? @"YES" : @"NO");
    
    void (^resultBlock)(NSInteger, NSString *, NSInteger, double) = ^(NSInteger answer, NSString *name, NSInteger tries, double time) {
        NSLog(@"You number is %ld, %@ guessed your number with %ld tries and %f seconds", answer, name, tries, time);
    };
    
    for (Student *student in students) {
        [student guessNumber:arc4random() % 100 range:NSMakeRange(0, 100) andResultBlock:resultBlock];
    }
    
//    NSLog(@"--------------------------------------- MASTER ---------------------------------------");
//    10. Создать приватный метод класса (да да, приватный метод да еще и с плюсом), который будет возвращать статическую (то есть одну на все объекты класса студент) dispatch_queue_t, которая инициализируется при первом обращении к этому методу.
//    11. Лучше в этом методе реализовать блок dispatch_once, ищите в инете как и зачем :) А что, программист всегда что-то ищет и хороший программист всегда находит.
//    12. Все студенты должны выполнять свои процессы в этой queue и она должна быть CONCURRENT, типа все блоки одновременно выполняются

//        NSLog(@"--------------------------------------- SUPERMAN ---------------------------------------");
//    13. Добавьте еще один класс студента, который делает все тоже самое что вы реализовали до этого, только вместо GCD он использует NSOperation и NSOperationQueue. Вообще вынос мозга в самостоятельной работе :)
//    14. Все сделавшие Мастера и Супермена и с красивым кодом получают отдельный огромный РЕСПЕКТ, так как они это на самом деле заслуживают.

    NewStudent *newStudent1 = [[NewStudent alloc] initWithName:@"NewStudent1"];
    NewStudent *newStudent2 = [[NewStudent alloc] initWithName:@"NewStudent2"];
    NewStudent *newStudent3 = [[NewStudent alloc] initWithName:@"NewStudent3"];
    NewStudent *newStudent4 = [[NewStudent alloc] initWithName:@"NewStudent4"];
    NewStudent *newStudent5 = [[NewStudent alloc] initWithName:@"NewStudent5"];
    
    NSArray *newStudents = @[newStudent1, newStudent2, newStudent3, newStudent4, newStudent5];

    for (NewStudent *newStudent in newStudents) {
        [newStudent guessNumber:arc4random() % 100 range:NSMakeRange(0, 100) andResultBlock:resultBlock];
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
