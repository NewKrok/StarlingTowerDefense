/**
 * Created by newkrok on 13/01/16.
 */
package net.fpp.starlingtowerdefense.game.service.animatedgraphic.events
{
	import starling.events.Event;

	public class DragonBonesGraphicServiceEvent extends Event
	{
		public static const COMPLETE:String = 'DragonBonesGraphicServiceEvent.COMPLETE';

		public function DragonBonesGraphicServiceEvent( type:String )
		{
			super( type );
		}
	}
}