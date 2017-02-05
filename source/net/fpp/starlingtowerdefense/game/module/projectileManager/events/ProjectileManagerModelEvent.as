/**
 * Created by newkrok on 26/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.projectilemanager.events
{
	import net.fpp.starlingtowerdefense.game.module.projectilemanager.vo.ProjectileVO;

	import starling.events.Event;

	public class ProjectileManagerModelEvent extends Event
	{
		public static const PROJECTILE_ADDED:String = 'ProjectileManagerModelEvent.PROJECTILE_ADDED';

		public var projectileVO:ProjectileVO;

		public function ProjectileManagerModelEvent( type:String, projectileVO:ProjectileVO )
		{
			this.projectileVO = projectileVO;

			super( type );
		}
	}
}