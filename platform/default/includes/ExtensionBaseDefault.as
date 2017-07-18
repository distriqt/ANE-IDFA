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
 * @file   		ExtensionBase.as
 * @brief  		
 * @author 		Shane Korin & Michael Archbold
 * @created		Nov 13, 2014
 * @copyright	http://distriqt.com/copyright/license.txt
 */



////////////////////////////////////////////////////////
//	VARIABLES
//

public static const VERSION_BASE	: String = "8";

protected var _extensionId			: String = "";
protected var _extensionIdNumber	: int = -1;

private var _registered				: Boolean = false;
private var _initialised			: Boolean = false;
private var _key			: String = "";


////////////////////////////////////////////////////////
//	FUNCTIONALITY
//

private function get key():String
{
	return _key;
}


private function set key(value:String):void
{
	if (_initialised) 
	{
		trace( "You cannot change the key once initialised" );
		return;
	}
	validateKey( value, _extensionId, _extensionIdNumber );
}


/**
 * Overrides the default dispatch event to check if the developer id is valid.
 * If the id is invalid, the dispatch does not occur
 */		
override public function dispatchEvent( event:Event ):Boolean
{
	try
	{
		if (verify())
			return super.dispatchEvent(event);
	}
	catch (e:Error)
	{
		return super.dispatchEvent( new ErrorEvent( ErrorEvent.ERROR, event.bubbles, event.cancelable, e.message ));
	}
	return false;
}


/**
 * Verifies the developer key, returns true or throws error and returns false. 
 */
private function verify():Boolean
{
	if (_key == "" || !_initialised)
	{
		throw new Error( "You must call the init() method of the "+_extensionId +" native extension class with your key" );
		return false;
	}
	else if (!_registered)
	{
		throw new Error( "Your key was not able to be verified for the "+_extensionId+" native extension" );
	}
	return _registered;
}


////////////////////////////////////////////////////////
//	INTERNALS
//

/**
 * 
 * @param key
 * @param extensionId
 * 
 */		
private function validateKey( key:String, extensionId:String, extensionIdNumber:int ):void
{
	_key 			= key;
	_initialised 	= true;
	_registered   	= false; 
	try
	{
		_registered = true;
	}
	catch (e:Error)
	{
	}
}
