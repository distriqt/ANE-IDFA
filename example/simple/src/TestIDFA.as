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
 * This is a test application for the distriqt extension
 * 
 * @author Michael Archbold & Shane Korin
 * 	
 */
package
{
	import com.distriqt.extension.idfa.IDFA;
	import com.distriqt.extension.idfa.events.IDFAEvent;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	
	/**	
	 * Sample application for using the IDFA Native Extension
	 */
	public class TestIDFA extends Sprite
	{
		public static var APP_KEY : String = "APPLICATION_KEY";
		
		
		
		//
		//	VARIABLES
		//
		
		private var _text		: TextField;
		
		
		//
		//	FUNCTIONALITY
		//	
		
		public function TestIDFA()
		{
			super();
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			_text = new TextField();
			_text.defaultTextFormat = new TextFormat("_typewriter", 18 );
			addChild( _text );
			
			stage.addEventListener( Event.RESIZE, stage_resizeHandler, false, 0, true );
			stage.addEventListener( MouseEvent.CLICK, mouseClickHandler, false, 0, true );
			
			
			try
			{
				IDFA.init( APP_KEY );
				
				message( "IDFA Supported: " + IDFA.isSupported );
				message( "IDFA Version:   " + IDFA.service.version );
			}
			catch (e:Error)
			{
				message( "ERROR::"+e.message );
			}
		}
		
		
		private function message( str:String ):void
		{
			trace( str );
			_text.appendText(str+"\n");
		}
		
		
		//
		//	EVENT HANDLERS
		//
		
		private function stage_resizeHandler( event:Event ):void
		{
			_text.width  = stage.stageWidth;
			_text.height = stage.stageHeight - 100;
		}
		
		
		private function mouseClickHandler( event:MouseEvent ):void
		{
			message( "getIDFA()" );
			if (IDFA.isSupported)
			{
				IDFA.service.addEventListener( IDFAEvent.COMPLETE, idfaCompleteHandler );
				IDFA.service.getIDFA();
			}
		}
		
		
		private function idfaCompleteHandler( event:IDFAEvent ):void
		{
			message( "identifier: " + event.identifier );
			message( "isLimitAdTrackingEnabled: " + event.isLimitAdTrackingEnabled );
		}

		
	}
}

