//
//  TrustDefenderMobile+RiskModule.h
//  TrustDefenderMobile
//
//  Created by Nick Blievers on 18/03/2014.
//  Copyright (c) 2014 TrustDefender. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "TrustDefenderMobile.h"
#import "RiskModuleProtocol.h"
@interface TrustDefenderMobile (SharedImplementation)
- (void) prepareRiskTransaction;
- (NSURL *) configurationURL;
- (NSDictionary *) configurationHTTPHeaders: (NSString *) userAgent;
- (NSDictionary *) riskDataHTTPHeaders;
- (NSData *) riskDataBody:(NSDictionary *)clientSideParams;
- (NSString *) dnsIPHostName;
@end

@interface TrustDefenderMobile (NoTransport)  <RiskModuleProtocol>
- (BOOL) riskDataResponse:(NSData *)__attribute__((unused))responseData error:(__autoreleasing NSError **)riskModuleError;
- (instancetype) initWithoutTransport:(NSString*) org_id with: (NSString *) sessionId;
- (instancetype) initWithoutTransport:(NSString*) org_id with: (NSString *) sessionId using: (NSString *) fp_server;
- (id) setConfigurationData:(NSData *) configurationData;
- (NSInteger) proxyCheckPort;
- (NSString *) proxyCheckHost;
- (NSString *) configurationHttpMethod;
- (NSData *) proxyCheckBody;
- (NSURL *) riskDataURL;
- (NSData *) configurationBody;
- (NSString *)riskDataHttpMethod;
@end
