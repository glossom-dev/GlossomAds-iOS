//
//  NativeAdViewController.m
//  GlossomAdsObjcSample
//
//  Created by Amin Al on 2018/07/09.
//  Copyright © 2018 Glossom, Inc. All rights reserved.
//

#import "NativeAdViewController.h"
#import "AppConst.h"

@interface NativeAdViewController ()<GlossomNativeAdDelegate>
@property (strong, nonatomic) GlossomAdsNativeAd *nativeAd;
@property (weak, nonatomic) IBOutlet UITextView *interactionLog;
@property (weak, nonatomic) IBOutlet UIView *adContainerView;
@property (weak, nonatomic) IBOutlet UIButton *loadAdButton;
@property (weak, nonatomic) IBOutlet UIButton *playAdButton;
@end

@implementation NativeAdViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.playAdButton.enabled = NO;
  self.nativeAd = [[GlossomAdsNativeAd alloc] initWithZoneId:kGlossomAdsNativeAdZoneId];
  self.nativeAd.delegate = self;
}
- (IBAction)loadAd:(id)sender {
  self.interactionLog.text = [NSString stringWithFormat:@"%@load ad clicked\n", self.interactionLog.text];
  [self.nativeAd loadAd];
}
- (IBAction)playAd:(id)sender {
  self.playAdButton.enabled = NO;
  self.interactionLog.text = [NSString stringWithFormat:@"%@start playing clicked\n", self.interactionLog.text];
  [self.adContainerView addSubview: [self.nativeAd getMediaView]];
  [self.nativeAd getMediaView].frame = CGRectMake(0, 0, self.adContainerView.bounds.size.width, self.adContainerView.bounds.size.width * 9/ 16);
  [self.nativeAd playMediaView];
}

- (void)onGlossomNativeAdDidLoad:(GlossomAdsNativeAd *)nativeAd {
  self.interactionLog.text = [NSString stringWithFormat:@"%@ad was loaded, you can now play\n", self.interactionLog.text];
  self.nativeAd = nativeAd;
  [self.nativeAd setupMediaView];
  self.playAdButton.enabled = YES;
}

- (void)onGlossomNativeAdDidStartPlaying {
  self.interactionLog.text = [NSString stringWithFormat:@"%@started playing\n", self.interactionLog.text];
}

- (void)onGlossomNativeAdDidFinishPlaying {
  self.interactionLog.text = [NSString stringWithFormat:@"%@finished playing\n", self.interactionLog.text];
}
- (void)onGlossomNativeAdDidFailWithError:(NSError *)error {
  self.interactionLog.text = [NSString stringWithFormat:@"%@load failed\n", self.interactionLog.text];
}
- (void)onGlossomNativeAdPlayWithError:(NSError *)error {
  self.interactionLog.text = [NSString stringWithFormat:@"%@play failed\n", self.interactionLog.text];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
