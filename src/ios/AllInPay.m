#import "AllInPay.h"
#import <Cordova/CDV.h>

#import "APay.h"
#import "PaaCreater.h"

@implementation AllInPay
    
@synthesize callbackId;

- (void)pay:(CDVInvokedUrlCommand*)command
{
    self.callbackId = command.callbackId;
    
    double amount = [[command.arguments objectAtIndex:0] doubleValue];
    NSString* receiveUrl = [command.arguments objectAtIndex:1];
    NSString* signType = [command.arguments objectAtIndex:2];
    NSString* merchantId = [command.arguments objectAtIndex:3];
    NSString* orderNo = [command.arguments objectAtIndex:4];
    NSString* productName = [command.arguments objectAtIndex:5];
    NSString* orderCurrency = [command.arguments objectAtIndex:6];
    NSString* orderDatetime = [command.arguments objectAtIndex:7];
    NSString* payType = [command.arguments objectAtIndex:8];
    NSString* stage = [command.arguments objectAtIndex:9];
    NSString* key = [command.arguments objectAtIndex:10];
    
    if([orderDatetime compare:@""] == 0){
        NSDateFormatter* dateformatter = [[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyyMMddhhmmss"];
        orderDatetime = [dateformatter stringFromDate:[NSDate date]];
    }
    
    NSString* paydata = [PaaCreater genPayDate:amount receiveUrl:receiveUrl signType:signType merchantId:merchantId orderNo:orderNo productName:productName orderCurrency:orderCurrency orderDatetime:orderDatetime payType:payType key:key];
    UIViewController* viewController = self.viewController;
    
    [APay startPay:paydata viewController:viewController delegate:self mode:stage];
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