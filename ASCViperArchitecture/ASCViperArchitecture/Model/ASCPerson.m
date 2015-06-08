//
//  ASCPerson.m
//  ASCViperArchitecture
//
//  Created by Abel Sánchez Custodio on 5/6/15.
//  Copyright (c) 2015 acsanchezcu. All rights reserved.
//

#import "ASCPerson.h"

@implementation ASCPerson

#pragma mark - Init

- (id)copyWithZone:(NSZone *)zone
{
    ASCPerson *person = [[ASCPerson allocWithZone:zone] init];
    
    person.personId = self.personId;
    
    person.name = self.name;
    person.firstName = self.firstName;
    person.secondName = self.secondName;
    
    return person;
}

#pragma mark - Custom Accessors

- (NSString *)firstName
{
    if (_firstName.length == 0)
    {
        return @"";
    }
    
    return _firstName;
}

- (NSString *)secondName
{
    if (_secondName.length == 0)
    {
        return @"";
    }
    
    return _secondName;
}

@end
