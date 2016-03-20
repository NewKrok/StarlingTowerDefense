/**
 * Created by newkrok on 20/03/16.
 */
package starlingtowerdefense.game.module.unitcontroller.events
{
	import starling.events.Event;

	public class UnitControllerModuleEvent extends Event
	{
		public static var UNIT_MOVE_TO_REQUEST:String = 'UnitControllerModuleEvent.UNIT_MOVE_TO_REQUEST';

		public function UnitControllerModuleEvent( type:String, data:Object = null ):void
		{
			super( type, false, data );
		}
	}
}