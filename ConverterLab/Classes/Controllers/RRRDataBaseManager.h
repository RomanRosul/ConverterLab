//
//  RRRDataBaseManager.h
//  ConverterLab
//
//  Created by Roman R on 11.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RRRNetworkManager.h"

@interface RRRDataBaseManager : NSObject <FetchedWebDataDelegate>

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (instancetype)sharedDBManager;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
