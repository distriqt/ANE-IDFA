/**
 *        __       __               __ 
 *   ____/ /_ ____/ /______ _ ___  / /_
 *  / __  / / ___/ __/ ___/ / __ `/ __/
 * / /_/ / (__  ) / / /  / / /_/ / / 
 * \__,_/_/____/_/ /_/  /_/\__, /_/ 
 *                           / / 
 *                           \/ 
 * https://distriqt.com
 *
 * @brief  		
 * @author 		marchbold
 * @created		17/7/17
 * @copyright	https://distriqt.com/copyright/license.txt
 */
package com.distriqt.test.idfa 
{
	import com.distriqt.extension.idfa.IDFA;
	import com.distriqt.extension.idfa.TrackingAuthorisationStatus;
	import com.distriqt.extension.idfa.events.IDFAAuthorisationEvent;
	import com.distriqt.extension.idfa.events.IDFAEvent;
	
	import flash.events.ErrorEvent;
	
	import starling.display.Sprite;
	
	public class IDFATests extends Sprite
    {
 		////////////////////////////////////////////////////////
        //  CONSTANTS
        //
        
        private static const TAG : String = "IDFATests";
		
		
		private var _l : ILogger;
		
		private function log( log:String ):void
		{
			_l.log( TAG, log );
		}
		
		
		////////////////////////////////////////////////////////
        //  VARIABLES
        //
        

 		////////////////////////////////////////////////////////
        //  FUNCTIONALITY
        //
        
        public function IDFATests(logger:ILogger )
        {
	        _l = logger;
	        try
	        {
		        log( "IDFA isSupported: " + IDFA.isSupported );
		        if (IDFA.isSupported)
		        {
			        log( "IDFA version:     " + IDFA.service.version );
					IDFA.service.addEventListener( ErrorEvent.ERROR, errorHandler );
				}
	        }
	        catch (e:Error)
	        {
	        }
        }

		
		private function errorHandler( event:ErrorEvent ):void
		{
			log( "ERROR: " + event.text );
		}
		
		
		//
		//
		//
		
		
		public function getIDFA():void
		{
			log( "getIDFA()" );
			if (IDFA.isSupported)
			{
				IDFA.service.addEventListener( IDFAEvent.COMPLETE, idfaCompleteHandler );
				IDFA.service.addEventListener( IDFAEvent.ERROR, idfaErrorHandler );
				IDFA.service.getIDFA();
			}
		}
		
		private function idfaCompleteHandler( event:IDFAEvent ):void
		{
			log( "identifier: " + event.identifier );
			log( "isLimitAdTrackingEnabled: " + event.isLimitAdTrackingEnabled );
		}
	    
	    private function idfaErrorHandler( event:IDFAEvent ):void
		{
			log( "idfaErrorHandler" )
		}
	    
	    //
	    //  TRACKING ENABLED
	    //
	    
	    public function trackingEnabledTest():void
	    {
		    log( "trackingEnabledTest()" );
		    if (IDFA.isSupported)
		    {
			    log( "advertisingTrackingEnabled = " + IDFA.service.advertisingTrackingEnabled );
		    }
	    }
		
		
		//
		//	AUTHORISATION
		//
		
		
		public function authorisationStatus():void
		{
			log( "authorisationStatus() = " + IDFA.service.authorisationStatus() );
		}
		
		
		public function requestAuthorisation():void
		{
			if (IDFA.isSupported)
			{
				IDFA.service.addEventListener( IDFAAuthorisationEvent.CHANGED, authorisationChangedHandler );
//				if (IDFA.service.authorisationStatus() == TrackingAuthorisationStatus.NOT_DETERMINED)
				{
					var success:Boolean = IDFA.service.requestAuthorisation(
							function( status:String ):void
							{
								log( "requestAuthorisation(): callback: " + status );
							}
					);
					log( "requestAuthorisation() = " + success );
				}
			}
		}
		
		
		private function authorisationChangedHandler( event:IDFAAuthorisationEvent ):void
		{
			log( "authorisationChangedHandler: " + event.authorisationStatus );
			IDFA.service.removeEventListener( IDFAAuthorisationEvent.CHANGED, authorisationChangedHandler );
		}
		
		
		
    }
}
