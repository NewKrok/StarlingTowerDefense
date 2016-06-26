/**
 * Created by newkrok on 20/03/16.
 */
package net.fpp.starlingtowerdefense.game.config.unit
{
	import net.fpp.starlingtowerdefense.constant.CSkin;
	import net.fpp.starlingtowerdefense.game.module.projectileManager.vo.ProjectileSettingVO;
	import net.fpp.starlingtowerdefense.game.module.unit.constant.CArmorType;
	import net.fpp.starlingtowerdefense.game.module.unit.constant.CAttackType;
	import net.fpp.starlingtowerdefense.game.module.unit.vo.UnitConfigVO;

	public class MageUnitConfigVO extends UnitConfigVO
	{
		public function MageUnitConfigVO()
		{
			this.name = 'Mage';

			this.sizeRadius = 30;
			this.attackRadius = 250;
			this.unitDetectionRadius = 250;

			this.armor = 0;
			this.armorType = CArmorType.MAGIC;

			this.blockChance = 2;

			this.projectileConfigVO = new ProjectileSettingVO();
			this.projectileConfigVO.skin = CSkin.MAGE_PROJECTILE;
			this.projectileConfigVO.speed = 50;
			this.projectileConfigVO.isEnemyFollower = true;

			this.minDamage = 3;
			this.maxDamage = 5;

			this.areaDamage = 0;
			this.areaDamageRadius = 0;

			this.attackSpeed = .5;
			this.attackType = CAttackType.MAGIC;

			this.criticalHitChance = .01;
			this.criticalHitDamageMultiple = 1.5;

			this.attackActionDelay = .7;

			this.maxLife = 100;
			this.lifeRegeneration = 2;

			this.maxMana = 40;
			this.manaRegeneration = 4;

			this.movementSpeed = 250;
		}
	}
}