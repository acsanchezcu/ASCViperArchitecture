//
//  ASCInteractor.h
//  ASCViperArchitecture
//
//  Created by Abel Sánchez Custodio on 5/6/15.
//  Copyright (c) 2015 acsanchezcu. All rights reserved.
//

#import <Foundation/Foundation.h>


@class ASCViewController;


@protocol ASCViewControllerInterface <NSObject>

- (void)showMessage:(NSString *)message  withTitle:(NSString *)title;
- (void)navigateTo:(ASCViewController *)viewController animated:(BOOL)animated;

@end


@interface ASCInteractor : NSObject

@end
