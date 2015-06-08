//
//  ASCPersonViewController.h
//  ASCViperArchitecture
//
//  Created by Abel Sánchez Custodio on 7/6/15.
//  Copyright (c) 2015 acsanchezcu. All rights reserved.
//

#import "ASCViewController.h"


@class ASCPerson;
@class ASCPersonInteractor;


@interface ASCPersonViewController : ASCViewController

@property (strong, nonatomic) ASCPersonInteractor *interactor;

@property (strong, nonatomic) ASCPerson *person;
@property (assign, nonatomic) BOOL isEditing;

@end
