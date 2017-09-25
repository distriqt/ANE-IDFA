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
 * @created 25/09/2017
 * @copyright http://distriqt.com/copyright/license.txt
 */
package com.distriqt.extension.idfa.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.distriqt.core.utils.FREUtils;
import com.distriqt.extension.idfa.IDFAContext;

public class AdvertisingTrackingEnabledFunction implements FREFunction
{

	@Override
	public FREObject call( FREContext freContext, FREObject[] freObjects )
	{
		FREObject result = null;
		try
		{
			IDFAContext ctx = (IDFAContext)freContext;
			boolean advertisingTrackingEnabled = ctx.controller().advertisingTrackingEnabled();

			result = FREObject.newObject( advertisingTrackingEnabled );
		}
		catch (Exception e)
		{
			FREUtils.handleException( freContext, e );
		}
		return result;
	}

}
