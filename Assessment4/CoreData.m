//
//  CoreData.m
//  Assessment4
//
//  Created by Andrew Liu on 11/13/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "CoreData.h"

@implementation CoreData

- (instancetype)initWithMOC:(NSManagedObjectContext*)managedObjectContext;
{
    self = [super init];
    self.managedObjectContext = managedObjectContext;
    return self;
}

- (NSMutableArray *)retrieveListFrom:(NSString *)stringFromClass;
{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:stringFromClass];
    NSSortDescriptor *sortByActorName = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
    request.sortDescriptors = @[sortByActorName];
    NSMutableArray *arrayOfList = [@[] mutableCopy];
    arrayOfList = [[self.managedObjectContext executeFetchRequest:request error:nil] mutableCopy];
    return arrayOfList;
}

- (void)removeDogsInCoreDataWithArray:(NSMutableArray *)arrayOfDogList forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Dog *dog = [arrayOfDogList objectAtIndex:indexPath.row];
    [self.managedObjectContext deleteObject:dog];
    [arrayOfDogList removeObjectAtIndex:indexPath.row];
    [self.managedObjectContext save:nil];
}

- (void)storeOwnersListByArray:(NSMutableArray *)arrayOfDogOwnerList;
{
    for (NSString *nameString in arrayOfDogOwnerList)
    {
        Person *owner = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
        owner.name = nameString;
    }
    [self.managedObjectContext save:nil];
}

- (void)storeDogsByNameString:(NSString *)nameString byColorString:(NSString *)colorString byBreedString:(NSString *)breedString wtihOwner:(Person *)owner
{
    Dog *dog = [NSEntityDescription insertNewObjectForEntityForName:@"Dog" inManagedObjectContext:self.managedObjectContext];
    dog.name = nameString;
    dog.color = colorString;
    dog.breed = breedString;
    [owner addDogsObject:dog];
    [self.managedObjectContext save:nil];
}


@end
