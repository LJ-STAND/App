// Generated by Apple Swift version 3.0 (swiftlang-802.0.27.2 clang-802.0.27.2)
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
#if defined(__has_attribute) && __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
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
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import CoreGraphics;
@import ObjectiveC;
@import CoreBluetooth;
@import Foundation;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class UIWindow;
@class NSUserDefaults;
@class UIApplicationShortcutItem;
@class UIApplication;
@class NSNotification;

SWIFT_CLASS("_TtC8LJ_STAND11AppDelegate")
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) UIWindow * _Nullable window;
@property (nonatomic, strong) UIWindow * _Nullable dock;
@property (nonatomic, readonly, strong) NSUserDefaults * _Nonnull defaults;
@property (nonatomic) CGRect dockFrame;
@property (nonatomic) CGRect windowFrame;
@property (nonatomic, strong) UIApplicationShortcutItem * _Nullable shortcutItem;
- (BOOL)application:(UIApplication * _Nonnull)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id> * _Nullable)launchOptions SWIFT_WARN_UNUSED_RESULT;
- (void)setUpWindows;
- (void)addWindowWithNotification:(NSNotification * _Nonnull)notification;
- (void)setFrames;
- (void)orientationDidChange;
- (void)addWindowWithViewName:(NSString * _Nonnull)viewName;
- (void)initialWindow;
- (void)removeWindowWithName:(NSString * _Nonnull)name;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


@interface AppDelegate (SWIFT_EXTENSION(LJ_STAND))
- (void)application:(UIApplication * _Nonnull)application performActionForShortcutItem:(UIApplicationShortcutItem * _Nonnull)shortcutItem completionHandler:(void (^ _Nonnull)(BOOL))completionHandler;
- (BOOL)handleShortcutWithShortcutItem:(UIApplicationShortcutItem * _Nonnull)shortcutItem SWIFT_WARN_UNUSED_RESULT;
- (void)applicationDidBecomeActiveWithApplication:(UIApplication * _Nonnull)application;
@end

@class HexButton;
@class UIView;
@class UIButton;
@class NSBundle;
@class NSCoder;

SWIFT_CLASS("_TtC8LJ_STAND24BackgroundViewController")
@interface BackgroundViewController : UIViewController
@property (nonatomic, strong) HexButton * _Null_unspecified serialButton;
@property (nonatomic, strong) HexButton * _Null_unspecified TSOPButton;
@property (nonatomic, strong) HexButton * _Null_unspecified lightButton;
@property (nonatomic, strong) HexButton * _Null_unspecified compassButton;
@property (nonatomic, strong) HexButton * _Null_unspecified designButton;
@property (nonatomic, weak) IBOutlet UIView * _Null_unspecified dockView;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (void)buttonTapped:(UIButton * _Nonnull)sender;
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class CBCentralManager;
@class CBPeripheral;
@class CBCharacteristic;
@class NSNumber;
@class CBService;

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


SWIFT_CLASS("_TtC8LJ_STAND11CompassView")
@interface CompassView : UIView
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)commonInit;
- (void)drawRect:(CGRect)rect;
- (void)rotate:(double)angle;
- (double)degToRad:(double)angle SWIFT_WARN_UNUSED_RESULT;
@end


SWIFT_PROTOCOL("_TtP8LJ_STAND23ResizableViewController_")
@protocol ResizableViewController
@optional
- (void)windowWasResized;
- (void)windowWasMoved;
@end


SWIFT_CLASS("_TtC8LJ_STAND21CompassViewController")
@interface CompassViewController : UIViewController <ResizableViewController>
@property (nonatomic, strong) UIButton * _Nullable tappedButton;
@property (nonatomic, strong) CompassView * _Null_unspecified compass;
- (void)viewDidLoad;
- (void)viewDidAppear:(BOOL)animated;
- (CGRect)calculateFrame SWIFT_WARN_UNUSED_RESULT;
- (void)windowWasResized;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface CompassViewController (SWIFT_EXTENSION(LJ_STAND))
- (void)hasNewHeading:(double)angle;
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


SWIFT_CLASS("_TtC8LJ_STAND18DockViewController")
@interface DockViewController : UIViewController
- (void)viewDidLoad;
- (void)commonActionWithName:(NSString * _Nonnull)name;
- (IBAction)serialAction:(id _Nonnull)sender;
- (IBAction)tsopAction:(id _Nonnull)sender;
- (IBAction)lightAction:(id _Nonnull)sender;
- (IBAction)compassAction:(id _Nonnull)sender;
- (IBAction)designAction:(id _Nonnull)sender;
- (IBAction)settingsAction:(id _Nonnull)sender;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC8LJ_STAND9HexButton")
@interface HexButton : UIButton
@property (nonatomic, copy) NSString * _Nonnull text;
@property (nonatomic) CGRect frame;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)commonInit;
- (void)drawRect:(CGRect)rect;
@end

@class lightSensorView;

SWIFT_CLASS("_TtC8LJ_STAND25LightSensorViewController")
@interface LightSensorViewController : UIViewController <ResizableViewController>
@property (nonatomic, strong) UIButton * _Nullable tappedButton;
@property (nonatomic, strong) lightSensorView * _Null_unspecified lightSensView;
- (void)viewDidLoad;
- (void)viewDidAppear:(BOOL)animated;
- (CGRect)calculateFrame SWIFT_WARN_UNUSED_RESULT;
- (void)windowWasResized;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface LightSensorViewController (SWIFT_EXTENSION(LJ_STAND))
- (void)updatedCurrentLightSensors:(NSArray<NSNumber *> * _Nonnull)sensors;
@end

@class SCNView;

SWIFT_CLASS("_TtC8LJ_STAND19ModelViewController")
@interface ModelViewController : UIViewController
@property (nonatomic, strong) SCNView * _Null_unspecified sceneView;
- (void)viewDidLoad;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UILabel;
@class UITextView;

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
- (NSString * _Nonnull)trimString:(NSString * _Nonnull)str SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UITableViewCell;

SWIFT_CLASS("_TtC8LJ_STAND28PartsListTableViewController")
@interface PartsListTableViewController : UITableViewController
- (void)viewDidLoad;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section SWIFT_WARN_UNUSED_RESULT;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath SWIFT_WARN_UNUSED_RESULT;
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (nonnull instancetype)initWithStyle:(UITableViewStyle)style OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@class NSLayoutConstraint;
@class UIGestureRecognizer;

SWIFT_CLASS("_TtC8LJ_STAND20SerialViewController")
@interface SerialViewController : UIViewController <UIKeyInput, UITextInputTraits, ResizableViewController>
@property (nonatomic, readonly) BOOL hasText;
@property (nonatomic, weak) IBOutlet UITextView * _Null_unspecified serialOutputTextView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * _Null_unspecified bottomConstraint;
@property (nonatomic) NSInteger connectCount;
@property (nonatomic, strong) CBPeripheral * _Nullable selectedPeripheral;
@property (nonatomic) BOOL blinkOn;
@property (nonatomic, copy) NSString * _Nonnull enteredText;
@property (nonatomic, copy) NSString * _Nonnull previousText;
@property (nonatomic) CGRect keyboardFrame;
- (void)viewDidLoad;
- (void)keyboardWillShow:(NSNotification * _Nonnull)notification;
- (void)keyboardWillHide:(NSNotification * _Nonnull)notification;
- (void)windowWasResized;
- (void)windowWasMoved;
- (BOOL)becomeFirstResponder SWIFT_WARN_UNUSED_RESULT;
- (void)superBecomeFirstResponder;
- (void)blink;
- (void)viewDidAppear:(BOOL)animated;
- (void)reloadView;
- (void)showHideKeyboard:(UIGestureRecognizer * _Nonnull)rec;
- (void)insertText:(NSString * _Nonnull)text;
- (void)deleteBackward;
- (void)updateText;
- (void)updateTextNoScroll;
- (void)send;
@property (nonatomic, readonly) BOOL canBecomeFirstResponder;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface SerialViewController (SWIFT_EXTENSION(LJ_STAND))
- (void)hasNewOutput:(NSString * _Nonnull)serial;
@end

@class UISwitch;

SWIFT_CLASS("_TtC8LJ_STAND27SettingsTableViewController")
@interface SettingsTableViewController : UITableViewController
@property (nonatomic, weak) IBOutlet UISwitch * _Null_unspecified logWindowSwitch;
@property (nonatomic, weak) IBOutlet UISwitch * _Null_unspecified dockOnRightSwitch;
@property (nonatomic, readonly, strong) NSUserDefaults * _Nonnull defaults;
@property (nonatomic, readonly, strong) AppDelegate * _Nonnull delegate;
- (void)viewDidLoad;
- (IBAction)logWindowAction:(id _Nonnull)sender;
- (IBAction)dockOnRightAction:(id _Nonnull)sender;
- (nonnull instancetype)initWithStyle:(UITableViewStyle)style OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class tsopRingView;

SWIFT_CLASS("_TtC8LJ_STAND18TSOPViewController")
@interface TSOPViewController : UIViewController <ResizableViewController>
@property (nonatomic, strong) UIButton * _Nullable tappedButton;
@property (nonatomic, strong) tsopRingView * _Null_unspecified tsopView;
- (void)viewDidLoad;
- (void)viewDidAppear:(BOOL)animated;
- (void)windowWasResized;
- (CGRect)calculateFrame SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface TSOPViewController (SWIFT_EXTENSION(LJ_STAND))
- (void)hasNewActiveTSOP:(NSInteger)tsopNum;
@end


@interface UIBezierPath (SWIFT_EXTENSION(LJ_STAND))
+ (UIBezierPath * _Nonnull)roundedPolygonIn:(CGRect)rect numberOfSides:(NSInteger)numberOfSides cornerRadius:(CGFloat)cornerRadius lineWidth:(CGFloat)lineWidth rotationOffset:(CGFloat)rotationOffset SWIFT_WARN_UNUSED_RESULT;
@end


@interface UIDevice (SWIFT_EXTENSION(LJ_STAND))
@property (nonatomic, readonly) BOOL isSimulator;
@end


@interface UITextView (SWIFT_EXTENSION(LJ_STAND))
- (void)scrollToBottom;
@end


@interface UIView (SWIFT_EXTENSION(LJ_STAND))
- (void)makeCircular;
@end


@interface UIViewController (SWIFT_EXTENSION(LJ_STAND))
- (void)tintNavigationController;
@end

@class UIPanGestureRecognizer;

SWIFT_CLASS("_TtC8LJ_STAND8WMWindow")
@interface WMWindow : UIWindow <UIGestureRecognizerDelegate>
@property (nonatomic) CGRect _savedFrame;
@property (nonatomic) BOOL _inWindowMove;
@property (nonatomic) BOOL _inWindowResize;
@property (nonatomic) CGPoint _originPoint;
@property (nonatomic, copy) NSString * _Nullable title;
@property (nonatomic, copy) NSArray<UIButton *> * _Nullable windowButtons;
@property (nonatomic) BOOL maximized;
@property (nonatomic) CGSize minSize;
- (void)_commonInit;
- (void)layoutSubviews;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)maximize:(id _Nonnull)sender;
- (void)disableClose;
- (void)close:(id _Nonnull)sender;
- (void)becomeKeyWindow;
- (void)resignKeyWindow;
- (void)addSubview:(UIView * _Nonnull)view;
- (void)didTap:(UIGestureRecognizer * _Nonnull)rec;
- (void)setFrameWithFrame:(CGRect)frame;
- (void)didPan:(UIPanGestureRecognizer * _Nonnull)recognizer;
- (void)adjustMask;
- (BOOL)gestureRecognizer:(UIGestureRecognizer * _Nonnull)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer * _Nonnull)otherGestureRecognizer SWIFT_WARN_UNUSED_RESULT;
- (void)drawRect:(CGRect)rect;
- (BOOL)wm_isOpaque SWIFT_WARN_UNUSED_RESULT;
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
- (void)setValues:(NSInteger)sensorNumber;
- (void)clearValues;
- (double)degToRad:(double)angle SWIFT_WARN_UNUSED_RESULT;
@end


SWIFT_CLASS("_TtC8LJ_STAND12tsopRingView")
@interface tsopRingView : UIView
@property (nonatomic, copy) NSArray<NSNumber *> * _Nonnull tsops;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)commonInit;
- (void)drawRect:(CGRect)rect;
- (void)setCurrent:(NSInteger)current;
- (double)degToRad:(double)angle SWIFT_WARN_UNUSED_RESULT;
@end

#pragma clang diagnostic pop
