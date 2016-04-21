/**
 * Created by newkrok on 07/01/16.
 */
package starlingtowerdefense.game.module.unit
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;

	import net.fpp.geom.SimplePoint;
	import net.fpp.starling.module.AModule;

	import starlingtowerdefense.game.module.helper.DamageCalculator;

	import starlingtowerdefense.game.module.unit.events.UnitModuleEvent;

	import starlingtowerdefense.game.module.unit.view.UnitModuleView;
	import starlingtowerdefense.game.module.unit.vo.UnitConfigVO;
	import starlingtowerdefense.game.service.animatedgraphic.DragonBonesGraphicService;
	import starlingtowerdefense.game.service.pathfinder.vo.RouteVO;

	public class UnitModule extends AModule implements IUnitModule
	{
		private var _unitView:UnitModuleView;
		private var _unitModel:UnitModel;

		private var _damageCalculator:DamageCalculator;

		private var _routeVO:RouteVO;
		private var _routeIndex:int;
		private var _isMoving:Boolean;

		public function UnitModule( unitConfigVO:UnitConfigVO, damageCalculator:DamageCalculator, dragonBonesGraphicService:DragonBonesGraphicService ):void
		{
			this._unitModel = this.createModel( UnitModel ) as UnitModel;

			this.processUnitConfigVO( unitConfigVO );
			this._damageCalculator = damageCalculator;

			this._unitView = this.createView( UnitModuleView ) as UnitModuleView;
			this._unitView.setDragonBonesGraphicService( dragonBonesGraphicService );
		}

		private function processUnitConfigVO( unitConfigVO:UnitConfigVO ):void
		{
			this._unitModel.setAttackSpeed( unitConfigVO.attackSpeed );
			this._unitModel.setDamageDelay( unitConfigVO.damageDelay );
			this._unitModel.setMaxDamage( unitConfigVO.maxDamage );
			this._unitModel.setMaxLife( unitConfigVO.maxLife );
			this._unitModel.setLife( unitConfigVO.maxLife );
			this._unitModel.setMinDamage( unitConfigVO.minDamage );
			this._unitModel.setMovementSpeed( unitConfigVO.movementSpeed );
			this._unitModel.setSizeRadius( unitConfigVO.sizeRadius );
			this._unitModel.setAreaDamage( unitConfigVO.areaDamage );
			this._unitModel.setAreaDamageSize( unitConfigVO.areaDamageSize );
			this._unitModel.setArmor( unitConfigVO.armor );
			this._unitModel.setArmorType( unitConfigVO.armorType );
			this._unitModel.setAttackRadius( unitConfigVO.attackRadius );
			this._unitModel.setAttackType( unitConfigVO.attackType );
			this._unitModel.setBlockChance( unitConfigVO.blockChance );
			this._unitModel.setCriticalHitChance( unitConfigVO.criticalHitChance );
			this._unitModel.setCriticalHitDamageMultiple( unitConfigVO.criticalHitDamageMultiple );
			this._unitModel.setLifeRegeneration( unitConfigVO.lifeRegeneration );
			this._unitModel.setUnitDetectionRadius( unitConfigVO.unitDetectionRadius );
		}

		public function moveTo( routeVO:RouteVO ):void
		{
			this._isMoving = true;

			this._routeIndex = 0;
			this._routeVO = routeVO;

			this.runNextRouteData();
			this._unitView.run();
		}

		private function runNextRouteData():void
		{
			this.move( this._routeVO.route[ this._routeIndex ] );

			this._routeIndex++;
		}

		private function move( position:SimplePoint ):void
		{
			if( position.x == this._unitView.x && position.y == this._unitView.y )
			{
				return;
			}

			if( this._unitView.x != position.x )
			{
				this._unitView.scaleX = this.calculateScaleByEndX( position.x );
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

			return distance / this._unitModel.getMovementSpeed();
		}

		private function onMoveEnd():void
		{
			if( this._routeVO && this._routeVO.route )
			{
				if( this._routeIndex == this._routeVO.route.length )
				{
					this.clearRouteData();
					this._isMoving = false;
					this._unitView.idle();
				}
				else if( !this._unitModel.getTarget() )
				{
					this.runNextRouteData();
				}
			}
			else if( this._unitModel.getTarget() )
			{
				this._unitView.idle();

				this._unitView.scaleX = this.calculateScaleByEndX( this._unitModel.getTarget().getView().x );
			}
		}

		private function clearRouteData():void
		{
			if( this._routeVO && this._routeVO.route )
			{
				this._routeVO.route.length = 0;
				this._routeVO.route = null;
				this._routeVO = null;

				this._routeIndex = 0;
			}
		}

		public function setPosition( x:Number, y:Number ):void
		{
			this._unitView.x = x;
			this._unitView.y = y;

			if( this._isMoving && !this._unitModel.getTarget() )
			{
				TweenLite.killTweensOf( this._unitView );

				if( this._routeIndex > 0 )
				{
					this._routeIndex--;
				}

				this.runNextRouteData();
			}
		}

		public function attack():void
		{
			TweenLite.killTweensOf( this._unitView );

			var now:Number = new Date().time;

			if( new Date().time - this._unitModel.getLastAttackTime() > this._unitModel.getAttackSpeed() * 1000 )
			{
				this._unitModel.setLastAttackTime( now );

				this._unitView.scaleX = this.calculateScaleByEndX( this._unitModel.getTarget().getView().x );

				this._unitView.attack();

				TweenLite.delayedCall( this._unitModel.getDamageDelay(), damageTarget )
			}
		}

		private function damageTarget():void
		{
			if( this._unitModel.getTarget() )
			{
				this._unitModel.getTarget().damage( this.calculateDamage() );

				if( this._unitModel.getTarget().getIsDead() )
				{
					this.removeTarget();
				}
			}
		}

		private function calculateDamage():Number
		{
			var damageValue:Number = this._damageCalculator.getAttackByMinAndMax( this._unitModel.getMinDamage(), this._unitModel.getMaxDamage() );

			if( this._unitModel.getCriticalHitChance() > Math.random() )
			{
				damageValue *= this._unitModel.getCriticalHitDamageMultiple();
			}

			damageValue = this._damageCalculator.calculateDamageByAttackAndArmorType( damageValue, this._unitModel.getAttackType(), this._unitModel.getTarget().getArmorType() );

			return damageValue;
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
			return this._unitModel.getSizeRadius();
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

			if( distance > this._unitModel.getAttackRadius() )
			{
				this._unitView.run();
				this.move( new SimplePoint( this._unitModel.getTarget().getView().x, this._unitModel.getTarget().getView().y ) );
			}
		}

		public function removeTarget():void
		{
			this._unitModel.setTarget( null );

			if( this._routeVO && this._routeVO.route && this._routeVO.route.length > 0 && this._routeIndex != this._routeVO.route.length )
			{
				if( this._routeIndex > 0 )
				{
					this._routeIndex--;
				}

				this._unitView.run();
				this.runNextRouteData();
			}
		}

		public function getPlayerGroup():String
		{
			return this._unitModel.getPlayerGroup();
		}

		public function setPlayerGroup( value:String ):void
		{
			this._unitModel.setPlayerGroup( value );
		}

		public function getIsMoving():Boolean
		{
			return this._isMoving;
		}

		public function getArmorType():String
		{
			return this._unitModel.getArmorType();
		}

		public function getAttackRadius():Number
		{
			return this._unitModel.getAttackRadius();
		}

		public function getUnitDetectionRadius():Number
		{
			return this._unitModel.getUnitDetectionRadius();
		}
	}
}