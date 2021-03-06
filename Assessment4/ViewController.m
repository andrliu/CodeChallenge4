//
//  ViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "ViewController.h"
#import "DogsViewController.h"
#import "AppDelegate.h"
#import "SubPerson.h"
#import "CoreData.h"

#define kJsonAPI @"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/25/owners.json"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property UIAlertView *addAlert;
@property UIAlertView *colorAlert;
@property NSMutableArray *arrayOfDogOwnerList;
@property NSManagedObjectContext *managedObjectContext;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Dog Owners";

    AppDelegate *delegate = [[UIApplication sharedApplication]delegate];
    self.managedObjectContext = delegate.managedObjectContext;

    CoreData *coreDataManager = [[CoreData alloc]initWithMOC:self.managedObjectContext];
    self.arrayOfDogOwnerList = [coreDataManager retrieveListFrom:NSStringFromClass([Person class])];

    if (self.arrayOfDogOwnerList.count == 0)
    {
        [SubPerson retrieveDogOwnerListFromJsonAPI:kJsonAPI withCompletion:^(NSMutableArray *arrayOfDogOwnerList, NSError *connectionError)
        {
            if (!connectionError)
            {
                self.arrayOfDogOwnerList = arrayOfDogOwnerList; //load arrayOfList from json

                [coreDataManager storeOwnersListByArray:self.arrayOfDogOwnerList]; //store arrayOfList to core data

                self.arrayOfDogOwnerList = [coreDataManager retrieveListFrom:NSStringFromClass([Person class])]; //replace arrayOfList from core data

                [self.myTableView reloadData];
            }
            else
            {
                [self Error:connectionError];
            }
        }];
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *userDefaultColor = [userDefaults objectForKey:@"defaultColor"];
    UIColor *defaultColor = [NSKeyedUnarchiver unarchiveObjectWithData:userDefaultColor];
    self.navigationController.navigationBar.tintColor = defaultColor;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self.myTableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DogsViewController *dvc = segue.destinationViewController;
    NSIndexPath *indexPath = [self.myTableView indexPathForCell:sender];
    Person *owner = self.arrayOfDogOwnerList[indexPath.row];
    dvc.owner = owner;
}

#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayOfDogOwnerList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"myCell"];
    Person *owner = self.arrayOfDogOwnerList[indexPath.row];
    cell.textLabel.text = owner.name;
    return cell;
}

#pragma mark - UIAlertView Methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //TODO: SAVE USER'S DEFAULT COLOR PREFERENCE USING THE CONDITIONAL BELOW

    if (buttonIndex == 0)
    {
        [self standardUserDefaultsWith:[UIColor redColor]];
    }
    else if (buttonIndex == 1)
    {
        [self standardUserDefaultsWith:[UIColor brownColor]];
    }
    else if (buttonIndex == 2)
    {
        [self standardUserDefaultsWith:[UIColor orangeColor]];
    }
    else if (buttonIndex == 3)
    {
        [self standardUserDefaultsWith:[UIColor greenColor]];
    }

}

- (void)standardUserDefaultsWith:(UIColor *)color
{
    self.navigationController.navigationBar.tintColor = color;
    NSData *userDefaultColor = [NSKeyedArchiver archivedDataWithRootObject:color];
    [[NSUserDefaults standardUserDefaults] setObject:userDefaultColor forKey:@"defaultColor"];
}


- (void)Error:(NSError *)error
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:error.localizedDescription
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault
                                                   handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

//METHOD FOR PRESENTING USER'S COLOR PREFERENCE
- (IBAction)onColorButtonTapped:(UIBarButtonItem *)sender
{
    self.colorAlert = [[UIAlertView alloc] initWithTitle:@"Choose a default color!"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Red", @"Brown", @"Orange", @"Green", nil];
    self.colorAlert.tag = 1;
    [self.colorAlert show];
}

@end
