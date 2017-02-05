/**
 * Created by newkrok on 20/03/16.
 */
package net.fpp.starlingtowerdefense.game.module.unit.vo
{
	import net.fpp.starlingtowerdefense.game.module.projectilemanager.vo.ProjectileSettingVO;

	public class UnitConfigVO
	{
		public var name:String;
		public var skeleton:String;
		public var movementSpeed:Number;
		public var sizeRadius:Number;
		public var unitHeight:Number;
		public var unitDetectionRadius:Number;
		public var minDamage:Number;
		public var maxDamage:Number;
		public var areaDamage:Number;
		public var areaDamageRadius:Number;
		public var criticalHitChance:Number;
		public var criticalHitDamageMultiple:Number;
		public var blockChance:Number;
		public var attackActionDelay:Number;
		public var attackSpeed:Number;
		public var attackAnimationSpeed:Number = 0;
		public var attackRadius:Number;
		public var attackType:String;
		public var projectileConfigVO:ProjectileSettingVO;
		public var isInvulnerable:Boolean;
		public var maxLife:Number;
		public var lifeRegeneration:Number;
		public var maxMana:Number;
		public var manaRegeneration:Number;
		public var armor:Number;
		public var armorType:String;
	}
}