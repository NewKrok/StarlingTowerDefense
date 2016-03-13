/**
 * Created by newkrok on 13/03/16.
 */
package starlingtowerdefense.game.module.unit.events
{
	import starling.events.Event;

	public class UnitModuleEvent extends Event
	{
		public static var UNIT_DIED:String = 'UnitModuleEvent.UNIT_DIED';

		public function UnitModuleEvent( type:String ):void
		{
			super( type );
		}
	}
}