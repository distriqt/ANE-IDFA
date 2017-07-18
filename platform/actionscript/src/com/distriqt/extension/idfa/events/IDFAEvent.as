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
package com.distriqt.extension.idfa.events 
{
	import flash.events.Event;
	
	public class IDFAEvent extends Event
    {
 		////////////////////////////////////////////////////////
        //  CONSTANTS
        //
        
        private static const TAG : String = "IDFAEvent";
		
		
		/**
		 * @eventType idfa:complete
		 */
		public static const COMPLETE : String = "idfa:complete";
		
		
		/**
		 * @eventType idfa:error
		 */
		public static const ERROR : String = "idfa:error";
		
		
        
 		////////////////////////////////////////////////////////
        //  VARIABLES
        //
        
		public var identifier : String;

		
		
 		////////////////////////////////////////////////////////
        //  FUNCTIONALITY
        //
        
        public function IDFAEvent(type:String, identifier:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
	        super(type,bubbles,cancelable);
	        this.identifier = identifier;
        }
        
		
		override public function clone():Event
		{
			return new IDFAEvent( type, identifier, bubbles, cancelable );
		}

		
		
    }
}
