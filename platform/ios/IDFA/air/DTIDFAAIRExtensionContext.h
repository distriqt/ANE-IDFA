//
//  DTIDFAAIRExtensionContext.h
//  IDFA
//
//  Created by Michael Archbold on 22/09/2015.
//  Copyright © 2015 distriqt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTIDFAContext.h"
#import "FlashRuntimeExtensions.h"


@interface DTIDFAAIRExtensionContext : NSObject<DTIDFAContext>

@property FREContext context;

@end
