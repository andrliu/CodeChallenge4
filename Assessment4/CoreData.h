//
//  CoreData.h
//  Assessment4
//
//  Created by Andrew Liu on 11/13/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "Person.h"
#import "Dog.h"

@interface CoreData : NSObject

@property NSManagedObjectContext *managedObjectContext;

- (instancetype)initWithMOC:(NSManagedObjectContext*)managedObjectContext;

- (NSMutableArray *)retrieveListFrom:(NSString *)stringFromClass;

- (void)removeDogsInCoreDataWithArray:(NSMutableArray *)arrayOfDogList forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)storeOwnersListByArray:(NSMutableArray *)arrayOfDogOwnerList;

- (void)storeDogsByNameString:(NSString *)nameString byColorString:(NSString *)colorString byBreedString:(NSString *)breedString wtihOwner:(Person *)owner;

@end
