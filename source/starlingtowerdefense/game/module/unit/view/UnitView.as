/**
 * Created by newkrok on 07/01/16.
 */
package starlingtowerdefense.game.module.unit.view
{
	import dragonBones.Armature;
	import dragonBones.Bone;
	import dragonBones.animation.WorldClock;
	import dragonBones.events.AnimationEvent;

	import net.fpp.starling.module.AView;

	import starling.display.Image;

	import starling.display.Sprite;

	import starlingtowerdefense.game.module.unit.view.constant.CUnitAnimation;
	import starlingtowerdefense.game.module.unit.view.constant.CUnitBones;
	import starlingtowerdefense.game.module.unit.view.constant.CUnitSkins;

	import starlingtowerdefense.game.service.animatedgraphic.DragonBonesGraphicService;

	public class UnitView extends AView
	{
		private var _dragonBonesGraphicService:DragonBonesGraphicService;

		private var armature:Armature;
		private var armatureClip:Sprite;

		public function UnitView( dragonBonesGraphicService:DragonBonesGraphicService )
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

		public function changeSkin():void
		{
			this.setHairSkin( CUnitSkins.WARRIOR_HAIRS[ Math.floor( Math.random() * CUnitSkins.WARRIOR_HAIRS.length ) ] );
			this.setWeaponSkin( CUnitSkins.WARRIOR_WEAPONS[ Math.floor( Math.random() * CUnitSkins.WARRIOR_WEAPONS.length ) ] );
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

			this.addChild( armatureClip );
			this.idle();
		}

		private function aramtureEventHandler( e:AnimationEvent ):void
		{
			this.armature.removeEventListener( AnimationEvent.COMPLETE, aramtureEventHandler );

			this.idle();
		}
	}
}