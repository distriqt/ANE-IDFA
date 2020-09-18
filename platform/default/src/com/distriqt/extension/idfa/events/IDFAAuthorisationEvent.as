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
 * @created		18/9/20
 * @copyright	http://distriqt.com/copyright/license.txt
 */
package com.distriqt.extension.idfa.events 
{
	import flash.events.Event;
	
	
	public class IDFAAuthorisationEvent extends Event
    {
 		////////////////////////////////////////////////////////
        //  CONSTANTS
        //
        
        private static const TAG : String = "IDFAAuthorisationEvent";
	
		/**
		 * @eventType idfa:authorisation:changed
		 */
		public static const CHANGED : String = "idfa:authorisation:changed";
		
        
 		////////////////////////////////////////////////////////
        //  VARIABLES
        //
	
		/**
		 * The new authorisation status value from the <code>TrackingAuthorisationStatus</code> constants
		 *
		 * @see TrackingAuthorisationStatus
		 */
		public var authorisationStatus:String;
		
		

 		////////////////////////////////////////////////////////
        //  FUNCTIONALITY
        //
	
	
		public function IDFAAuthorisationEvent( type:String, status:String, bubbles:Boolean =false, cancelable:Boolean =false )
		{
			super( type, bubbles, cancelable );
			this.authorisationStatus = status;
		}
	
	
		override public function clone():Event
		{
			return new IDFAAuthorisationEvent( type, authorisationStatus, bubbles, cancelable );
		}
	}
}
