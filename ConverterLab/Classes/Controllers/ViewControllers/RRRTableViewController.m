//
//  RRRTableViewController.m
//  ConverterLab
//
//  Created by Roman R on 11.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import "RRRTableViewController.h"
#import "RRRTableViewCell.h"
//#import "RRRNetworkManager.h"

@interface RRRTableViewController ()

@end

@implementation RRRTableViewController
@synthesize dataFetchedResultsController = __dataFetchedResultsController;

static NSString * const RRRCellIdentifier = @"financialOrganizationCell";

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.title = @"Converter Lab";
  UINib * cellNib = [UINib nibWithNibName:@"RRRTableViewCell" bundle:nil];
  [self.tableView registerNib:cellNib forCellReuseIdentifier:RRRCellIdentifier];
  
  UIImage* navBarSearchImage = [UIImage imageNamed:@"ic_search"];
  UIBarButtonItem *navBarSearchButton = [[UIBarButtonItem alloc] initWithImage:navBarSearchImage style:UIBarButtonItemStylePlain target:self action:@selector(navBarSearchButtonPressed)];
  self.navigationItem.rightBarButtonItem = navBarSearchButton;
  self.dataFetchedResultsController.delegate = self;
  [[RRRNetworkManager sharedNetworkManager] refreshDataSourceFromWeb];
  [self addSearchBar];
}
#pragma mark - Search Bar delegate
-(void)addSearchBar
{
    self.searchBar = [[UISearchBar alloc] init];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchBar.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;  
    self.searchController.searchBar.tintColor = [UIColor whiteColor];
}

- (void)navBarSearchButtonPressed{
  self.tableView.tableHeaderView = self.searchController.searchBar;
  self.searchController.active = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
  self.tableView.tableHeaderView = nil;
  self.searchController.searchBar.text = nil;
  [self refreshContent];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
  [self refreshContent]; }

- (void)refreshContent {
  self.dataFetchedResultsController = nil;
  [self dataFetchedResultsController];
  [self.tableView reloadData];}

#pragma mark - CoreData Fetched results controler

- (NSFetchedResultsController *)dataFetchedResultsController
{
  if (__dataFetchedResultsController != nil) {
    return __dataFetchedResultsController;
  }
  
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity = [NSEntityDescription entityForName:@"Organization" inManagedObjectContext:[RRRDataBaseManager sharedDBManager].managedObjectContext];
  [fetchRequest setEntity:entity];
  [fetchRequest setFetchBatchSize:20];
  
  if (self.searchController.searchBar.text != (id)[NSNull null] && self.searchController.searchBar.text > 0)  {
    [fetchRequest setPredicate:[self getPredicate]];
  }
  
  NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:YES];
  NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
  
  [fetchRequest setSortDescriptors:sortDescriptors];
  
  
  NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[RRRDataBaseManager sharedDBManager].managedObjectContext sectionNameKeyPath:nil cacheName:nil];
  
  self.dataFetchedResultsController = aFetchedResultsController;
  
  NSError *error = nil;
  if (![self.dataFetchedResultsController performFetch:&error]) {
    /*
     Replace this implementation with code to handle the error appropriately.
     
     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
     */
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    abort();
  }
  return __dataFetchedResultsController;
}


- (NSCompoundPredicate *)getPredicate {
  
  NSString *searchText = self.searchController.searchBar.text;
  NSString *strippedString = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  NSArray *searchItems = nil;
  if (strippedString.length > 0) {
    searchItems = [strippedString componentsSeparatedByString:@" "];
  }
  
  NSMutableArray *andMatchPredicates = [NSMutableArray array];
  
  for (NSString *searchString in searchItems) {
    NSMutableArray *searchItemsPredicate = [NSMutableArray array];
    
    NSPredicate *finalPredicate = [NSPredicate predicateWithFormat:@"title LIKE[c] %@", [NSString stringWithFormat:@"*%@*",searchString]];
    [searchItemsPredicate addObject:finalPredicate];
    
    finalPredicate = [NSPredicate predicateWithFormat:@"region LIKE[c] %@", [NSString stringWithFormat:@"*%@*",searchString]];
    [searchItemsPredicate addObject:finalPredicate];
    
    finalPredicate = [NSPredicate predicateWithFormat:@"city LIKE[c] %@", [NSString stringWithFormat:@"*%@*",searchString]];
    [searchItemsPredicate addObject:finalPredicate];    
    
    NSCompoundPredicate *orMatchPredicates = [NSCompoundPredicate orPredicateWithSubpredicates:searchItemsPredicate];
    [andMatchPredicates addObject:orMatchPredicates];
  }
    NSCompoundPredicate *finalCompoundPredicate =
  [NSCompoundPredicate andPredicateWithSubpredicates:andMatchPredicates];
  
  return finalCompoundPredicate;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  // NSLog(@"i = %li",[[self.dataFetchedResultsController sections] count]);
  return [[self.dataFetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  id <NSFetchedResultsSectionInfo> sectionInfo = [[self.dataFetchedResultsController sections] objectAtIndex:section];
 // NSLog(@"i = %li",[sectionInfo numberOfObjects]);

  return [sectionInfo numberOfObjects];}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RRRTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RRRCellIdentifier forIndexPath:indexPath];
    
  if (cell == nil) {
    cell = [[RRRTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:RRRCellIdentifier];
  }
  [self configureCell:cell atIndexPath:indexPath];
  return cell;
}

- (void)configureCell:(RRRTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
  NSManagedObject *managedObject = [self.dataFetchedResultsController objectAtIndexPath:indexPath];
  cell.titleLabel.text = [managedObject valueForKey:@"title"];
  cell.regionLabel.text = [managedObject valueForKey:@"region"];
  cell.cityLabel.text = [managedObject valueForKey:@"city"];
  cell.phoneLabel.text = [NSString stringWithFormat:@"Тел: %@",[managedObject valueForKey:@"phone"]];
  cell.addressLabel.text = [NSString stringWithFormat:@"Адрес: %@",[managedObject valueForKey:@"address"]];

}





#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     // Navigation logic may go here, for example:
    // Create the next view controller.
     //*detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];<#DetailViewController#>
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
   // [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - FetchedResultsControllerdelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
  [self.tableView reloadData];
}



@end
