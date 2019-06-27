//
//  AppDelegate.m
//  GlossomAdsObjcSample
//
//  Created by Yazaki Yuto on 2017/07/25.
//  Copyright © 2017年 Glossom, Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "AppConst.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  BOOL isAutoMode = false;

  //set up to receive test movie, you can find your deviceId from console log
  //[GlossomAds addTestDevice:@"C9BAB6DA-7896-4382-9E5F-E87A1E2C5582"];

  // ZoneIDを指定してGlossomAdsを初期化
  // clientOptionsには広告のリクエストパラメータに含める追加情報を適時入れていください
  if (isAutoMode) {
    [GlossomAds configure:kGlossomAdsAppID zoneIds:@[kGlossomAdsRewardZoneId,
                                                     kGlossomAdsInterstitialZoneID,
                                                     kGlossomAdsBillboardAdZoneId,
                                                     kGlossomAdsNativeAdZoneId] delegate:self clientOptions:nil];
  } else {
    [GlossomAds initialize:kGlossomAdsAppID zoneIds:@[kGlossomAdsRewardZoneId,
                                                      kGlossomAdsInterstitialZoneID,
                                                      kGlossomAdsBillboardAdZoneId,
                                                      kGlossomAdsNativeAdZoneId] clientOptions:nil];
  }
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
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
