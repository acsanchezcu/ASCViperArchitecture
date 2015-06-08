//
//  PersonsPersister.h
//  ASCViperArchitecture
//
//  Created by Abel Sánchez Custodio on 7/6/15.
//  Copyright (c) 2015 acsanchezcu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASCPersonsPersister : NSObject

@property (strong, nonatomic) NSMutableArray *persons;

+ (instancetype)shared;

@end
