//
//  AddDogViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "AddDogViewController.h"
#import "CoreData.h"
#import "AppDelegate.h"

@interface AddDogViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *breedTextField;
@property (weak, nonatomic) IBOutlet UITextField *colorTextField;
@property NSManagedObjectContext *managedObjectContext;

@end

@implementation AddDogViewController

//TODO: UPDATE CODE ACCORIDNGLY

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Add Dog";

    AppDelegate *delegate = [[UIApplication sharedApplication]delegate];
    self.managedObjectContext = delegate.managedObjectContext;

    self.nameTextField.text = self.dog.name;
    self.breedTextField.text = self.dog.breed;
    self.colorTextField.text = self.dog.color;
}

- (IBAction)onPressedUpdateDog:(UIButton *)sender
{
    self.dog.name = self.nameTextField.text;
    self.dog.color = self.colorTextField.text;
    self.dog.breed = self.breedTextField.text;

    NSString *nameString = self.nameTextField.text;
    NSString *colorString = self.colorTextField.text;
    NSString *breedString = self.breedTextField.text;

    CoreData *coreDataManager = [[CoreData alloc]initWithMOC:self.managedObjectContext];
    [coreDataManager storeDogsByNameString:nameString
                             byColorString:colorString
                             byBreedString:breedString
                                 wtihOwner:self.owner];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
