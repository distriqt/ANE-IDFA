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
 * @file   		ExtensionBaseDefaultNoVerification.as
 * @brief  		
 * @author 		"Michael Archbold (ma&#64;distriqt.com)"
 * @created		06/02/2015
 * @updated		$Date:$
 * @copyright	http://distriqt.com/copyright/license.txt
 */

		
////////////////////////////////////////////////////////
//	VARIABLES
//

private static const VERSION_BASE	: String = "8";

private var _extensionId			: String = "";
private var _extensionIdNumber		: int = -1;
private var _initialised			: Boolean = false;
private var _key					: String = "";


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
	_key = value;
	_initialised = true;
}



/**
 * Verifies the developer key, returns true or throws error and returns false. 
 */
private function verify():Boolean
{
	return true;
}


