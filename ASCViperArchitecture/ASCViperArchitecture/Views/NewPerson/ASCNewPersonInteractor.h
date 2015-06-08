//
//  ASCNewPersonInteractor.h
//  ASCViperArchitecture
//
//  Created by Abel Sánchez Custodio on 5/6/15.
//  Copyright (c) 2015 acsanchezcu. All rights reserved.
//

#import "ASCInteractor.h"


@class ASCViewController;
@class ASCPerson;


@protocol ASCNewPersonViewControllerInterface <NSObject>

- (void)printTextOnTextField:(NSString *)text;
- (void)printCancelButton;
- (void)printSaveButton;
- (void)printNextButton;
- (void)printTitle:(NSString *)title;
- (void)printPlaceholder:(NSString *)placeholder;

@optional


@end


typedef enum : NSUInteger {
    ASCNewPersonInteractorTypeName,
    ASCNewPersonInteractorTypeFirstName,
    ASCNewPersonInteractorTypeSecondName,
} ASCNewPersonInteractorType;


@interface ASCNewPersonInteractor : ASCInteractor

- (instancetype)initWithPerson:(ASCPerson *)person;

- (void)setViewController:(ASCViewController<ASCNewPersonViewControllerInterface> *)viewController type:(ASCNewPersonInteractorType)type person:(ASCPerson *)person isEditing:(BOOL)isEditing;

- (void)viewIsLoad;

- (void)userChangeText:(NSString *)text;
- (void)userDidTapCancelButton;
- (void)userDidTapSaveButton;
- (void)userDidTapNextButton;
- (void)userDidTapOkButton;

@end
