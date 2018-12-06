//
//  BillboardAdViewController.h
//  GlossomAdsObjcSample
//
//  Created by Junhua Li on 2018/02/01.
//  Copyright © 2018年 Glossom, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GlossomAds;

@interface BillboardAdViewController : UIViewController <GlossomBillboardAdDelegate>

@property (weak, nonatomic) IBOutlet UIButton *showAdButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *verticalLayout;
@property (weak, nonatomic) IBOutlet UISegmentedControl *horizontalLayout;

@end
