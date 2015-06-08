//
//  ASCPersonViewController.m
//  ASCViperArchitecture
//
//  Created by Abel Sánchez Custodio on 7/6/15.
//  Copyright (c) 2015 acsanchezcu. All rights reserved.
//

#import "ASCPersonViewController.h"

#import "ASCPersonInteractor.h"


@interface ASCPersonViewController ()
<ASCNewPersonViewControllerInterface, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end


@implementation ASCPersonViewController

#pragma mark - Init

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initialize];
}

#pragma mark - Actions

- (void)handleTap:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
}

- (void)userDidTapSaveButton
{
    [self.view endEditing:YES];
    
    [self.interactor userDidTapSaveButton];
}

- (void)userDidTapNextButton
{
    [self.interactor userDidTapNextButton];
}

- (void)userDidTapCancelButton
{
    [self.interactor userDidTapCancelButton];
}

#pragma mark - Override Methods

- (void)showMessage:(NSString *)message withTitle:(NSString *)title
{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    __weak typeof(self) this = self;
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action) {
                                   [this.interactor userDidTapOkButton];
                               }];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Private Methods

- (void)initialize
{    
    UITapGestureRecognizer *tapMainView = [[UITapGestureRecognizer alloc]init];
    [tapMainView addTarget:self action:@selector(handleTap:)];
    
    [self.view addGestureRecognizer:tapMainView];
    
    [self.interactor viewIsLoad];
}

#pragma mark - DELEGATES

#pragma mark - ASCNewPersonViewControllerInterface

- (void)printTextOnTextField:(NSString *)text
{
    self.textField.text = text;
}

- (void)printTitle:(NSString *)title
{
    self.title = title;
}

- (void)printPlaceholder:(NSString *)placeholder
{
    self.textField.placeholder = placeholder;
}

- (void)addSaveButton
{
    UIBarButtonItem *saveButtomItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(userDidTapSaveButton)];
    
    self.navigationItem.rightBarButtonItem = saveButtomItem;
}

- (void)addNextButton
{
    UIBarButtonItem *nextButtomItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(userDidTapNextButton)];
    
    self.navigationItem.rightBarButtonItem = nextButtomItem;
}

- (void)addCancelButton
{
    UIBarButtonItem *cancelButtomItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(userDidTapCancelButton)];
    
    self.navigationItem.leftBarButtonItem = cancelButtomItem;
}

#pragma mark - 

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *textChanged = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    [self.interactor userChangeText:textChanged];
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [self.interactor userChangeText:@""];
    
    return YES;
}

@end
