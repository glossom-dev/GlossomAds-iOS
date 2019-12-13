GlossomAds SDK
===

# ・セットアップ

## 基本設定

1. `GlossomAds.framework`をプロジェクトに追加してください
2. **TARGETS > Build Phases > Link Binary With Libraries** を開いて、下記のライブラリとフレームワークを追加してください
  - `AVFoundation.framework`
  - `AdSupport.framework`
  - `CoreGraphics.framework`
  - `CoreMedia.framework`
  - `CoreTelephony.framework`
  - `MediaPlayer.framework`
  - `StoreKit.framework`
  - `SystemConfiguration.framework`
  - `UIKit.framework`
  - `WebKit.framework`
  - `SafariServices.framework`（v1.10.0から追加）

# ・SDK実装
## 1.動画リワード広告 / 動画インタースティシャル広告 / 動画Billboard広告

動画広告を実装する方法を紹介します。  
以下はObjective-Cでの実装になりますが、Swiftでも同様の実装で動作します。

## 広告の表示

SDKの初期化から動画を実際に表示するまでの実装になります。  
AppID, ZoneIDには弊社が発行したご自身のIDをお使いください。

#### AppDelegate.m

```objc
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  [GlossomAds configure:/* App ID */
                  zoneIds:@[/* Zone IDs */]
               delegate:self
          clientOptions:@{/* Options */}]

  return YES;
}
```

＊SDKの初期化は一回のみになります、複数zoneご利用になる場合、発行されたzones全部入れてください。

#### ViewController.m

##### 動画リワード広告再生

```objc
- (IBAction)triggerVideo:(UIButton *)button {
  if ([GlossomAds isReady:/* Reward Zone ID */]) {
    [GlossomAds showRewardVideo:/* Reward Zone ID */ delegate:self];
  }
}
```

##### 動画インタースティシャル広告再生

```objc
- (IBAction)triggerVideo:(UIButton *)button {
  if ([GlossomAds isReady:/* Interstitial Zone ID */]) {
    [GlossomAds showVideo:/* Interstitial Zone ID */ delegate:self];
  }
}
```

## 報酬の付与(動画リワード広告のみ)

上述の動画を表示する際に指定したDelegate用のクラスにdelegateメソッドを実装し、その中でユーザに報酬を付与する実装をしてください。

#### ViewController.h

```objc
@import GlossomAds;

@interface ViewController : UIViewController<GlossomAdsRewardAdDelegate>
```

#### ViewController.m

```objc
- (void)onGlossomAdsReward:(NSString *)zoneId success:(BOOL)success {
  if (success) {
    // ユーザに報酬を付与する
  }
}
```

## 動画Billboard広告の表示

```objc
- (IBAction)triggerVideo:(UIButton *)button {
  if ([GlossomAds isReady:/* BillboardAd Zone ID */]) {
    [GlossomAds showBillboardAd:kGlossomAdsBillboardAdZoneId
                     delegate:self
               layoutVertical:/* GlossomBillBoardAdLayoutVertical */
             layoutHorizontal:/* GlossomBillBoardAdLayoutHorizontal */];
  }
}
```

##### GlossomBillBoardAdLayoutVertical
縦画面の場合のレイアウトを指定します  
TOP、MIDDLE、BOTTOM(デフォルト)

##### GlossomBillBoardAdLayoutHorizontal
横画面の場合のレイアウトを指定します  
LEFT(デフォルト)、MIDDLE、RIGHT

## 2.動画Native広告
v1.10から、動画Nativeのフォーマット追加しました。サイズ設定できるの動画Viewを提供し、アプリ内任意の位置に貼ることができます。

### 動画Native広告実装
以下はObjective-Cでの実装になりますが、Swiftでも同様の実装で動作します。
具体的の実装はサンプル内`NativeAdViewController.m `を参考することがおすすめです。

* ZoneIDの初期化（configure）

```objc
  [GlossomAds configure:/* App ID */
                  zoneIds:@[/* 動画NativeのZone IDs */]
               delegate:self
          clientOptions:@{/* Options */}]
```

* 動画nativeのインスタントを作成

```objc
self.nativeAd = [[GlossomAdsNativeAd alloc]
                   initWithZoneId:/* 動画NativeのZone ID */];
// callback受けるためにdelegateを設定
self.nativeAd.delegate = self;
```

* 動画nativeをリクエスト

```objc
[self.nativeAd loadAd];

// load成功する時のcallback
- (void)onGlossomNativeAdDidLoad:(nonnull GlossomAdsNativeAd *)nativeAd;

// load失敗する時のcallback
- (void)onGlossomNativeAdDidFailWithError:(nullable NSError *)error;
```

* 動画nativeの動画View

```objc
// 動画表示したい時の直前、動画Viewを作成
[self.nativeAd setupMediaView];

// 好きな場所に貼る
[self.adContainerView addSubview: [self.nativeAd getMediaView]];

// 必要なサイズを設定、動画は16:9になります
[self.nativeAd getMediaView].frame =
  CGRectMake(0, 0,
             self.adContainerView.bounds.size.width,
             self.adContainerView.bounds.size.width * 9/ 16);
```

* 動画Viewの動画を再生

```objc
[self.nativeAd playMediaView];
```

<font color="red">*注意:*</font> `ZoneIDの初期化（configure）`しないと`loadAd`必ず失敗になります。  

## 動画nativeの動画のガイドライン
### サイズ目安について

広告の視認性確保のため、以下を目安に実装をお願いします。
* 縦画面: 動画広告の横幅が画面横幅の50％以上であること
* 横画面: 動画広告の横幅が画面横幅の25％以上であること

※上記基準を下回る場合は、広告の配信が停止される可能性がございますので、ご了承ください。

### 動画案件更新について
* 次の案件の動画を表示するには、新たに`動画nativeをリクエスト(loadAd)`が必要となります。
* `loadAd`のタイミングはページの切り替える時がおすすめです。

### 複数表示について
* 同じページに複数動画Nativeを利用したい場合は、数に応じて複数zoneを利用してください。
* 1画面で1箇所の設置を推奨します。

## 3.テストモード

指定した広告IDの端末上でのSDKの動作をテストモードにすることが可能です。
テストモードにすると配信される案件がテスト案件のみになります。
開発中などはこちらをご利用ください。

```objc
//set up to receive test movie, you can find your deviceId from console log
[GlossomAds addTestDevice:/* 広告ID */];
```
＊広告IDはコンソールログにも確認することができます。

## その他

上述した他にもいくつかAPIがあります。  
APIドキュメントをHTMLで用意しているのでそちらをご参照ください。

```bash
$ open docs/index.html
```
