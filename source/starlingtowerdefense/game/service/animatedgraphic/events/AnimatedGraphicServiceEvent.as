/**
 * Created by newkrok on 13/01/16.
 */
package starlingtowerdefense.game.service.animatedgraphic.events
{
	import starling.events.Event;

	public class AnimatedGraphicServiceEvent extends Event
	{
		public static const COMPLETE:String = 'AnimatedGraphicServiceEvent.COMPLETE';

		public function AnimatedGraphicServiceEvent( type:String )
		{
			super( type );
		}
	}
}