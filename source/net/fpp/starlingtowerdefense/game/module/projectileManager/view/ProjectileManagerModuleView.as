/**
 * Created by newkrok on 26/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.projectilemanager.view
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;

	import net.fpp.common.geom.SimplePoint;
	import net.fpp.common.starling.module.AModel;
	import net.fpp.common.starling.module.AModuleView;
	import net.fpp.common.util.GeomUtil;
	import net.fpp.common.util.objectpool.IObjectPool;
	import net.fpp.common.util.objectpool.ObjectPool;
	import net.fpp.common.util.objectpool.ObjectPoolSettingVO;
	import net.fpp.starlingtowerdefense.game.module.projectilemanager.ProjectileManagerModel;
	import net.fpp.starlingtowerdefense.game.module.projectilemanager.events.ProjectileManagerModelEvent;
	import net.fpp.starlingtowerdefense.game.module.projectilemanager.factory.ProjectileViewFactory;
	import net.fpp.starlingtowerdefense.game.module.projectilemanager.vo.ProjectileVO;
	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;
	import net.fpp.starlingtowerdefense.game.util.DamageCalculatorUtil;

	public class ProjectileManagerModuleView extends AModuleView
	{
		private var _projectileManagerModel:ProjectileManagerModel;

		private var _projectileViews:Vector.<ProjectileView> = new <ProjectileView>[];

		private var _projectileViewObjectPool:IObjectPool;

		public function ProjectileManagerModuleView()
		{
			var projectileViewObjectPoolSettingVO:ObjectPoolSettingVO = new ObjectPoolSettingVO();
			projectileViewObjectPoolSettingVO.objectPoolFactory = new ProjectileViewFactory();
			projectileViewObjectPoolSettingVO.poolSize = 30;
			projectileViewObjectPoolSettingVO.increaseCount = 10;
			projectileViewObjectPoolSettingVO.isDynamicPool = true;

			this._projectileViewObjectPool = new ObjectPool( projectileViewObjectPoolSettingVO );
		}

		override public function setModel( model:AModel ):void
		{
			this._projectileManagerModel = model as ProjectileManagerModel;
			this._projectileManagerModel.addEventListener( ProjectileManagerModelEvent.PROJECTILE_ADDED, this.onProjectileAddedHandler );

			super.setModel( model );
		}

		private function onProjectileAddedHandler( e:ProjectileManagerModelEvent ):void
		{
			var projectileVO:ProjectileVO = e.projectileVO;

			var owner:IUnitModule = projectileVO.owner;
			var ownerPoint:SimplePoint = new SimplePoint(
					owner.getView().x + owner.getDirection() * projectileVO.projectileConfigVO.startPointOffset.x,
					owner.getView().y + projectileVO.projectileConfigVO.startPointOffset.y
			);

			var projectileView:ProjectileView = this._projectileViewObjectPool.getObject() as ProjectileView;
			projectileView.setSkin( projectileVO.projectileConfigVO.skinId );
			projectileView.x = ownerPoint.x;
			projectileView.y = ownerPoint.y;

			var target:IUnitModule = projectileVO.target;
			var targetPoint:SimplePoint = new SimplePoint(
					target.getView().x + target.getSizeRadius(),
					target.getView().y - target.getUnitHeight() / 2
			);

			var distance:Number = GeomUtil.simplePointDistance( ownerPoint, targetPoint );

			if( projectileVO.projectileConfigVO.projectileArcHeight != 0 )
			{
				var angle:Number = GeomUtil.simplePointAngle( ownerPoint, targetPoint );

				var archHeight:Number = ( distance / owner.getUnitConfigVO().attackRadius ) * projectileVO.projectileConfigVO.projectileArcHeight;
				var bezierControlPoint:SimplePoint = new SimplePoint(
						ownerPoint.x + distance / 2 * Math.cos( angle ),
						ownerPoint.y + distance / 2 * Math.sin( angle ) - archHeight
				);

				TweenLite.to( projectileView, distance / projectileVO.projectileConfigVO.speed, {
					ease: Linear.easeNone,
					bezier: {
						values: [
							{x: projectileView.x, y: projectileView.y},
							{x: bezierControlPoint.x, y: bezierControlPoint.y},
							{x: targetPoint.x, y: targetPoint.y}
						],
						autoRotate: [ "x", "y", "rotation", 0, true ]
					},
					onComplete: this.handleProjectileFinished,
					onCompleteParams: [ projectileVO, projectileView ]
				} );
			}
			else
			{
				TweenLite.to( projectileView, distance / projectileVO.projectileConfigVO.speed, {
					ease: Linear.easeNone,
					x: targetPoint.x,
					y: targetPoint.y,
					onComplete: this.handleProjectileFinished,
					onCompleteParams: [ projectileVO, projectileView ]
				} );
			}

			this.addChild( projectileView );

			this._projectileViews.push( projectileView );
		}

		private function handleProjectileFinished( projectileVO:ProjectileVO, projectileView:ProjectileView ):void
		{
			var target:IUnitModule = projectileVO.target;
			if( target )
			{
				target.damage( DamageCalculatorUtil.calculateDamage( projectileVO.owner, target ) );
			}

			for( var i:int = 0; i < this._projectileViews.length; i++ )
			{
				if( this._projectileViews[ i ] == projectileView )
				{
					this._projectileViews.splice( i, 1 );
					break;
				}
			}

			projectileView.removeFromParent( true );

			this._projectileManagerModel.removeProjectile( projectileVO );
		}

		override public function dispose():void
		{
			this._projectileManagerModel.removeEventListener( ProjectileManagerModelEvent.PROJECTILE_ADDED, this.onProjectileAddedHandler );
			this._projectileManagerModel = null;

			this._projectileViewObjectPool.dispose();
			this._projectileViewObjectPool = null;

			super.dispose();
		}
	}
}