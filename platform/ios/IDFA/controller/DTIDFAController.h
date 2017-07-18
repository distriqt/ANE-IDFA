//
//  DTIDFAController.h
//  IDFA
//
//  Created by Michael Archbold on 22/09/2015.
//  Copyright © 2015 distriqt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTIDFAEventDispatcherDelegate.h"


@interface DTIDFAController : NSObject

@property id<DTIDFAEventDispatcherDelegate> delegate;


-(void) getIDFA;

@end
