//
//  AppDelegate.h
//  iSetUp
//
//  Created by Anthony Cornell on 3/27/12.
//  Copyright (c) 2012 iDevice Designs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@class MainViewController;
@class HomeViewController;


@interface AppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate>{
     UINavigationController *controller;
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) UINavigationController *controller;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (strong, nonatomic) MainViewController *mainViewController;
@property (strong, nonatomic) HomeViewController *homeView;


@end
