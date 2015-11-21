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
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
- (NSURL *)applicationDocumentsDirectory;

@end

@implementation RRRDataBaseManager

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (instancetype)sharedDBManager {
  static id sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}

- (NSURL *)applicationDocumentsDirectory {
  return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
  if (_managedObjectModel != nil) {
    return _managedObjectModel;
  }
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ConverterLab" withExtension:@"momd"];
  _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
  if (_persistentStoreCoordinator != nil) {
    return _persistentStoreCoordinator;
  }
  _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
  NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ConverterLab.sqlite"];
  NSError *error = nil;
  NSString *failureReason = @"There was an error creating or loading the application's saved data.";
  if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
    dict[NSLocalizedFailureReasonErrorKey] = failureReason;
    dict[NSUnderlyingErrorKey] = error;
    error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
  }
  return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
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
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
  }
}

#pragma mark - FetchedWebDataDelegate

-(void)webDataSourceDidUpdated:(NSDictionary *)fetchedData {
  self.date = [fetchedData objectForKey:@"date"];
  NSArray * rawOrganizations = [fetchedData objectForKey:@"organizations"];
  self.organizationRegions = [fetchedData objectForKey:@"regions"];
  self.organizationCities = [fetchedData objectForKey:@"cities"];
  self.currenciesList = [fetchedData objectForKey:@"currencies"];
  self.organizations = [[NSMutableArray alloc] init];
  for (NSInteger i = 0; i<rawOrganizations.count; i++) {
    RRRSingleOrganization * singleOrganization = [[RRRSingleOrganization alloc] init];
    singleOrganization.title = [self nullCheck:[rawOrganizations[i] objectForKey:@"title"]];
    singleOrganization.phone = [self nullCheck:[rawOrganizations[i] objectForKey:@"phone"]];
    singleOrganization.link = [self nullCheck:[rawOrganizations[i] objectForKey:@"link"]];
    singleOrganization.address = [self nullCheck:[rawOrganizations[i] objectForKey:@"address"]];
    singleOrganization.city = [self nullCheck:[self.organizationCities objectForKey:[rawOrganizations[i] objectForKey:@"cityId"]]];
    singleOrganization.region = [self nullCheck:[self.organizationRegions objectForKey:[rawOrganizations[i] objectForKey:@"regionId"]]];
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
  [self clearDatabase];
  [self fillDatabase];
}

- (void)fillDatabase {
  NSManagedObjectContext * context = self.managedObjectContext;
  for (NSInteger i=0; i<self.organizations.count; i++) {
    NSManagedObject * organizationManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Organization" inManagedObjectContext: context];
    RRRSingleOrganization * currentOrganization = (RRRSingleOrganization *)self.organizations[i];
    [organizationManagedObject setValue:currentOrganization.title forKey:@"title"];
    [organizationManagedObject setValue:currentOrganization.city forKey:@"city"];
    [organizationManagedObject setValue:currentOrganization.region forKey:@"region"];
    [organizationManagedObject setValue:currentOrganization.address forKey:@"address"];
    [organizationManagedObject setValue:currentOrganization.phone forKey:@"phone"];
    [organizationManagedObject setValue:currentOrganization.link forKey:@"link"];
    [organizationManagedObject setValue:[NSNumber numberWithInteger:i] forKey:@"id"];
    NSData *currenciesData = [NSKeyedArchiver archivedDataWithRootObject:currentOrganization.currencies];
    [organizationManagedObject setValue:currenciesData forKey:@"currencies"];
    [self saveContext];
  }
}

- (void) clearDatabase {
  NSManagedObjectContext * context = self.managedObjectContext;
  NSFetchRequest *allItems = [[NSFetchRequest alloc] init];
  [allItems setEntity:[NSEntityDescription entityForName:@"Organization" inManagedObjectContext:context]];
  [allItems setIncludesPropertyValues:NO];
  NSError *error = nil;
  NSArray *itemList = [context executeFetchRequest:allItems error:&error];
  for (NSManagedObject *item in itemList) {
    [context deleteObject:item];
  }
  NSError *saveError = nil;
  [context save:&saveError];
}

- (NSString *)nullCheck:(NSString *) aString{
  if (aString == (id)[NSNull null] || aString.length == 0) {
    aString = @"*";
  }
  return (NSString *)aString;
}

- (void)webDataSourceNotUpdated {
  SEL selector = @selector(dataBaseNotUpdated);
  if (self.delegateInstance && [self.delegateInstance respondsToSelector:selector])
  {
    [self.delegateInstance performSelector:selector];
  }
}

@end
