 #import <Cordova/CDV.h>
 #import "APay.h"

@interface AllInPay : CDVPlugin <APayDelegate>

@property NSString* callbackId;

- (void)pay:(CDVInvokedUrlCommand*)command;

@end