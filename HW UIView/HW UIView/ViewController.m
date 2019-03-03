//  ViewController.m
//  HW UIView
//
//  Created by Kirill Fedorov on 28/02/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (assign, nonatomic) CGFloat cellSize;
@property (strong, nonatomic) NSMutableArray *checkersArray;
@property (strong, nonatomic) UIView *field;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    1. В цикле создавайте квадратные UIView с черным фоном и расположите их в виде шахматной доски
//    2. доска должна иметь столько клеток, как и настоящая шахматная

    self.checkersArray = [NSMutableArray array];
    CGFloat width = self.view.bounds.size.width - 20;

    self.field = [[UIView alloc] initWithFrame:CGRectMake(10, 248, width, width)];
    [self.view addSubview:self.field];
    self.field.backgroundColor = [UIColor redColor];
    
    self.cellSize = width / 8;
    self.checkersArray = [NSMutableArray array];
    CGFloat checkersSizeInCell = 0.7;
    CGFloat checkerSize = self.cellSize * checkersSizeInCell;
    CGFloat indentInCell = self.cellSize * (1 - checkersSizeInCell) / 2;
    
    for (NSInteger i = 0; i < 8; i++) {
        for (NSInteger j = 0; j < 8; j++) {
            
            UIView *cell = [[UIView alloc]initWithFrame:CGRectMake(self.cellSize * j, self.cellSize * i, self.cellSize, self.cellSize)];
            
            cell.backgroundColor = [UIColor blueColor];
            if ((i + j) % 2 != 0) {
                cell.backgroundColor = [UIColor lightGrayColor];
            } else {
                cell.backgroundColor = [UIColor blackColor];
            }
            [self.field addSubview:cell];
            
            if (i < 3 && (i + j) % 2 == 0) {
                UIView *checkerWhite = [[UIView alloc] initWithFrame:CGRectMake(self.cellSize * j + indentInCell,
                                                                                self.cellSize * i + indentInCell,
                                                                                checkerSize, checkerSize)];
                checkerWhite.backgroundColor = [UIColor whiteColor];
                [self.field addSubview:checkerWhite];
                [self.checkersArray addObject:checkerWhite];
            }
                if (i > 4 && (i + j) % 2 == 0) {
                    UIView *checkerRed = [[UIView alloc] initWithFrame:CGRectMake(self.cellSize * j + indentInCell,
                                                                                  self.cellSize * i + indentInCell,
                                                                                  checkerSize, checkerSize)];
                    checkerRed.backgroundColor = [UIColor redColor];
                    [self.field addSubview:checkerRed];
                    [self.checkersArray addObject:checkerRed];
            }
        }
    }
    
    
//    3. Доска должна быть вписана в максимально возможный квадрат, т.е. либо бока, либо верх или низ должны касаться границ экрана
//    4. Применяя соответствующие маски сделайте так, чтобы когда устройство меняет ориентацию, то все клетки растягивались соответственно и ничего не вылетало за пределы экрана.

    self.field.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
                             UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    //Мастер
    //5. При повороте устройства все черные клетки должны менять цвет :)
    //6.Сделайте так, чтобы доска при поворотах всегда строго находилась по центру
    
}

- (void)drawColor:(UIColor*) color {
    for (UIView *view in [self.view.subviews objectAtIndex:0].subviews) {
        BOOL isCell = view.frame.size.height == self.cellSize;
        if (view.backgroundColor != [UIColor lightGrayColor] && isCell) {
            view.backgroundColor = color;
        }
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    UIColor *color = [[UIColor alloc] init];
    
    if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
        color = [UIColor greenColor];
        [self drawColor:color];

    } else if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        color = [UIColor yellowColor];
        [self drawColor:color];
    }
    
    //8. Поставьте белые и красные шашки (квадратные вьюхи) так как они стоят на доске. Они должны быть сабвьюхами главной вьюхи (у них и у клеток один супервью)
    //9. После каждого переворота шашки должны быть перетасованы используя соответствующие методы иерархии UIView

    NSInteger randomCountChange = arc4random() % ([self.checkersArray count] / 2) + 1;

    for (NSInteger i = 0; i < randomCountChange; i++) {
        UIView* firstChecker = [self.checkersArray objectAtIndex:arc4random() % [self.checkersArray count]];
        UIView* secondChecker = [self.checkersArray objectAtIndex:arc4random() % [self.checkersArray count]];

        [UIView animateWithDuration:1 animations:^{

            CGRect tempRect = firstChecker.frame;
            [firstChecker setFrame:secondChecker.frame];
            [secondChecker setFrame:tempRect];

            [self.field bringSubviewToFront:firstChecker];
            [self.field bringSubviewToFront:secondChecker];
        }];
    }
}

@end
