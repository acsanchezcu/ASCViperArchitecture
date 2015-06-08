//
//  ASCHomeInteractor.h
//  ASCViperArchitecture
//
//  Created by Abel Sánchez Custodio on 5/6/15.
//  Copyright (c) 2015 acsanchezcu. All rights reserved.
//

#import "ASCInteractor.h"


@class ASCHomeViewController;
@class ASCPerson;


@protocol ASCHomeViewControllerInterface <NSObject>

- (void)navigateToNewPersonController;
- (void)printPersons:(NSArray *)persons;

@end


@interface ASCHomeInteractor : ASCInteractor

@property (strong, nonatomic) NSArray *persons;

- (instancetype)initWithViewController:(ASCHomeViewController<ASCHomeViewControllerInterface> *)viewController;

- (void)viewIsShown;

- (void)userRemovePerson:(ASCPerson *)person;
- (void)userDidTapOnNewPersonButton;
- (void)userDidTapOnPerson;

@end
