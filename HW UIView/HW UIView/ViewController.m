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
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    CGFloat minSide = MIN(width, height);
    NSInteger cellsInLine = 20;
    
    self.field = [[UIView alloc] initWithFrame:CGRectMake(self.view.center.x - minSide / 2, self.view.center.y - minSide / 2, minSide, minSide)];
    [self.view addSubview:self.field];
    self.field.backgroundColor = [UIColor redColor];
    
    self.cellSize = MIN(width, height) / cellsInLine;
    CGFloat multiplier = 0.7;
    CGFloat checkerSize = self.cellSize * multiplier;
    CGFloat indentInCell = self.cellSize * (1 - multiplier) / 2;
    NSInteger linesWithChekers = 16;
    NSInteger cellsWithOutChekers = cellsInLine - linesWithChekers / 2;
    
    for (NSInteger i = 0; i < cellsInLine; i++) {
        for (NSInteger j = 0; j < cellsInLine; j++) {
            BOOL isEven = (i + j) % 2 == 0;
            
            UIView *cell = [[UIView alloc]initWithFrame:CGRectMake(self.cellSize * j, self.cellSize * i, self.cellSize, self.cellSize)];
            
            if (!isEven) {
                cell.backgroundColor = [UIColor lightGrayColor];
            } else {
                cell.backgroundColor = [UIColor blackColor];
            }
            [self.field addSubview:cell];
            
            UIView *checker = [[UIView alloc] initWithFrame:CGRectMake(self.cellSize * j + indentInCell,
                                                                          self.cellSize * i + indentInCell,
                                                                          checkerSize,
                                                                          checkerSize)];

            if (i < cellsInLine - cellsWithOutChekers && isEven) {
                checker.backgroundColor = [UIColor whiteColor];
            }
            if (i >= cellsWithOutChekers && isEven) {
                checker.backgroundColor = [UIColor redColor];
            }
            [self.field addSubview:checker];
            [self.checkersArray addObject:checker];
        }
    }
    
    
//    3. Доска должна быть вписана в максимально возможный квадрат, т.е. либо бока, либо верх или низ должны касаться границ экрана
//    4. Применяя соответствующие маски сделайте так, чтобы когда устройство меняет ориентацию, то все клетки растягивались соответственно и ничего не вылетало за пределы экрана.

    self.field.autoresizingMask = UIViewAutoresizingFlexibleTopMargin |
                                  UIViewAutoresizingFlexibleBottomMargin |
                                  UIViewAutoresizingFlexibleLeftMargin |
                                  UIViewAutoresizingFlexibleRightMargin;
    
    //Мастер
    //5. При повороте устройства все черные клетки должны менять цвет :)
    //6.Сделайте так, чтобы доска при поворотах всегда строго находилась по центру
    
}

- (void)changeCellsColor:(UIColor*) color {
    for (UIView *view in self.field.subviews) {
        BOOL isCell = view.frame.size.height == self.cellSize;
        if (view.backgroundColor != [UIColor lightGrayColor] && isCell) {
            view.backgroundColor = color;
        }
    }
}

- (UIView *) randomChecker {
    return [self.checkersArray objectAtIndex:arc4random() % [self.checkersArray count]];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
        [self changeCellsColor:[UIColor greenColor]];
    } else if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        [self changeCellsColor:[UIColor blackColor]];
    }
    
    //8. Поставьте белые и красные шашки (квадратные вьюхи) так как они стоят на доске. Они должны быть сабвьюхами главной вьюхи (у них и у клеток один супервью)
    //9. После каждого переворота шашки должны быть перетасованы используя соответствующие методы иерархии UIView

    [UIView animateWithDuration:1 animations:^{
        NSInteger randomCountChange = arc4random() % ([self.checkersArray count] / 2) + 1;
        
        for (NSInteger i = 0; i < randomCountChange; i++) {
            UIView* firstChecker = [self randomChecker];
            UIView* secondChecker = [self randomChecker];
            
            CGRect tempRect = firstChecker.frame;
            [firstChecker setFrame:secondChecker.frame];
            [secondChecker setFrame:tempRect];
            
            [self.field bringSubviewToFront:firstChecker];
            [self.field bringSubviewToFront:secondChecker];
        }
    }];
}

@end
