//
//  AppDelegate.m
//  Помощник риэлтора
//
//  Created by Mikhail Kozlyukov on 19.03.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "AppDelegate.h"

//@import GoogleMaps;
@import GooglePlaces;

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize navcon;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   

    
// Default Settings
   
    NSDictionary *prefDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"За 2 часа",@"notificationType",@"Рубль ₽",@"currencyType",@"Метры",@"lengthType",@1,@"selectedTick",@1,@"selectedTick1",@4,@"selectedTick2",nil];
  
    [[NSUserDefaults standardUserDefaults] registerDefaults:prefDictionary];




// Notifications
    
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)]) {
        
        UNUserNotificationCenter *center  = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound + UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!granted) {
                NSLog(@"Something went wrong");
            }
        }];
    }
    
   
    //[GMSServices provideAPIKey:@"AIzaSyBLyGSJWcQvDrSdS2opP-BZtwu5WYo7JTE"];
    //[GMSPlacesClient provideAPIKey:@"AIzaSyAqAivv-DgtCZPvnH3josgO_5vLBU0SfoE"];
  
    [HNKGooglePlacesAutocompleteQuery setupSharedQueryWithAPIKey:@"AIzaSyAh4GgFn_mdwKvfOzhPNxxnU7UERxIMIIM"];
    
    
    
    
   // UIImage *tabBarBackground = [UIImage imageNamed:@"imageOfGradient2"];
    //[[UITabBar appearance] setBackgroundImage:tabBarBackground];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setBarTintColor:[StyleKitName gradientColor52]];
  
    
    return YES;
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.

    application.applicationIconBadgeNumber = 0;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    //[[DataManager sharedManager] saveContext];
}



-(void)switchNavController {
    UIStoryboard  *storyboard = [UIStoryboard storyboardWithName:@"Object" bundle:nil];
    self.navcon = [storyboard instantiateViewControllerWithIdentifier:@"Object88"];
    self.window.rootViewController = self.navcon;
}


-(void)switchNavControllerToTabBar {
    UIStoryboard  *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *controller = [storyboard instantiateViewControllerWithIdentifier:@"tab"];
    self.window.rootViewController = controller;
}





@end
