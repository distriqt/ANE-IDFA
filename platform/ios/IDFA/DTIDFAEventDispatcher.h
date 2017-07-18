//
//  DTIDFAEventDispatcher.h
//  IDFA
//
//  Created by Michael Archbold on 22/09/2015.
//  Copyright © 2015 distriqt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTIDFAEventDispatcherDelegate.h"
#import "FlashRuntimeExtensions.h"


@interface DTIDFAEventDispatcher : NSObject<DTIDFAEventDispatcherDelegate>

@property FREContext context;

@end
