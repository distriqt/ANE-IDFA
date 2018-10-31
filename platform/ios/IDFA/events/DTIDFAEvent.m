//
//  DTIDFAEvent.m
//  IDFA
//
//  Created by Michael Archbold on 17/7/17.
//  Copyright © 2017 distriqt. All rights reserved.
//

#import "DTIDFAEvent.h"

@implementation DTIDFAEvent

+(NSString*) formatForEvent: (NSString*) identifier isLimitAdTrackingEnabled:(Boolean)isLimitAdTrackingEnabled
{
    @try
    {
        NSMutableDictionary* eventDict = [[NSMutableDictionary alloc] init];
        
        [eventDict setObject: identifier forKey: @"identifier"];
		[eventDict setObject: [NSNumber numberWithBool: isLimitAdTrackingEnabled] forKey: @"isLimitAdTrackingEnabled" ];
		
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject: eventDict options: 0 error: nil];
        return [[NSString alloc] initWithData: jsonData encoding:NSUTF8StringEncoding];
    }
    @catch (NSException *exception)
    {
    }
    return @"{}";
}


@end
