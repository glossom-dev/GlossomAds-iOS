//
//  InterstitialViewController.h
//  GlossomAdsObjcSample
//
//  Created by Yazaki Yuto on 2017/07/25.
//  Copyright © 2017年 Glossom, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@import GlossomAds;
@interface InterstitialViewController : UIViewController <GlossomAdsLoadDelegate, GlossomAdsInterstitialAdDelegate>
@property (weak, nonatomic) IBOutlet UIButton *showAdButton;

@end
