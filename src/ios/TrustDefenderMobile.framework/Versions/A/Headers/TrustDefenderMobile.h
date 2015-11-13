/*!
 @header TrustDefenderMobile.h

 TrustDefender Mobile SDK for iOS. This header is the main framework header, and is required to make use of the mobile
 SDK.

 @author Nick Blievers
 @copyright ThreatMetrix
*/
#ifndef _TRUSTDEFENDERMOBILE_H_
#define _TRUSTDEFENDERMOBILE_H_
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/*!
 @enum thm_status_code_t

 Possible return codes
 @constant THM_NotYet                   profile request has returned but not yet completed
 @constant THM_OK                       Completed, No errors
 @constant THM_Connection_Error         There has been a connection issue, profiling incomplete
 @constant THM_HostNotFound_Error       Unable to resolve the host name of the fingerprint server
 @constant THM_NetworkTimeout_Error     Network timed out
 @constant THM_HostVerification_Error   Certificate verification or other SSL failure! Potential Man In The Middle attack"
 @constant THM_Internal_Error           Internal Error, profiling incomplete or interrupted
 @constant THM_Interrupted_Error        Request was cancelled
 @constant THM_PartialProfile           Connection error, only partial profile completed
 @constant THM_InvalidOrgID             Request contained an invalid org id
 */
typedef NS_ENUM(NSInteger, thm_status_code_t)
{
    THM_NotYet = 0,
    THM_OK,
    THM_Connection_Error,
    THM_HostNotFound_Error,
    THM_NetworkTimeout_Error,
    THM_HostVerification_Error,
    THM_Internal_Error,
    THM_Interrupted_Error,
    THM_PartialProfile,
    THM_InvalidOrgID
};


/*!
 * @define THM_OPTION_SYNC
 * Return once all requests complete, when API query can proceed
 * @deprecated in version 1.2
 */
#define THM_OPTION_SYNC             0x0
/*!
 * @define THM_OPTION_ASYNC
 * Returns immediately after requests are fired, before they have completed
 *  profile.isDone will return true when the profiling is complete
 */
#define THM_OPTION_ASYNC            0x1
/*!
 * @define THM_OPTION_TCP_FP
 * do TCP fingerprinting and True IP requests
 */
#define THM_OPTION_TCP_FP           0x40

/*!
 * @define THM_OPTION_TCP_FP
 * Do all TCP fingerprinting, including tarpitting (which can be slow)
 */
#define THM_OPTION_TCP_TARPIT       0x80


/*!
 * @define THM_OPTION_ALL
 */
#define THM_OPTION_ALL              (0xFFFE ^ (0x100 | 0x200))
/*!
 * @define THM_OPTION_ALL_SYNC
 * @deprecated in version 1.2
 */
#define THM_OPTION_ALL_SYNC         THM_OPTION_ALL
/*!
 * @define THM_OPTION_ALL_ASYNC
 * As of 2.0 this is the only supported option
 */
#define THM_OPTION_ALL_ASYNC        (THM_OPTION_ALL | THM_OPTION_ASYNC)

/*!
 * @define THM_OPTION_MOST_SYNC
 * @deprecated in version 1.2
 */
#define THM_OPTION_MOST_SYNC        (THM_OPTION_ALL_SYNC  ^ THM_OPTION_TCP_TARPIT)
/*!
 * @define THM_OPTION_MOST_ASYNC
 * @deprecated in version 2.0
 */
#define THM_OPTION_MOST_ASYNC       (THM_OPTION_ALL_ASYNC ^ THM_OPTION_TCP_TARPIT)

/*!
 * @define THM_OPTION_LEAN_SYNC
 * @deprecated in version 1.2
 */
#define THM_OPTION_LEAN_SYNC        (THM_OPTION_ALL_SYNC  ^ (THM_OPTION_TCP_FP | THM_OPTION_TCP_TARPIT))
/*!
 * @define THM_OPTION_LEAN_ASYNC
 * @deprecated in version 2.0
 */
#define THM_OPTION_LEAN_ASYNC       (THM_OPTION_ALL_ASYNC ^ (THM_OPTION_TCP_FP | THM_OPTION_TCP_TARPIT))

/*!
 *    @interface TrustDefenderMobile
 *    @discussion TrustDefender Mobile SDK
 */
__attribute__((visibility("default")))
@interface TrustDefenderMobile : NSObject

/*!
 *    Perform a profiling request.
 *
 *    @param org_id  must be valid, and should be supplied by threatmetrix
 *
 *    @return thm_status_code_t indicating whether the profiling request successfully launched
 */
-(thm_status_code_t) doProfileRequestFor: (NSString *)org_id;

/*!
 *    Perform a profiling request.
 *
 *    @param org_id    must be valid, and should be supplied by threatmetrix
 *    @param fp_server fp_server can be nil. If nil it defaults to "h.online-metrix.net". Please pass the fully qualified domain name.
 *
 *    @return thm_status_code_t indicating whether the profiling request successfully launched
 */
-(thm_status_code_t) doProfileRequestFor: (NSString *)org_id connectingTo: (NSString *) fp_server;

/*!
 *    Perform a profiling request.
 *
 *    @param org_id    must be valid, and should be supplied by threatmetrix
 *    @param fp_server fp_server can be nil. If nil it defaults to "h.online-metrix.net". Please pass the fully qualified domain name.
 *    @param url       is a user defined descriptive string with a max length of 255 minus whatever escapes for special characters
 *
 *    @return thm_status_code_t indicating whether the profiling request successfully launched
 */
-(thm_status_code_t) doProfileRequestFor: (NSString *)org_id connectingTo: (NSString *) fp_server passing: (NSString *)url;

/*!
 *    Perform a profiling request.
 *
 *    @param org_id    must be valid, and should be supplied by threatmetrix
 *    @param fp_server fp_server can be nil. If nil it defaults to "h.online-metrix.net". Please pass the fully qualified domain name.
 *    @param options   options to determine how profiling is performed
 *
 *    @return thm_status_code_t indicating whether the profiling request successfully launched
 */
-(thm_status_code_t) doProfileRequestFor: (NSString *)org_id connectingTo: (NSString *) fp_server  with: (uint32_t)options;

/*!
 *    Perform a profiling request.
 *
 *    @param org_id    must be valid, and should be supplied by threatmetrix
 *    @param fp_server fp_server can be nil. If nil it defaults to "h.online-metrix.net". Please pass the fully qualified domain name.
 *    @param url       is a user defined descriptive string with a max length of 255 minus whatever escapes for special characters
 *    @param options   options to determine how profiling is performed
 *
 *    @deprecated in version 2.0
 *
 *    @return thm_status_code_t indicating whether the profiling request successfully launched
 */
-(thm_status_code_t) doProfileRequestFor: (NSString *)org_id connectingTo: (NSString *) fp_server passing: (NSString *)url with: (uint32_t)options __attribute__((deprecated("passing options is now discouraged. There are no longer performance gains to be had by limiting attribute gathering")));

/*!
 *    Get the profiling status.
 *
 *    @return the current state of an asynchronous profiling request
 */
-(thm_status_code_t)isDone;


/*!
 *    Register location services and start collecting location info. If we have useful information
 *    when the profiling request is made, we will send it along. Location updates are enabled only
 *    while the application has focus
 *
 *    This function will never prompt the user
 *
 *    @return YES if it successfully registers
 */
-(BOOL) registerLocationServices;

/*!
 *    Register location services and start collecting location info. If we have useful information
 *    when the profiling request is made, we will send it along. Location updates are enabled only
 *    while the application has focus
 *
 *    This function will prompt the user if permissions are required.
 *
 *    @return YES if it successfully registers
 */
-(BOOL) registerLocationServicesWithPossiblePermissionRequest;

/*!
 *    Pause or resume location services
 *
 *    @param pause YES to pause, NO to unpause
 */
-(void) pauseLocationServices: (BOOL) pause;

/*!
 *    Set the timeout for network requests
 */
@property (nonatomic, readwrite) time_t timeout;

/*!
 *    Once the profile request has been issued, this property will have the session id that can be used for querying the threatmetrix server
 */
@property (nonatomic, readwrite, retain) NSString *sessionID;

/*!
 *    If the application belongs to a suite of applications with the same bundle id seed information can be shared via the keychain
 *    NOTE: The application must be configured with the correct plist entries etc
 */
@property (nonatomic, readwrite, retain) NSString *keychainAccessGroup;

/*!
 *    The application can pass up to 5 custom attribute values
 */
@property (nonatomic, readwrite, retain) NSArray *customAttributes;

/*!
 *    Set a delegate to receive completion notification
 */
@property (nonatomic, readwrite, retain) id delegate;

/*!
 *    If the application already has a location it can be used in the profile via this attribute
 */
@property (nonatomic, readwrite, retain) CLLocation *location;

/*!
 *    The application can specify a desired accuracy, however, finer accuracy can and will drain battery life
 */
@property (nonatomic, readwrite) CLLocationAccuracy desiredAccuracy;

/*!
 *    Set an API key for the profiling request. Only do this if the account configuration
 *    requires it, as an incorrectly configured API key will result in blocked profiling requests
 */
@property (nonatomic, readwrite, retain) NSString* apiKey;

/*!
 *    Query the build number, for debugging purposes only
 */
@property (nonatomic, readonly, retain) NSString* version;

/*!
 *    Cancel's the currently running sync request. If no request is outstanding, just returns
 */
-(void) cancel;

@end

/*!
 *    The delegate should implement this protocol to receive completion notification. Only one of the
 *    methods should be implemented.
 */
@protocol TrustDefenderMobileDelegate
@optional
/*!
 *    Once profiling is complete, this method is called. querying isDone will return the status of the profiling request
 */
-(void) profileComplete;

/*!
 *    Once profiling is complete, this method is called.
 *
 *    @param status describes the profiling status
 */
-(void) profileComplete: (thm_status_code_t) status;

@end
#endif
