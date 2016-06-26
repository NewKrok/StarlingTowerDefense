/**
 * Created by newkrok on 26/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.projectileManager.view
{
	import net.fpp.common.starling.module.AModel;
	import net.fpp.common.starling.module.AModuleView;
	import net.fpp.starlingtowerdefense.game.module.projectileManager.ProjectileManagerModel;
	import net.fpp.starlingtowerdefense.game.module.projectileManager.events.ProjectileManagerModelEvent;
	import net.fpp.starlingtowerdefense.game.module.projectileManager.vo.ProjectileVO;

	public class ProjectileManagerModuleView extends AModuleView
	{
		private var _projectileManagerModel:ProjectileManagerModel;

		override public function setModel( model:AModel ):void
		{
			this._projectileManagerModel = model as ProjectileManagerModel;
			this._projectileManagerModel.addEventListener( ProjectileManagerModelEvent.PROJECTILE_ADDED, this.onProjectileAddedHandler );

			super.setModel( model );
		}

		private function onProjectileAddedHandler( e:ProjectileManagerModelEvent ):void
		{
			var projectileVO:ProjectileVO = e.projectileVO;

			
		}

		override public function dispose():void
		{
			this._projectileManagerModel.removeEventListener( ProjectileManagerModelEvent.PROJECTILE_ADDED, this.onProjectileAddedHandler );
			this._projectileManagerModel = null;

			super.dispose();
		}
	}
}