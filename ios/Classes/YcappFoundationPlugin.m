#import "YcappFoundationPlugin.h"
#if __has_include(<ycapp_foundation/ycapp_foundation-Swift.h>)
#import <ycapp_foundation/ycapp_foundation-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "ycapp_foundation-Swift.h"
#endif

@implementation YcappFoundationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftYcappFoundationPlugin registerWithRegistrar:registrar];
}
@end
