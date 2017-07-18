//
//  DTIDFAEvent.h
//  IDFA
//
//  Created by Michael Archbold on 17/7/17.
//  Copyright © 2017 distriqt. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DTIDFA_IDFAEVENT_COMPLETE @"idfa:complete"
#define DTIDFA_IDFAEVENT_ERROR @"idfa:error"


@interface DTIDFAEvent : NSObject

+(NSString*) formatForEvent: (NSString*) identifier;

@end
