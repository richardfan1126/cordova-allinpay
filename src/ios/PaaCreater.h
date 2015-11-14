//
//  PaaCreater.h
//  AllinpayTest_ObjC
//
//  Created by allinpay-shenlong on 14-10-27.
//  Copyright (c) 2014年 Allinpay.inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

@interface PaaCreater : NSObject

+ (NSString *)genPayDate:(double)amount receiveUrl:(NSString*)receiveUrl signType:(NSString*)signType merchantId:(NSString*)merchantId orderNo:(NSString*)orderNo productName:(NSString*)productName orderCurrency:(NSString*)orderCurrency orderDatetime:(NSString*)orderDatetime payType:(NSString*)payType key:(NSString*)key;

@end
