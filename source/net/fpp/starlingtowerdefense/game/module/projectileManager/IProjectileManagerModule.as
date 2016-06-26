/**
 * Created by newkrok on 26/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.projectileManager
{
	import net.fpp.common.starling.module.IUpdatableModule;
	import net.fpp.starlingtowerdefense.game.module.projectileManager.vo.ProjectileSettingVO;
	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;

	public interface IProjectileManagerModule extends IUpdatableModule
	{
		function addProjectile( projectileConfigVO:ProjectileSettingVO, target:IUnitModule ):void;
	}
}