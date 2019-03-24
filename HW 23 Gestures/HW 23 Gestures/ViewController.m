//
//  ViewController.m
//  HW 23 Gestures
//
//  Created by Kirill Fedorov on 21/03/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) UIImageView *womanView;
@property (assign, nonatomic) CGFloat womanViewScale;
@property (assign, nonatomic) CGFloat womanViewRotation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    Ученик
//    1. Добавьте квадратную картинку на вьюху вашего контроллера
//    2. Если хотите, можете сделать ее анимированной
    
    NSMutableArray *imageViews = [NSMutableArray array];
    for(NSInteger imageCounter = 0; imageCounter < 24; imageCounter++) {
        [imageViews addObject:[UIImage imageNamed: imageCounter < 10 ? [NSString stringWithFormat:@"frame_0%ld_delay-0.04s.gif", (long)imageCounter]
                                                                     : [NSString stringWithFormat:@"frame_%ld_delay-0.04s.gif", (long)imageCounter]]];
    }
    
    UIImageView *womanImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.bounds) - 100,
                                                                                CGRectGetMidY(self.view.bounds) - 100,
                                                                                200,
                                                                                200)];
    womanImageView.image = [UIImage imageNamed:@"frame_00_delay-0.04s.gif"] ;
    womanImageView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin |
                                      UIViewAutoresizingFlexibleLeftMargin |
                                      UIViewAutoresizingFlexibleTopMargin |
                                      UIViewAutoresizingFlexibleBottomMargin;
    
    self.womanView = womanImageView;
    [self.view addSubview:self.womanView];
    womanImageView.animationImages = imageViews;
    [womanImageView startAnimating];
    
//    Студент
//    3. По тачу анимационно передвигайте картинку со ее позиции в позицию тача
//    4. Если я вдруг делаю тач во время анимации, то картинка должна двигаться в новую точку без рывка (как будто она едет себе и все)

    //tap
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGesture];

    //right swipe
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc]
                                                   initWithTarget:self
                                                   action:@selector(handleRightSwipe:)];
    
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:rightSwipeGesture];
    
    //left swipe
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc]
                                                  initWithTarget:self
                                                  action:@selector(handleLeftSwipe:)];
    
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:leftSwipeGesture];
    
    //double tap double touch
    UITapGestureRecognizer *doubleTapDoubleTouchGesture = [[UITapGestureRecognizer alloc]
                                                  initWithTarget:self
                                                  action:@selector(handleDoubleTapDoubleTouch:)];
    
    doubleTapDoubleTouchGesture.numberOfTapsRequired = 2;
    doubleTapDoubleTouchGesture.numberOfTouchesRequired = 2;
    [tapGesture requireGestureRecognizerToFail:doubleTapDoubleTouchGesture];
    
    [self.view addGestureRecognizer:doubleTapDoubleTouchGesture];
    
    //pinch gesture
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]
                                              initWithTarget:self
                                              action:@selector(handlePinch:)];
    
    pinchGesture.delegate = self;
    [self.view addGestureRecognizer:pinchGesture];

    //rotation gesture
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(handleRotation:)];
    
    rotationGesture.delegate = self;
    [self.view addGestureRecognizer:rotationGesture];


}

#pragma mark - Gestures

- (void) handleTap:(UITapGestureRecognizer *) tapGesture {
    NSLog(@"Tap: %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    
    [UIView animateWithDuration:3
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                            self.womanView.center = [tapGesture locationInView:self.view];
                        }
                     completion:^(BOOL finished) {
                     }];
    [self.womanView startAnimating];
}

//Мастер
//5. Если я делаю свайп вправо, то давайте картинке анимацию поворота по часовой стрелке на 360 градусов
//6. То же самое для свайпа влево, только анимация должна быть против часовой (не забудьте остановить предыдущее кручение)
//7. По двойному тапу двух пальцев останавливайте анимацию

- (void) handleRightSwipe:(UITapGestureRecognizer *) rightSwipeGesture {
    NSLog(@"right swipe: %@", NSStringFromCGPoint([rightSwipeGesture locationInView:self.view]));
    
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                            self.womanView.transform = CGAffineTransformRotate(self.womanView.transform, M_PI);
                        }
                     completion:^(BOOL finished) {
                     }];
}

- (void) handleLeftSwipe:(UITapGestureRecognizer *) leftSwipeGesture {
    NSLog(@"left swipe: %@", NSStringFromCGPoint([leftSwipeGesture locationInView:self.view]));
    
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                            self.womanView.transform = CGAffineTransformRotate(self.womanView.transform, -(M_PI - 0.000000000001f)); //костыль
                        }
                     completion:^(BOOL finished) {
                     }];
}

- (void) handleDoubleTapDoubleTouch:(UITapGestureRecognizer *) doubleTapDoubleTouchGesture {
    NSLog(@"Handle Double Tap Double Touch: %@", NSStringFromCGPoint([doubleTapDoubleTouchGesture locationInView:self.view]));
    [self.womanView stopAnimating];
}

//Супермен
//8. Добавьте возможность зумить и отдалять картинку используя пинч
//9. Добавьте возможность поворачивать картинку используя ротейшн

- (void) handlePinch:(UIPinchGestureRecognizer*) pinchGesture {
    
    NSLog(@"handlePinch %1.3f", pinchGesture.scale);
    
    if (pinchGesture.state == UIGestureRecognizerStateBegan) {
        self.womanViewScale = 1.f;
    }
    
    CGFloat newScale = 1.f + pinchGesture.scale - self.womanViewScale;
    
    CGAffineTransform currentTransform = self.womanView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, newScale, newScale);
    
    self.womanView.transform = newTransform;
    
    self.womanViewScale = pinchGesture.scale;
}

- (void) handleRotation:(UIRotationGestureRecognizer*) rotationGesture {
    NSLog(@"handleRotation %1.3f", rotationGesture.rotation);
    
    if (rotationGesture.state == UIGestureRecognizerStateBegan) {
        self.womanViewRotation = 0;
    }
    
    CGFloat newRotation = rotationGesture.rotation - self.womanViewRotation;
    CGAffineTransform currentTransform = self.womanView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, newRotation);
    
    self.womanView.transform = newTransform;
    
    self.womanViewRotation = rotationGesture.rotation;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
    shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
