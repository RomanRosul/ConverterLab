//
//  RRRDataBaseManager.m
//  ConverterLab
//
//  Created by Roman R on 11.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import "RRRDataBaseManager.h"
#import "RRRSingleOrganization.h"
#import "RRRSingleCurrency.h"

@interface RRRDataBaseManager ()

@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSMutableArray *organizations;
@property (strong, nonatomic) NSDictionary *organizationTypes;
@property (strong, nonatomic) NSDictionary *organizationRegions;
@property (strong, nonatomic) NSDictionary *organizationCities;
@property (strong, nonatomic) NSDictionary *currenciesList;

@end

@implementation RRRDataBaseManager

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


+ (instancetype)sharedDBManager
{
  static id sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}

-(void)webDataSourceDidUpdated:(NSDictionary *)fetchedData
{
  self.date = [fetchedData objectForKey:@"date"];
  NSArray * rawOrganizations = [fetchedData objectForKey:@"organizations"];
  self.organizationRegions = [fetchedData objectForKey:@"regions"];
  self.organizationCities = [fetchedData objectForKey:@"cities"];
  self.currenciesList = [fetchedData objectForKey:@"currencies"];
  self.organizations = [[NSMutableArray alloc] init];
  
  for (NSInteger i = 0; i<rawOrganizations.count; i++) {
    RRRSingleOrganization * singleOrganization = [[RRRSingleOrganization alloc] init];
    singleOrganization.title = [rawOrganizations[i] objectForKey:@"title"];
    singleOrganization.phone = [rawOrganizations[i] objectForKey:@"phone"];
    singleOrganization.link = [rawOrganizations[i] objectForKey:@"link"];
    singleOrganization.address = [rawOrganizations[i] objectForKey:@"address"];
    singleOrganization.city = [self.organizationCities objectForKey:[rawOrganizations[i] objectForKey:@"cityId"]];
    singleOrganization.region = [self.organizationRegions objectForKey:[rawOrganizations[i] objectForKey:@"regionId"]];
    NSDictionary * rawCurrencies = [rawOrganizations[i] objectForKey:@"currencies"];
    NSArray * currenciesKeys = [rawCurrencies allKeys];
    
    for (NSInteger k = 0; k<rawCurrencies.count; k++) {
      RRRSingleCurrency * singleCurrency = [[RRRSingleCurrency alloc] init];
      singleCurrency.localizedTitle = [self.currenciesList objectForKey:currenciesKeys[k]];
      singleCurrency.keyTitle = currenciesKeys[k];
      NSDictionary * singleRawCurrencie = [rawCurrencies objectForKey:currenciesKeys[k]];
      singleCurrency.ask = [singleRawCurrencie objectForKey:@"ask"];
      singleCurrency.bid = [singleRawCurrencie objectForKey:@"bid"];
      [singleOrganization.currencies addObject:singleCurrency];
    }
    [self.organizations addObject:singleOrganization];
  }
  NSManagedObjectContext * context = self.managedObjectContext;
  NSManagedObject * organizationManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Organization" inManagedObjectContext: context];
  
#warning DB fill here
  NSInteger i = 0;
  RRRSingleOrganization * currentOrganization = (RRRSingleOrganization *)self.organizations[i];
  [organizationManagedObject setValue:currentOrganization.title forKey:@"title"];
  [organizationManagedObject setValue:currentOrganization.city forKey:@"city"];
  [organizationManagedObject setValue:currentOrganization.region forKey:@"region"];
  [organizationManagedObject setValue:currentOrganization.address forKey:@"address"];
  [organizationManagedObject setValue:currentOrganization.phone forKey:@"phone"];
  [organizationManagedObject setValue:currentOrganization.link forKey:@"link"];
 // [organizationManagedObject setValue:currentOrganization.currencies forKey:@"currencies"];
[self saveContext];
}

- (NSURL *)applicationDocumentsDirectory {
  // The directory the application uses to store the Core Data store file. This code uses a directory named "iOS-courses-FinalTask.ConverterLab" in the application's documents directory.
  return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
  // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
  if (_managedObjectModel != nil) {
    return _managedObjectModel;
  }
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ConverterLab" withExtension:@"momd"];
  _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
  // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
  if (_persistentStoreCoordinator != nil) {
    return _persistentStoreCoordinator;
  }
  
  // Create the coordinator and store
  
  _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
  NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ConverterLab.sqlite"];
  NSError *error = nil;
  NSString *failureReason = @"There was an error creating or loading the application's saved data.";
  if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
    // Report any error we got.
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
    dict[NSLocalizedFailureReasonErrorKey] = failureReason;
    dict[NSUnderlyingErrorKey] = error;
    error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
    // Replace this with code to handle the error appropriately.
    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    abort();
  }
  
  return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
  // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
  if (_managedObjectContext != nil) {
    return _managedObjectContext;
  }
  
  NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
  if (!coordinator) {
    return nil;
  }
  _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
  [_managedObjectContext setPersistentStoreCoordinator:coordinator];
  return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
  NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
  if (managedObjectContext != nil) {
    NSError *error = nil;
    if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
      // Replace this implementation with code to handle the error appropriately.
      // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
    }
  }
}


@end
