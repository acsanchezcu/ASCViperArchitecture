//
//  ASCNewPersonInteractor.m
//  ASCViperArchitecture
//
//  Created by Abel Sánchez Custodio on 5/6/15.
//  Copyright (c) 2015 acsanchezcu. All rights reserved.
//

#import "ASCNewPersonInteractor.h"

#import "ASCPerson.h"

#import "ASCNewPersonViewController.h"
#import "ASCViewControllerFactory.h"
#import "ASCPersonsPersister.h"


@interface ASCNewPersonInteractor ()

@property (weak, nonatomic) ASCViewController<ASCNewPersonViewControllerInterface> *viewController;
@property (strong, nonatomic) ASCPerson *person;
@property (assign, nonatomic) ASCNewPersonInteractorType type;
@property (assign, nonatomic) BOOL isEditing;

@property (assign, nonatomic) BOOL flowFinished;

@property (strong, nonatomic) ASCViewControllerFactory *factory;

@end


@implementation ASCNewPersonInteractor

#pragma mark - Init

- (instancetype)initWithPerson:(ASCPerson *)person
{
    self = [super init];
    
    if (self)
    {
        _person = (person) ? person : [[ASCPerson alloc] init];
        _factory = [[ASCViewControllerFactory alloc] init];
    }
    
    return self;
}

#pragma mark - Public Methods

- (void)setViewController:(ASCViewController<ASCNewPersonViewControllerInterface> *)viewController type:(ASCNewPersonInteractorType)type person:(ASCPerson *)person isEditing:(BOOL)isEditing
{
    _viewController = viewController;
    _type = type;
    _person = (person) ? person : [[ASCPerson alloc] init];
    _isEditing = isEditing;
}

- (void)viewIsLoad
{
    NSString *title = @"";
    NSString *placeHolder = @"";
    NSString *textFieldValue = @"";
    
    switch (self.type)
    {
        case ASCNewPersonInteractorTypeName:
            title = (self.isEditing) ? @"Edit name" : @"Insert name";
            placeHolder = @"name";
            textFieldValue = self.person.name;
            [self.viewController printCancelButton];
            [self.viewController printNextButton];
            break;
        case ASCNewPersonInteractorTypeFirstName:
            title = (self.isEditing) ? @"Edit firstName" : @"Insert firstName";
            placeHolder = @"first name";
            textFieldValue = self.person.firstName;
            [self.viewController printNextButton];
            break;
        case ASCNewPersonInteractorTypeSecondName:
            title = (self.isEditing) ? @"Edit secondName" : @"Insert secondName";
            placeHolder = @"second name";
            textFieldValue = self.person.secondName;
            [self.viewController printSaveButton];
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
        case ASCNewPersonInteractorTypeName:
            self.person.name = text;
            break;
        case ASCNewPersonInteractorTypeFirstName:
            self.person.firstName = text;
            break;
        case ASCNewPersonInteractorTypeSecondName:
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
        case ASCNewPersonInteractorTypeName:
            text = self.person.name;
            errorText = @"Name is mandatory";
            break;
        case ASCNewPersonInteractorTypeFirstName:
            text = self.person.firstName;
            errorText = @"First name is mandatory";
            break;
        case ASCNewPersonInteractorTypeSecondName:
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
