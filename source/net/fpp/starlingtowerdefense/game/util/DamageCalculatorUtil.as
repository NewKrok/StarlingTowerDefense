/**
 * Created by newkrok on 20/03/16.
 */
package net.fpp.starlingtowerdefense.game.util
{
	import flash.utils.Dictionary;

	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;

	import net.fpp.starlingtowerdefense.game.module.unit.constant.CArmorType;
	import net.fpp.starlingtowerdefense.game.module.unit.constant.CAttackType;
	import net.fpp.starlingtowerdefense.game.module.unit.vo.UnitConfigVO;

	public class DamageCalculatorUtil
	{
		private static var _damageMultipleByArmorMaifest:Dictionary;

		public static function setConfig():void
		{
			_damageMultipleByArmorMaifest = new Dictionary();

			_damageMultipleByArmorMaifest[CArmorType.NORMAL + CAttackType.NORMAL] = .75;
			_damageMultipleByArmorMaifest[CArmorType.NORMAL + CAttackType.PIERCING] = 1.25;
			_damageMultipleByArmorMaifest[CArmorType.NORMAL + CAttackType.MAGIC] = 1;

			_damageMultipleByArmorMaifest[CArmorType.HEAVY + CAttackType.NORMAL] = 1;
			_damageMultipleByArmorMaifest[CArmorType.HEAVY + CAttackType.PIERCING] = .75;
			_damageMultipleByArmorMaifest[CArmorType.HEAVY + CAttackType.MAGIC] = 1.25;

			_damageMultipleByArmorMaifest[CArmorType.MAGIC + CAttackType.NORMAL] = 1.25;
			_damageMultipleByArmorMaifest[CArmorType.MAGIC + CAttackType.PIERCING] = 1;
			_damageMultipleByArmorMaifest[CArmorType.MAGIC + CAttackType.MAGIC] = .75;
		}

		private static function calculateDamageByAttackAndArmorType( damage:Number, attackType:String, armorType:String ):Number
		{
			return damage * _damageMultipleByArmorMaifest[armorType + attackType];
		}

		private static function getAttackByMinAndMax( min:Number, max:Number ):Number
		{
			var difference:Number = max - min;

			return Math.round( min + Math.random() * difference );
		}

		public static function calculateDamage( attacker:IUnitModule, target:IUnitModule ):Number
		{
			var attackerUnitConfigVO:UnitConfigVO = attacker.getUnitConfigVO();

			var damageValue:Number = getAttackByMinAndMax( attackerUnitConfigVO.minDamage, attackerUnitConfigVO.maxDamage );

			if( attackerUnitConfigVO.criticalHitChance > Math.random() )
			{
				damageValue *= attackerUnitConfigVO.criticalHitDamageMultiple;
			}

			damageValue = calculateDamageByAttackAndArmorType( damageValue, attackerUnitConfigVO.attackType, target.getArmorType() );

			return damageValue;
		}
	}
}