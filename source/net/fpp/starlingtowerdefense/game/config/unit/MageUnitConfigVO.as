/**
 * Created by newkrok on 20/03/16.
 */
package net.fpp.starlingtowerdefense.game.config.unit
{
	import net.fpp.common.geom.SimplePoint;
	import net.fpp.starlingtowerdefense.constant.CSkin;
	import net.fpp.starlingtowerdefense.game.module.projectilemanager.vo.ProjectileSettingVO;
	import net.fpp.starlingtowerdefense.game.module.unit.constant.CArmorType;
	import net.fpp.starlingtowerdefense.game.module.unit.constant.CAttackType;
	import net.fpp.starlingtowerdefense.game.module.unit.vo.UnitConfigVO;

	public class MageUnitConfigVO extends UnitConfigVO
	{
		public function MageUnitConfigVO()
		{
			this.name = 'Mage';
			this.skeleton = 'Mage';

			this.sizeRadius = 30;
			this.unitHeight = 100;

			this.attackRadius = 300;
			this.unitDetectionRadius = 300;

			this.armor = 0;
			this.armorType = CArmorType.MAGIC;

			this.blockChance = 2;

			this.projectileConfigVO = new ProjectileSettingVO();
			this.projectileConfigVO.skinId = CSkin.MAGE_PROJECTILE;
			this.projectileConfigVO.minDamage = 25;
			this.projectileConfigVO.maxDamage = 45;
			this.projectileConfigVO.attackType = CAttackType.MAGIC;
			this.projectileConfigVO.speed = 250;
			this.projectileConfigVO.isEnemyFollower = true;
			this.projectileConfigVO.startPointOffset = new SimplePoint( 30, -20 );
			this.projectileConfigVO.projectileArcHeight = 0;

			this.minDamage = 1;
			this.maxDamage = 4;

			this.areaDamage = 0;
			this.areaDamageRadius = 0;

			this.attackSpeed = 2.5;
			this.attackAnimationSpeed = .5;
			this.attackType = CAttackType.NORMAL;

			this.criticalHitChance = .01;
			this.criticalHitDamageMultiple = 1.5;

			this.attackActionDelay = .2;

			this.maxLife = 20;
			this.lifeRegeneration = 2;

			this.maxMana = 40;
			this.manaRegeneration = 4;

			this.movementSpeed = 80;
		}
	}
}