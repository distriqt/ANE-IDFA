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
package com.distriqt.extension.idfa.controller;

import android.content.Context;

import com.distriqt.core.utils.FREUtils;
import com.distriqt.core.utils.IExtensionContext;
import com.distriqt.core.utils.LogUtil;
import com.distriqt.extension.idfa.IDFAExtension;
import com.distriqt.extension.idfa.events.IDFAEvent;
import com.google.android.gms.ads.identifier.AdvertisingIdClient;
import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GooglePlayServicesNotAvailableException;
import com.google.android.gms.common.GooglePlayServicesRepairableException;
import com.google.android.gms.common.GooglePlayServicesUtil;


public class IDFAController
{
	////////////////////////////////////////////////////////
	//  CONSTANTS
	//

	public static final String TAG = IDFAController.class.getSimpleName();

	private static final int PLAY_SERVICES_RESOLUTION_REQUEST = 9000;


	////////////////////////////////////////////////////////
	//  VARIABLES
	//

	private IExtensionContext _extContext;

	private AdvertisingIdClient.Info _advertisingInfo;


	////////////////////////////////////////////////////////
	//  FUNCTIONALITY
	//

	public IDFAController( IExtensionContext extContext )
	{
		_extContext = extContext;
	}


	public void dispose()
	{

	}


	public boolean isGooglePlayServicesAvailable()
	{
		//int resultCode = GoogleApiAvailability.getInstance().isGooglePlayServicesAvailable( _extContext.getActivity().getApplicationContext() );
		int resultCode = GooglePlayServicesUtil.isGooglePlayServicesAvailable( _extContext.getActivity().getApplicationContext() );
		if (ConnectionResult.SUCCESS == resultCode)
		{
			LogUtil.d( IDFAExtension.ID, TAG, "Google Play services is available.");
			return true;
		}
		else
		{
			LogUtil.d( IDFAExtension.ID, TAG, "Google Play services NOT available.");
		}
		return false;
	}


	public void getIDFA()
	{
		LogUtil.d( IDFAExtension.ID, TAG, "getIDFA()" );

		if (isGooglePlayServicesAvailable())
		{
			final Context context = _extContext.getActivity().getApplicationContext();
			new Thread( new Runnable()
			{
				@Override
				public void run()
				{
					try
					{
						_advertisingInfo = AdvertisingIdClient.getAdvertisingIdInfo( context );
						_extContext.dispatchEvent(
								IDFAEvent.COMPLETE,
								IDFAEvent.formatForEvent(
										_advertisingInfo.getId(),
										_advertisingInfo.isLimitAdTrackingEnabled()
								)
						);
					}
					catch (GooglePlayServicesRepairableException e)
					{
						showErrorDialog(e.getConnectionStatusCode());
						_extContext.dispatchEvent( IDFAEvent.ERROR, "" );
					}
					catch (GooglePlayServicesNotAvailableException e)
					{
						showErrorDialog(e.errorCode);
						_extContext.dispatchEvent( IDFAEvent.ERROR, "" );
					}
					catch (Exception e)
					{
						FREUtils.handleException( e );
						_extContext.dispatchEvent( IDFAEvent.ERROR, "" );
					}
				}
			}).start();
		}
		else
		{
			//showErrorDialog( GoogleApiAvailability.getInstance().isGooglePlayServicesAvailable( _extContext.getActivity() ));
		}

	}


	public boolean advertisingTrackingEnabled()
	{
		LogUtil.d( IDFAExtension.ID, TAG, "advertisingTrackingEnabled()" );
		if (_advertisingInfo != null)
		{
			return !_advertisingInfo.isLimitAdTrackingEnabled();
		}
		else
		{
			getIDFA();
		}
		return false;
	}




	private void showErrorDialog(int errorCode)
	{
		LogUtil.d( IDFAExtension.ID, TAG, "showErrorDialog()" );
		//if (GoogleApiAvailability.getInstance().isUserResolvableError( errorCode ))
		//{
		//	LogUtil.d( IDFAExtension.ID, TAG, "UserResolvableError" );
		//	GoogleApiAvailability.getInstance().getErrorDialog(
		//			_extContext.getActivity(),
		//			errorCode,
		//			PLAY_SERVICES_RESOLUTION_REQUEST ).show();
		//}
		if (GooglePlayServicesUtil.isUserRecoverableError( errorCode ))
		{
			LogUtil.d( IDFAExtension.ID, TAG, "UserRecoverableError" );
			GooglePlayServicesUtil.getErrorDialog(
					errorCode,
					_extContext.getActivity(),
					PLAY_SERVICES_RESOLUTION_REQUEST
			).show();
		}
	}



}
