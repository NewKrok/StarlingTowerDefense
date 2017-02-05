/**
 * Created by newkrok on 11/07/16.
 */
package net.fpp.starlingtowerdefense.game.module.projectilemanager.factory
{
	import net.fpp.common.util.objectpool.IPoolableObject;
	import net.fpp.common.util.objectpool.IPoolableObjectFactory;
	import net.fpp.starlingtowerdefense.game.module.projectilemanager.view.ProjectileView;

	public class ProjectileViewFactory implements IPoolableObjectFactory
	{
		public function createObject():IPoolableObject
		{
			return new ProjectileView();
		}
	}
}