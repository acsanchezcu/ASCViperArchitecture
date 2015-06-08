//
//  ASCPersonInteractor.m
//  ASCViperArchitecture
//
//  Created by Abel Sánchez Custodio on 5/6/15.
//  Copyright (c) 2015 acsanchezcu. All rights reserved.
//

#import "ASCPersonInteractor.h"

#import "ASCPerson.h"

#import "ASCPersonViewController.h"
#import "ASCViewControllerFactory.h"
#import "ASCPersonsPersister.h"


@interface ASCPersonInteractor ()

@property (weak, nonatomic) ASCViewController<ASCNewPersonViewControllerInterface> *viewController;
@property (strong, nonatomic) ASCPerson *person;
@property (assign, nonatomic) ASCPersonInteractorType type;
@property (assign, nonatomic) BOOL isEditing;

@property (assign, nonatomic) BOOL flowFinished;

@property (strong, nonatomic) ASCViewControllerFactory *factory;

@end


@implementation ASCPersonInteractor

#pragma mark - Init

- (instancetype)initWithPerson:(ASCPerson *)person viewController:(ASCViewController<ASCNewPersonViewControllerInterface> *)viewController type:(ASCPersonInteractorType)type isEditing:(BOOL)isEditing
{
    self = [self init];
    
    if (self)
    {
        _viewController = viewController;
        _type = type;
        _person = (person) ? person : [[ASCPerson alloc] init];
        _isEditing = isEditing;
    }
    
    return self;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _factory = [[ASCViewControllerFactory alloc] init];
    }
    
    return self;
}

#pragma mark - Public Methods

- (void)viewIsLoad
{
    NSString *title = @"";
    NSString *placeHolder = @"";
    NSString *textFieldValue = @"";
    
    switch (self.type)
    {
        case ASCPersonInteractorTypeName:
            title = (self.isEditing) ? @"Edit name" : @"Insert name";
            placeHolder = @"name";
            textFieldValue = self.person.name;
            [self.viewController addCancelButton];
            [self.viewController addNextButton];
            break;
        case ASCPersonInteractorTypeFirstName:
            title = (self.isEditing) ? @"Edit firstName" : @"Insert firstName";
            placeHolder = @"first name";
            textFieldValue = self.person.firstName;
            [self.viewController addNextButton];
            break;
        case ASCPersonInteractorTypeSecondName:
            title = (self.isEditing) ? @"Edit secondName" : @"Insert secondName";
            placeHolder = @"second name";
            textFieldValue = self.person.secondName;
            [self.viewController addSaveButton];
            break;
    }
    
    [self.viewController printTitle:title];
    [self.viewController printPlaceholder:placeHolder];
    [self.viewController printTextOnTextField:textFieldValue];
}

- (void)userChangeText:(NSString *)text
{
    switch (self.type)
    {
        case ASCPersonInteractorTypeName:
            self.person.name = text;
            break;
        case ASCPersonInteractorTypeFirstName:
            self.person.firstName = text;
            break;
        case ASCPersonInteractorTypeSecondName:
            self.person.secondName = text;
            break;
    }
}

- (void)userDidTapCancelButton
{
    [self.viewController dismissViewController:YES];
}

- (void)userDidTapNextButton
{
    if ([self validateFields])
    {
        ASCViewController *viewController = [self.factory viewControllerWithPerson:self.person type:self.type isEditing:self.isEditing];
        
        [self.viewController navigateTo:viewController animated:YES];
    }
}

- (void)userDidTapSaveButton
{
    if ([self validateFields])
    {
        NSString *title = @"";
        NSString *message = @"";
        
        if (self.isEditing)
        {
            for (ASCPerson *person in [ASCPersonsPersister shared].persons)
            {
                if (person.personId == self.person.personId)
                {
                    person.name = self.person.name;
                    person.firstName = self.person.firstName;
                    person.secondName = self.person.secondName;
                    
                    break;
                }
            }
            
            title = @"Person modified!";
            message = [NSString stringWithFormat:@"%@ has been modified successfully",self.person.name];
        }
        else
        {
            self.person.personId = [ASCPersonsPersister shared].persons.count;
            
            [[ASCPersonsPersister shared].persons addObject:self.person];
            
            title = @"Person added!";
            message = [NSString stringWithFormat:@"%@ has been added successfully",self.person.name];
        }
        
        self.flowFinished = YES;
        
        [self.viewController showMessage:title withTitle:message];
    }
}

- (void)userDidTapOkButton
{
    if (self.flowFinished)
    {
        [self.viewController dismissViewController:YES];
    }
}

#pragma mark - Private Methods

- (BOOL)validateFields
{
    NSString *text = @"";
    NSString *errorText = @"";
    
    switch (self.type)
    {
        case ASCPersonInteractorTypeName:
            text = self.person.name;
            errorText = @"Name is mandatory";
            break;
        case ASCPersonInteractorTypeFirstName:
            text = self.person.firstName;
            errorText = @"First name is mandatory";
            break;
        case ASCPersonInteractorTypeSecondName:
            text = self.person.secondName;
            errorText = @"Second name is mandatory";
            break;
    }
    
    if (text.length == 0)
    {
        [self.viewController showMessage:errorText withTitle:@"Error"];
        
        return NO;
    }
    
    return YES;
}

@end
