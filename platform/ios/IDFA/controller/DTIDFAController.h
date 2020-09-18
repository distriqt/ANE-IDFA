//
//  DTIDFAController.h
//  IDFA
//
//  Created by Michael Archbold on 22/09/2015.
//  Copyright © 2015 distriqt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTIDFAContext.h"


@interface DTIDFAController : NSObject

@property id<DTIDFAContext> extContext;


-(void) getIDFA;

-(Boolean) advertisingTrackingEnabled;


//
//
//    AUTHORISATION
//
//

-(NSString*) authorisationStatus;

-(Boolean) requestAuthorisation;


@end
