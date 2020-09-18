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
package com.distriqt.extension.idfa
{
	
	/**
	 * Defines the status values for app tracking authorisation status
	 */
	public class TrackingAuthorisationStatus
	{
		////////////////////////////////////////////////////////
		//  CONSTANTS
		//
		
		private static const TAG:String = "TrackingAuthorisationStatus";
		
		
		/**
		 * The end user has authorized access to app-related data that can be used for tracking the user or the device.
		 * <br/>
		 * Note, end users can revoke permission at any time through the Allow Apps To Request To Track
		 * privacy setting on the device.
		 * This setting allows users to opt in or out of allowing apps to request user consent
		 * to access app-related data that can be used for tracking the user or the device.
		 */
		public static const AUTHORISED:String = "authorised";
		
		
		/**
		 * The end user has denied the authorization request to access app-related data that
		 * can be used for tracking the user or the device.
		 */
		public static const DENIED:String = "denied";
		
		
		/**
		 * The value returned if a user has not yet received an authorization request to authorize
		 * access to app-related data that can be used for tracking the user or the device.
		 */
		public static const NOT_DETERMINED:String = "not_determined";
		
		
		/**
		 * A restricted condition means the device does not prompt for tracking authorization
		 * when <code>requestTrackingAuthorisation()</code> is called, nor is it displayed when
		 * the <code>NSUserTrackingUsageDescription</code> is triggered.
		 * <br/>
		 * Also, on restricted devices, the Allow Apps To Request To Track setting is disabled
		 * and cannot be changed. This setting allows users to opt in or out of allowing apps
		 * to request user consent to access app-related data that can be used for tracking the
		 * user or the device.
		 */
		public static const RESTRICTED:String = "restricted";
		
		
	}
	
}
