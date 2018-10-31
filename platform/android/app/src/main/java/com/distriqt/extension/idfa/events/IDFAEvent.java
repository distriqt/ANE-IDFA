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
 * @author marchbold
 * @created 17/07/2017
 * @copyright http://distriqt.com/copyright/license.txt
 */
package com.distriqt.extension.idfa.events;

import org.json.JSONObject;

public class IDFAEvent
{

	public static final String COMPLETE = "idfa:complete";
	public static final String ERROR = "idfa:error";


	public static String formatForEvent( String identifier, boolean isLimitAdTrackingEnabled )
	{
		try
		{
			JSONObject event = new JSONObject();

			event.put( "identifier", identifier );
			event.put( "isLimitAdTrackingEnabled", isLimitAdTrackingEnabled );

			return event.toString();
		}
		catch (Exception e)
		{
		}
		return "{}";
	}





}
