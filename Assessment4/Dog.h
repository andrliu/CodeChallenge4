//
//  Dog.h
//  Assessment4
//
//  Created by Andrew Liu on 11/13/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Dog : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) NSString * breed;
@property (nonatomic, retain) NSManagedObject *person;

@end
