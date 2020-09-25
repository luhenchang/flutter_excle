#import "FlutterExclePlugin.h"
#if __has_include(<flutter_excle/flutter_excle-Swift.h>)
#import <flutter_excle/flutter_excle-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_excle-Swift.h"
#endif

@implementation FlutterExclePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterExclePlugin registerWithRegistrar:registrar];
}
@end
