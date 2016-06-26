/**
 * Created by newkrok on 26/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.projectileManager
{
	import net.fpp.common.starling.module.AModule;
	import net.fpp.starlingtowerdefense.game.module.projectileManager.view.ProjectileManagerModuleView;
	import net.fpp.starlingtowerdefense.game.module.projectileManager.vo.ProjectileSettingVO;
	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;

	public class ProjectileManagerModule extends AModule implements IProjectileManagerModule
	{
		private var _projectileManagerModel:ProjectileManagerModel;

		private var _projectileManagerView:ProjectileManagerModuleView;

		public function ProjectileManagerModule()
		{
			this._projectileManagerModel = this.createModel( ProjectileManagerModel ) as ProjectileManagerModel;

			this._projectileManagerView = this.createModuleView( ProjectileManagerModuleView ) as ProjectileManagerModuleView;
		}

		public function onUpdate():void
		{
		}

		public function addProjectile( projectileConfigVO:ProjectileSettingVO, target:IUnitModule ):void
		{
			this._projectileManagerModel.addProjectile( projectileConfigVO, target );
		}

		override public function dispose():void
		{
			this._projectileManagerModel = null;

			this._projectileManagerView = null;

			super.dispose();
		}
	}
}