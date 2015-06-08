//
//  ASCHomeViewController.m
//  ASCViperArchitecture
//
//  Created by Abel Sánchez Custodio on 5/6/15.
//  Copyright (c) 2015 acsanchezcu. All rights reserved.
//

#import "ASCHomeViewController.h"

#import "ASCPerson.h"

#import "ASCHomeInteractor.h"
#import "ASCPersonViewController.h"
#import "ASCPersonInteractor.h"


NSString * const CellIdentifier = @"CellIdentifier";
NSString * const goToNewFlow = @"goToNewFlow";


@interface ASCHomeViewController()
<ASCHomeViewControllerInterface>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *persons;
@property (strong, nonatomic) ASCHomeInteractor *interactor;

@end


@implementation ASCHomeViewController

#pragma mark - Init

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initialize];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.interactor viewIsShown];
}

#pragma mark - Actions

- (IBAction)userDidTapOnNewPersonButton:(id)sender
{
    [self.interactor userDidTapOnNewPersonButton];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:goToNewFlow])
    {
        UINavigationController *navigationController = segue.destinationViewController;

        ASCPersonViewController<ASCNewPersonViewControllerInterface> *viewController = (ASCPersonViewController<ASCNewPersonViewControllerInterface> *)navigationController.topViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        ASCPerson *person = nil;
        
        if (indexPath)
        {
            person = self.persons[indexPath.row];
            
            viewController.person = [person copy];
            
            viewController.isEditing = YES;
        }
        
        ASCPersonInteractor *interactor = [[ASCPersonInteractor alloc] initWithPerson:person viewController:viewController type:ASCPersonInteractorTypeName isEditing:viewController.isEditing];
        
        viewController.interactor = interactor;
    }
}

#pragma mark - Private Methods

- (void)initialize
{
    self.interactor = [[ASCHomeInteractor alloc] initWithViewController:self];
    
    self.title = @"PERSONS";
}

#pragma mark - DELEGATES

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.persons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    [self configureCell:cell forRowAtIndexPath:indexPath];

    return cell;
}

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ASCPerson *person = self.persons[indexPath.row];
    
    NSString *personDescription = [NSString stringWithFormat:@"%@ %@ %@", person.name, person.firstName, person.secondName];
    
    cell.textLabel.text = personDescription;
    
    cell.editing = YES;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        ASCPerson *person = self.persons[indexPath.row];
        
        [self.interactor userRemovePerson:person];
        
        self.persons = self.interactor.persons;
        
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.tableView endUpdates];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.interactor userDidTapOnPerson];
}

#pragma mark - ASCHomeViewControllerInterface

- (void)printPersons:(NSArray *)persons
{
    self.persons = persons;
    
    [self.tableView reloadData];
}

- (void)navigateToNewPersonController
{
    [self performSegueWithIdentifier:goToNewFlow sender:self];
}

@end
