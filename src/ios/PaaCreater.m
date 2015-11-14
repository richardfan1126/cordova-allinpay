//
//  PaaCreater.m
//  AllinpayTest_ObjC
//
//  Created by allinpay-shenlong on 14-10-27.
//  Copyright (c) 2014年 Allinpay.inc. All rights reserved.
//

#import "PaaCreater.h"

@implementation PaaCreater

static int count = 0;

+ (NSString *)genPayDate:(double)amount receiveUrl:(NSString *)receiveUrl signType:(NSString *)signType merchantId:(NSString *)merchantId orderNo:(NSString *)orderNo productName:(NSString *)productName orderCurrency:(NSString *)orderCurrency orderDatetime:(NSString *)orderDatetime payType:(NSString *)payType key:(NSString *)key {
    
    NSString* amountString = [NSString stringWithFormat:@"%.0f", (amount*100)];
    
//####################################  计算外卡扩展信息字段签名  ######################################//

//    NSString *ext1 = [self ext1From:[self extPart]];
    
//##################################################################################################//
    
    NSArray *paaDic = @[
                         
                         ////协议字符集 1-UTF-8  2-GBK; 3-GB2312
                         @"1", @"inputCharset",
                         
                         //支付通知结果以此为准,后台通知商户网站支付结 果的 url 地址
                         receiveUrl, @"receiveUrl",
                         
                         ////协议版本,固定填 v1.0
                         @"v1.0", @"version",
                         
                         //指定当前语言
                         //固定选择值:1-简体中文 2-繁体中文 3-英文
                         //可不填
                         //非外卡支付只支持简体中文
                         //外卡支付若未指定语言则默认为系统语言，若系统语言不被支持则默认为英文
//                         @"3", @"language",
                         
                         //订单信息签名方式
                         signType, @"signType",
                         
                         //通联分配给商户的ID
                         merchantId, @"merchantId",//测试商户号
                         
//                         @"20140901", @"merchantId",
                         
//                         @"100020150803001", @"merchantId",
                         
                         //商户当前支付订单号
                         orderNo, @"orderNo",
                         
                         //订单支付金额
                         //分做单位
                         //最小0.01元
                         amountString, @"orderAmount",
                         
                         //针对非跨境和非外卡支付
                         //payType=27
                         //支持以下币种: 默认[人民币]-0 人民币-156
                         orderCurrency, @"orderCurrency",
                         
                         //针对跨境支付
                         //payType=27
                         //支持以下币种: 默认[人民币]-0 人民币-156
                         //美元-840 英镑-826 港币-344 欧元-978 加拿大元-124 澳大利亚元-036
                         //日元-392 新加坡币-702 瑞典克朗-752 瑞士法郎-756
//                         @"344", @"orderCurrency",
                         
                         //########################  填充外卡支付币种字段  ###########################//
                         
                         //针对外卡支付
                         //payType=30
                         //币种限定如下:
                         //美元-840 英镑-826 港币-344 欧元-978 加拿大元-124 澳大利亚元-036
                         //日元-392 新加坡币-702 瑞典克朗-752 瑞士法郎-756
//                         @"840", @"orderCurrency",
                         
                         //########################################################################//
                         
                         //商户生成订单时间戳
                         //必须允许的订单时间范围内
                         orderDatetime, @"orderDatetime",
                         
                         //商品名称
                         productName, @"productName",
                         
                         //对于非外卡支付
                         //商户用户号在通联会员系统对应的会员号
//                         @"<USER>201410131001556</USER>", @"ext1",//若商户用户未注册通联会员号,该行不需要,可以注释掉
                                                                    //此时为 非会员模式,只能走认证支付
                         
                         //########################  填充外卡扩展字段签名信息  ########################//
                         
                         //针对于外卡
                         //该处填充的为外卡扩展字段的签名信息
//                         ext1, @"ext1", //ext1 != nil
                         
                         //########################################################################//
                         
                         //通联给商户开通的支付方式
                         //此处必须与商户实际开通的支付方式一致
                         
                         //27-移动(跨境)支付 v2.x版本的支付控件
                         payType, @"payType",
                         
                         //########################  填充外卡支付方式字段  ###########################//
                         
                         //30-移动外卡支付 v2.x版本的支付控件
//                         @"30", @"payType",
                         
                         //########################################################################//
                         
                         //指定发卡机构
                         //可不填
                         //外卡支付字段: visa、mastercard或者jcb
//                         @"visa", @"issuerId",
                         
                         //固定选择值：GOODS或SERVICES
                         //当币种为人民币时选填
                         //当币种为非人民币时必填，GOODS表示实物贸易，SERVICES表示服务贸易
//                         @"GOODS", @"tradeNature",
                         
                         //商户订单签名key
                         //在通联商户平台维护
                         key, @"key",
                         ];
    
    NSString *paaStr = [self formatPaa:paaDic];
    
    count++;
    
    return paaStr;
}

//############################  外卡支付订单数据与签名请参考以下部分  ###################################//

//外卡扩展字段示例数据
//扩展字段不参与signMsg的计算
+ (NSDictionary *)extPart {
    
    NSDictionary *tmpDic = @{
                             
                             /** 消费者信息 **/
                             
                             //@"消费者在商户系统的用户号"
                             @"customer_id":@"100000000000000_1",
                             
                             //"用户名字"
                             @"customer_first_name":@"George",
                             
                             //用户姓氏
                             @"customer_last_name":@"Bush",
                             
                             //用户邮箱地址
                             @"customer_email":@"bruce@gmail.com",
                             
                             //用户电话"
                             @"customer_phone":@"021-61680906",
                             
                             /** 出发|到达信息 **/
                             
                             //出发城市-抵达城市
                             @"traveldata_complete_route":@"SFO-JFK:JFK-LHR:LHRCDG",
                             
                             //出发时间
                             @"traveldata_departure_datetime":@"2014-04-18 23:59 pm GMT",
                             
                             //出发地三位码
                             @"traveldata_leg_origin":@"CFD",
                             
                             //目的地三位码
                             @"traveldata_leg_destination":@"MDD",
                             
                             //航程类型信息
                             @"traveldata_journeytype":@"single",
                             
                             //用户类型"
                             @"passengertype":@"ADT",
                             
                             //乘客身份类型
                             @"passenger_status":@"0",
                             
                             /** 收货信息 **/
                             
                             //收货地址国家,ISO编码,例如 US
                             @"ship_to_country":@"US",
                             
                                 //收货地址州,ISO编码,例如 IL
                             @"ship_to_state":@"IL",
                             
                                 //收货地址城市
                             @"ship_to_city":@"Chicago",
                             
                                 //收货地址街道1
                             @"ship_to_street1":@"North Street1",
                             
                                 //收货地址街道2
                             @"ship_to_street2":@"",
                             
                                 //收货地址电话
                             @"ship_to_phonenumber":@"021-61680906",
                             
                                 //收货地址邮编
                             @"ship_to_postalcode":@"11111",
                             
                                  //货运方式
                             @"ship_to_shipmethod":@"7",
                             
                                  //收货人名字
                             @"ship_to_firstname":@"George",
                             
                                  //收货人姓氏
                             @"ship_to_lastname":@"Bush",
                             
                             /** 注册信息 **/
                             
                             //注册名
                             @"registration_name":@"George.Bush",
                            
                             //注册邮箱
                             @"registration_email":@"bruce@gmail.com",
                            
                             //注册电话
                             @"registration_phone":@"021-61680906",
                             
                             //买家账户注册时长
//                             @"buyerid_period":@"",//可不填
                             
                             /** 账单信息 **/
                             
                             //账单电子邮件
//                             @"bill_email":@"",
                             
                             //账单国家,ISO编码,例如 US
//                             @"bill_country":@"",
                             
                             //账单地址
//                             @"bill_address":@"",
                             
                             //账单城市
//                             @"bill_city":@"",
                             
                             //账单州/省,ISO编码,例如 IL
//                             @"bill_state":@"",
                             
                             //账单邮政编码
//                             @"bill_zip":@"",
                             
                             //账单名字
//                             @"bill_firstname":@"",
                             
                             //账单姓氏
//                             @"bill_lastname":@"",
                             
                             /** 交易模式 **/
    
                             //交易模式"
//                             @"fnpay_mode":@"",
    
                             /** 卡信息 **/
                             
                             //卡有效期
//                             @"expireddate":@"",
    
                             //卡CVV2
//                             @"cvv2":@""
                             };
    
    return tmpDic;
}

//计算外卡扩展字段的签名信息
+ (NSString *)ext1From:(NSDictionary *)extPart {
    
    if (extPart == nil) { return nil; }
    
    NSArray *keys = @[ @"customer_id", @"customer_first_name", @"customer_last_name", @"customer_email",
                       @"customer_phone", @"traveldata_complete_route", @"traveldata_departure_datetime",
                       @"traveldata_leg_origin", @"traveldata_leg_destination", @"traveldata_journeytype",
                       @"passengertype", @"passenger_status", @"ship_to_country", @"ship_to_state", @"ship_to_city", @"ship_to_street1",
                       @"ship_to_street2", @"ship_to_phonenumber", @"ship_to_postalcode", @"ship_to_firstname",
                       @"ship_to_lastname", @"registration_name", @"registration_email", @"registration_phone",
                       @"buyerid_period", @"fnpay_mode", @"bill_firstname", @"bill_lastname", @"expireddate",
                       @"cvv2", @"bill_email", @"bill_country", @"bill_address", @"bill_city", @"bill_state",
                       @"bill_zip",@"mdd07", @"mdd08", @"mdd09", @"mdd10", @"mdd11", @"mdd12", @"mdd13", @"mdd1",
                       @"mdd15", @"mdd16", @"mdd17", @"mdd18" ];
    
    NSMutableString *mstring = [NSMutableString string];
    
    for (NSString *key in keys) {
        
        if ([extPart objectForKey:key] != nil) {
            
            [mstring appendString:[extPart objectForKey:key]];
        }
    }
    
    if ([mstring length] <= 0) { return nil; }
    
    NSString *ext1 = [self md5:mstring];
    
    return ext1;
}

//##################################################################################################//

//订单信息示例
/**
 
 {
 "orderAmount" : "3500",
 "signMsg" : "D1B2B1B938C5370E7F3F00B9D37B8CB8",
 "orderNo" : "201505111408570000",
 "productName" : "二维码",
 "orderCurrency" : "0",
 "payType" : "27",
 "version" : "v1.0",
 "merchantId" : "100020091218001",
 "orderDatetime" : "20150511140857",
 "inputCharset" : "1",
 "ext1" : "<USER>201410131001556<\/USER>",
 "receiveUrl" : "http:\/\/www",
 "signType" : "1"
 }
 
**/
+ (NSString *)formatPaa:(NSArray *)array {
    
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    
    NSMutableString *paaStr = [[NSMutableString alloc] init];
    for (int i = 0; i < array.count; i++) {
        [paaStr appendFormat:@"%@=%@&", array[i+1], array[i]];
        mdic[array[i+1]] = array[i];
        i++;
    }
    
    NSString *signMsg = [self md5:[paaStr substringToIndex:paaStr.length - 1]];
    mdic[@"signMsg"] = signMsg.uppercaseString;
    
//############################  卡号回显请参考以下部分  ##############################################//
    
    //卡号回显需要在订单信息中传入该字段
    //该字段不参与订单信息的签名计算
    //若不需要卡号回显的功能该字段可不传入
//    NSString *cardNo = @"4391880000000004";//测试用信用卡
//                       @"6225882120759623";//测试用借记卡
//    mdic[@"cardNo"] = cardNo;
    
//##################################################################################################//
    
//############################  外卡支付订单添加扩展信息字段  ###########################################//
    
//    [mdic addEntriesFromDictionary:[self extPart]];
    
//##################################################################################################//
    
    if (mdic[@"key"]) {//商户私有签名密钥 通联后台持有不传入插件
        [mdic removeObjectForKey:@"key"];
    }
    
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:mdic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonStr = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
    
    [paaStr setString:jsonStr];
    
    return paaStr;
}

//计算订单签名信息
//签名串的顺序与范例
/**
 
 inputCharset=1&receiveUrl=http://www&version=v1.0&signType=1&merchantId=100020091218001&orderNo=201505111408570000&orderAmount=3500&orderCurrency=0&orderDatetime=20150511140857&productName=二维码&ext1=<USER>201410131001556</USER>&payType=27&key=1234567890
 
**/

//计算字符串对应的md5值
+ (NSString *)md5:(NSString *)string {
    
    NSLog(@"%@", string);
    
    if (string == nil) { return nil; }
    
    const char *str = [string cStringUsingEncoding:NSUTF8StringEncoding];
    CC_LONG strLen = (CC_LONG)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    unsigned char *result = calloc(CC_MD5_DIGEST_LENGTH, sizeof(unsigned char));
    CC_MD5(str, strLen, result);
    
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; ++i) {
        [hash appendFormat:@"%02x", result[i]];
    }
    
    free(result);
    
    return hash;
}

@end
