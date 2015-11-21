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
@property (strong, nonatomic) NSFetchedResultsController *dataFetchedResultsController;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UISearchController *searchController;
@property (nonatomic, strong)  UIView * overlayView;
@property (nonatomic, strong) NSMutableArray * fetchedArray;
@property (nonatomic) BOOL isScrolling;
@end

@implementation RRRTableViewController
@synthesize dataFetchedResultsController = __dataFetchedResultsController;
static NSString * const RRRCellIdentifier = @"financialOrganizationCell";

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Converter Lab";
  [self.tableView registerNib:[UINib nibWithNibName:@"RRRTableViewCell" bundle:nil] forCellReuseIdentifier:RRRCellIdentifier];
  UIBarButtonItem *navBarSearchButton = [[UIBarButtonItem alloc] initWithImage: [UIImage imageNamed:@"ic_search"] style:UIBarButtonItemStylePlain target:self action:@selector(navBarSearchButtonPressed)];
  self.navigationItem.rightBarButtonItem = navBarSearchButton;
  self.dataFetchedResultsController.delegate = self;
  [RRRDataBaseManager sharedDBManager].delegateInstance = self;
   [self lockUI];
  [[RRRNetworkManager sharedNetworkManager] refreshDataSourceFromWeb];
  [self addSearchBar];
  self.navigationItem.backBarButtonItem =
  [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
  [self refreshDataArray];
  self.tableView.bounces = NO;
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
  [navController.hamburgerButton hideMeAnimated];
  }
}

-(void)addSearchBar {
  self.searchBar = [[UISearchBar alloc] init];
  self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
  self.searchController.searchBar.delegate = self;
  self.searchController.searchResultsUpdater = self;
  self.searchController.dimsBackgroundDuringPresentation = NO;
  self.searchController.searchBar.tintColor = [UIColor whiteColor];
}

- (void)navBarSearchButtonPressed {
  if (!self.isScrolling) {
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.searchController.active = YES;
  }
}

#pragma mark - Table Cell Buttons delegate

- (void)buttonDetailedInfoPressed:(RRRSingleOrganization *)aSingleOrganization {
    RRRDetailedTableViewController * detailedTableViewController = [[RRRDetailedTableViewController alloc] initWithData:aSingleOrganization];
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
    [self displayError:[ NSString stringWithFormat:@"Data Fetching error: %@",error]];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
return self.fetchedArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RRRTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RRRCellIdentifier forIndexPath:indexPath];
  if (cell == nil) {
    cell = [[RRRTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RRRCellIdentifier];
  }
  NSInteger i = indexPath.row;
  RRRSingleOrganization * singleOrganization = [[RRRSingleOrganization alloc]
                                                initWithTitle:[self.fetchedArray[i] valueForKey:@"title"]
                                                withRegion:[self.fetchedArray[i] valueForKey:@"region"]
                                                withCity:[self.fetchedArray[i] valueForKey:@"city"]
                                                withAddress:[self.fetchedArray[i] valueForKey:@"address"]
                                                withPhone:[self.fetchedArray[i] valueForKey:@"phone"]
                                                withLink:[self.fetchedArray[i] valueForKey:@"link"]
                                                withCurrencies:[NSKeyedUnarchiver unarchiveObjectWithData:[self.fetchedArray[i] valueForKey:@"currencies"]]];
  
  [cell configureCellWithData:singleOrganization forIndexPath:indexPath];
  cell.delegateInstance = self;
  return cell;
}

#pragma mark - FetchedResultsControllerdelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
  [self refreshDataArray];
  [self unlockUI];
}

#pragma mark - Data Base Manager delegate

- (void)dataBaseNotUpdated {
  [self unlockUI];
  [self displayError:@"Server not found \n Data not updated"];
}

#pragma mark - other

- (void) lockUI {
  self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
  self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
  UILabel * statusLabel =[[UILabel alloc] initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height-20, [UIScreen mainScreen].bounds.size.width, 20)];
  statusLabel.backgroundColor = [UIColor colorwithHexString:@"#b0bec5" alpha:0.8];
  statusLabel.text = @"Updating...";
  statusLabel.textColor = [UIColor whiteColor];
  [self.overlayView addSubview:statusLabel];
  [self.overlayView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
  statusLabel.translatesAutoresizingMaskIntoConstraints = NO;
   [self.overlayView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[label(20)]|" options:0 metrics:nil views:@{ @"label" : statusLabel}]];
  [self.overlayView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[label]|" options:0 metrics:nil views:@{ @"label" : statusLabel}]];
  [self.navigationController.view addSubview:self.overlayView];
}

-(void) unlockUI {
    if (self.overlayView) {
      [self.overlayView removeFromSuperview];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
  self.isScrolling = YES;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  self.isScrolling = NO;
}

@end
