//
//  ASCPersonInteractor.h
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
- (void)addCancelButton;
- (void)addSaveButton;
- (void)addNextButton;
- (void)printTitle:(NSString *)title;
- (void)printPlaceholder:(NSString *)placeholder;

@end


typedef enum : NSUInteger {
    ASCPersonInteractorTypeName,
    ASCPersonInteractorTypeFirstName,
    ASCPersonInteractorTypeSecondName,
} ASCPersonInteractorType;


@interface ASCPersonInteractor : ASCInteractor

- (instancetype)initWithPerson:(ASCPerson *)person viewController:(ASCViewController<ASCNewPersonViewControllerInterface> *)viewController type:(ASCPersonInteractorType)type isEditing:(BOOL)isEditing;

- (void)viewIsLoad;

- (void)userChangeText:(NSString *)text;
- (void)userDidTapCancelButton;
- (void)userDidTapSaveButton;
- (void)userDidTapNextButton;
- (void)userDidTapOkButton;

@end
