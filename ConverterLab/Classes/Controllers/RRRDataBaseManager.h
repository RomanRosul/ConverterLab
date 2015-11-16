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

//@protocol DataBaseManagerDelegate <NSObject>
//@optional
//- (void)dataBaseNotUpdated;
//@end

@interface RRRDataBaseManager : NSObject <FetchedWebDataDelegate>

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//@property (nonatomic, weak) id <DataBaseManagerDelegate> delegateInstance;

+ (instancetype)sharedDBManager;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
