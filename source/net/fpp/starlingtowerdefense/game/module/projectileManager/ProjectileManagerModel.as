/**
 * Created by newkrok on 26/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.projectilemanager
{
	import net.fpp.common.starling.module.AModel;
	import net.fpp.starlingtowerdefense.game.module.projectilemanager.events.ProjectileManagerModelEvent;
	import net.fpp.starlingtowerdefense.game.module.projectilemanager.vo.ProjectileVO;

	public class ProjectileManagerModel extends AModel
	{
		private var _projectileVOs:Vector.<ProjectileVO> = new Vector.<ProjectileVO>();

		public function addProjectile( projectileVO:ProjectileVO ):void
		{
			this._projectileVOs.push( projectileVO );

			this.dispatchEvent( new ProjectileManagerModelEvent( ProjectileManagerModelEvent.PROJECTILE_ADDED, projectileVO ) );
		}

		public function removeProjectile( projectileVO:ProjectileVO ):void
		{
			for ( var i:int = 0; i < this._projectileVOs.length; i++ )
			{
				if ( this._projectileVOs[i] == projectileVO )
				{
					this._projectileVOs.splice( i, 1 );
					break;
				}
			}
		}
	}
}