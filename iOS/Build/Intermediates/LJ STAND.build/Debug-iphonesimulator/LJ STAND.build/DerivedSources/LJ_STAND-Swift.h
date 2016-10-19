// Generated by Apple Swift version 3.0.1 (swiftlang-800.0.56 clang-800.0.42)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if defined(__has_attribute) && __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import ObjectiveC;
@import CoreBluetooth;
@import Foundation;
@import CoreGraphics;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class UIWindow;
@class UIApplication;

SWIFT_CLASS("_TtC8LJ_STAND11AppDelegate")
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) UIWindow * _Nullable window;
- (BOOL)application:(UIApplication * _Nonnull)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id> * _Nullable)launchOptions;
- (void)checkForUpdate;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class CBCentralManager;
@class CBPeripheral;
@class NSNumber;
@class CBService;
@class CBCharacteristic;

SWIFT_CLASS("_TtC8LJ_STAND15BluetoothSerial")
@interface BluetoothSerial : NSObject <CBPeripheralDelegate, CBCentralManagerDelegate>
@property (nonatomic, strong) CBCentralManager * _Null_unspecified centralManager;
@property (nonatomic, strong) CBPeripheral * _Nullable pendingPeripheral;
@property (nonatomic, strong) CBPeripheral * _Nullable connectedPeripheral;
@property (nonatomic, weak) CBCharacteristic * _Nullable writeCharacteristic;
@property (nonatomic, readonly) BOOL isReady;
@property (nonatomic) CBCharacteristicWriteType writeType;
- (void)startScan;
- (void)stopScan;
- (void)connectToPeripheral:(CBPeripheral * _Nonnull)peripheral;
- (void)disconnect;
- (void)readRSSI;
- (void)sendMessageToDevice:(NSString * _Nonnull)message;
- (void)sendBytesToDevice:(NSArray<NSNumber *> * _Nonnull)bytes;
- (void)sendDataToDevice:(NSData * _Nonnull)data;
- (void)centralManager:(CBCentralManager * _Nonnull)central didDiscoverPeripheral:(CBPeripheral * _Nonnull)peripheral advertisementData:(NSDictionary<NSString *, id> * _Nonnull)advertisementData RSSI:(NSNumber * _Nonnull)RSSI;
- (void)centralManager:(CBCentralManager * _Nonnull)central didConnectPeripheral:(CBPeripheral * _Nonnull)peripheral;
- (void)centralManager:(CBCentralManager * _Nonnull)central didDisconnectPeripheral:(CBPeripheral * _Nonnull)peripheral error:(NSError * _Nullable)error;
- (void)centralManager:(CBCentralManager * _Nonnull)central didFailToConnectPeripheral:(CBPeripheral * _Nonnull)peripheral error:(NSError * _Nullable)error;
- (void)centralManagerDidUpdateState:(CBCentralManager * _Nonnull)central;
- (void)peripheral:(CBPeripheral * _Nonnull)peripheral didDiscoverServices:(NSError * _Nullable)error;
- (void)peripheral:(CBPeripheral * _Nonnull)peripheral didDiscoverCharacteristicsForService:(CBService * _Nonnull)service error:(NSError * _Nullable)error;
- (void)peripheral:(CBPeripheral * _Nonnull)peripheral didUpdateValueForCharacteristic:(CBCharacteristic * _Nonnull)characteristic error:(NSError * _Nullable)error;
- (void)peripheral:(CBPeripheral * _Nonnull)peripheral didReadRSSI:(NSNumber * _Nonnull)RSSI error:(NSError * _Nullable)error;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end

@class NSCoder;

SWIFT_CLASS("_TtC8LJ_STAND11CompassView")
@interface CompassView : UIView
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)commonInit;
- (void)drawRect:(CGRect)rect;
- (void)rotateWithAngle:(double)angle;
- (double)degToRadWithAngle:(double)angle;
@end

@class TitleView;
@class UILabel;
@class NSBundle;

SWIFT_CLASS("_TtC8LJ_STAND21CompassViewController")
@interface CompassViewController : UIViewController
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified angleLabel;
@property (nonatomic, strong) CompassView * _Null_unspecified compass;
@property (nonatomic, strong) TitleView * _Null_unspecified titleView;
- (void)viewDidLoad;
- (void)newCompassWithNotification:(NSNotification * _Nonnull)notification;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UITableView;

SWIFT_CLASS("_TtC8LJ_STAND25DesignTableViewController")
@interface DesignTableViewController : UITableViewController
- (void)viewDidLoad;
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (nonnull instancetype)initWithStyle:(UITableViewStyle)style OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class lightSensorView;

SWIFT_CLASS("_TtC8LJ_STAND25LightSensorViewController")
@interface LightSensorViewController : UIViewController
@property (nonatomic, strong) lightSensorView * _Null_unspecified lightSensView;
@property (nonatomic, strong) TitleView * _Null_unspecified titleView;
- (void)viewDidLoad;
- (void)newDataWithNotification:(NSNotification * _Nonnull)notification;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class SCNView;

SWIFT_CLASS("_TtC8LJ_STAND19ModelViewController")
@interface ModelViewController : UIViewController
@property (nonatomic, strong) SCNView * _Null_unspecified sceneView;
- (void)viewDidLoad;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UITextView;
@class UIButton;

SWIFT_CLASS("_TtC8LJ_STAND24PartDetailViewController")
@interface PartDetailViewController : UIViewController
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified descriptionLabel;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified supplierLabel;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified vendorPartLabel;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified totalQtyLabel;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified sparesLabel;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified priceInORGCurrencyLabel;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified priceAudLabel;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified totalPrice;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified weightPerItem;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified qtyLabel;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified totalWeight;
@property (nonatomic, weak) IBOutlet UITextView * _Null_unspecified notesTextView;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified productButton;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewDidLoad;
- (void)updateLabel;
- (IBAction)openProductPageAction:(id _Nonnull)sender;
- (NSString * _Nonnull)trimStringWithStr:(NSString * _Nonnull)str;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UITableViewCell;

SWIFT_CLASS("_TtC8LJ_STAND28PartsListTableViewController")
@interface PartsListTableViewController : UITableViewController
- (void)viewDidLoad;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (nonnull instancetype)initWithStyle:(UITableViewStyle)style OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UITextField;
@class NSLayoutConstraint;

SWIFT_CLASS("_TtC8LJ_STAND20SerialViewController")
@interface SerialViewController : UIViewController
@property (nonatomic, weak) IBOutlet UITextField * _Null_unspecified sendTextField;
@property (nonatomic, weak) IBOutlet UITextView * _Null_unspecified serialOutputTextView;
@property (nonatomic, weak) IBOutlet UIView * _Null_unspecified bottomView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * _Null_unspecified bottomConstraint;
@property (nonatomic, strong) TitleView * _Null_unspecified titleView;
@property (nonatomic, strong) CBPeripheral * _Nullable selectedPeripheral;
- (void)viewDidLoad;
- (void)keyboardWillShow:(NSNotification * _Nonnull)notification;
- (void)keyboardWillHide:(NSNotification * _Nonnull)notification;
- (void)viewDidAppear:(BOOL)animated;
- (void)reloadView;
- (void)dismissKeyboard;
- (void)connect;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface SerialViewController (SWIFT_EXTENSION(LJ_STAND)) <UITextFieldDelegate>
- (BOOL)textFieldShouldReturn:(UITextField * _Nonnull)textField;
@end

@class NSError;

@interface SerialViewController (SWIFT_EXTENSION(LJ_STAND))
- (void)serialDidDiscoverPeripheral:(CBPeripheral * _Nonnull)peripheral RSSI:(NSNumber * _Nullable)RSSI;
- (void)serialDidConnect:(CBPeripheral * _Nonnull)peripheral;
- (void)serialDidFailToConnect:(CBPeripheral * _Nonnull)peripheral error:(NSError * _Nullable)error;
- (void)serialDidReceiveString:(NSString * _Nonnull)message;
- (void)serialDidChangeState;
- (void)serialDidDisconnect:(CBPeripheral * _Nonnull)peripheral error:(NSError * _Nullable)error;
@end

@class tsopRingView;

SWIFT_CLASS("_TtC8LJ_STAND18TSOPViewController")
@interface TSOPViewController : UIViewController
@property (nonatomic, strong) tsopRingView * _Null_unspecified tsopView;
@property (nonatomic, strong) TitleView * _Null_unspecified titleView;
- (void)viewDidLoad;
- (void)newActiveWithNotification:(NSNotification * _Nonnull)notification;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC8LJ_STAND9TitleView")
@interface TitleView : UIView
@property (nonatomic, strong) UILabel * _Null_unspecified titleLabel;
- (nonnull instancetype)initWithFrame:(CGRect)frame title:(NSString * _Nonnull)title OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)drawRect:(CGRect)rect;
- (nonnull instancetype)initWithFrame:(CGRect)frame SWIFT_UNAVAILABLE;
@end


@interface UITextView (SWIFT_EXTENSION(LJ_STAND))
- (void)scrollToBotom;
@end


@interface UIView (SWIFT_EXTENSION(LJ_STAND))
- (void)makeCircular;
@end

@class WKWebView;

SWIFT_CLASS("_TtC8LJ_STAND17WebViewController")
@interface WebViewController : UIViewController
@property (nonatomic, copy) NSURL * _Null_unspecified url;
@property (nonatomic, copy) NSString * _Null_unspecified navTitle;
@property (nonatomic, strong) WKWebView * _Null_unspecified webView;
- (void)viewDidLoad;
- (void)viewDidAppear:(BOOL)animated;
- (void)loadWeb;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC8LJ_STAND15lightSensorView")
@interface lightSensorView : UIView
@property (nonatomic, copy) NSArray<NSNumber *> * _Nonnull lights;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)commonInit;
- (void)drawRect:(CGRect)rect;
- (void)setValuesWithSensorNumber:(NSInteger)sensorNumber;
- (void)clearValues;
- (double)degToRadWithAngle:(double)angle;
@end


SWIFT_CLASS("_TtC8LJ_STAND12tsopRingView")
@interface tsopRingView : UIView
@property (nonatomic, copy) NSArray<NSNumber *> * _Nonnull tsops;
@property (nonatomic, strong) UILabel * _Null_unspecified tsopNumberLabel;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)commonInit;
- (void)drawRect:(CGRect)rect;
- (void)setCurrentWithCurrent:(NSInteger)current;
- (double)degToRadWithAngle:(double)angle;
@end

#pragma clang diagnostic pop
