//
//  SubPerson.m
//  Assessment4
//
//  Created by Andrew Liu on 11/13/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "SubPerson.h"

@implementation SubPerson

+ (void)retrieveDogOwnerListFromJsonAPI:(NSString *)jsonString withCompletion:(dogOwnerBlock)complete;
{
    NSURL *url = [NSURL URLWithString:jsonString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
                            {
                               if(!connectionError)
                               {
                                   NSError *JSONError;
                                   NSMutableArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data
                                                                                               options:NSJSONReadingAllowFragments
                                                                                                 error:&JSONError];
                                   if(!JSONError)
                                   {
                                       NSMutableArray *arrayOfDogOwnerList = [@[]mutableCopy];
                                       for (NSString *stringOfDogOwnerName in jsonArray)
                                       {
                                           [arrayOfDogOwnerList addObject:stringOfDogOwnerName];
                                       }

                                       complete(arrayOfDogOwnerList, nil);
                                   }
                                   else
                                   {
                                       complete(nil, JSONError);
                                   }
                               }
                               else
                               {
                                   complete(nil, connectionError);
                               }
                           }];
}

@end
