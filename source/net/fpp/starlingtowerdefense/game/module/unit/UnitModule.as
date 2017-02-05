/**
 * Created by newkrok on 07/01/16.
 */
package net.fpp.starlingtowerdefense.game.module.unit
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;

	import net.fpp.common.geom.SimplePoint;
	import net.fpp.common.starling.module.AModule;
	import net.fpp.common.util.pathfinding.vo.PathVO;
	import net.fpp.starlingtowerdefense.game.module.pathfinder.IPathFinderModule;
	import net.fpp.starlingtowerdefense.game.module.projectilemanager.IProjectileManagerModule;
	import net.fpp.starlingtowerdefense.game.module.projectilemanager.vo.ProjectileVO;
	import net.fpp.starlingtowerdefense.game.module.unit.events.UnitModuleEvent;
	import net.fpp.starlingtowerdefense.game.module.unit.view.UnitModuleView;
	import net.fpp.starlingtowerdefense.game.module.unit.vo.UnitConfigVO;
	import net.fpp.starlingtowerdefense.game.service.animatedgraphic.DragonBonesGraphicService;
	import net.fpp.starlingtowerdefense.game.util.DamageCalculatorUtil;

	public class UnitModule extends AModule implements IUnitModule
	{
		[Inject]
		public var projectileManagerModule:IProjectileManagerModule;

		[Inject]
		public var pathFinderModule:IPathFinderModule;

		[Inject]
		public var _dragonBonesGraphicService:DragonBonesGraphicService;

		private var _unitView:UnitModuleView;
		private var _unitModel:UnitModel;

		private var _isMoving:Boolean;
		private var _isAttackMoveToInProgress:Boolean;

		private var _pathVO:PathVO;
		private var _pathIndex:int;

		private static var staticInstanceId:int = 0;
		private var _instanceId:int = staticInstanceId++;

		public function UnitModule():void
		{
			this._unitModel = this.createModel( UnitModel ) as UnitModel;
		}

		public function init():void
		{
			this._unitView = this.createModuleView( UnitModuleView ) as UnitModuleView;
		}

		public function reset():void
		{
			TweenLite.killTweensOf( _unitView );
			TweenLite.killTweensOf( this );

			_isMoving = false;
			_isAttackMoveToInProgress = false;

			_pathIndex = 0;
			_pathVO = null;

			_unitView.x = 0;
			_unitView.y = 0;
			_unitView.alpha = 1;

			_unitModel.setDirection( 1 );

			processUnitConfigVO( _unitModel.getUnitConfigVO() );
		}

		override public function onInited():void
		{
			this._unitView.setDragonBonesGraphicService( this._dragonBonesGraphicService );
		}

		public function onUpdate():void
		{
			if( !this.getIsDead() )
			{
				this._unitModel.regenerateLifeAndMana();
			}
		}

		public function getUpdateFrequency():int
		{
			return 500;
		}

		public function setUnitConfigVO( value:UnitConfigVO ):void
		{
			this.processUnitConfigVO( value );
		}

		private function processUnitConfigVO( unitConfigVO:UnitConfigVO ):void
		{
			this._unitModel.setUnitConfigVO( unitConfigVO );

			this._unitModel.setLife( unitConfigVO.maxLife );
			this._unitModel.setMana( unitConfigVO.maxMana );
		}

		public function attackMoveTo( pathVO:PathVO ):void
		{
			this.moveTo( pathVO );

			this._isAttackMoveToInProgress = true;
		}

		public function moveTo( pathVO:PathVO ):void
		{
			this._isAttackMoveToInProgress = false;

			this.removeTarget();

			if ( pathVO.path )
			{
				this._pathVO = pathVO;

				this._isMoving = true;

				this._pathIndex = 0;

				this.runNextPathData();
				this._unitView.run();
			}
		}

		private function runNextPathData():void
		{
			this.move( this._pathVO.path[ this._pathIndex ] );

			this._pathIndex++;
		}

		private function move( position:SimplePoint ):void
		{
			if( position.x == this._unitView.x && position.y == this._unitView.y )
			{
				return;
			}

			if( this._unitView.x != position.x )
			{
				this._unitModel.setDirection( this.calculateScaleByEndX( position.x ) )
				this._unitView.setDirection( this._unitModel.getDirection() );
			}

			TweenLite.killTweensOf( this._unitView );

			TweenLite.to( this._unitView, this.calculateMoveTimeByEndPosition( position.x, position.y ), {
				x: position.x,
				y: position.y,
				ease: Linear.easeNone,
				onComplete: this.onMoveEnd
			} );
		}

		private function calculateScaleByEndX( x:Number ):Number
		{
			return this._unitView.x > x ? -1 : 1;
		}

		private function calculateMoveTimeByEndPosition( x:Number, y:Number ):Number
		{
			var distanceX:Number = this._view.x - x;
			var distanceY:Number = this._view.y - y;

			var distance:Number = Math.sqrt( Math.pow( distanceX, 2 ) + Math.pow( distanceY, 2 ) );

			return distance / this._unitModel.getUnitConfigVO().movementSpeed;
		}

		private function onMoveEnd():void
		{
			if( this._pathVO && this._pathVO.path )
			{
				if( this._pathIndex == this._pathVO.path.length )
				{
					this.clearRouteData();
					this._isMoving = false;
					this._unitView.idle();
				}
				else if( !this._unitModel.getTarget() )
				{
					this.runNextPathData();
				}
			}
			else if( this._unitModel.getTarget() )
			{
				this._unitView.idle();

				this._unitModel.setDirection( this.calculateScaleByEndX( this._unitModel.getTarget().getView().x ) )
				this._unitView.setDirection( this._unitModel.getDirection() );
			}
			else if( this._unitModel.getLastPositionBeforeFight() )
			{
				if( this._unitModel.getLastPositionBeforeFight().x == this._view.x && this._unitModel.getLastPositionBeforeFight().y == this._view.y )
				{
					this._unitModel.setLastPositionBeforeFight( null );
					this._unitView.idle();
				}
				else
				{
					this.moveLastPositionAfterFight();
				}
			}
			else
			{
				this._isAttackMoveToInProgress = false;
				this._unitView.idle();
			}
		}

		private function clearRouteData():void
		{
			if( this._pathVO && this._pathVO.path )
			{
				this._pathVO.path.length = 0;
				this._pathVO.path = null;
				this._pathVO = null;

				this._pathIndex = 0;
			}
		}

		public function setPosition( x:Number, y:Number ):void
		{
			this._unitView.x = x;
			this._unitView.y = y;

			if( this._isMoving && !this._unitModel.getTarget() )
			{
				TweenLite.killTweensOf( this._unitView );

				if( this._pathIndex > 0 )
				{
					this._pathIndex--;
				}

				this.runNextPathData();
			}
		}

		public function getPosition():SimplePoint
		{
			return new SimplePoint( this._unitView.x, this._unitView.y );
		}

		public function attack():void
		{
			TweenLite.killTweensOf( this._unitView );

			var now:Number = new Date().time;

			if( new Date().time - this._unitModel.getLastAttackTime() > this._unitModel.getUnitConfigVO().attackSpeed * 1000 )
			{
				this._unitModel.setLastAttackTime( now );

				this._unitView.setDirection( this.calculateScaleByEndX( this._unitModel.getTarget().getView().x ) );

				this._unitView.attack();

				this._unitModel.damageDelayTween = TweenLite.delayedCall( this._unitModel.getUnitConfigVO().attackActionDelay, runAttackAction )
			}
		}

		private function runAttackAction():void
		{
			if( this._unitModel.getTarget() )
			{
				if( this._unitModel.getUnitConfigVO().projectileConfigVO )
				{
					this.projectileAttackRutin();
				}
				else
				{
					this.meleeAttackRutin();
				}
			}
		}

		private function projectileAttackRutin():void
		{
			var projectileVO:ProjectileVO = new ProjectileVO();
			projectileVO.projectileConfigVO = this._unitModel.getUnitConfigVO().projectileConfigVO;
			projectileVO.owner = this;
			projectileVO.target = this.getTarget();

			this.projectileManagerModule.addProjectile( projectileVO );
		}

		private function meleeAttackRutin():void
		{
			this._unitModel.getTarget().damage( DamageCalculatorUtil.calculateDamage( this, this.getTarget() ) );

			if( this._unitModel.getTarget().getIsDead() )
			{
				this.removeTarget();
			}
		}

		public function damage( value:Number ):void
		{
			this._unitModel.setLife( Math.max( this._unitModel.getLife() - value, 0 ) );

			if( this._unitModel.getLife() == 0 )
			{
				this.die();
			}
		}

		private function die():void
		{
			TweenLite.killTweensOf( this._unitView );
			TweenLite.killTweensOf( this );

			TweenLite.to( this._unitView, 1, {alpha: 0, onComplete: onDiedHandler} );

			this.clearRouteData();
			this.removeTarget();
		}

		private function onDiedHandler():void
		{
			this.dispatchEvent( new UnitModuleEvent( UnitModuleEvent.UNIT_DIED ) );
		}

		public function getIsDead():Boolean
		{
			return this._unitModel.getLife() == 0;
		}

		public function changeSkin( type:int ):void
		{
			this._unitView.changeSkin( type );
		}

		public function getSizeRadius():Number
		{
			return this._unitModel.getUnitConfigVO().sizeRadius
		}

		public function getTarget():IUnitModule
		{
			return this._unitModel.getTarget();
		}

		public function setTarget( value:IUnitModule ):void
		{
			this._unitModel.setTarget( value );

			var distance:Number = Math.sqrt(
					Math.pow( this._view.x - value.getView().x, 2 ) +
					Math.pow( this._view.y - value.getView().y, 2 )
			);

			if( distance > this._unitModel.getUnitConfigVO().attackRadius )
			{
				if( this._unitModel.damageDelayTween )
				{
					this._unitModel.damageDelayTween.kill();
				}

				if( !this._unitModel.getLastPositionBeforeFight() )
				{
					this._unitModel.setLastPositionBeforeFight( new SimplePoint( this._view.x, this._view.y ) );
				}

				this._unitView.run();

				moveTo( pathFinderModule.getPath( getPosition(), _unitModel.getTarget().getPosition() ) );
			}
		}

		public function removeTarget():void
		{
			if( this._unitModel.damageDelayTween )
			{
				this._unitModel.damageDelayTween.kill();
			}

			this._unitModel.setTarget( null );

			if( this._pathVO && this._pathVO.path && this._pathVO.path.length > 0 && ( this._pathIndex != this._pathVO.path.length || this._isAttackMoveToInProgress ) )
			{
				if( this._pathIndex > 0 )
				{
					this._pathIndex--;
				}

				this._unitView.run();
				this.runNextPathData();
			}
		}

		private function moveLastPositionAfterFight():void
		{
			_unitView.run();
			moveTo( pathFinderModule.getPath( getPosition(), _unitModel.getLastPositionBeforeFight() ) );
		}

		public function getPlayerGroup():String
		{
			return _unitModel.getPlayerGroup();
		}

		public function setPlayerGroup( value:String ):void
		{
			_unitModel.setPlayerGroup( value );
		}

		public function getIsAttackMoveToInProgress():Boolean
		{
			return this._isAttackMoveToInProgress;
		}

		public function getIsMoving():Boolean
		{
			return this._isMoving;
		}

		public function getArmorType():String
		{
			return this._unitModel.getUnitConfigVO().armorType
		}

		public function getAttackRadius():Number
		{
			return this._unitModel.getUnitConfigVO().attackRadius;
		}

		public function getUnitDetectionRadius():Number
		{
			return this._unitModel.getUnitConfigVO().unitDetectionRadius;
		}

		public function getDirection():Number
		{
			return this._unitModel.getDirection();
		}

		public function getUnitHeight():Number
		{
			return this._unitModel.getUnitConfigVO().unitHeight;
		}

		public function getUnitConfigVO():UnitConfigVO
		{
			return this._unitModel.getUnitConfigVO();
		}

		override public function dispose():void
		{
			super.dispose();
		}

		public function getInstanceId():int
		{
			return this._instanceId;
		}
	}
}