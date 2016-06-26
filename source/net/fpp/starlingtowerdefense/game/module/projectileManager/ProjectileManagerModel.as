/**
 * Created by newkrok on 26/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.projectileManager
{
	import net.fpp.common.starling.module.AModel;
	import net.fpp.starlingtowerdefense.game.module.projectileManager.events.ProjectileManagerModelEvent;
	import net.fpp.starlingtowerdefense.game.module.projectileManager.vo.ProjectileSettingVO;
	import net.fpp.starlingtowerdefense.game.module.projectileManager.vo.ProjectileVO;
	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;

	public class ProjectileManagerModel extends AModel
	{
		private var _projectileVOs:Vector.<ProjectileVO> = new Vector.<ProjectileVO>();

		public function addProjectile( projectileConfigVO:ProjectileSettingVO, target:IUnitModule ):void
		{
			var projectileVO:ProjectileVO = new ProjectileVO( projectileConfigVO, target );

			this._projectileVOs.push( projectileVO );

			this.dispatchEvent( new ProjectileManagerModelEvent( ProjectileManagerModelEvent.PROJECTILE_ADDED, projectileVO ) );
		}
	}
}