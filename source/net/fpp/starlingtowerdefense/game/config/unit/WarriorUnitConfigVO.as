/**
 * Created by newkrok on 20/03/16.
 */
package net.fpp.starlingtowerdefense.game.config.unit
{
	import net.fpp.starlingtowerdefense.game.module.unit.constant.CArmorType;
	import net.fpp.starlingtowerdefense.game.module.unit.constant.CAttackType;
	import net.fpp.starlingtowerdefense.game.module.unit.vo.UnitConfigVO;

	public class WarriorUnitConfigVO extends UnitConfigVO
	{
		public function WarriorUnitConfigVO()
		{
			this.name = 'Warrior';

			this.sizeRadius = 30;
			this.attackRadius = 90;
			this.unitDetectionRadius = 150;

			this.armor = 0;
			this.armorType = CArmorType.HEAVY;

			this.blockChance = 2;

			this.minDamage = 10;
			this.maxDamage = 15;

			this.areaDamage = 0;
			this.areaDamageRadius = 0;

			this.attackSpeed = 1;
			this.attackType = CAttackType.NORMAL;

			this.criticalHitChance = .01;
			this.criticalHitDamageMultiple = 1.5;

			this.damageDelay = .7;

			this.maxLife = 30;
			this.lifeRegeneration = 2;

			this.maxMana = 15;
			this.manaRegeneration = 4;

			this.movementSpeed = 300;
		}
	}
}