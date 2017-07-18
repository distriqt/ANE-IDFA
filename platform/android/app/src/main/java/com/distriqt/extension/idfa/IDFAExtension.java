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
 * @file   		FirebaseExtension.java
 * @brief  		Main Extension implementation for this ANE
 * @author 		Michael Archbold
 * @created		Jan 19, 2012
 * @updated		$Date:$
 * @copyright	http://distriqt.com/copyright/license.txt
 *
 */
package com.distriqt.extension.idfa;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class IDFAExtension implements FREExtension
{
	public static IDFAContext context;
	
	public static String ID	= "com.distriqt.IDFA";
	
	
	@Override
	public FREContext createContext(String arg0) 
	{
		context = new IDFAContext();
		return context;
	}

	
	@Override
	public void dispose() 
	{
		context = null;
	}

	
	@Override
	public void initialize() 
	{
	}

}
