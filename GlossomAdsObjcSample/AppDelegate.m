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

  //set up to receive test movie, you can find your deviceId from console log
  //[GlossomAds addTestDevice:@"1115D852-FFAF-4510-B375-A331267C847E"];

  // ZoneIDを指定してGlossomAdsを初期化
  // clientOptionsには広告のリクエストパラメータに含める追加情報を適時入れていください
  [GlossomAds configure:kGlossomAdsAppID zoneIds:@[kGlossomAdsInterstitialZoneID, kGlossomAdsRewardZoneId, kGlossomAdsBillboardAdZoneId, kGlossomAdsNativeAdZoneId] delegate:self clientOptions:nil];
  
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

#pragma GlossomAdsDelegate

// 広告在庫が変更する時にコールバックを受け取ることができます
- (void)onAdAvailabilityChange:(BOOL)available inZone:(NSString *)zoneId {
  [[NSNotificationCenter defaultCenter] postNotificationName:kAdAvailabilityChange object:nil];
}


@end
