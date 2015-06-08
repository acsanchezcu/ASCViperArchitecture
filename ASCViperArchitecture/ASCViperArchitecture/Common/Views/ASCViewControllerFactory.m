//
//  ASCViewControllerFactory.m
//  ASCViperArchitecture
//
//  Created by Abel Sánchez Custodio on 7/6/15.
//  Copyright (c) 2015 acsanchezcu. All rights reserved.
//

#import "ASCViewControllerFactory.h"

#import "ASCPersonViewController.h"


NSString * const ASCNewPersonViewControllerIdentifier = @"ASCNewPersonViewControllerIdentifier";


@implementation ASCViewControllerFactory

- (ASCViewController *)viewControllerWithPerson:(ASCPerson *)person type:(ASCPersonInteractorType)type isEditing:(BOOL)isEditing
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ASCPersonViewController<ASCNewPersonViewControllerInterface> *viewController = [storyboard instantiateViewControllerWithIdentifier:ASCNewPersonViewControllerIdentifier];
    
    ASCPersonInteractorType nextType = [self newTypeForType:type];
    
    ASCPersonInteractor *interactor = [[ASCPersonInteractor alloc] initWithPerson:person viewController:viewController type:nextType isEditing:isEditing];
    
    viewController.person = person;
    viewController.isEditing = isEditing;
    
    viewController.interactor = interactor;
    
    return viewController;
}

#pragma mark - Private Methods

- (ASCPersonInteractorType)newTypeForType:(ASCPersonInteractorType)type
{
    switch (type) {
        case ASCPersonInteractorTypeName:
            return ASCPersonInteractorTypeFirstName;
        case ASCPersonInteractorTypeFirstName:
            return ASCPersonInteractorTypeSecondName;
        default:
            return ASCPersonInteractorTypeSecondName;
    }
}

@end
