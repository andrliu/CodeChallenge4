//
//  SubPerson.h
//  Assessment4
//
//  Created by Andrew Liu on 11/13/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "Person.h"

typedef void(^dogOwnerBlock)(NSMutableArray *arrayOfDogOwnerList, NSError *connectionError);

@interface SubPerson : Person

+ (void)retrieveDogOwnerListFromJsonAPI:(NSString *)jsonString withCompletion:(dogOwnerBlock)complete;

@end
