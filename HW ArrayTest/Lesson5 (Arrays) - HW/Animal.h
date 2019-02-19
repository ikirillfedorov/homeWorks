//
//  Animal.h
//  Lesson5 (Arrays) - HW
//
//  Created by Daria on 20/01/2019.
//  Copyright © 2019 KirillFedorov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Animal : NSObject

@property (strong, nonatomic) NSString *nickname;
@property (assign, nonatomic) NSInteger legs;

- (void) move;

@end

NS_ASSUME_NONNULL_END
