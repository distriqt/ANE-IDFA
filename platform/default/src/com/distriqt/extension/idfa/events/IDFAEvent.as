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
	
		/**
		 * <p>
		 * The advertising identifier
		 * </p>
		 *
		 * <p>
		 * An alphanumeric string unique to each device, used only for serving advertisements.
		 * </p>
		 *
		 * <p>
		 * Note: when ad tracking is limited, the value of the advertising identifier may be <code>00000000-0000-0000-0000-000000000000</code>.
		 * </p>
		 */
		public var identifier	: String = "";
	
	
		/**
		 * <p>
		 * A Boolean value that indicates whether the user has limited ad tracking.
		 * </p>
		 * <p>
		 * If this value is <code>true</code> then the identifier should only be used
		 * for limited ad tracking reasons, for example: frequency capping, attribution,
		 * conversion events, estimating the number of unique users, advertising fraud detection, and debugging.
		 * </p>
		 *
		 * <p>
		 * See:
		 * <ul>
		 *     <li>Android: https://developers.google.com/android/reference/com/google/android/gms/ads/identifier/AdvertisingIdClient.Info</li>
		 *     <li>iOS: https://developer.apple.com/documentation/adsupport/asidentifiermanager</li>
		 * </ul>
		 * </p>
		 */
		public var isLimitAdTrackingEnabled : Boolean = false;
		
		
		
 		////////////////////////////////////////////////////////
        //  FUNCTIONALITY
        //
        
        public function IDFAEvent( type:String, identifier:String, isLimitAdTrackingEnabled:Boolean, bubbles:Boolean =false, cancelable:Boolean =false)
        {
	        super(type,bubbles,cancelable);
	        this.identifier = identifier;
			this.isLimitAdTrackingEnabled = isLimitAdTrackingEnabled;
        }
        
		
		override public function clone():Event
		{
			return new IDFAEvent( type, identifier, isLimitAdTrackingEnabled, bubbles, cancelable );
		}

		
		
    }
}
