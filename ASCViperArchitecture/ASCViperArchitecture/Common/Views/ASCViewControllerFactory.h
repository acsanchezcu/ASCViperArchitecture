//
//  ASCViewControllerFactory.h
//  ASCViperArchitecture
//
//  Created by Abel Sánchez Custodio on 7/6/15.
//  Copyright (c) 2015 acsanchezcu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ASCNewPersonInteractor.h"


@class ASCPerson;


@interface ASCViewControllerFactory : NSObject

- (ASCViewController *)viewControllerWithPerson:(ASCPerson *)person type:(ASCNewPersonInteractorType )type isEditing:(BOOL)isEditing;

@end
