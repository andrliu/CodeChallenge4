//
//  DogsViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "DogsViewController.h"
#import "DetailTableViewCell.h"
#import "AddDogViewController.h"
#import "CoreData.h"
#import "AppDelegate.h"
@interface DogsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *dogsTableView;
@property NSMutableArray *arrayOfDogList;
@property NSManagedObjectContext *managedObjectContext;

@end

@implementation DogsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Dogs";

    AppDelegate *delegate = [[UIApplication sharedApplication]delegate];
    self.managedObjectContext = delegate.managedObjectContext;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.arrayOfDogList = [[self.owner.dogs allObjects] mutableCopy];
    [self.dogsTableView reloadData];
}

#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayOfDogList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"dogCell"];
    Dog *dog = self.arrayOfDogList[indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"Name:\n   %@",dog.name];
    cell.colorLabel.text = [NSString stringWithFormat:@"Color:\n   %@",dog.color];
    cell.breedLabel.text = [NSString stringWithFormat:@"Breed:\n   %@",dog.breed];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CoreData *coreDataManager = [[CoreData alloc]initWithMOC:self.managedObjectContext];
    [coreDataManager removeDogsInCoreDataWithArray:self.arrayOfDogList forRowAtIndexPath:indexPath];

    [self.dogsTableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AddDogViewController *advc = segue.destinationViewController;
    if ([segue.identifier isEqualToString: @"AddDogSegue"])
    {
        advc.owner = self.owner;
    }
    else
    {
        NSIndexPath *indexPath = [self.dogsTableView indexPathForCell:sender];
        Dog *dog = self.arrayOfDogList[indexPath.row];
        advc.dog = dog;
    }
}

@end
