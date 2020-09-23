GlossomAds SDK
===

# ・セットアップ

## CocoaPodsで設置

GlossomAds SDKはCocoaPodsで設置することが出来ます。

Podfileに下記のように書いて設置することが出来ます。

`pod 'GlossomAds'`

## Frameworkをダウンロードして設置

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
  
  # ・iOS14から必要な設定
  ## Default Browserを変更した端末での遷移について

   iOS14からDefault BrowserをSafari以外に設定した場合、一部の広告でクリックした時の遷移がうまくできないケースがあります。
   その対応のため、Info.plistで次のような設定を行ってください。

   ```xml
   　<key>LSApplicationQueriesSchemes</key>
   　　<array>
   　　　<string>http</string>
   　　　<string>https</string>
   　　</array>
   ```

# ・SDK実装
## 動画リワード広告 / 動画インタースティシャル広告 / 動画Billboard広告

動画広告を実装する方法を紹介します。  
以下はObjective-Cでの実装になりますが、Swiftでも同様の実装で動作します。

### 初期化

```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  [GlossomAds initialize:/* App ID */
                  zoneIds:@[/* Zone IDs */]
          clientOptions:@{/* Options */}]

  return YES;
}
```

* 広告Zoneの初期化は一回のみになります、複数zoneご利用になる場合、発行されたzones全部入れるか、各Zoneに対して複数の初期化を実施してください。
* `application:didFinishLaunchingWithOptions:`ライフサイクル等、アプリの開始直後に極力呼び出して下さい。


### 広告取得
```objc
[GlossomAds load:/* Zone ID */ 
　　　　　notifyTo:/* GlossomAdsLoadDelegate */];
```
広告を再生する前に、広告情報を取得する必要があります。

広告の在庫が確認できるか、広告取得に失敗した場合には `GlossomAdsLoadDelegate` を通じて通知を受け取れます。

<font color="red">*注意:*</font> 初期化をしないと、loadは必ず失敗になります。

```objc
typedef NS_ENUM(NSInteger, GlossomAdLoadError) {
    GlossomAdsLoadErrorNoAd,
    GlossomAdsLoadErrorNetworkError,
    GlossomAdsLoadErrorInvalidResponse,
    GlossomAdsLoadErrorUnknown
};

- (void)onAdLoadSuccess:(nonnull NSString *)zoneId;
- (void)onAdLoadFail:(nonnull NSString *)zoneId error:(GlossomAdLoadError)error;

```

### 広告の表示

広告の準備が出来ましたら、広告種類に合わせて再生関数を呼び出して表示が出来ます。

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

#### 動画Billboard広告の表示

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

### 報酬の付与(動画リワード広告のみ)

上述の動画を表示する際に指定したDelegate用のクラスにdelegateメソッドを実装し、その中でユーザに報酬を付与する実装をしてください。

```objc
@import GlossomAds;

@interface ViewController : UIViewController<GlossomAdsRewardAdDelegate>

- (void)onGlossomAdsReward:(NSString *)zoneId success:(BOOL)success {
  if (success) {
    // ユーザに報酬を付与する
  }
}
```

### 2回目以降の広告再生

最初に広告を再生した後、再度広告を再生するためには広告取得（Load）から繰り返す必要があります。

```
① Zone初期化
② 広告取得
③ 再生
④ 広告取得
...

```	

## 動画Native広告
v1.10から、動画Nativeのフォーマット追加しました。サイズ設定できるの動画Viewを提供し、アプリ内任意の位置に貼ることができます。

### 動画Native広告実装
以下はObjective-Cでの実装になりますが、Swiftでも同様の実装で動作します。
具体的の実装はサンプル内`NativeAdViewController.m `を参考することがおすすめです。

* ZoneIDの初期化

```objc
  [GlossomAds initialize:/* App ID */
                  zoneIds:@[/* Zone IDs */]
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

<font color="red">*注意:*</font> `ZoneIDの初期化`しないと`loadAd`は必ず失敗になります。  

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

## 広告再生時の音設定について
動画広告が再生する際にBGMを流すが否か設定することが出来ます。

音設定を明示的にやらないと次のように動作します。

| 広告種類 | Default値 |
| --- | :---: |
| Reward | 音あり |
| Interstitial | 音あり |
| Billboard | 無音 |
| Native | 無音 |

`GlossomAds.setSoundEnable:(BOOL)enable`

enableをTrueにすると広告再生時に音が流れるようになります。

また、この関数を呼び出すと左上にMuteボタンが表示され、広告再生中にユーザがコントロールすることができるようになります。NativeAdは、常時Muteボタンが表示されます。


## テストモード

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
