//
//  DTIDFAController.m
//  IDFA
//
//  Created by Michael Archbold on 22/09/2015.
//  Copyright © 2015 distriqt. All rights reserved.
//

#import "DTIDFAController.h"
#import "DTIDFAEvent.h"
#import "DTIDFAAuthorisationEvent.h"

#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>


@implementation DTIDFAController

@synthesize extContext;


-(void) getIDFA
{
    [extContext log: DTIDFA_TAG message: @"DTIDFAController::getIDFA"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 100 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^
    {
        NSString* idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
		Boolean isLimitAdTrackingEnabled = ![[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled];
    
        [self.extContext dispatch: DTIDFA_IDFAEVENT_COMPLETE
                             data: [DTIDFAEvent formatForEvent: idfa
                                      isLimitAdTrackingEnabled: isLimitAdTrackingEnabled]
        ];
    });
    
}


-(Boolean) advertisingTrackingEnabled
{
    [extContext log: DTIDFA_TAG message: @"DTIDFAController::advertisingTrackingEnabled"];
    return [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled] == YES;
}



//
//
//    AUTHORISATION
//
//

-(NSString*) authorisationStatus
{
    [extContext log: DTIDFA_TAG message: @"DTIDFAController::authorisationStatus"];
    if (@available(iOS 14.0, *))
    {
        return [self authorisationStatusToString: ATTrackingManager.trackingAuthorizationStatus];
    }
    return @"authorised";
}


-(Boolean) requestAuthorisation
{
    [extContext log: DTIDFA_TAG message: @"DTIDFAController::requestAuthorisation"];
    if (@available(iOS 14.0, *))
    {
        if (ATTrackingManager.trackingAuthorizationStatus == ATTrackingManagerAuthorizationStatusNotDetermined)
        {
            [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status)
            {
                NSString* statusString = [self authorisationStatusToString: status];
                [self.extContext log: DTIDFA_TAG message: @"DTIDFAController::requestAuthorisation: complete: %@", statusString];
                [self.extContext dispatch: DTIDFA_AUTHORISATIONEVENT_CHANGED
                                     data: [DTIDFAAuthorisationEvent formatStatusForEvent: statusString ]
                 ];
            }];
            return true;
        }
    }
    return false;
}



-(NSString*) authorisationStatusToString: (NSUInteger)status
{
    switch (status)
    {
        case ATTrackingManagerAuthorizationStatusNotDetermined:
            return @"not_determined";
        case ATTrackingManagerAuthorizationStatusDenied:
            return @"denied";
        case ATTrackingManagerAuthorizationStatusAuthorized:
            return @"authorised";
        case ATTrackingManagerAuthorizationStatusRestricted:
            return @"restricted";
    }
    return @"authorised";
}


@end
