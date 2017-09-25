/**
 *        __       __               __ 
 *   ____/ /_ ____/ /______ _ ___  / /_
 *  / __  / / ___/ __/ ___/ / __ `/ __/
 * / /_/ / (__  ) / / /  / / /_/ / / 
 * \__,_/_/____/_/ /_/  /_/\__, /_/ 
 *                           / / 
 *                           \/ 
 * http://distriqt.com
 *
 * @file   		IDFA.m
 * @brief  		ActionScript Native Extension
 * @author 		Michael Archbold
 * @created		Jul 17, 2017
 * @copyright	http://distriqt.com/copyright/license.txt
 *
 */


#import "FlashRuntimeExtensions.h"
#import "DTIDFAController.h"
#import "DTIDFAEventDispatcher.h"

#import <CoreNativeExtension/CoreNativeExtension.h>


NSString * const IDFA_VERSION = @"1.0";
NSString * const IDFA_IMPLEMENTATION = @"iOS";

FREContext distriqt_idfa_ctx = nil;
DTIDFAEventDispatcher* distriqt_idfa_eventDispatcher = nil;
DTIDFAController* distriqt_idfa_controller = nil;


////////////////////////////////////////////////////////
//	ACTIONSCRIPT INTERFACE METHODS 
//

FREObject IDFAVersion(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
	FREObject result = NULL;
    @autoreleasepool
    {
        result = [DTFREUtils newFREObjectFromString: IDFA_VERSION];
    }
    return result;
}


FREObject IDFAImplementation(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
	FREObject result = NULL;
    @autoreleasepool
    {
        result = [DTFREUtils newFREObjectFromString: IDFA_IMPLEMENTATION];
    }
    return result;
}


FREObject IDFAIsSupported(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
	FREObject result = NULL;
    @autoreleasepool
    {
        result = [DTFREUtils newFREObjectFromBoolean: true ];
    }
    return result;
}



//
//
//  EXTENSION FUNCTIONALITY
//
//

FREObject IDFA_getIDFA(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    FREObject result = NULL;
    @autoreleasepool
    {
        [distriqt_idfa_controller getIDFA];
    }
    return result;
}

FREObject IDFA_advertisingTrackingEnabled(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    FREObject result = NULL;
    @autoreleasepool
    {
        Boolean advertisingTrackingEnabled = [distriqt_idfa_controller advertisingTrackingEnabled];
        result = [DTFREUtils newFREObjectFromBoolean: advertisingTrackingEnabled];
    }
    return result;
}


////////////////////////////////////////////////////////
// FRE CONTEXT 
//

void IDFAContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{

    //
	//	Add the ACTIONSCRIPT interface
	
	static FRENamedFunction distriqt_idfaFunctionMap[] =
    {
        MAP_FUNCTION( IDFAVersion,          "version",          NULL ),
        MAP_FUNCTION( IDFAImplementation,   "implementation",   NULL ),
        MAP_FUNCTION( IDFAIsSupported,      "isSupported",      NULL ),
        
        MAP_FUNCTION( IDFA_getIDFA,         "getIDFA",          NULL ),
        
        MAP_FUNCTION( IDFA_advertisingTrackingEnabled, "advertisingTrackingEnabled", NULL ),
        
        
        
    };
    
    *numFunctionsToTest = sizeof( distriqt_idfaFunctionMap ) / sizeof( FRENamedFunction );
    *functionsToSet = distriqt_idfaFunctionMap;
    
	
	//
	//	Store the global states
	
    distriqt_idfa_ctx = ctx;
    
    distriqt_idfa_eventDispatcher = [[DTIDFAEventDispatcher alloc] init];
    distriqt_idfa_eventDispatcher.context = distriqt_idfa_ctx;
    
    distriqt_idfa_controller = [[DTIDFAController alloc] init];
    distriqt_idfa_controller.delegate = distriqt_idfa_eventDispatcher;

}


/**	
 *	The context finalizer is called when the extension's ActionScript code calls the ExtensionContext instance's dispose() method. 
 *	If the AIR runtime garbage collector disposes of the ExtensionContext instance, the runtime also calls ContextFinalizer().
 */
void IDFAContextFinalizer(FREContext ctx) 
{
    if (distriqt_idfa_controller != nil)
    {
        distriqt_idfa_controller.delegate = nil;
        distriqt_idfa_controller = nil;
    }
    
    if (distriqt_idfa_eventDispatcher != nil)
    {
        distriqt_idfa_eventDispatcher.context = nil;
        distriqt_idfa_eventDispatcher = nil;
    }

	distriqt_idfa_ctx = nil;
}


/**
 *	The extension initializer is called the first time the ActionScript
 *		side of the extension calls ExtensionContext.createExtensionContext() 
 *		for any context.
 */
void IDFAExtInitializer( void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet ) 
{
	*extDataToSet = NULL;
	*ctxInitializerToSet = &IDFAContextInitializer;
	*ctxFinalizerToSet   = &IDFAContextFinalizer;
} 


/**
 *	The extension finalizer is called when the runtime unloads the extension. However, it is not always called.
 */
void IDFAExtFinalizer( void* extData ) 
{
	// Nothing to clean up.	
}

