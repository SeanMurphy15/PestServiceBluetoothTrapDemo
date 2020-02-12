#if 0
#elif defined(__arm64__) && __arm64__
// Generated by Apple Swift version 5.1.3 (swiftlang-1100.0.282.1 clang-1100.0.33.15)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <Foundation/Foundation.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus)
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

#if __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if __has_attribute(noreturn)
# define SWIFT_NORETURN __attribute__((noreturn))
#else
# define SWIFT_NORETURN
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
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif
#if !defined(SWIFT_RESILIENT_CLASS)
# if __has_attribute(objc_class_stub)
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME) __attribute__((objc_class_stub))
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_class_stub)) SWIFT_CLASS_NAMED(SWIFT_NAME)
# else
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME)
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) SWIFT_CLASS_NAMED(SWIFT_NAME)
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
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if defined(__has_attribute) && __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR(_extensibility) __attribute__((enum_extensibility(_extensibility)))
# else
#  define SWIFT_ENUM_ATTR(_extensibility)
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name, _extensibility) enum _name : _type _name; enum SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) SWIFT_ENUM(_type, _name, _extensibility)
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
#if !defined(SWIFT_WEAK_IMPORT)
# define SWIFT_WEAK_IMPORT __attribute__((weak_import))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if __has_feature(attribute_diagnose_if_objc)
# define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
#else
# define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
#endif
#if !defined(IBSegueAction)
# define IBSegueAction
#endif
#if __has_feature(modules)
#if __has_warning("-Watimport-in-framework-header")
#pragma clang diagnostic ignored "-Watimport-in-framework-header"
#endif
@import CoreBluetooth;
@import Foundation;
@import ObjectiveC;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"

#if __has_attribute(external_source_symbol)
# pragma push_macro("any")
# undef any
# pragma clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in="BellSensingBLE",generated_declaration))), apply_to=any(function,enum,objc_interface,objc_category,objc_protocol))
# pragma pop_macro("any")
#endif


SWIFT_CLASS("_TtC14BellSensingBLE20AdvertisingDataModel")
@interface AdvertisingDataModel : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC14BellSensingBLE10BeaconData")
@interface BeaconData : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

@class CBPeripheral;
@class NSNumber;
@class CBService;
@class CBCharacteristic;

/// Bluetooth Model Delegate
SWIFT_PROTOCOL("_TtP14BellSensingBLE17BluetoothDelegate_")
@protocol BluetoothDelegate
@optional
/// The callback function when the bluetooth has updated.
/// \param state The newest state
///
- (void)didUpdateState:(CBManagerState)state;
/// The callback function when peripheral has been found.
/// \param peripheral The peripheral has been found.
///
/// \param advertisementData The advertisement data.
///
/// \param RSSI The signal strength.
///
- (void)didDiscoverPeripheral:(CBPeripheral * _Nonnull)peripheral advertisementData:(NSDictionary<NSString *, id> * _Nonnull)advertisementData RSSI:(NSNumber * _Nonnull)RSSI;
/// The callback function when central manager connected the peripheral successfully.
/// \param connectedPeripheral The peripheral which connected successfully.
///
- (void)didConnectedPeripheral:(CBPeripheral * _Nonnull)connectedPeripheral;
/// The callback function when central manager failed to connect the peripheral.
/// \param connectedPeripheral The peripheral which connected failure.
///
/// \param error The connected failed error message.
///
- (void)failToConnectPeripheral:(CBPeripheral * _Nonnull)peripheral error:(NSError * _Nonnull)error;
/// The callback function when the services has been discovered.
/// \param peripheral Peripheral which provide this information and contain services information
///
- (void)didDiscoverServices:(CBPeripheral * _Nonnull)peripheral;
/// The callback function when the peripheral disconnected.
/// \param peripheral The peripheral which provide this action
///
- (void)didDisconnectPeripheral:(CBPeripheral * _Nonnull)peripheral;
/// The callback function when interrogate the peripheral is timeout
/// \param peripheral The peripheral which is failed to discover service
///
- (void)didFailedToInterrogate:(CBPeripheral * _Nonnull)peripheral;
/// The callback function when discover characteritics successfully.
/// \param service The service information include characteritics.
///
- (void)didDiscoverCharacteristics:(CBService * _Nonnull)service;
/// The callback function when peripheral failed to discover charateritics.
/// \param error The error information.
///
- (void)didFailToDiscoverCharacteritics:(NSError * _Nonnull)error;
/// The callback function when discover descriptor for characteristic successfully
/// \param characteristic The characteristic which has the descriptor
///
- (void)didDiscoverDescriptors:(CBCharacteristic * _Nonnull)characteristic;
/// The callback function when failed to discover descriptor for characteristic
/// \param error The error message
///
- (void)didFailToDiscoverDescriptors:(NSError * _Nonnull)error;
/// The callback function invoked when peripheral read value for the characteristic successfully
/// \param characteristic The characteristic withe the value
///
- (void)didReadValueForCharacteristic:(CBCharacteristic * _Nonnull)characteristic;
/// The callback function invoked when failed to read value for the characteristic
/// \param error The error message
///
- (void)didFailToReadValueForCharacteristic:(NSError * _Nonnull)error;
/// The callback function invoked when peripheral write value for the characteristic successfully
/// \param characteristic The characteristic with the value
///
- (void)didWriteValueForCharacteristic:(CBCharacteristic * _Nonnull)characteristic;
/// The callback function invoked when failed to read value for the characteristic
/// \param error The error message
///
- (void)didFailToWriteValueForCharacteristic:(NSError * _Nonnull)error;
/// The callback function invoked when peripheral updates notification value for the characteristic successfully
/// \param characteristic The characteristic withe the value
///
- (void)didUpdateNotificationValueForCharacteristic:(CBCharacteristic * _Nonnull)characteristic;
/// The callback function invoked when failed to updates notification value for the characteristic
/// \param error The error message
///
- (void)didFailToUpdateNotificationValueForCharacteristic:(NSError * _Nonnull)error;
@end

@class CBCentralManager;

SWIFT_CLASS("_TtC14BellSensingBLE16BluetoothManager")
@interface BluetoothManager : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate>
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
/// Invoked whenever the central manager’s state has been updated.
- (void)centralManagerDidUpdateState:(CBCentralManager * _Nonnull)central;
/// This method is invoked while scanning, upon the discovery of peripheral by central
/// <ul>
///   <li>
///     \code
///                                was not available.
///
///     \endcode</li>
/// </ul>
/// \param central The central manager providing this update.
///
/// \param peripheral The discovered peripheral.
///
/// \param advertisementData A dictionary containing any advertisement and scan response data.
///
/// \param RSSI The current RSSI of peripheral, in dBm. A value of 127 is reserved and indicates the RSSI
///
- (void)centralManager:(CBCentralManager * _Nonnull)central didDiscoverPeripheral:(CBPeripheral * _Nonnull)peripheral advertisementData:(NSDictionary<NSString *, id> * _Nonnull)advertisementData RSSI:(NSNumber * _Nonnull)RSSI;
/// This method is invoked when a connection succeeded
/// \param central The central manager providing this information.
///
/// \param peripheral The peripheral that has connected.
///
- (void)centralManager:(CBCentralManager * _Nonnull)central didConnectPeripheral:(CBPeripheral * _Nonnull)peripheral;
/// This method is invoked where a connection failed.
/// \param central The central manager providing this information.
///
/// \param peripheral The peripheral that you tried to connect.
///
/// \param error The error infomation about connecting failed.
///
- (void)centralManager:(CBCentralManager * _Nonnull)central didFailToConnectPeripheral:(CBPeripheral * _Nonnull)peripheral error:(NSError * _Nullable)error;
/// The method is invoked where services were discovered.
/// \param peripheral The peripheral with service informations.
///
/// \param error Errot message when discovered services.
///
- (void)peripheral:(CBPeripheral * _Nonnull)peripheral didDiscoverServices:(NSError * _Nullable)error;
/// The method is invoked where characteristics were discovered.
/// \param peripheral The peripheral provide this information
///
/// \param service The service included the characteristics.
///
/// \param error If an error occurred, the cause of the failure.
///
- (void)peripheral:(CBPeripheral * _Nonnull)peripheral didDiscoverCharacteristicsForService:(CBService * _Nonnull)service error:(NSError * _Nullable)error;
/// This method is invoked when the peripheral has found the descriptor for the characteristic
/// \param peripheral The peripheral providing this information
///
/// \param characteristic The characteristic which has the descriptor
///
/// \param error The error message
///
- (void)peripheral:(CBPeripheral * _Nonnull)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic * _Nonnull)characteristic error:(NSError * _Nullable)error;
/// This method is invoked when the peripheral has been disconnected.
/// \param central The central manager providing this information
///
/// \param peripheral The disconnected peripheral
///
/// \param error The error message
///
- (void)centralManager:(CBCentralManager * _Nonnull)central didDisconnectPeripheral:(CBPeripheral * _Nonnull)peripheral error:(NSError * _Nullable)error;
/// Thie method is invoked when the user call the peripheral.readValueForCharacteristic
/// \param peripheral The periphreal which call the method
///
/// \param characteristic The characteristic with the new value
///
/// \param error The error message
///
- (void)peripheral:(CBPeripheral * _Nonnull)peripheral didUpdateValueForCharacteristic:(CBCharacteristic * _Nonnull)characteristic error:(NSError * _Nullable)error;
/// This method is invoked when the user call the peripheral.setNotifyValue
/// \param peripheral The periphreal which call the method
///
/// \param characteristic The characteristic with the updated notification
///
/// \param error The error message
///
- (void)peripheral:(CBPeripheral * _Nonnull)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic * _Nonnull)characteristic error:(NSError * _Nullable)error;
/// This method is invoked when the user call the peripheral.writeValue
/// \param peripheral The periphreal which call the method
///
/// \param characteristic The characteristic with the updated notification
///
/// \param error The error message
///
- (void)peripheral:(CBPeripheral * _Nonnull)peripheral didWriteValueForCharacteristic:(CBCharacteristic * _Nonnull)characteristic error:(NSError * _Nullable)error;
@end


SWIFT_CLASS("_TtC14BellSensingBLE16DeviceActivation")
@interface DeviceActivation : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC14BellSensingBLE15DeviceDetection")
@interface DeviceDetection : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC14BellSensingBLE11DeviceEvent")
@interface DeviceEvent : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC14BellSensingBLE13DeviceScanner")
@interface DeviceScanner : NSObject <BluetoothDelegate>
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


@interface DeviceScanner (SWIFT_EXTENSION(BellSensingBLE))
- (void)didUpdateState:(CBManagerState)state;
- (void)didDiscoverPeripheral:(CBPeripheral * _Nonnull)peripheral advertisementData:(NSDictionary<NSString *, id> * _Nonnull)advertisementData RSSI:(NSNumber * _Nonnull)RSSI;
- (void)didConnectedPeripheral:(CBPeripheral * _Nonnull)connectedPeripheral;
- (void)failToConnectPeripheral:(CBPeripheral * _Nonnull)peripheral error:(NSError * _Nonnull)error;
- (void)didDiscoverServices:(CBPeripheral * _Nonnull)peripheral;
- (void)didDisconnectPeripheral:(CBPeripheral * _Nonnull)peripheral;
- (void)didFailedToInterrogate:(CBPeripheral * _Nonnull)peripheral;
- (void)didReadValueForCharacteristic:(CBCharacteristic * _Nonnull)characteristic;
@end




SWIFT_CLASS("_TtC14BellSensingBLE15SyncDeviceModel")
@interface SyncDeviceModel : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC14BellSensingBLE18SyncSignatureModel")
@interface SyncSignatureModel : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

#if __has_attribute(external_source_symbol)
# pragma clang attribute pop
#endif
#pragma clang diagnostic pop

#elif defined(__ARM_ARCH_7A__) && __ARM_ARCH_7A__
// Generated by Apple Swift version 5.1.3 (swiftlang-1100.0.282.1 clang-1100.0.33.15)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <Foundation/Foundation.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus)
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

#if __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if __has_attribute(noreturn)
# define SWIFT_NORETURN __attribute__((noreturn))
#else
# define SWIFT_NORETURN
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
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif
#if !defined(SWIFT_RESILIENT_CLASS)
# if __has_attribute(objc_class_stub)
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME) __attribute__((objc_class_stub))
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_class_stub)) SWIFT_CLASS_NAMED(SWIFT_NAME)
# else
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME)
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) SWIFT_CLASS_NAMED(SWIFT_NAME)
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
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if defined(__has_attribute) && __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR(_extensibility) __attribute__((enum_extensibility(_extensibility)))
# else
#  define SWIFT_ENUM_ATTR(_extensibility)
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name, _extensibility) enum _name : _type _name; enum SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) SWIFT_ENUM(_type, _name, _extensibility)
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
#if !defined(SWIFT_WEAK_IMPORT)
# define SWIFT_WEAK_IMPORT __attribute__((weak_import))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if __has_feature(attribute_diagnose_if_objc)
# define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
#else
# define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
#endif
#if !defined(IBSegueAction)
# define IBSegueAction
#endif
#if __has_feature(modules)
#if __has_warning("-Watimport-in-framework-header")
#pragma clang diagnostic ignored "-Watimport-in-framework-header"
#endif
@import CoreBluetooth;
@import Foundation;
@import ObjectiveC;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"

#if __has_attribute(external_source_symbol)
# pragma push_macro("any")
# undef any
# pragma clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in="BellSensingBLE",generated_declaration))), apply_to=any(function,enum,objc_interface,objc_category,objc_protocol))
# pragma pop_macro("any")
#endif


SWIFT_CLASS("_TtC14BellSensingBLE20AdvertisingDataModel")
@interface AdvertisingDataModel : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC14BellSensingBLE10BeaconData")
@interface BeaconData : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

@class CBPeripheral;
@class NSNumber;
@class CBService;
@class CBCharacteristic;

/// Bluetooth Model Delegate
SWIFT_PROTOCOL("_TtP14BellSensingBLE17BluetoothDelegate_")
@protocol BluetoothDelegate
@optional
/// The callback function when the bluetooth has updated.
/// \param state The newest state
///
- (void)didUpdateState:(CBManagerState)state;
/// The callback function when peripheral has been found.
/// \param peripheral The peripheral has been found.
///
/// \param advertisementData The advertisement data.
///
/// \param RSSI The signal strength.
///
- (void)didDiscoverPeripheral:(CBPeripheral * _Nonnull)peripheral advertisementData:(NSDictionary<NSString *, id> * _Nonnull)advertisementData RSSI:(NSNumber * _Nonnull)RSSI;
/// The callback function when central manager connected the peripheral successfully.
/// \param connectedPeripheral The peripheral which connected successfully.
///
- (void)didConnectedPeripheral:(CBPeripheral * _Nonnull)connectedPeripheral;
/// The callback function when central manager failed to connect the peripheral.
/// \param connectedPeripheral The peripheral which connected failure.
///
/// \param error The connected failed error message.
///
- (void)failToConnectPeripheral:(CBPeripheral * _Nonnull)peripheral error:(NSError * _Nonnull)error;
/// The callback function when the services has been discovered.
/// \param peripheral Peripheral which provide this information and contain services information
///
- (void)didDiscoverServices:(CBPeripheral * _Nonnull)peripheral;
/// The callback function when the peripheral disconnected.
/// \param peripheral The peripheral which provide this action
///
- (void)didDisconnectPeripheral:(CBPeripheral * _Nonnull)peripheral;
/// The callback function when interrogate the peripheral is timeout
/// \param peripheral The peripheral which is failed to discover service
///
- (void)didFailedToInterrogate:(CBPeripheral * _Nonnull)peripheral;
/// The callback function when discover characteritics successfully.
/// \param service The service information include characteritics.
///
- (void)didDiscoverCharacteristics:(CBService * _Nonnull)service;
/// The callback function when peripheral failed to discover charateritics.
/// \param error The error information.
///
- (void)didFailToDiscoverCharacteritics:(NSError * _Nonnull)error;
/// The callback function when discover descriptor for characteristic successfully
/// \param characteristic The characteristic which has the descriptor
///
- (void)didDiscoverDescriptors:(CBCharacteristic * _Nonnull)characteristic;
/// The callback function when failed to discover descriptor for characteristic
/// \param error The error message
///
- (void)didFailToDiscoverDescriptors:(NSError * _Nonnull)error;
/// The callback function invoked when peripheral read value for the characteristic successfully
/// \param characteristic The characteristic withe the value
///
- (void)didReadValueForCharacteristic:(CBCharacteristic * _Nonnull)characteristic;
/// The callback function invoked when failed to read value for the characteristic
/// \param error The error message
///
- (void)didFailToReadValueForCharacteristic:(NSError * _Nonnull)error;
/// The callback function invoked when peripheral write value for the characteristic successfully
/// \param characteristic The characteristic with the value
///
- (void)didWriteValueForCharacteristic:(CBCharacteristic * _Nonnull)characteristic;
/// The callback function invoked when failed to read value for the characteristic
/// \param error The error message
///
- (void)didFailToWriteValueForCharacteristic:(NSError * _Nonnull)error;
/// The callback function invoked when peripheral updates notification value for the characteristic successfully
/// \param characteristic The characteristic withe the value
///
- (void)didUpdateNotificationValueForCharacteristic:(CBCharacteristic * _Nonnull)characteristic;
/// The callback function invoked when failed to updates notification value for the characteristic
/// \param error The error message
///
- (void)didFailToUpdateNotificationValueForCharacteristic:(NSError * _Nonnull)error;
@end

@class CBCentralManager;

SWIFT_CLASS("_TtC14BellSensingBLE16BluetoothManager")
@interface BluetoothManager : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate>
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
/// Invoked whenever the central manager’s state has been updated.
- (void)centralManagerDidUpdateState:(CBCentralManager * _Nonnull)central;
/// This method is invoked while scanning, upon the discovery of peripheral by central
/// <ul>
///   <li>
///     \code
///                                was not available.
///
///     \endcode</li>
/// </ul>
/// \param central The central manager providing this update.
///
/// \param peripheral The discovered peripheral.
///
/// \param advertisementData A dictionary containing any advertisement and scan response data.
///
/// \param RSSI The current RSSI of peripheral, in dBm. A value of 127 is reserved and indicates the RSSI
///
- (void)centralManager:(CBCentralManager * _Nonnull)central didDiscoverPeripheral:(CBPeripheral * _Nonnull)peripheral advertisementData:(NSDictionary<NSString *, id> * _Nonnull)advertisementData RSSI:(NSNumber * _Nonnull)RSSI;
/// This method is invoked when a connection succeeded
/// \param central The central manager providing this information.
///
/// \param peripheral The peripheral that has connected.
///
- (void)centralManager:(CBCentralManager * _Nonnull)central didConnectPeripheral:(CBPeripheral * _Nonnull)peripheral;
/// This method is invoked where a connection failed.
/// \param central The central manager providing this information.
///
/// \param peripheral The peripheral that you tried to connect.
///
/// \param error The error infomation about connecting failed.
///
- (void)centralManager:(CBCentralManager * _Nonnull)central didFailToConnectPeripheral:(CBPeripheral * _Nonnull)peripheral error:(NSError * _Nullable)error;
/// The method is invoked where services were discovered.
/// \param peripheral The peripheral with service informations.
///
/// \param error Errot message when discovered services.
///
- (void)peripheral:(CBPeripheral * _Nonnull)peripheral didDiscoverServices:(NSError * _Nullable)error;
/// The method is invoked where characteristics were discovered.
/// \param peripheral The peripheral provide this information
///
/// \param service The service included the characteristics.
///
/// \param error If an error occurred, the cause of the failure.
///
- (void)peripheral:(CBPeripheral * _Nonnull)peripheral didDiscoverCharacteristicsForService:(CBService * _Nonnull)service error:(NSError * _Nullable)error;
/// This method is invoked when the peripheral has found the descriptor for the characteristic
/// \param peripheral The peripheral providing this information
///
/// \param characteristic The characteristic which has the descriptor
///
/// \param error The error message
///
- (void)peripheral:(CBPeripheral * _Nonnull)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic * _Nonnull)characteristic error:(NSError * _Nullable)error;
/// This method is invoked when the peripheral has been disconnected.
/// \param central The central manager providing this information
///
/// \param peripheral The disconnected peripheral
///
/// \param error The error message
///
- (void)centralManager:(CBCentralManager * _Nonnull)central didDisconnectPeripheral:(CBPeripheral * _Nonnull)peripheral error:(NSError * _Nullable)error;
/// Thie method is invoked when the user call the peripheral.readValueForCharacteristic
/// \param peripheral The periphreal which call the method
///
/// \param characteristic The characteristic with the new value
///
/// \param error The error message
///
- (void)peripheral:(CBPeripheral * _Nonnull)peripheral didUpdateValueForCharacteristic:(CBCharacteristic * _Nonnull)characteristic error:(NSError * _Nullable)error;
/// This method is invoked when the user call the peripheral.setNotifyValue
/// \param peripheral The periphreal which call the method
///
/// \param characteristic The characteristic with the updated notification
///
/// \param error The error message
///
- (void)peripheral:(CBPeripheral * _Nonnull)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic * _Nonnull)characteristic error:(NSError * _Nullable)error;
/// This method is invoked when the user call the peripheral.writeValue
/// \param peripheral The periphreal which call the method
///
/// \param characteristic The characteristic with the updated notification
///
/// \param error The error message
///
- (void)peripheral:(CBPeripheral * _Nonnull)peripheral didWriteValueForCharacteristic:(CBCharacteristic * _Nonnull)characteristic error:(NSError * _Nullable)error;
@end


SWIFT_CLASS("_TtC14BellSensingBLE16DeviceActivation")
@interface DeviceActivation : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC14BellSensingBLE15DeviceDetection")
@interface DeviceDetection : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC14BellSensingBLE11DeviceEvent")
@interface DeviceEvent : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC14BellSensingBLE13DeviceScanner")
@interface DeviceScanner : NSObject <BluetoothDelegate>
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


@interface DeviceScanner (SWIFT_EXTENSION(BellSensingBLE))
- (void)didUpdateState:(CBManagerState)state;
- (void)didDiscoverPeripheral:(CBPeripheral * _Nonnull)peripheral advertisementData:(NSDictionary<NSString *, id> * _Nonnull)advertisementData RSSI:(NSNumber * _Nonnull)RSSI;
- (void)didConnectedPeripheral:(CBPeripheral * _Nonnull)connectedPeripheral;
- (void)failToConnectPeripheral:(CBPeripheral * _Nonnull)peripheral error:(NSError * _Nonnull)error;
- (void)didDiscoverServices:(CBPeripheral * _Nonnull)peripheral;
- (void)didDisconnectPeripheral:(CBPeripheral * _Nonnull)peripheral;
- (void)didFailedToInterrogate:(CBPeripheral * _Nonnull)peripheral;
- (void)didReadValueForCharacteristic:(CBCharacteristic * _Nonnull)characteristic;
@end




SWIFT_CLASS("_TtC14BellSensingBLE15SyncDeviceModel")
@interface SyncDeviceModel : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC14BellSensingBLE18SyncSignatureModel")
@interface SyncSignatureModel : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

#if __has_attribute(external_source_symbol)
# pragma clang attribute pop
#endif
#pragma clang diagnostic pop

#endif
