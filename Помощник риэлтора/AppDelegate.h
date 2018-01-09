//
//  AppDelegate.h
//  Помощник риэлтора
//
//  Created by Mikhail Kozlyukov on 19.03.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HNKGooglePlacesAutocomplete/HNKGooglePlacesAutocompleteQuery.h>
#import "StyleKitName.h"
#import "AddToMapVC.h"
#import "MapTab.h"
#import <UserNotifications/UserNotifications.h>
#import "DetailObjectController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSArray *delegateMutableArray;

@property(assign, nonatomic) BOOL inAppActivated;

@property(strong, nonatomic) EstateObjectEntity* detailItem;
@property(strong, nonatomic) UINavigationController *navcon;
@property(strong, nonatomic) UITabBarController *tabBar;
@property(strong, nonatomic) UIViewController *cont;


-(void)switchNavController;
-(void)switchNavControllerToTabBar;


@end

