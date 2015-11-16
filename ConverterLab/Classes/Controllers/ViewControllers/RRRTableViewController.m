//
//  RRRTableViewController.m
//  ConverterLab
//
//  Created by Roman R on 11.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import "RRRTableViewController.h"
#import "RRRNavigationController.h"


@interface RRRTableViewController ()
@property (nonatomic, strong)  UIView * overlayView;
@property (nonatomic, strong) NSMutableArray * fetchedArray;
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
  [RRRDataBaseManager sharedDBManager].delegateInstance = self;
  [self lockUI];
  [[RRRNetworkManager sharedNetworkManager] refreshDataSourceFromWeb];
  [self addSearchBar];
  self.navigationItem.backBarButtonItem =
  [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
 [self refreshDataArray];
}

- (void)refreshDataArray {
  self.fetchedArray = [[NSMutableArray alloc] init];
  for (NSInteger i = 0; i<[self.dataFetchedResultsController fetchedObjects].count; i++) {
    NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
    NSManagedObject *managedObject = [self.dataFetchedResultsController objectAtIndexPath:path];
    NSArray *keys = [[[managedObject entity] attributesByName] allKeys];
    NSDictionary *dict = [managedObject dictionaryWithValuesForKeys:keys];
    [self.fetchedArray addObject:dict];
  }
    if (self.searchController.searchBar.text != (id)[NSNull null] && self.searchController.searchBar.text > 0)  {
      self.fetchedArray = [[self.fetchedArray filteredArrayUsingPredicate:[self getPredicate]] mutableCopy];
    }
  [self.tableView reloadData];
}

- (void) viewWillAppear:(BOOL)animated {
  RRRNavigationController * navController = (RRRNavigationController *)self.navigationController;
  if (navController.hamburgerButton) {
  [navController.hamburgerButton removeFromSuperview];
  }
}

-(void)addSearchBar
{
  self.searchBar = [[UISearchBar alloc] init];
  self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
  self.searchController.searchBar.delegate = self;
  self.searchController.searchResultsUpdater = self;
  self.searchController.dimsBackgroundDuringPresentation = NO;
  self.searchController.searchBar.tintColor = [UIColor whiteColor];
}

- (void)navBarSearchButtonPressed{
  self.tableView.tableHeaderView = self.searchController.searchBar;
  self.searchController.active = YES;
}

#pragma mark - Table Cell Buttons delegate

- (void)buttonURLPressed:(NSNumber *)tableRow {
  NSIndexPath *path = [NSIndexPath indexPathForRow:[tableRow integerValue] inSection:0];
  NSManagedObject *managedObject = [self.dataFetchedResultsController objectAtIndexPath:path];
  NSURL *url = [NSURL URLWithString:[managedObject valueForKey:@"link"]];
  [[UIApplication sharedApplication] openURL:url];
}

- (void)buttonMapPressed:(NSNumber *)tableRow {
  NSInteger i = [tableRow integerValue];
  NSString * fullAddressString = [NSString stringWithFormat:@"Ukraine, %@, %@, %@",[self.fetchedArray[i] valueForKey:@"region"],[self.fetchedArray[i] valueForKey:@"city"],[self.fetchedArray[i] valueForKey:@"address"]];
  CLGeocoder *geocoder = [[CLGeocoder alloc] init];
  [geocoder geocodeAddressString:fullAddressString completionHandler:^(NSArray *placemarks, NSError *error) {
    if (error != nil)  {      
      [self displayError:[NSString stringWithFormat:@"Geocode failed with error: %@", error]];
      return;
    }
    CLPlacemark *placemark = (CLPlacemark *)placemarks[0];
    RRRMapViewController * locationViewController = [RRRMapViewController new];
    locationViewController.location = placemark.location;
    locationViewController.title = [self.fetchedArray[i] valueForKey:@"title"];
    [self.navigationController pushViewController:locationViewController animated:YES];
  }];
}

- (void)buttonCallPressed:(NSNumber *)tableRow {
  NSInteger i = [tableRow integerValue];
  NSString *cleanedString = [[[self.fetchedArray[i] valueForKey:@"phone"] componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
  NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:+38%@", cleanedString]];
 // [[UIApplication sharedApplication] openURL:telURL];
   NSLog(@"calling to %@",telURL);
}

- (void)buttonDetailedInfoPressed:(NSNumber *)tableRow {
   NSInteger i = [tableRow integerValue];
   RRRSingleOrganization * singleOrganization = [[RRRSingleOrganization alloc]
    initWithTitle:[self.fetchedArray[i] valueForKey:@"title"]
    withRegion:[self.fetchedArray[i] valueForKey:@"region"]
    withCity:[self.fetchedArray[i] valueForKey:@"city"]
    withAddress:[self.fetchedArray[i] valueForKey:@"address"]
    withPhone:[self.fetchedArray[i] valueForKey:@"phone"]
    withLink:[self.fetchedArray[i] valueForKey:@"link"]
    withCurrencies:[NSKeyedUnarchiver unarchiveObjectWithData:[self.fetchedArray[i] valueForKey:@"currencies"]]];
  RRRDetailedTableViewController * detailedTableViewController = [RRRDetailedTableViewController new];
  detailedTableViewController.singleOrganization = singleOrganization;
  [self.navigationController pushViewController:detailedTableViewController animated:YES];
}


#pragma mark - Search Bar delegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
  self.tableView.tableHeaderView = nil;
  self.searchController.searchBar.text = nil;
}

#pragma mark - CoreData Fetched results controler

- (NSFetchedResultsController *)dataFetchedResultsController {
  if (__dataFetchedResultsController != nil) {
    return __dataFetchedResultsController;
  }
  
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity = [NSEntityDescription entityForName:@"Organization" inManagedObjectContext:[RRRDataBaseManager sharedDBManager].managedObjectContext];
  [fetchRequest setEntity:entity];
  [fetchRequest setFetchBatchSize:20];
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

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
  [self refreshDataArray];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
return self.fetchedArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RRRTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RRRCellIdentifier forIndexPath:indexPath];
  if (cell == nil) {
    cell = [[RRRTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RRRCellIdentifier];
  }
  [self configureCell:cell atIndexPath:indexPath];
  return cell;
}

- (void)configureCell:(RRRTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
  NSInteger i = indexPath.row;
  cell.titleLabel.text = [self.fetchedArray[i] valueForKey:@"title"];
  cell.regionLabel.text = [self.fetchedArray[i] valueForKey:@"region"];
  cell.cityLabel.text = [self.fetchedArray[i] valueForKey:@"city"];
  cell.phoneLabel.text = [NSString stringWithFormat:@"Тел: %@",[self.fetchedArray[i] valueForKey:@"phone"]];
  cell.addressLabel.text = [NSString stringWithFormat:@"Адрес: %@",[self.fetchedArray[i] valueForKey:@"address"]];
  cell.delegateInstance = self;
  cell.linkButton.tag = indexPath.row;
  cell.mapButton.tag = indexPath.row;
  cell.callButton.tag = indexPath.row;
  cell.detailsButton.tag = indexPath.row;
  [cell.borderBottom removeFromSuperlayer];
}

#pragma mark - FetchedResultsControllerdelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
  [self refreshDataArray];
  [self unlockUI];
}

#pragma mark - Data Base Manager delegate

- (void)dataBaseNotUpdated {
  [self unlockUI];
  //NSLog(@"Not updated");
  [self displayError:@"Server not found \n Data not updated"];
}

#pragma mark - other
- (void)displayError:(NSString *)message
{
  dispatch_async(dispatch_get_main_queue(),^ {
    UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:@"Message"
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok =
    [UIAlertAction actionWithTitle:@"OK"style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                           }];
    [alertController addAction:ok];
    [self presentViewController:alertController animated:YES completion:nil];
  });
}


- (void) lockUI {
  self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
  self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
  UILabel * statusLabel =[[UILabel alloc] initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height-20, [UIScreen mainScreen].bounds.size.width, 20)];
  statusLabel.backgroundColor = [UIColor colorwithHexString:@"#b0bec5" alpha:0.8];
  statusLabel.text = @"Updating...";
  statusLabel.textColor = [UIColor whiteColor];
  [self.overlayView addSubview:statusLabel];
  [self.navigationController.view addSubview:self.overlayView];
}

-(void) unlockUI {
    if (self.overlayView) {
      [self.overlayView removeFromSuperview];
    }
}



@end
