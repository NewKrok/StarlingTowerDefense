/**
 * Created by newkrok on 07/01/16.
 */
package starlingtowerdefense.game.module.unit.view
{
	import dragonBones.Armature;
	import dragonBones.animation.WorldClock;
	import dragonBones.events.AnimationEvent;

	import net.fpp.starling.module.AView;

	import starling.display.Sprite;

	import starlingtowerdefense.game.module.unit.view.constant.CUnitAnimation;

	import starlingtowerdefense.game.service.animatedgraphic.AnimatedGraphicService;

	public class UnitView extends AView
	{
		private var _animatedGraphicService:AnimatedGraphicService;

		private var armature:Armature;
		private var armatureClip:Sprite;

		public function UnitView( animatedGraphicService:AnimatedGraphicService )
		{
			this._animatedGraphicService = animatedGraphicService;
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

		override protected function onInit():void
		{
			this.armature = this._animatedGraphicService.buildArmature( 'Warrior' );
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