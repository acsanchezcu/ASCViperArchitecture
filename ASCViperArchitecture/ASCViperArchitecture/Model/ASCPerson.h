//
//  ASCPerson.h
//  ASCViperArchitecture
//
//  Created by Abel Sánchez Custodio on 5/6/15.
//  Copyright (c) 2015 acsanchezcu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ASCPerson : NSObject
<NSCopying>

@property (assign, nonatomic) NSInteger personId;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *secondName;

@end
