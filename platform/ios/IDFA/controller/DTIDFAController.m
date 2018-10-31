//
//  DTIDFAController.m
//  IDFA
//
//  Created by Michael Archbold on 22/09/2015.
//  Copyright © 2015 distriqt. All rights reserved.
//

#import "DTIDFAController.h"
#import "DTIDFAEvent.h"

#import <CoreNativeExtension/CoreNativeExtension.h>
#import <AdSupport/AdSupport.h>

@implementation DTIDFAController

@synthesize delegate;



-(void) getIDFA
{
    [DTFREUtils log: DTIDFA_TAG message: @"DTIDFAController::getIDFA"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 100 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^
    {
        NSString* idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
		Boolean isLimitAdTrackingEnabled = ![[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled];
    
        [delegate dispatch: DTIDFA_IDFAEVENT_COMPLETE
                      data: [DTIDFAEvent formatForEvent: idfa
							   isLimitAdTrackingEnabled: isLimitAdTrackingEnabled]
        ];
    });
    
}


-(Boolean) advertisingTrackingEnabled
{
    [DTFREUtils log: DTIDFA_TAG message: @"DTIDFAController::advertisingTrackingEnabled"];
    return [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled] == YES;
}



@end
