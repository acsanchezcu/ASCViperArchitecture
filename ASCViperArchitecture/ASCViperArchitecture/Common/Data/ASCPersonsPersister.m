//
//  PersonsPersister.m
//  ASCViperArchitecture
//
//  Created by Abel Sánchez Custodio on 7/6/15.
//  Copyright (c) 2015 acsanchezcu. All rights reserved.
//

#import "ASCPersonsPersister.h"

@implementation ASCPersonsPersister

+ (instancetype)shared
{
    static id instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _persons = [NSMutableArray array];
    }
    
    return self;
}

@end
