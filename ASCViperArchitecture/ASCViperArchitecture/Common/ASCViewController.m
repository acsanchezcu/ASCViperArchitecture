//
//  ASCViewController.m
//  ASCViperArchitecture
//
//  Created by Abel Sánchez Custodio on 5/6/15.
//  Copyright (c) 2015 acsanchezcu. All rights reserved.
//

#import "ASCViewController.h"


@implementation ASCViewController

#pragma mark - DELEGATES

#pragma mark - ASCViewControllerInterface

- (void)showMessage:(NSString *)message withTitle:(NSString *)title
{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)navigateTo:(ASCViewController *)viewController animated:(BOOL)animated
{
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
