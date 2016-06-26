/**
 * Created by newkrok on 07/01/16.
 */
package net.fpp.starlingtowerdefense.game.module.unit.view
{
	import dragonBones.Armature;
	import dragonBones.Bone;
	import dragonBones.animation.WorldClock;
	import dragonBones.events.AnimationEvent;

	import net.fpp.common.geom.SimplePoint;

	import net.fpp.common.starling.display.VUIBox;

	import net.fpp.common.starling.module.AModel;

	import net.fpp.common.starling.module.AModuleView;
	import net.fpp.starlingtowerdefense.constant.CColor;
	import net.fpp.starlingtowerdefense.game.module.linebar.ILineBarModule;
	import net.fpp.starlingtowerdefense.game.module.linebar.LineBarModule;
	import net.fpp.starlingtowerdefense.game.module.unit.UnitModel;
	import net.fpp.starlingtowerdefense.game.module.unit.events.UnitModelEvent;

	import starling.display.DisplayObject;

	import starling.display.Image;
	import starling.display.Sprite;

	import net.fpp.starlingtowerdefense.game.module.unit.view.constant.CUnitAnimation;
	import net.fpp.starlingtowerdefense.game.module.unit.view.constant.CUnitBones;
	import net.fpp.starlingtowerdefense.game.module.unit.view.constant.CUnitSkins;
	import net.fpp.starlingtowerdefense.game.service.animatedgraphic.DragonBonesGraphicService;

	public class UnitModuleView extends AModuleView
	{
		private const LINE_BAR_HEIGHT:Number = 5;
		private const LINE_BAR_GAP:Number = 2;
		private const LINE_BAR_BACKGROUND_ALPHA:Number = 0.8;

		private var _dragonBonesGraphicService:DragonBonesGraphicService;

		private var _unitBarContainer:VUIBox;
		private var _lifeBar:ILineBarModule;
		private var _manaBar:ILineBarModule;

		private var _unitModel:UnitModel;

		private var armature:Armature;
		private var armatureClip:Sprite;

		private var _currentAnimation:String;

		public function UnitModuleView()
		{
		}

		override public function setModel( model:AModel ):void
		{
			super.setModel( model );

			this._unitModel = model as UnitModel;
		}

		override protected function onInit():void
		{
			this.armature = this._dragonBonesGraphicService.buildArmature( 'Warrior' );
			this.armatureClip = this.armature.display as Sprite;

			WorldClock.clock.add( this.armature );

			this.addChild( this.armatureClip );

			this.createUnitBars();

			this.idle();
		}

		private function createUnitBars():void
		{
			this._unitBarContainer = new VUIBox();
			this._unitBarContainer.gap = LINE_BAR_GAP;

			this.createLifeBar();
			this.onLifeChangedHandler();

			if ( this._unitModel.getUnitConfigVO().maxMana > 0 )
			{
				this.createManaBar();
				this.onManaChangedHandler();
			}

			this._unitBarContainer.x = -this._unitBarContainer.width / 2;
			this._unitBarContainer.y = -this.height;

			this.addChild( this._unitBarContainer );
		}

		private function createLifeBar():void
		{
			this._lifeBar = new LineBarModule();

			var lifeBarView:DisplayObject = this._lifeBar.getView();

			this._lifeBar.setViewSize( new SimplePoint( this._unitModel.getUnitConfigVO().sizeRadius * 2, this.LINE_BAR_HEIGHT ) );
			this._lifeBar.setBackgroundAlpha( this.LINE_BAR_BACKGROUND_ALPHA );
			this._lifeBar.setLineColor( CColor.LIFE_BAR_COLOR );

			this._unitModel.addEventListener( UnitModelEvent.LIFE_CHANGED, onLifeChangedHandler );

			this._unitBarContainer.addChild( lifeBarView );
		}

		private function onLifeChangedHandler( e:UnitModelEvent = null ):void
		{
			this._lifeBar.setPercentage( this._unitModel.getLifePercentage() );
		}

		private function createManaBar():void
		{
			this._manaBar = new LineBarModule();

			var manaBarView:DisplayObject = this._manaBar.getView();

			this._manaBar.setViewSize( new SimplePoint( this._unitModel.getUnitConfigVO().sizeRadius * 2, this.LINE_BAR_HEIGHT ) );
			this._manaBar.setBackgroundAlpha( this.LINE_BAR_BACKGROUND_ALPHA );
			this._manaBar.setLineColor( CColor.MANA_BAR_COLOR );

			this._unitModel.addEventListener( UnitModelEvent.MANA_CHANGED, onManaChangedHandler );

			this._unitBarContainer.addChild( manaBarView );
		}

		private function onManaChangedHandler( e:UnitModelEvent = null ):void
		{
			this._manaBar.setPercentage( this._unitModel.getManaPercentage() );
		}

		public function setDragonBonesGraphicService( dragonBonesGraphicService:DragonBonesGraphicService ):void
		{
			this._dragonBonesGraphicService = dragonBonesGraphicService;
		}

		public function setDirection( value:Number ):void
		{
			this.armatureClip.scaleX = value;
		}

		public function attack():void
		{
			if ( this._currentAnimation == CUnitAnimation.ATTACK )
			{
				return;
			}

			this._currentAnimation = CUnitAnimation.ATTACK;

			this.armature.animation.gotoAndPlay( CUnitAnimation.ATTACK, 0, 0 );
			this.armature.addEventListener( AnimationEvent.COMPLETE, this.aramtureEventHandler );
		}

		public function run():void
		{
			if ( this._currentAnimation == CUnitAnimation.RUN )
			{
				return;
			}

			this._currentAnimation = CUnitAnimation.RUN;

			this.armature.animation.gotoAndPlay( CUnitAnimation.RUN, 0, 0 );
		}

		public function idle():void
		{
			if ( this._currentAnimation == CUnitAnimation.IDLE )
			{
				return;
			}

			this._currentAnimation = CUnitAnimation.IDLE;

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

		private function aramtureEventHandler( e:AnimationEvent ):void
		{
			this._currentAnimation = '';

			this.armature.removeEventListener( AnimationEvent.COMPLETE, aramtureEventHandler );

			this.idle();
		}

		override public function dispose():void
		{
			this._unitModel.removeEventListener( UnitModelEvent.LIFE_CHANGED, onLifeChangedHandler );

			this._lifeBar.dispose();
			this._lifeBar = null;

			super.dispose();
		}
	}
}