//
//  NativeAdViewController.m
//  GlossomAdsObjcSample
//
//  Created by Junhua Li on 2018/06/23.
//  Copyright © 2018年 Glossom, Inc. All rights reserved.
//

#import "NativeAdScrollViewController.h"
#import "AppConst.h"

@interface NativeAdScrollViewController ()<GlossomNativeAdDelegate>
@property (strong, nonatomic) GlossomAdsNativeAd *nativeAd;
@property (strong, nonatomic) NSMutableArray* datas;
@property (strong, nonatomic) UITableViewCell* adViewCell;
@end

@implementation NativeAdScrollViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if ([self.datas[indexPath.item] isEqualToString:@"advertise"]) {
    return [UIScreen mainScreen].bounds.size.width * 9/ 16;
  } else {
    return 80;
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"customcell" forIndexPath:indexPath];
  if ([self.datas[indexPath.item] isEqualToString:@"advertise"]) {
    [cell.contentView addSubview: [self.nativeAd getMediaView]];
    [self.nativeAd getMediaView].frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 9/ 16);
    [self.nativeAd playMediaView];
  } else {
    cell.textLabel.text = self.datas[indexPath.item];
  }
  return cell;
}

- (void)viewDidLoad {
  [super viewDidLoad];
    self.datas = [NSMutableArray arrayWithObjects: @"lorem ipsum 1", @"lorem ipsum 2", @"lorem ipsum 3", @"lorem ipsum 4",
                  @"lorem ipsum 5",  @"lorem ipsum 6", @"lorem ipsum 8", @"lorem ipsum 9", @"lorem ipsum 10",
                  @"lorem ipsum 11", @"lorem ipsum 12", @"lorem ipsum 13", @"lorem ipsum 14", @"lorem ipsum 15",
                  @"lorem ipsum 16", @"lorem ipsum 17", @"lorem ipsum 18", @"lorem ipsum 19", @"lorem ipsum 20", nil];
  self.nativeAd = [[GlossomAdsNativeAd alloc] initWithZoneId:kGlossomAdsNativeAdZoneId];
  self.nativeAd.delegate = self;
  
  [self.nativeAd loadAd];
}

- (void)dealloc {
  NSLog(@"NativeAdViewController dealloc");
}

#pragma mark - GlossomNativeAdDelegate
- (void)onGlossomNativeAdDidLoad:(GlossomAdsNativeAd *)nativeAd {
  NSLog(@"onGlossomNativeAdDidLoad");
  
  self.nativeAd = nativeAd;
  [self.nativeAd setupMediaView];
  [self.datas insertObject:@"advertise" atIndex: 8];
  [self.tableView reloadData];
}

- (void)onGlossomNativeAdDidFailWithError:(NSError *)error {
  NSLog(@"onGlossomNativeAdDidFailWithError");
}

- (void)onGlossomNativeAdDidStartPlaying {
  NSLog(@"onGlossomNativeAdDidStartPlaying");
}

- (void)onGlossomNativeAdDidFinishPlaying {
  NSLog(@"onGlossomNativeAdDidFinishPlaying");
}

- (void)onGlossomNativeAdPlayWithError:(NSError *)error {
  NSLog(@"onGlossomNativeAdPlayWithError");
}

@end
