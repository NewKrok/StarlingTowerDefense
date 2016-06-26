/**
 * Created by newkrok on 26/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.unit.events
{
	import starling.events.Event;

	public class UnitModelEvent extends Event
	{
		public static const LIFE_CHANGED:String = 'UnitModelEvent.LIFE_CHANGED';
		public static const MANA_CHANGED:String = 'UnitModelEvent.MANA_CHANGED';

		public function UnitModelEvent( type:String )
		{
			super( type, false, null );
		}
	}
}