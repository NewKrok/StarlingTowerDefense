/**
 * Created by newkrok on 26/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.projectilemanager
{
	import net.fpp.common.starling.module.AModule;
	import net.fpp.starlingtowerdefense.game.module.projectilemanager.view.ProjectileManagerModuleView;
	import net.fpp.starlingtowerdefense.game.module.projectilemanager.vo.ProjectileVO;

	public class ProjectileManagerModule extends AModule implements IProjectileManagerModule
	{
		private var _projectileManagerModel:ProjectileManagerModel;

		private var _projectileManagerView:ProjectileManagerModuleView;

		public function ProjectileManagerModule()
		{
			this._projectileManagerModel = this.createModel( ProjectileManagerModel ) as ProjectileManagerModel;

			this._projectileManagerView = this.createModuleView( ProjectileManagerModuleView ) as ProjectileManagerModuleView;
		}

		public function addProjectile( projectileVO:ProjectileVO ):void
		{
			this._projectileManagerModel.addProjectile( projectileVO );
		}

		override public function dispose():void
		{
			this._projectileManagerModel = null;

			this._projectileManagerView = null;

			super.dispose();
		}
	}
}