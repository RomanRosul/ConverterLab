//
//  RRRTableViewController.m
//  ConverterLab
//
//  Created by Roman R on 11.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import "RRRTableViewController.h"
#import "RRRTableViewCell.h"
#import "RRRNetworkManager.h"

@interface RRRTableViewController ()

@end

@implementation RRRTableViewController

static NSString * const RRRCellIdentifier = @"financialOrganizationCell";

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.title = @"Converter Lab";
  
  UINib * cellNib = [UINib nibWithNibName:@"RRRTableViewCell" bundle:nil];
  [self.tableView registerNib:cellNib forCellReuseIdentifier:RRRCellIdentifier];
  
  UIImage* navBarSearchImage = [UIImage imageNamed:@"ic_search"];
  UIBarButtonItem *navBarSearchButton = [[UIBarButtonItem alloc] initWithImage:navBarSearchImage style:UIBarButtonItemStylePlain target:self action:@selector(navBarSearchButtonPressed)];
  self.navigationItem.rightBarButtonItem = navBarSearchButton;
  
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)navBarSearchButtonPressed{
  RRRNetworkManager * nm = [RRRNetworkManager new];
  nm.delegateInstance = self;
  [nm log];
  
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RRRCellIdentifier forIndexPath:indexPath];
    
  if (cell == nil) {
    cell = [[RRRTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:RRRCellIdentifier];
  }
  
  //[self configureCell:cell atIndexPath:indexPath];
  
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


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

-(void)dataSourceDidUpdated:(NSDictionary *)fetchedData
{
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths objectAtIndex:0];
  NSString * fileName = [documentsDirectory stringByAppendingPathComponent:@"org.plist"];
  NSArray * organizations = [fetchedData objectForKey:@"organizations"];
 
  if ([organizations writeToFile:fileName atomically:NO]) {
    NSLog(@"callback %@",organizations);
  }
   NSLog(@"callback %lu",organizations.count);
  
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
