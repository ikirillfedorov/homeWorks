//
//  AppDelegate.m
//  HW Blocks
//
//  Created by Daria on 07/02/2019.
//  Copyright © 2019 KirillFedorov. All rights reserved.
//

#import "AppDelegate.h"
#import "Student.h"


typedef void (^MyBlock1)(void);
typedef void (^MyBlock2)(NSString *, CGFloat);
typedef NSString *(^MyBlock3)(NSString *, NSInteger);
typedef void (^PatientBlock)(Student *);

@interface AppDelegate ()

@property (strong, nonatomic) NSArray *studentsArray;

- (void) methodWithBlock: (MyBlock1) givenBlock;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSLog(@"------------------------------------------------------------ Learner -------------------");
//    1. В апп делегате создайте блок без возвращаемой переменной и без параметров и вызовите его.
//    2. Создайте блоки с параметрами и передайте туда строку, которую выведите на экран в последствии.
//    3. Если вы не определили тип данных для ваших блоков, то сделайте это сейчас и используйте их
//    4. Создайте метод который принимает блок и вызывает его и вызовите этот метод.

    void (^block1)(void) = ^{
        NSLog(@"This is block without return and parametrs");
    };
    
    void (^block2)(NSString *, CGFloat) = ^(NSString * string, CGFloat floatValue) {
        NSLog(@"This is block with parametrs: first parametr = %@, second parametr = %f", string, floatValue);
    };

    NSString *(^block3)(NSString *, NSInteger) = ^(NSString * string, NSInteger invValue) {
        return [NSString stringWithFormat:@"This is block with return and parametrs: first parametr = %@, second parametr = %ld", string, (long)invValue];
    };

    block1();
    block2(@"Hello world", 36.6);
    NSString *testString = block3(@"Happy new year!", 2019);
    NSLog(@"%@", testString);
    
    MyBlock1 typeDefBlock1 = ^{
        NSLog(@"This is block with typeDef without return and parametrs");
    };
    
    MyBlock2 typeDefBlock2 = ^(NSString *string, CGFloat floatValue) {
        NSLog(@"This is block with typeDef and with parametrs: first parametr = %@, second parametr = %f", string, floatValue);
    };
    
    MyBlock3 typeDefBlock3 = ^(NSString * string, NSInteger invValue) {
        return [NSString stringWithFormat:@"This is block with typeDef, return and parametrs: first parametr = %@, second parametr = %ld", string, (long)invValue];
    };
    
    typeDefBlock1();
    typeDefBlock2(@"Hello world", 36.6);
    NSString *testStringForMyBlock3 = typeDefBlock3(@"Happy new year!", 2019);
    NSLog(@"%@", testStringForMyBlock3);
    
    [self methodWithBlock:^{
        NSLog(@"This is my method with given block");
    }];
    
    NSLog(@"------------------------------------------------------------ Student -------------------");
//    Студент.
//    5. Создайте класс студент с проперти имя и фамилия.
//    6. Создайте в аппделегате 10 разных студентов, пусть у парочки будут одинаковые фамилии.
//    7. Поместите всех в массив.
//    8. Используя соответствующий метод сортировки массива (с блоком) отсортируйте массив студентов сначала по фамилии, а если они одинаковы то по имени.

    Student *student1 = [[Student alloc] initWithName:@"Oleg" lastName:@"Ptrov"];
    Student *student2 = [[Student alloc] initWithName:@"Viktor" lastName:@"Ptrov"];
    Student *student3 = [[Student alloc] initWithName:@"Alex" lastName:@"Ptrov"];
    Student *student4 = [[Student alloc] initWithName:@"Kirill" lastName:@"Fedorov"];
    Student *student5 = [[Student alloc] initWithName:@"Daria" lastName:@"Ptrov"];
    Student *student6 = [[Student alloc] initWithName:@"Maxim" lastName:@"Ptrov"];
    Student *student7 = [[Student alloc] initWithName:@"Sasha" lastName:@"Efimov"];
    Student *student8 = [[Student alloc] initWithName:@"Igor" lastName:@"Sinicin"];
    Student *student9 = [[Student alloc] initWithName:@"Yna" lastName:@"Soloveva"];
    Student *student10 = [[Student alloc] initWithName:@"Masha" lastName:@"Smirnova"];
    
    NSArray *partyList = [NSArray arrayWithObjects:student1, student2, student3, student4,
                          student5, student6, student7, student8, student9, student10, nil];
    
    NSArray *sortedPartyList = [partyList sortedArrayUsingComparator:^NSComparisonResult(Student *obj1, Student *obj2) {
        if (obj1.lastName == obj2.lastName) {
            return [obj1.name compare:obj2.name];
        } else {
            return [obj1.lastName compare:obj2.lastName];
        }
    }];
    
    NSLog(@"Guest list for a party");
    for (Student * student in sortedPartyList) {
        NSLog(@"LastName: %@ Name: %@", student.lastName, student.name);
    }
    
    NSLog(@"------------------------------------------------------------ Master -------------------");
//    Мастер.
//    9. Задание из видео. Из урока о делегатах. У пациентов удалите протокол делегат и соответствующее проперти.
//    10. Добавьте метод принимающий блок когда им станет плохо.
//    11. Блок должен передавать указатель на самого студента ну и на те параметры, которые были в задании по делегатам.
//    12. Теперь когда пациентам поплохеет, они должны вызывать блок, а в блоке нужно принимать решения что делать (доктор не нужен делайте все в апп делегате)
    
    for (Student * student in sortedPartyList) {
        NSLog(@"%@ %@ How are you feeling?",student.name, student.lastName);
        if (student.feeling) {
            [student feelingWorse:^(Student *patient) {
                NSLog(@"%@ that have you aching?",patient.name);
                switch (patient.achingOrgan) {
                    case AchingOrganHead:
                        NSLog(@"My head hurts!");
                        [patient takePill];
                        break;
                    case AchingOrganHeadHand:
                        NSLog(@"My hand hurts!");
                        [patient doGypsum];
                        break;
                    case AchingOrganLeg:
                        NSLog(@"My leg hurts!");
                        [patient doGypsum];
                        break;
                    case AchingOrganEyes:
                        NSLog(@"My eyes hurts!");
                        [patient takeEyeDrops];
                        break;
                    default:
                        break;
                }
            }];
        } else {
            NSLog(@"I'm OK!");
        }
        NSLog(@"--------------------------------------");
    }

    NSLog(@"------------------------------------------------------------ Superman -------------------");
//    Супермен
//    13. Познайте истинное предназначение блоков :) Пусть пациентам становится плохо не тогда когда вы их вызываете в цикле(это убрать), а через случайное                                   время 5-15 секунд после создания (используйте специальный метод из урока по селекторам в ините пациента).
//    14. не забудьте массив пациентов сделать проперти аппделегата, а то все помрут по выходе из функции так и не дождавшись :)

     PatientBlock supermanBlock = ^(Student *patient) {
        NSLog(@"%@ that have you aching?",patient.name);
        switch (patient.achingOrgan) {
            case AchingOrganHead:
                NSLog(@"My head hurts!");
                [patient takePill];
                break;
            case AchingOrganHeadHand:
                NSLog(@"My hand hurts!");
                [patient doGypsum];
                break;
            case AchingOrganLeg:
                NSLog(@"My leg hurts!");
                [patient doGypsum];
                break;
            case AchingOrganEyes:
                NSLog(@"My eyes hurts!");
                [patient takeEyeDrops];
                break;
            default:
                break;
        }
         NSLog(@"--------------------------------------");
     };

    Student *student11 = [[Student alloc] initWithBlock:supermanBlock name:@"Oleg" lastName:@"Petrov"];
    Student *student12 = [[Student alloc] initWithBlock:supermanBlock name:@"Kirill" lastName:@"Fedorov"];
    Student *student13 = [[Student alloc] initWithBlock:supermanBlock name:@"Max" lastName:@"Ivanov"];
    Student *student14 = [[Student alloc] initWithBlock:supermanBlock name:@"Sasha" lastName:@"Efimov"];
    Student *student15 = [[Student alloc] initWithBlock:supermanBlock name:@"Masha" lastName:@"Petrova"];

    NSArray *studentsJournal = [NSArray arrayWithObjects:student11, student12, student13, student14, student15, nil];
    
    self.studentsArray = studentsJournal;

    return YES;
}

- (void) methodWithBlock:(MyBlock1) givenBlock {
    givenBlock();
};

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
