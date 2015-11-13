#import "AllInPay.h"
#import <Cordova/CDV.h>

#import "APay.h"
#import "PaaCreater.h"

@implementation AllInPay
    
@synthesize callbackId;

- (void)pay:(CDVInvokedUrlCommand*)command
{
    self.callbackId = command.callbackId;
    
    NSString* data = [PaaCreater randomPaa];
    UIViewController* viewController = self.viewController;
    
    [APay startPay:data viewController:viewController delegate:self mode:@"01"];
}

-(void)APayResult:(NSString *)result
{
    CDVPluginResult* pluginResult = nil;

    NSLog(@"%@", result);
    NSArray *parts = [result componentsSeparatedByString:@"="];
    NSError *error;
    NSData *data = [[parts lastObject] dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    NSInteger payResult = [dic[@"payResult"] integerValue];

    if (payResult == APayResultSuccess) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"pay success"];
    } else if (payResult == APayResultFail) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"pay fail"];
    } else if (payResult == APayResultCancel) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"pay cancelled"];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
}

@end