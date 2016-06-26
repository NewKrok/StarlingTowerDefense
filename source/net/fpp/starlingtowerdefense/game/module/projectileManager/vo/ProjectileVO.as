/**
 * Created by newkrok on 26/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.projectileManager.vo
{
	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;

	public class ProjectileVO
	{
		public var projectileConfigVO:ProjectileSettingVO;
		public var target:IUnitModule;

		public function ProjectileVO( projectileConfigVO:ProjectileSettingVO, target:IUnitModule )
		{
			this.projectileConfigVO = projectileConfigVO;
			this.target = target;
		}
	}
}