/**
 * Created by newkrok on 20/03/16.
 */
package net.fpp.starlingtowerdefense.game.config.unit
{
	import net.fpp.starlingtowerdefense.game.module.unit.constant.CArmorType;
	import net.fpp.starlingtowerdefense.game.module.unit.constant.CAttackType;
	import net.fpp.starlingtowerdefense.game.module.unit.vo.UnitConfigVO;

	public class TestEnemyUitConfigVO extends UnitConfigVO
	{
		public function TestEnemyUitConfigVO()
		{
			this.name = 'tst enemy';

			this.sizeRadius = 30;
			this.attackRadius = 90;
			this.unitDetectionRadius = 200;

			this.armor = 0;
			this.armorType = CArmorType.NORMAL;

			this.blockChance = 2;

			this.minDamage = 5;
			this.maxDamage = 7;

			this.areaDamage = 0;
			this.areaDamageRadius = 0;

			this.attackSpeed = 1;
			this.attackType = CAttackType.NORMAL;

			this.criticalHitChance = .01;
			this.criticalHitDamageMultiple = 1.5;

			this.attackActionDelay = .7;

			this.maxLife = 20;
			this.lifeRegeneration = 3;

			this.movementSpeed = 100;
		}
	}
}