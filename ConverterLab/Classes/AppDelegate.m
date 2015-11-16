//
//  AppDelegate.m
//  ConverterLab
//
//  Created by Roman R on 11.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import "AppDelegate.h"
#import "RRRNavigationController.h"
#import "RRRTableViewcontroller.h"
#import "RRRDataBaseManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  RRRTableViewController * commonListTableViewController = [[RRRTableViewController alloc] initWithStyle:UITableViewStylePlain];
  RRRNavigationController * commonNavController = [[RRRNavigationController alloc] initWithRootViewController:commonListTableViewController];
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
  self.window.rootViewController = commonNavController;
  [self.window makeKeyAndVisible];
  return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
  [[RRRDataBaseManager sharedDBManager] saveContext];
}

@end
