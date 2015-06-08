//
//  ASCHomeInteractor.m
//  ASCViperArchitecture
//
//  Created by Abel Sánchez Custodio on 5/6/15.
//  Copyright (c) 2015 acsanchezcu. All rights reserved.
//

#import "ASCHomeInteractor.h"

#import "ASCPerson.h"
#import "ASCPersonsPersister.h"
#import "ASCHomeViewController.h"


@interface ASCHomeInteractor ()

@property (weak, nonatomic) ASCHomeViewController<ASCHomeViewControllerInterface> *viewController;

@end

@implementation ASCHomeInteractor

#pragma mark - Init

- (instancetype)initWithViewController:(ASCHomeViewController<ASCHomeViewControllerInterface> *)viewController
{
    self = [super init];
    
    if (self)
    {
        _viewController = viewController;
    }
    
    return self;
}

#pragma mark - Custom Accesors

- (NSArray *)persons
{
    return [ASCPersonsPersister shared].persons;
}

#pragma mark - Public Methods

- (void)viewIsShown
{    
    [self.viewController printPersons:self.persons];
}

- (void)userRemovePerson:(ASCPerson *)person
{
    [[ASCPersonsPersister shared].persons removeObject:person];
}

- (void)userDidTapOnNewPersonButton
{
    [self.viewController navigateToNewPersonController];
}

- (void)userDidTapOnPerson
{
    [self.viewController navigateToNewPersonController];
}

@end
