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
@property (weak, nonatomic) IBOutlet UITextView *log;

@end

@implementation InterstitialViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)loadAd:(id)sender {
  self.log.text = [NSString stringWithFormat:@"%@load ad clicked\n", self.log.text];
  [GlossomAds load:kGlossomAdsInterstitialZoneID notifyTo:self];
}

- (IBAction)showAd:(UIButton *)sender {
  self.log.text = [NSString stringWithFormat:@"%@show ad clicked\n", self.log.text];
  // インタースティシャル動画広告を表示します
  [GlossomAds showVideo:kGlossomAdsInterstitialZoneID delegate:self];
}

- (void)onAdLoadSuccess:(NSString *)zoneId {
  self.log.text = [NSString stringWithFormat:@"%@ad load success. zone id : %@\n", self.log.text, zoneId];
  _showAdButton.enabled = true;
}

- (void)onAdLoadFail:(NSString *)zoneId error:(GlossomAdLoadError)error {
  self.log.text = [NSString stringWithFormat:@"%@ad load fail (%d). zone id : %@\n", self.log.text, (int)error, zoneId];
  _showAdButton.enabled = false;
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
}

- (void)onGlossomAdsVideoPlayError:(NSString *)zoneId error:(NSError *)error {
  self.log.text = [NSString stringWithFormat:@"%@video play error. zone id : %@, error code : %d\n", self.log.text, zoneId, (int)error.code];
}

@end
