//
//  ViewController.m
//  HW 21 UIView Animations
//
//  Created by Kirill Fedorov on 09/03/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIView *fifthView;
@property (strong, nonatomic) UIView *sixthView;
@property (strong, nonatomic) UIView *seventhView;
@property (strong, nonatomic) UIView *eighthView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    Ученик.
//    1. Создайте 4 вьюхи у левого края ипада.
//    2. Ваша задача всех передвинуть горизонтально по прямой за одно и тоже время
//    3. Для каждой вьюхи используйте свою интерполяцию (EasyInOut, EasyIn и т.д.). Это для того, чтобы вы увидели разницу своими собственными глазами :)
//    4. Добавте реверсивную анимацию и бесконечные повторения
//    5. добавьте смену цвета на рандомный

    UIView *firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 200, 50, 50)];
    UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(0, 300, 50, 50)];
    UIView *thirdView = [[UIView alloc]initWithFrame:CGRectMake(0, 400, 50, 50)];
    UIView *fourthView = [[UIView alloc]initWithFrame:CGRectMake(0, 500, 50, 50)];
    
    [self.view addSubview:firstView];
    [self.view addSubview:secondView];
    [self.view addSubview:thirdView];
    [self.view addSubview:fourthView];
    
    for (UIView *view in [self.view subviews]) {
        view.backgroundColor = [self getRandomColor];
    }
    
    [self moveView:firstView withOptions:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse];
    [self moveView:secondView withOptions:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse];
    [self moveView:thirdView withOptions:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse];
    [self moveView:fourthView withOptions:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse];

    //Студент
    //5. Добавьте еще четыре квадратные вьюхи по углам - красную, желтую, зеленую и синюю
    //6. За одинаковое время и при одинаковой интерполяции двигайте их всех случайно, либо по, либо против часовой стрелки в другой угол.
    //7. Когда анимация закончиться повторите все опять: выберите направление и передвиньте всех :)
    //8. Вьюха должна принимать в новом углу цвет той вьюхи, что была здесь до него ;)
    
    CGFloat maxWidth = CGRectGetWidth(self.view.bounds);
    CGFloat maxHeight = CGRectGetHeight(self.view.bounds);
    CGFloat squareSize = 50.f;
    
    self.fifthView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, squareSize, squareSize)];
    self.fifthView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.fifthView];
    
    self.sixthView = [[UIView alloc]initWithFrame:CGRectMake(maxWidth - squareSize, 0, squareSize, squareSize)];
    self.sixthView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.sixthView];
    
    self.seventhView = [[UIView alloc]initWithFrame:CGRectMake(maxWidth - squareSize, maxHeight - squareSize, squareSize, squareSize)];
    self.seventhView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.seventhView];
    
    self.eighthView = [[UIView alloc]initWithFrame:CGRectMake(0, maxHeight - squareSize, squareSize, squareSize)];
    self.eighthView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.eighthView];

    [self rotateSquers];
    
//    Мастер
//    8. Нарисуйте несколько анимационных картинок человечка, который ходит.
//    9. Добавьте несколько человечков на эту композицию и заставьте их ходить
    
    //man images
    UIImage *manImage1 = [UIImage imageNamed:@"frame_01_delay-0.1s.gif"];
    UIImage *manImage2 = [UIImage imageNamed:@"frame_02_delay-0.1s.gif"];
    UIImage *manImage3 = [UIImage imageNamed:@"frame_03_delay-0.1s.gif"];
    UIImage *manImage4 = [UIImage imageNamed:@"frame_04_delay-0.1s.gif"];
    UIImage *manImage5 = [UIImage imageNamed:@"frame_05_delay-0.1s.gif"];
    UIImage *manImage6 = [UIImage imageNamed:@"frame_06_delay-0.1s.gif"];
    UIImage *manImage7 = [UIImage imageNamed:@"frame_07_delay-0.1s.gif"];
    UIImage *manImage8 = [UIImage imageNamed:@"frame_08_delay-0.1s.gif"];
    UIImage *manImage9 = [UIImage imageNamed:@"frame_09_delay-0.1s.gif"];
    UIImage *manImage10 = [UIImage imageNamed:@"frame_10_delay-0.1s.gif"];
    UIImage *manImage11 = [UIImage imageNamed:@"frame_11_delay-0.1s.gif"];
    
    NSArray *manImages = [NSArray arrayWithObjects:manImage1, manImage2, manImage3, manImage4, manImage5, manImage6, manImage7, manImage8, manImage9, manImage10, manImage11, nil];

    UIImageView *manImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 - 200, 400, 300, 300)];
    
    [self.view addSubview:manImageView];
    manImageView.animationImages = manImages;
    [manImageView startAnimating];
    
    [UIView animateWithDuration:2
                          delay:0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionRepeat
                     animations:^{
                         manImageView.frame = CGRectMake(maxWidth, 400, 300, 300);
                     } completion:^(BOOL finished) {
                         nil;
                     }];

    //background image
    UIImage *field = [UIImage imageNamed:@"field.jpg"];
    
    UIImageView *imageField = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, maxWidth, maxHeight)];
    imageField.image = field;
    [self.view addSubview:imageField];
    [self.view sendSubviewToBack:imageField];

    
    //girl images
    UIImage *girlImage1 = [UIImage imageNamed:@"girl1.gif"];
    UIImage *girlImage2 = [UIImage imageNamed:@"girl2.gif"];
    UIImage *girlImage3 = [UIImage imageNamed:@"girl3.gif"];
    UIImage *girlImage4 = [UIImage imageNamed:@"girl4.gif"];
    UIImage *girlImage5 = [UIImage imageNamed:@"girl5.gif"];
    UIImage *girlImage6 = [UIImage imageNamed:@"girl6.gif"];
    UIImage *girlImage7 = [UIImage imageNamed:@"girl7.gif"];
    UIImage *girlImage8 = [UIImage imageNamed:@"girl8.gif"];
    UIImage *girlImage9 = [UIImage imageNamed:@"girl9.gif"];
    UIImage *girlImage10 = [UIImage imageNamed:@"girl10.gif"];
    UIImage *girlImage11 = [UIImage imageNamed:@"girl11.gif"];
    UIImage *girlImage12 = [UIImage imageNamed:@"girl12.gif"];
    UIImage *girlImage13 = [UIImage imageNamed:@"girl13.gif"];
    UIImage *girlImage14 = [UIImage imageNamed:@"girl14.gif"];

    NSArray *girlImages = [NSArray arrayWithObjects:girlImage1, girlImage2, girlImage3, girlImage4, girlImage5, girlImage6,
                           girlImage7, girlImage8, girlImage9, girlImage10, girlImage11, girlImage12, girlImage13, girlImage14, nil];

    UIImageView *girlImageView = [[UIImageView alloc] initWithFrame:CGRectMake(maxWidth, 400, 300, 300)];
    
    [self.view addSubview:girlImageView];
    girlImageView.animationImages = girlImages;
    [girlImageView startAnimating];
    
    [UIView animateWithDuration:5
                          delay:0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionRepeat
                     animations:^{
                         girlImageView.frame = CGRectMake(0 - 300, 400, 300, 300);
                     } completion:^(BOOL finished) {
                         nil;
                     }];
}

#pragma mark - Supporting methods

- (void) moveView:(UIView *) view withOptions:(UIViewAnimationOptions) options {
    
    [UIView animateWithDuration:5
                          delay:0
                        options:options
                     animations:^{
                         view.center = CGPointMake(CGRectGetWidth(self.view.bounds) - CGRectGetWidth(view.frame) / 2, view.center.y);
                         view.backgroundColor = [self getRandomColor];
                     }
                     completion:^(BOOL finished) {
                         nil;
                     }];
}

- (void)rotateSquers {
    
    BOOL isClockwiseDirection = arc4random() % 2 == 0;
    
    NSArray *viewsArray = [[NSArray alloc] initWithObjects:self.fifthView, self.sixthView, self.seventhView, self.eighthView, nil];
    
    [UIView animateWithDuration:5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         CGRect tempRectForClockwiseDirection = self.fifthView.frame;
                         UIColor *tempColorFroClockwiseDirection = self.fifthView.backgroundColor;
                         
                         CGRect tempRectForCounterClockwise = self.eighthView.frame;
                         UIColor *tempColorForCounterClockwise = self.eighthView.backgroundColor;
                         
                         if (isClockwiseDirection) {
                             for (NSInteger i = [viewsArray count] - 1; i >= 0; i--) {
                                 if (i == 0) {
                                     UIView *view1 = [viewsArray objectAtIndex:i];
                                     view1.frame = tempRectForCounterClockwise;
                                     view1.backgroundColor = tempColorForCounterClockwise;
                                 } else {
                                     UIView *view1 = [viewsArray objectAtIndex:i];
                                     UIView *view2 = [viewsArray objectAtIndex:i-1];
                                     [self changeParametrsFrom:view1 to:view2];
                                 }
                             }
                         } else {
                             for (NSInteger i = 0; i < [viewsArray count]; i++) {
                                 if (i+1 == [viewsArray count]) {
                                     UIView *view1 = [viewsArray objectAtIndex:i];
                                     view1.frame = tempRectForClockwiseDirection;
                                     view1.backgroundColor = tempColorFroClockwiseDirection;
                                 } else {
                                     UIView *view1 = [viewsArray objectAtIndex:i];
                                     UIView *view2 = [viewsArray objectAtIndex:i+1];
                                     [self changeParametrsFrom:view1 to:view2];
                                 }
                             }
                         }
                     }
                     completion:^(BOOL finished) {
                         [self rotateSquers];
                     }];
}


- (void) changeParametrsFrom:(UIView *) view1 to:(UIView *) view2 {
    view1.frame = view2.frame;
    view1.backgroundColor = view2.backgroundColor;
}

- (UIColor *) getRandomColor {
    
    CGFloat red = arc4random() % 256 / 255.0;
    CGFloat green = arc4random() % 256 / 255.0;
    CGFloat blue = arc4random() % 256 / 255.0;

    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

@end
