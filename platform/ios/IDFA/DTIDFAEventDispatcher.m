//
//  DTIDFAEventDispatcher.m
//  IDFA
//
//  Created by Michael Archbold on 22/09/2015.
//  Copyright © 2015 distriqt. All rights reserved.
//

#import "DTIDFAEventDispatcher.h"
#import <CoreNativeExtension/CoreNativeExtension.h>

@implementation DTIDFAEventDispatcher

@synthesize context;


-(void) log: (NSString*) tag message: (NSString*) message, ...
{
    va_list args;
    va_start(args, message);
    NSString* formatedMessage = [[NSString alloc] initWithFormat: message arguments: args];
    va_end(args);
    
    [DTFREUtils log: tag message: formatedMessage ];
}


-(void) dispatch: (NSString*) code data: (NSString*) data
{
    [DTFREUtils dispatchStatusEvent: context
                               code: code
                              level: data ];
}

@end
