/**
 * Created by newkrok on 07/01/16.
 */
package net.fpp.starlingtowerdefense.game.module.unit.view
{
	import dragonBones.Armature;
	import dragonBones.Bone;
	import dragonBones.animation.WorldClock;
	import dragonBones.events.AnimationEvent;

	import net.fpp.common.starling.module.AModuleView;

	import starling.display.Image;
	import starling.display.Sprite;

	import net.fpp.starlingtowerdefense.game.module.unit.view.constant.CUnitAnimation;
	import net.fpp.starlingtowerdefense.game.module.unit.view.constant.CUnitBones;
	import net.fpp.starlingtowerdefense.game.module.unit.view.constant.CUnitSkins;
	import net.fpp.starlingtowerdefense.game.service.animatedgraphic.DragonBonesGraphicService;

	public class UnitModuleView extends AModuleView
	{
		private var _dragonBonesGraphicService:DragonBonesGraphicService;

		private var armature:Armature;
		private var armatureClip:Sprite;

		public function UnitModuleView()
		{
		}

		public function setDragonBonesGraphicService( dragonBonesGraphicService:DragonBonesGraphicService ):void
		{
			this._dragonBonesGraphicService = dragonBonesGraphicService;
		}

		public function attack():void
		{
			this.armature.animation.gotoAndPlay( CUnitAnimation.ATTACK, 0, 0 );
			this.armature.addEventListener( AnimationEvent.COMPLETE, this.aramtureEventHandler );
		}

		public function run():void
		{
			this.armature.animation.gotoAndPlay( CUnitAnimation.RUN, 0, 0 );
		}

		public function idle():void
		{
			this.armature.animation.gotoAndPlay( CUnitAnimation.IDLE, 0, 0 );
		}

		public function changeSkin( type:int ):void
		{
			this.setHairSkin( CUnitSkins.WARRIOR_HAIRS[type] );
			this.setWeaponSkin( CUnitSkins.WARRIOR_WEAPONS[type] );
			this.setHeadSkin( CUnitSkins.WARRIOR_HEADS[type] );
		}

		private function setHeadSkin( name:String ):void
		{
			var newHead:Image = this._dragonBonesGraphicService.getTextureDisplay( name ) as Image;

			var bone:Bone = this.armature.getBone( CUnitBones.HEAD );
			bone.display.dispose();
			bone.display = newHead;
		}

		private function setHairSkin( name:String ):void
		{
			var newHair:Image = this._dragonBonesGraphicService.getTextureDisplay( name ) as Image;

			var bone:Bone = this.armature.getBone( CUnitBones.HAIR );
			bone.display.dispose();
			bone.display = newHair;
		}

		private function setWeaponSkin( name:String ):void
		{
			var newHair:Image = this._dragonBonesGraphicService.getTextureDisplay( name ) as Image;

			var bone:Bone = this.armature.getBone( CUnitBones.WEAPON );
			bone.display.dispose();
			bone.display = newHair;
		}

		override protected function onInit():void
		{
			this.armature = this._dragonBonesGraphicService.buildArmature( 'Warrior' );
			this.armatureClip = this.armature.display as Sprite;

			WorldClock.clock.add( this.armature );

			this.addChild( this.armatureClip );
			this.armatureClip.scaleX = this.armatureClip.scaleY = .75;

			this.idle();

			this.setHeadSkin( CUnitSkins.WARRIOR_HEAD_2 );
			this.setHairSkin( '' );
		}

		private function aramtureEventHandler( e:AnimationEvent ):void
		{
			this.armature.removeEventListener( AnimationEvent.COMPLETE, aramtureEventHandler );

			this.idle();
		}
	}
}