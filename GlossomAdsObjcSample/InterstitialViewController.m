//
//  InterstitialViewController.m
//  GlossomAdsObjcSample
//
//  Created by Yazaki Yuto on 2017/07/25.
//  Copyright © 2017年 Glossom, Inc. All rights reserved.
//

#import "InterstitialViewController.h"
#import "AppConst.h"

@interface InterstitialViewController ()

@end

@implementation InterstitialViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  _showAdButton.enabled = [GlossomAds isReady:kGlossomAdsInterstitialZoneID];

  // 再生可能状態の変更通知を受け取る
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(adAvailabilityChange) name:kAdAvailabilityChange object:nil];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)adAvailabilityChange {
  NSLog(@"adAvailabilityChange");
  _showAdButton.enabled = [GlossomAds isReady:kGlossomAdsInterstitialZoneID];
}

#pragma mark - IBAction

- (IBAction)showAd:(UIButton *)sender {
  // インタースティシャル動画広告を表示します
  [GlossomAds showVideo:kGlossomAdsInterstitialZoneID delegate:self];
}

#pragma mark - GlossomAdsInterstitialAdDelegate

// 動画広告が表示されたことを通知します
- (void)onGlossomAdsAdShow:(NSString *)zoneId {
  NSLog(@"onGlossomAdsAdShow: %@", zoneId);
}

// 動画広告の再生を開始したことを通知します
- (void)onGlossomAdsVideoStartPlay:(NSString *)zoneId {
  NSLog(@"onGlossomAdsVideoStartPlay: %@", zoneId);
}

// 動画広告の再生が一時停止したことを通知します
- (void)onGlossomAdsVideoPause:(NSString *)zoneId {
  NSLog(@"onGlossomAdsVideoPause: %@", zoneId);
}

// 動画広告の再生が再開したことを通知します
- (void)onGlossomAdsVideoResume:(NSString *)zoneId {
  NSLog(@"onGlossomAdsVideoResume: %@", zoneId);
}

// 動画広告が再生途中でスキップされたことを通知します
- (void)onGlossomAdsVideoSkip:(NSString *)zoneId {
  NSLog(@"onGlossomAdsVideoSkip: %@", zoneId);
}

// 動画広告が最後まで再生されたことを通知します
- (void)onGlossomAdsVideoFinish:(NSString *)zoneId {
  NSLog(@"onGlossomAdsVideoFinish: %@", zoneId);
}

// 動画広告が閉じたことを通知します
- (void)onGlossomAdsAdClose:(NSString *)zoneId isShown:(BOOL)shown {
  NSLog(@"onGlossomAdsAdClose: %@, shown: %d", zoneId, shown);
  _showAdButton.enabled = [GlossomAds isReady:kGlossomAdsInterstitialZoneID];
}

@end
