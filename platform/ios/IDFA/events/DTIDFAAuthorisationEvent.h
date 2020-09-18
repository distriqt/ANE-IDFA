//
//  DTIDFAAuthorisationEvent.h
//  IDFA
//
//  Created by Michael Archbold on 18/9/20.
//  Copyright © 2020 distriqt. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DTIDFA_AUTHORISATIONEVENT_CHANGED @"idfa:authorisation:changed"


@interface DTIDFAAuthorisationEvent : NSObject


+(NSString*) formatStatusForEvent: (NSString*)authorisationStatus;

@end

