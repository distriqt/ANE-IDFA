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
 * @brief  		
 * @author 		marchbold
 * @created		17/7/17
 * @copyright	http://distriqt.com/copyright/license.txt
 */
package com.distriqt.test.idfa 
{
	import com.distriqt.extension.idfa.IDFA;
	import com.distriqt.extension.idfa.events.IDFAEvent;
	
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
		        IDFA.init( Config.applicationKey );
		        log( "IDFA isSupported: " + IDFA.isSupported );
		        if (IDFA.isSupported)
		        {
			        log( "IDFA version:     " + IDFA.service.version );
		        }
	        }
	        catch (e:Error)
	        {
	        }
        }

		
		public function getIDFA():void
		{
			log( "getIDFA()" );
			if (IDFA.isSupported)
			{
				IDFA.service.addEventListener( IDFAEvent.COMPLETE, idfaCompleteHandler );
				IDFA.service.getIDFA();
			}
		}
		
		private function idfaCompleteHandler( event:IDFAEvent ):void
		{
			log( "identifier: " + event.identifier );
			log( "isLimitAdTrackingEnabled: " + event.isLimitAdTrackingEnabled );
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
		
    }
}
