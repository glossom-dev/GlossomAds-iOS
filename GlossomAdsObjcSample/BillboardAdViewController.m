//
//  BillboardAdViewController.m
//  GlossomAdsObjcSample
//
//  Created by Junhua Li on 2018/02/01.
//  Copyright © 2018年 Glossom, Inc. All rights reserved.
//

#import "BillboardAdViewController.h"
#import "AppConst.h"

@interface BillboardAdViewController ()

@end

@implementation BillboardAdViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  _showAdButton.enabled = [GlossomAds isReady:kGlossomAdsBillboardAdZoneId];
  
  // 再生可能状態の変更通知を受け取る
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(adAvailabilityChange) name:kAdAvailabilityChange object:nil];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)adAvailabilityChange {
  NSLog(@"adAvailabilityChange");
  _showAdButton.enabled = [GlossomAds isReady:kGlossomAdsBillboardAdZoneId];
}

#pragma mark - IBAction

- (IBAction)showAd:(UIButton *)sender {
  GlossomBillBoardAdLayoutVertical lv = GlossomBillBoardAdLayoutVerticalBottom;
  GlossomBillBoardAdLayoutHorizontal lh = GlossomBillBoardAdLayoutHorizontalLeft;
  
  switch (self.verticalLayout.selectedSegmentIndex) {
    case 1:
      lv = GlossomBillBoardAdLayoutVerticalMiddle;
      break;
      
    case 2:
      lv = GlossomBillBoardAdLayoutVerticalTop;
      break;
    
    default:
      break;
  }
  
  switch (self.horizontalLayout.selectedSegmentIndex) {
  case 1:
    lh = GlossomBillBoardAdLayoutHorizontalMiddle;
    break;
    
  case 2:
    lh = GlossomBillBoardAdLayoutHorizontalRight;
    break;
    
  default:
    break;
  }
  
  // BillboardAdを表示します
  [GlossomAds showBillboardAd:kGlossomAdsBillboardAdZoneId delegate:self layoutVertical:lv layoutHorizontal:lh];
}

- (IBAction)closeAd:(UIButton *)sender {
  // BillboardAdを強制的に閉じます
  [GlossomAds closeBillboardAd];
}

#pragma mark - GlossomBillboardAdDelegate

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
@end
