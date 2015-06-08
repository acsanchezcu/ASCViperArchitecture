//
//  ASCViewControllerFactory.m
//  ASCViperArchitecture
//
//  Created by Abel Sánchez Custodio on 7/6/15.
//  Copyright (c) 2015 acsanchezcu. All rights reserved.
//

#import "ASCViewControllerFactory.h"

#import "ASCNewPersonViewController.h"


NSString * const ASCNewPersonViewControllerIdentifier = @"ASCNewPersonViewControllerIdentifier";


@implementation ASCViewControllerFactory

- (ASCViewController *)viewControllerWithPerson:(ASCPerson *)person type:(ASCNewPersonInteractorType)type isEditing:(BOOL)isEditing
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ASCNewPersonViewController<ASCNewPersonViewControllerInterface> *viewController = [storyboard instantiateViewControllerWithIdentifier:ASCNewPersonViewControllerIdentifier];
    
    ASCNewPersonInteractor *interactor = [[ASCNewPersonInteractor alloc] initWithPerson:person];
    
    ASCNewPersonInteractorType nextType = [self newTypeForType:type];
    
    [interactor setViewController:viewController type:nextType person:person isEditing:isEditing];
    
    viewController.person = person;
    viewController.isEditing = isEditing;
    
    viewController.interactor = interactor;
    
    return viewController;
}

#pragma mark - Private Methods

- (ASCNewPersonInteractorType)newTypeForType:(ASCNewPersonInteractorType)type
{
    switch (type) {
        case ASCNewPersonInteractorTypeName:
            return ASCNewPersonInteractorTypeFirstName;
        case ASCNewPersonInteractorTypeFirstName:
            return ASCNewPersonInteractorTypeSecondName;
        default:
            return ASCNewPersonInteractorTypeSecondName;
    }
}

@end
