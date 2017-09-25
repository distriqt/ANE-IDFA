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
 * @file   		FirebaseContext.java
 * @brief  		Main Context for an ActionScript Native Extension
 * @author 		Michael Archbold
 * @created		Jan 19, 2012
 * @updated		$Date:$
 * @copyright	http://distriqt.com/copyright/license.txt
 *
 */
package com.distriqt.extension.idfa;

import android.content.Intent;
import android.content.res.Configuration;
import android.os.Handler;
import android.os.Looper;

import com.adobe.air.ActivityResultCallback;
import com.adobe.air.AndroidActivityWrapper;
import com.adobe.air.StateChangeCallback;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.distriqt.core.utils.IExtensionContext;
import com.distriqt.extension.idfa.controller.IDFAController;
import com.distriqt.extension.idfa.functions.AdvertisingTrackingEnabledFunction;
import com.distriqt.extension.idfa.functions.GetIDFAFunction;
import com.distriqt.extension.idfa.functions.ImplementationFunction;
import com.distriqt.extension.idfa.functions.IsSupportedFunction;
import com.distriqt.extension.idfa.functions.VersionFunction;

import java.util.HashMap;
import java.util.Map;

public class IDFAContext extends FREContext implements IExtensionContext, ActivityResultCallback, StateChangeCallback
{
	public static final String TAG = IDFAContext.class.getSimpleName();
	public static final String VERSION = "1.0";
	public static final String IMPLEMENTATION = "Android";


	////////////////////////////////////////////////////////////
	//	VARIABLES
	//

	public boolean v = false;

	private AndroidActivityWrapper _aaw;


	////////////////////////////////////////////////////////////
	//	FUNCTIONALITY
	//

	public IDFAContext()
	{
		_aaw = AndroidActivityWrapper.GetAndroidActivityWrapper();
		_aaw.addActivityResultListener( this );
		_aaw.addActivityStateChangeListner( this );
	}


	@Override
	public void dispose() 
	{
		if (_aaw != null)
		{
			_aaw.removeActivityResultListener( this );
			_aaw.removeActivityStateChangeListner( this );
			_aaw = null;
		}
		if (_controller != null)
		{
			_controller.dispose();
			_controller = null;
		}
	}

	
	@Override
	public Map<String, FREFunction> getFunctions() 
	{
		Map<String, FREFunction> functionMap = new HashMap<String, FREFunction>();
		
		functionMap.put( "isSupported", 	new IsSupportedFunction() );
		functionMap.put( "version",   		new VersionFunction() );
		functionMap.put( "implementation", 	new ImplementationFunction() );

		functionMap.put( "getIDFA", 					new GetIDFAFunction() );
		functionMap.put( "advertisingTrackingEnabled", 	new AdvertisingTrackingEnabledFunction() );

		return functionMap;
	}


	private IDFAController _controller = null;

	public IDFAController controller()
	{
		if (_controller == null)
		{
			_controller = new IDFAController( this );
		}
		return _controller;
	}




	//
	//	ActivityResultCallback
	//

	@Override
	public void onActivityResult( int requestCode, int resultCode, Intent intent )
	{
//		if (_controller != null)
//		{
//			_controller.onActivityResult( requestCode, resultCode, intent );
//		}
	}


	//
	//	StateChangeCallback
	//

	@Override
	public void onActivityStateChanged( AndroidActivityWrapper.ActivityState state )
	{
//		if (_controller != null)
//		{
//			switch (state)
//			{
//				case STARTED:
//					_controller.onStart();
//					break;
//
//				case STOPPED:
//					_controller.onStop();
//					break;
//
//				case PAUSED:
//					_controller.onPause();
//					break;
//
//				case RESTARTED:
//					_controller.onRestart();
//					break;
//
//				case DESTROYED:
//					_controller.onDestroy();
//					break;
//
//				case RESUMED:
//					_controller.onResume();
//					break;
//			}
//		}
	}


	@Override
	public void onConfigurationChanged( Configuration paramConfiguration )
	{
//		FREUtils.log( TAG, "onConfigurationChanged()" );
	}


	//
	//	IEventDispatcher
	//

	@Override
	public void dispatchEvent( final String code, final String data )
	{
		try
		{
			dispatchStatusEventAsync( code, data );
		}
		catch (Exception e)
		{
			new Handler(Looper.getMainLooper()).postDelayed(new Runnable()
			{
				@Override
				public void run()
				{
					IDFAExtension.context.dispatchEvent( code, data );
				}
			}, 500 );
		}
	}
	
}
