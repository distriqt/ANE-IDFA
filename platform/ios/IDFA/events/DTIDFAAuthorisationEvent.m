//
//  DTIDFAAuthorisationEvent.m
//  IDFA
//
//  Created by Michael Archbold on 18/9/20.
//  Copyright © 2020 distriqt. All rights reserved.
//

#import "DTIDFAAuthorisationEvent.h"

@implementation DTIDFAAuthorisationEvent


+(NSString*) formatStatusForEvent: (NSString*)authorisationStatus
{
    @try
    {
        NSMutableDictionary* eventDict = [[NSMutableDictionary alloc] init];
        
        [eventDict setObject: authorisationStatus forKey: @"authorisationStatus"];
        
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject: eventDict options: 0 error: nil];
        return [[NSString alloc] initWithData: jsonData encoding:NSUTF8StringEncoding];
    }
    @catch (NSException *exception)
    {
    }
    return @"{}";
}


@end
