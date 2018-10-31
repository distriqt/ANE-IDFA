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
 * @brief  		IDFA Native Extension
 * @author 		Michael Archbold
 * @created		Jul 17, 2017
 * @copyright	http://distriqt.com/copyright/license.txt
 */
package com.distriqt.extension.idfa
{
	import com.distriqt.extension.idfa.events.IDFAEvent;
	
	import flash.events.Event;
	import flash.events.ErrorEvent;
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	
	/**	
	 * <p>
	 * This class represents the IDFA extension. A simple extension to retrieve
	 * the advertising identifier for the current device
	 * </p>
	 */
	public final class IDFA extends EventDispatcher
	{
		////////////////////////////////////////////////////////
		//	CONSTANTS
		//
		
		//
		//	ID and Version numbers
		public static const EXT_CONTEXT_ID			: String = "com.distriqt.IDFA";
		private static const EXT_ID_NUMBER			: int = -1;
		
		public static const VERSION					: String = Version.VERSION;
		private static const VERSION_DEFAULT		: String = "0";
		private static const IMPLEMENTATION_DEFAULT	: String = "unknown";
		
		
		//
		//	Error Messages
		private static const ERROR_CREATION			: String = "The native extension context could not be created";
		private static const ERROR_SINGLETON		: String = "The singleton has already been created. Use IDFA.service to access the functionality";
		
		
		////////////////////////////////////////////////////////
		//	VARIABLES
		//
		
		//
		// Singleton variables
		private static var _instance				: IDFA;
		private static var _shouldCreateInstance	: Boolean = false;
		private static var _extContext	        	: ExtensionContext = null;
		
		private var _extensionId			: String = "";
		private var _extensionIdNumber		: int = -1;
		
		
		////////////////////////////////////////////////////////
		//	SINGLETON INSTANCE
		//
		
		/**
		 * The singleton instance of the IDFA class.
		 * @throws Error If there was a problem creating or accessing the extension, or if the key is invalid
		 */
		public static function get service():IDFA
		{
			createInstance();
			return _instance;
		}
		
		
		/**
		 * @private
		 * Creates the actual singleton instance 
		 */
		private static function createInstance():void
		{
			if(_instance == null)
			{
				_shouldCreateInstance = true; 
				_instance = new IDFA();
				_shouldCreateInstance = false;
			}
		}
		
		
		
		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//
		
		/**
		 * Constructor
		 * 
		 * You should not call this directly, but instead use the singleton access
		 */
		public function IDFA()
		{
			if (_shouldCreateInstance)
			{
				try
				{
					_extensionId = EXT_CONTEXT_ID;
					_extensionIdNumber = EXT_ID_NUMBER;
					_extContext = ExtensionContext.createExtensionContext( EXT_CONTEXT_ID, null );
					_extContext.addEventListener( StatusEvent.STATUS, extension_statusHandler, false, 0, true );
				}
				catch (e:Error)
				{
					throw new Error( ERROR_CREATION );
				}
			}
			else
			{
				throw new Error( ERROR_SINGLETON );
			}
		}
		
		
		/**
		 * Initialises the extension class for use with the provided key.
		 *
		 * @throws Error If there was a problem creating or accessing the extension, or if the key is invalid
		 */
		public static function init( key:String="" ):void
		{
			createInstance();
		}
		
		
		/**
		 * <p>
		 * Disposes the extension and releases any allocated resources. Once this function 
		 * has been called, a call to <code>init</code> is neccesary again before any of the 
		 * extensions functionality will work.
		 * </p>
		 */		
		public function dispose():void
		{
			if (_extContext)
			{
				_extContext.removeEventListener( StatusEvent.STATUS, extension_statusHandler );
				_extContext.dispose();
				_extContext = null;
			}
			_instance = null;
		}
		
		
		/**
		 * Whether the current device supports the extensions functionality
		 */
		public static function get isSupported():Boolean
		{
			createInstance();
			return _extContext.call( "isSupported" );
		}
		
		
		/**
		 * <p>
		 * The version of this extension.
		 * </p>
		 * <p>
		 * This should be of the format, MAJOR.MINOR.BUILD
		 * </p>
		 */
		public function get version():String
		{
			return VERSION;
		}
		
		
		/**
		 * <p>
		 * The native version string of the native extension.
		 * </p>
		 */
		public function get nativeVersion():String
		{
			try
			{
				return _extContext.call( "version" ) as String;
			}
			catch (e:Error)
			{
			}
			return VERSION_DEFAULT;
		}
		
		
		/**
		 * <p>
		 * The implementation currently in use. 
		 * This should be one of the following depending on the platform in use and the
		 * functionality supported by this extension:
		 * <ul>
		 * <li><code>Android</code></li>
		 * <li><code>iOS</code></li>
		 * <li><code>default</code></li>
		 * <li><code>unknown</code></li>
		 * </ul>
		 * </p>
		 */		
		public function get implementation():String
		{
			try
			{
				return _extContext.call( "implementation" ) as String;
			}
			catch (e:Error)
			{
			}
			return IMPLEMENTATION_DEFAULT;
		}
		
		
		//
		//
		//	EXTENSION FUNCTIONALITY
		//
		//
		
		/**
		 * <p>
		 * An alphanumeric string unique to each device, used only for serving advertisements.
		 * </p>
		 *
		 * <p>
		 * This identifier may change—for example, if the user erases the device—so you should not cache it.
		 * </p>
		 *
		 * <p>
		 * <strong>Important</strong>
		 * In iOS 10.0 and later, the value of this is all zeroes when the user has limited ad tracking
		 * (<code>00000000-0000-0000-0000-000000000000</code>).
		 * </p>
		 */
		public function getIDFA():void
		{
			try
			{
				_extContext.call( "getIDFA" );
			}
			catch (e:Error)
			{
			}
		}
		
		
		/**
		 * <p>
		 * A Boolean value that indicates whether the user has limited ad tracking.
		 * </p>
		 *
		 * <p>
		 * Check the value of this property before performing any advertising tracking.
		 * If the value is NO, use the advertising identifier only for the following
		 * purposes: frequency capping, attribution, conversion events, estimating
		 * the number of unique users, advertising fraud detection, and debugging.
		 * </p>
		 *
		 * <p>
		 * <strong>NOTE</strong>: This value will be invalid immediately after initialisation.
		 * To ensure you have the should call <code>getIDFA</code> and use the <code>isLimitAdTrackingEnabled</code>
		 * property on the <code>IDFAEvent.COMPLETE</code> event.
		 * </p>
		 */
		[Deprecated(message="Use the isLimitAdTrackingEnabled property on the IDFAEvent")]
		public function get advertisingTrackingEnabled():Boolean
		{
			try
			{
				return _extContext.call( "advertisingTrackingEnabled" ) as Boolean;
			}
			catch (e:Error)
			{
			}
			return false;
		}
		
		
		
		////////////////////////////////////////////////////////
		//	INTERNALS
		//
		
		
		
		////////////////////////////////////////////////////////
		//	EVENT HANDLERS
		//
		
		private function extension_statusHandler( event:StatusEvent ):void
		{
			var data:Object;
			try
			{
				switch (event.code)
				{
					case "extension:error":
					{
						dispatchEvent( new ErrorEvent( ErrorEvent.ERROR, false, false, event.level ));
						break;
					}
					
					case IDFAEvent.COMPLETE:
					{
						data = JSON.parse(event.level);
						dispatchEvent( new IDFAEvent( event.code, data.identifier, data.isLimitAdTrackingEnabled ));
						break;
					}
					
					case IDFAEvent.ERROR:
					{
						data = JSON.parse(event.level);
						dispatchEvent( new IDFAEvent( event.code, null, false ));
						break;
					}
				}
			}
			catch (e:Error)
			{
			}
		}
		
		
	}
}
