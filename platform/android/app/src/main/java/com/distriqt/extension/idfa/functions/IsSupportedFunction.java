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
 * @file   		IsSupportedFunction.java
 * @brief  		Is Supported function implementation for this ANE
 * @author 		Michael Archbold
 * @created		Jan 19, 2012
 * @updated		$Date:$
 * @copyright	http://distriqt.com/copyright/license.txt
 *
 */
package com.distriqt.extension.idfa.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;
import com.distriqt.core.utils.FREUtils;

public class IsSupportedFunction implements FREFunction 
{

	@Override
	public FREObject call( FREContext context, FREObject[] args ) 
	{
		FREObject result = null;
		try
		{
			//boolean isGooglePlayServicesAvailable = ((IDFAContext)context).controller().isGooglePlayServicesAvailable();
			//result = FREObject.newObject( isGooglePlayServicesAvailable );
			result = FREObject.newObject( true );
		}
		catch (FREWrongThreadException e) 
		{
			FREUtils.handleException( context, e );
		}
		return result;
	}

}
