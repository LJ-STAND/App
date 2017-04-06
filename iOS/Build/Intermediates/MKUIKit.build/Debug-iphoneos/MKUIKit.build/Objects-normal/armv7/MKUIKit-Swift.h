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
@import Foundation;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class UIView;

SWIFT_PROTOCOL("_TtP7MKUIKit10AnchorView_")
@protocol AnchorView
@property (nonatomic, readonly, strong) UIView * _Nonnull plainView;
@end

@class UIColor;
@class UIFont;
@class UINib;
@class DropDownCell;
@class NSCoder;

SWIFT_CLASS("_TtC7MKUIKit8DropDown")
@interface DropDown : UIView
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, weak) DropDown * _Nullable VisibleDropDown;)
+ (DropDown * _Nullable)VisibleDropDown SWIFT_WARN_UNUSED_RESULT;
+ (void)setVisibleDropDown:(DropDown * _Nullable)value;
@property (nonatomic, weak) id <AnchorView> _Nullable anchorView;
@property (nonatomic) CGPoint topOffset;
@property (nonatomic) CGPoint bottomOffset;
@property (nonatomic) CGFloat cellHeight;
@property (nonatomic, strong) UIColor * _Nullable backgroundColor;
@property (nonatomic, strong) UIColor * _Nonnull selectionBackgroundColor;
@property (nonatomic, strong) UIColor * _Nonnull separatorColor;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic, strong) UIColor * _Nonnull shadowColor;
@property (nonatomic) CGSize shadowOffset;
@property (nonatomic) float shadowOpacity;
@property (nonatomic) CGFloat shadowRadius;
@property (nonatomic) double animationduration;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class) UIViewAnimationOptions animationEntranceOptions;)
+ (UIViewAnimationOptions)animationEntranceOptions SWIFT_WARN_UNUSED_RESULT;
+ (void)setAnimationEntranceOptions:(UIViewAnimationOptions)value;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class) UIViewAnimationOptions animationExitOptions;)
+ (UIViewAnimationOptions)animationExitOptions SWIFT_WARN_UNUSED_RESULT;
+ (void)setAnimationExitOptions:(UIViewAnimationOptions)value;
@property (nonatomic) UIViewAnimationOptions animationEntranceOptions;
@property (nonatomic) UIViewAnimationOptions animationExitOptions;
@property (nonatomic) CGAffineTransform downScaleTransform;
@property (nonatomic, strong) UIColor * _Nonnull textColor;
@property (nonatomic, strong) UIFont * _Nonnull textFont;
@property (nonatomic, strong) UINib * _Nonnull cellNib;
@property (nonatomic, copy) NSArray<NSString *> * _Nonnull dataSource;
@property (nonatomic, copy) NSArray<NSString *> * _Nonnull localizationKeysDataSource;
@property (nonatomic, copy) NSString * _Nonnull (^ _Nullable cellConfiguration)(NSInteger, NSString * _Nonnull);
@property (nonatomic, copy) void (^ _Nullable customCellConfiguration)(NSInteger, NSString * _Nonnull, DropDownCell * _Nonnull);
@property (nonatomic, copy) void (^ _Nullable selectionAction)(NSInteger, NSString * _Nonnull);
@property (nonatomic, copy) void (^ _Nullable willShowAction)(void);
@property (nonatomic, copy) void (^ _Nullable cancelAction)(void);
- (nonnull instancetype)init;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface DropDown (SWIFT_EXTENSION(MKUIKit))
+ (void)setupDefaultAppearance;
@end

@class UIEvent;

@interface DropDown (SWIFT_EXTENSION(MKUIKit))
- (UIView * _Nullable)hitTest:(CGPoint)point withEvent:(UIEvent * _Nullable)event SWIFT_WARN_UNUSED_RESULT;
@end


@interface DropDown (SWIFT_EXTENSION(MKUIKit))
@end


@interface DropDown (SWIFT_EXTENSION(MKUIKit))
+ (void)startListeningToKeyboard;
@end

@class UITableView;
@class UITableViewCell;

@interface DropDown (SWIFT_EXTENSION(MKUIKit)) <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section SWIFT_WARN_UNUSED_RESULT;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath SWIFT_WARN_UNUSED_RESULT;
- (void)tableView:(UITableView * _Nonnull)tableView willDisplayCell:(UITableViewCell * _Nonnull)cell forRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
@end

@class NSDictionary;

@interface DropDown (SWIFT_EXTENSION(MKUIKit))
- (NSDictionary * _Nonnull)show SWIFT_WARN_UNUSED_RESULT;
- (void)hide;
@end


@interface DropDown (SWIFT_EXTENSION(MKUIKit))
- (void)updateConstraints;
- (void)layoutSubviews;
@end


@interface DropDown (SWIFT_EXTENSION(MKUIKit))
- (void)reloadAllComponents;
@property (nonatomic, readonly, copy) NSString * _Nullable selectedItem;
@end

@class UILabel;

SWIFT_CLASS("_TtC7MKUIKit12DropDownCell")
@interface DropDownCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified optionLabel;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER SWIFT_AVAILABILITY(ios,introduced=3.0);
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface DropDownCell (SWIFT_EXTENSION(MKUIKit))
- (void)awakeFromNib;
@property (nonatomic, setter=setSelected:) BOOL isSelected;
@property (nonatomic, setter=setHighlighted:) BOOL isHighlighted;
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
@end


@interface UIBarButtonItem (SWIFT_EXTENSION(MKUIKit)) <AnchorView>
@property (nonatomic, readonly, strong) UIView * _Nonnull plainView;
@end


@interface UIView (SWIFT_EXTENSION(MKUIKit))
@end


@interface UIView (SWIFT_EXTENSION(MKUIKit))
@end


@interface UIView (SWIFT_EXTENSION(MKUIKit)) <AnchorView>
@property (nonatomic, readonly, strong) UIView * _Nonnull plainView;
@end


@interface UIWindow (SWIFT_EXTENSION(MKUIKit))
@end

#pragma clang diagnostic pop
