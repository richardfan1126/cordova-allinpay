//
//  APayLib.h
//  APayLib
//
//  Created by allinpay-shenlong on 14-5-26.
//  Copyright (c) 2014年 Allinpay.inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, APayResult)
{
    APayResultSuccess = 0,
    APayResultFail = 1,
    APayResultCancel = -1,
    APayResultDuplicte = 2,//已实名认证、已绑卡
};

@protocol APayDelegate <NSObject>

@optional

//插件支付的回调方法
- (void)APayResult:(NSString *)result;
//控件支付的回调方法
- (void)widgetPayResult:(NSString *)result;
//绑卡回调
- (void)bindCardResult:(NSString *)result;
//查询用户绑定常用卡回调
- (void)queryBindedCardResult:(NSString *)result;
//用户银行卡快捷实名认证回调
- (void)verifyUserResult:(NSString *)result;

@end

@interface APay : NSObject

//插件支付
+ (void)startPay:(NSString *)payData viewController:(UIViewController *)viewController delegate:(id<APayDelegate>)delegate mode:(NSString *)mode;

//绑卡
+ (void)bindCard:(NSString *)cardInfo viewController:(UIViewController *)viewController delegate:(id<APayDelegate>)delegate mode:(NSString *)mode;

//控件支付
+ (void)widgetPay:(NSString *)payData viewController:(UIViewController *)viewController delegate:(id<APayDelegate>)delegate mode:(NSString *)mode;

//查询用户绑定的常用卡
+ (void)queryBindedCard:(NSString *)queryInfo viewController:(UIViewController *)viewController delegate:(id<APayDelegate>)delegate mode:(NSString *)mode;

//用户银行卡快捷实名认证
+ (void)verifyUser:(NSString *)userInfo viewController:(UIViewController *)viewController delegate:(id<APayDelegate>)delegate mode:(NSString *)mode;

@end

