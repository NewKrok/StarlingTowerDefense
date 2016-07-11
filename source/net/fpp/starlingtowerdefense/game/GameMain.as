/**
 * Created by newkrok on 07/01/16.
 */
package net.fpp.starlingtowerdefense.game
{
	import assets.GameAssets;
	import assets.TerrainTextures;

	import com.greensock.TweenLite;
	import com.greensock.plugins.BezierPlugin;
	import com.greensock.plugins.TweenPlugin;

	import dragonBones.animation.WorldClock;

	import net.fpp.common.geom.SimplePoint;
	import net.fpp.common.starling.StaticAssetManager;
	import net.fpp.common.starling.module.AApplicationContext;
	import net.fpp.common.util.GeomUtil;
	import net.fpp.common.util.jsonbitmapatlas.JSONBitmapAtlas;
	import net.fpp.common.util.jsonbitmapatlas.vo.BitmapDataVO;
	import net.fpp.common.util.objectpool.IObjectPool;
	import net.fpp.common.util.objectpool.ObjectPool;
	import net.fpp.common.util.objectpool.ObjectPoolSettingVO;
	import net.fpp.common.util.pathfinding.astar.AStarUtil;
	import net.fpp.common.util.pathfinding.astar.vo.AStarNodeVO;
	import net.fpp.common.util.pathfinding.astar.vo.AStarPathRequestVO;
	import net.fpp.common.util.pathfinding.vo.PathVO;
	import net.fpp.starlingtowerdefense.game.config.unit.ArcherUnitConfigVO;
	import net.fpp.starlingtowerdefense.game.config.unit.WarriorUnitConfigVO;
	import net.fpp.starlingtowerdefense.game.module.background.polygonbackground.IPolygonBackgroundModule;
	import net.fpp.starlingtowerdefense.game.module.background.polygonbackground.PolygonBackgroundModule;
	import net.fpp.starlingtowerdefense.game.module.background.rectanglebackground.RectangleBackgroundModule;
	import net.fpp.starlingtowerdefense.game.module.map.IMapModule;
	import net.fpp.starlingtowerdefense.game.module.map.MapModule;
	import net.fpp.starlingtowerdefense.game.module.map.constant.CMapSize;
	import net.fpp.starlingtowerdefense.game.module.projectileManager.IProjectileManagerModule;
	import net.fpp.starlingtowerdefense.game.module.projectileManager.ProjectileManagerModule;
	import net.fpp.starlingtowerdefense.game.module.touchdrag.ITouchDragModule;
	import net.fpp.starlingtowerdefense.game.module.touchdrag.TouchDragModule;
	import net.fpp.starlingtowerdefense.game.module.touchzoom.ITouchZoomModule;
	import net.fpp.starlingtowerdefense.game.module.touchzoom.TouchZoomModule;
	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;
	import net.fpp.starlingtowerdefense.game.module.unit.events.UnitModuleEvent;
	import net.fpp.starlingtowerdefense.game.module.unit.factory.UnitModuleFactory;
	import net.fpp.starlingtowerdefense.game.module.unit.vo.UnitConfigVO;
	import net.fpp.starlingtowerdefense.game.module.unitcontroller.IUnitControllerModule;
	import net.fpp.starlingtowerdefense.game.module.unitcontroller.UnitControllerModule;
	import net.fpp.starlingtowerdefense.game.module.unitcontroller.events.UnitControllerModuleEvent;
	import net.fpp.starlingtowerdefense.game.module.unitcontroller.request.UnitMoveToRequest;
	import net.fpp.starlingtowerdefense.game.module.unitdistancecalculator.IUnitDistanceCalculatorModule;
	import net.fpp.starlingtowerdefense.game.module.unitdistancecalculator.UnitDistanceCalculatorModule;
	import net.fpp.starlingtowerdefense.game.module.unitdistanceholder.IUnitDistanceHolderModule;
	import net.fpp.starlingtowerdefense.game.module.unitdistanceholder.UnitDistanceHolderModule;
	import net.fpp.starlingtowerdefense.game.module.unittargetmanager.IUnitTargetManagerModule;
	import net.fpp.starlingtowerdefense.game.module.unittargetmanager.UnitTargetManagerModule;
	import net.fpp.starlingtowerdefense.game.module.wavehandler.IWaveHandlerModule;
	import net.fpp.starlingtowerdefense.game.module.wavehandler.WaveHandlerModule;
	import net.fpp.starlingtowerdefense.game.module.zorder.IZOrderModule;
	import net.fpp.starlingtowerdefense.game.module.zorder.ZOrderModule;
	import net.fpp.starlingtowerdefense.game.service.animatedgraphic.DragonBonesGraphicService;
	import net.fpp.starlingtowerdefense.game.service.animatedgraphic.events.DragonBonesGraphicServiceEvent;
	import net.fpp.starlingtowerdefense.game.util.DamageCalculatorUtil;
	import net.fpp.starlingtowerdefense.game.util.MapPositionUtil;
	import net.fpp.starlingtowerdefense.vo.LevelDataVO;

	import starling.display.Quad;
	import starling.display.Sprite;

	public class GameMain extends AApplicationContext
	{
		private var _dragonBonesGraphicService:DragonBonesGraphicService;

		private var _rectangleBackgroundModule:RectangleBackgroundModule;
		private var _pathBackgroundModule:IPolygonBackgroundModule;

		private var _mapModule:IMapModule;
		private var _unitControllerModule:IUnitControllerModule;
		private var _zOrderModule:IZOrderModule;
		private var _unitDistanceCalculatorModule:IUnitDistanceCalculatorModule;
		private var _unitDistanceHolderModule:IUnitDistanceHolderModule;
		private var _unitTargetManagerModule:IUnitTargetManagerModule;
		private var _projectileManagerModule:IProjectileManagerModule;
		private var _waveHandlerModule:IWaveHandlerModule;
		private var _touchZoomModule:ITouchZoomModule;
		private var _touchDragModule:ITouchDragModule;

		private var _units:Vector.<IUnitModule> = new <IUnitModule>[];

		private var _unitModuleObjectPool:IObjectPool;

		private var _levelDataVO:LevelDataVO;
		private var _viewContainer:Sprite;

		public function GameMain()
		{
			TweenPlugin.activate( [ BezierPlugin ] );
			DamageCalculatorUtil.setConfig();

			this.createUnitModuleObjectPool();

			this.configureInjector();

			this.loadDragonBonesGraphicAssets();
		}

		private function createUnitModuleObjectPool():void
		{
			var unitModuleObjectPoolSettingVO:ObjectPoolSettingVO = new ObjectPoolSettingVO();
			unitModuleObjectPoolSettingVO.objectPoolFactory = new UnitModuleFactory;
			unitModuleObjectPoolSettingVO.poolSize = 20;
			unitModuleObjectPoolSettingVO.increaseCount = 5;
			unitModuleObjectPoolSettingVO.isDynamicPool = true;

			this._unitModuleObjectPool = new ObjectPool( unitModuleObjectPoolSettingVO );
		}

		private function configureInjector():void
		{
			this._mapModule = new MapModule();
			this.injector.mapValue( IMapModule, this._mapModule );

			this._dragonBonesGraphicService = new DragonBonesGraphicService();
			this.injector.mapValue( DragonBonesGraphicService, this._dragonBonesGraphicService );
		}

		public function setLevelDataVO( value:LevelDataVO ):void
		{
			this._levelDataVO = value;
		}

		private function loadDragonBonesGraphicAssets():void
		{
			this._dragonBonesGraphicService.addEventListener( DragonBonesGraphicServiceEvent.COMPLETE, this.loadStarlingAssets );
		}

		private function loadStarlingAssets( e:DragonBonesGraphicServiceEvent ):void
		{
			StaticAssetManager.instance.enqueue( GameAssets );
			StaticAssetManager.instance.loadQueue( this.onAssetsLoadProgress );
		}

		private function onAssetsLoadProgress( ratio:Number ):void
		{
			if( ratio == 1 )
			{
				this.build();
			}
		}

		private function build():void
		{
			this._viewContainer = new Sprite();
			this.addChild( this._viewContainer );

			this.createBackgroundModules();

			this._unitControllerModule = this.createModule( UnitControllerModule ) as IUnitControllerModule;
			this._unitControllerModule.setGameContainer( this._viewContainer );
			this._unitControllerModule.addEventListener( UnitControllerModuleEvent.UNIT_MOVE_TO_REQUEST, this.unitMoveToRequest );
			this._viewContainer.addChild( this._unitControllerModule.getView() );

			this._zOrderModule = this.createModule( ZOrderModule ) as IZOrderModule;
			this._zOrderModule.setUnitContainer( this._viewContainer );

			this._unitDistanceCalculatorModule = this.createModule( UnitDistanceCalculatorModule ) as IUnitDistanceCalculatorModule;

			this._unitDistanceHolderModule = this.createModule( UnitDistanceHolderModule ) as IUnitDistanceHolderModule;
			this._unitDistanceHolderModule.setUnitDistanceCalculator( this._unitDistanceCalculatorModule );

			this._unitTargetManagerModule = this.createModule( UnitTargetManagerModule ) as IUnitTargetManagerModule;
			this._unitTargetManagerModule.setUnitDistanceCalculator( this._unitDistanceCalculatorModule );

			this._projectileManagerModule = this.createModule( ProjectileManagerModule ) as IProjectileManagerModule;
			this._viewContainer.addChild( this._projectileManagerModule.getView() );
			this.injector.mapValue( IProjectileManagerModule, this._projectileManagerModule );

			//this.createUnit( 300, 300, new HeroArcherUnitConfigVO() );
			//this._units[ this._units.length - 1 ].setPlayerGroup( '1' );
			//this._unitControllerModule.setTarget( this._units[ 0 ] );

			this._waveHandlerModule = this.createModule( WaveHandlerModule ) as IWaveHandlerModule;

			this._touchZoomModule = this.createModule( TouchZoomModule ) as ITouchZoomModule;
			this._touchZoomModule.setGameContainer( this._viewContainer );

			this._touchDragModule = this.createModule( TouchDragModule ) as ITouchDragModule;
			this._touchDragModule.setGameContainer( this._viewContainer );

			this.startUpdateHandling();

			this.drawDebugDatas();

			this.startTestWave();
		}

		private function startTestWave():void
		{
			TweenLite.delayedCall( 10, this.startTestWave );

			var pathVO1:PathVO = new PathVO();
			pathVO1.path = new <SimplePoint> [ new SimplePoint( 800, 300 ) ];
			this.createUnit( 100, 300 + Math.random() * 20, new ArcherUnitConfigVO() );
			this._units[ this._units.length - 1 ].setPlayerGroup( '1' );
			this._units[ this._units.length - 1 ].attackMoveTo( pathVO1 );
			/*
			 pathVO1 = new PathVO();
			 pathVO1.path = new <SimplePoint> [ new SimplePoint( 800, 300 ) ];
			 this.createUnit( 100, 300 + Math.random() * 20, new ArcherUnitConfigVO() );
			 this._units[ this._units.length - 1 ].setPlayerGroup( '1' );
			 this._units[ this._units.length - 1 ].attackMoveTo( pathVO1 );

			 pathVO1 = new PathVO();
			 pathVO1.path = new <SimplePoint> [ new SimplePoint( 800, 300 ) ];
			 this.createUnit( 150, 300 + Math.random() * 20, new WarriorUnitConfigVO() );
			 this._units[ this._units.length - 1 ].setPlayerGroup( '1' );
			 this._units[ this._units.length - 1 ].attackMoveTo( pathVO1 );
			 */
			pathVO1 = new PathVO();
			pathVO1.path = new <SimplePoint> [ new SimplePoint( 800, 300 ) ];
			this.createUnit( 150, 300 + Math.random() * 20, new WarriorUnitConfigVO() );
			this._units[ this._units.length - 1 ].setPlayerGroup( '1' );
			this._units[ this._units.length - 1 ].attackMoveTo( pathVO1 );

			var pathVO2:PathVO = new PathVO();
			pathVO2.path = new <SimplePoint> [ new SimplePoint( 100, 300 ) ];
			this.createUnit( 900 - 100, 300 + Math.random() * 20, new ArcherUnitConfigVO() );
			this._units[ this._units.length - 1 ].setPlayerGroup( '2' );
			this._units[ this._units.length - 1 ].attackMoveTo( pathVO2 );
			/*
			 pathVO2 = new PathVO();
			 pathVO2.path = new <SimplePoint> [ new SimplePoint( 100, 300 ) ];
			 this.createUnit( 900 - 100, 300 + Math.random() * 20, new ArcherUnitConfigVO() );
			 this._units[ this._units.length - 1 ].setPlayerGroup( '2' );
			 this._units[ this._units.length - 1 ].attackMoveTo( pathVO2 );

			 pathVO2 = new PathVO();
			 pathVO2.path = new <SimplePoint> [ new SimplePoint( 100, 300 ) ];
			 this.createUnit( 900 - 150, 300 + Math.random() * 20, new WarriorUnitConfigVO() );
			 this._units[ this._units.length - 1 ].setPlayerGroup( '2' );
			 this._units[ this._units.length - 1 ].attackMoveTo( pathVO2 );
			 */
			pathVO2 = new PathVO();
			pathVO2.path = new <SimplePoint> [ new SimplePoint( 100, 300 ) ];
			this.createUnit( 900 - 150, 300 + Math.random() * 20, new WarriorUnitConfigVO() );
			this._units[ this._units.length - 1 ].setPlayerGroup( '2' );
			this._units[ this._units.length - 1 ].attackMoveTo( pathVO2 );
		}

		private function createBackgroundModules():void
		{
			var bitmapTextures:Vector.<BitmapDataVO> = JSONBitmapAtlas.getBitmapDataVOs( new TerrainTextures.AtlasImage, new TerrainTextures.AtlasDescription );

			this._rectangleBackgroundModule = this.createModule( RectangleBackgroundModule ) as RectangleBackgroundModule;
			this._viewContainer.addChild( this._rectangleBackgroundModule.getView() );
			this._rectangleBackgroundModule.setTerrainInformations( bitmapTextures );
			this._rectangleBackgroundModule.setRectangleBackgroundVO( this._levelDataVO.rectangleBackgroundData );

			this._pathBackgroundModule = this.createModule( PolygonBackgroundModule ) as PolygonBackgroundModule;
			this._viewContainer.addChild( this._pathBackgroundModule.getView() );
			this._pathBackgroundModule.setTerrainInformations( bitmapTextures );
			this._pathBackgroundModule.setPolygonBackgroundVO( this._levelDataVO.polygonBackgroundData );
		}

		private function drawDebugDatas():void
		{
			var debugLayer:Sprite = this._viewContainer.addChild( new Sprite() ) as Sprite;
			debugLayer.touchable = false;
			var map:Vector.<Vector.<AStarNodeVO>> = this._mapModule.getMapNodes();

			for( var i:int = 0; i < map.length; i++ )
			{
				for( var j:int = 0; j < map[ i ].length; j++ )
				{
					if( !map[ i ][ j ].isWalkable )
					{
						var nodeColor:uint = map[ i ][ j ].isWalkable ? 0x00FF00 : 0xFF0000;

						var debugNodeView:Quad = new Quad( CMapSize.NODE_SIZE, CMapSize.NODE_SIZE, nodeColor );
						debugNodeView.alpha = .6;
						debugNodeView.x = i * CMapSize.NODE_SIZE;
						debugNodeView.y = j * CMapSize.NODE_SIZE;

						debugLayer.addChild( debugNodeView );
					}
				}
			}
		}

		private function createUnit( x:Number, y:Number, unitConfigVO:UnitConfigVO ):void
		{
			var unitModule:IUnitModule = this._unitModuleObjectPool.getObject() as IUnitModule;
			this.registerModule( unitModule );
			unitModule.setUnitConfigVO( unitConfigVO );

			unitModule.addEventListener( UnitModuleEvent.UNIT_DIED, releaseUnit );

			this._units.push( unitModule );

			this._zOrderModule.addUnit( unitModule );
			this._unitDistanceCalculatorModule.addUnit( unitModule );

			unitModule.setPosition( x, y );
			this._viewContainer.addChild( unitModule.getView() );
		}

		private function releaseUnit( e:UnitModuleEvent ):void
		{
			var unitModule:IUnitModule = e.target as IUnitModule;

			this.unregisterModule( unitModule );
			this._unitModuleObjectPool.releaseObject( unitModule );

			this._zOrderModule.removeUnit( unitModule );
			this._unitDistanceCalculatorModule.removeUnit( unitModule );

			var length:int = this._units.length;

			for( var i:int = 0; i < length; i++ )
			{
				if( this._units[ i ] != e.target && this._units[ i ].getTarget() == unitModule )
				{
					this._units[ i ].removeTarget();
				}
			}

			for( i = 0; i < length; i++ )
			{
				if( this._units[ i ] == unitModule )
				{
					this._units[ i ] = null;
					this._units.splice( i, 1 );

					break;
				}
			}

			if( this._units.length > 0 )
			{
				this._unitControllerModule.setTarget( this._units[ 0 ] );
			}

			this._viewContainer.removeChild( unitModule.getView() );
		}

		override protected function onUpdate():void
		{
			WorldClock.clock.advanceTime( -1 );
		}

		private function unitMoveToRequest( e:UnitControllerModuleEvent, request:UnitMoveToRequest ):void
		{
			if( !this._touchDragModule.getIsTouchDragged() && !this._touchZoomModule.getIsZoomInProgress() )
			{
				this.unitMoveTo( request.unit, request.position );
			}
		}

		private function unitMoveTo( unit:IUnitModule, position:SimplePoint ):void
		{
			var pathRequestVO:AStarPathRequestVO = new AStarPathRequestVO();
			pathRequestVO.startPosition = MapPositionUtil.changePositionToMapNodePoint( unit.getPosition() );
			pathRequestVO.endPosition = MapPositionUtil.changePositionToMapNodePoint( position );
			pathRequestVO.mapNodes = this._mapModule.getMapNodes();

			if( !pathRequestVO.mapNodes[ pathRequestVO.endPosition.x ][ pathRequestVO.endPosition.y ].isWalkable ||
					GeomUtil.isSimplePointEqual( pathRequestVO.startPosition, pathRequestVO.endPosition )
			)
			{
				return;
			}

			var pathVO:PathVO = AStarUtil.getPath( pathRequestVO );
			if( pathVO && pathVO.path && pathVO.path.length > 0 )
			{
				pathVO.path = MapPositionUtil.changeMapNodePointVectorToPositionVector( pathVO.path );

				unit.moveTo( pathVO );
			}
		}

		override public function dispose():void
		{
			this._pathBackgroundModule.dispose();

			this._dragonBonesGraphicService.dispose();
			this._dragonBonesGraphicService = null;

			this._zOrderModule.dispose();
			this._zOrderModule = null;

			this._unitDistanceCalculatorModule.dispose();
			this._unitDistanceCalculatorModule = null;

			this._unitDistanceHolderModule.dispose();
			this._unitDistanceHolderModule = null;

			this._unitTargetManagerModule.dispose();
			this._unitTargetManagerModule = null;

			this._touchZoomModule.dispose();
			this._touchZoomModule = null;

			this._touchDragModule.dispose();
			this._touchDragModule = null;

			this._unitModuleObjectPool.dispose();
			this._unitModuleObjectPool = null;

			this._viewContainer.removeFromParent( true );
			this._viewContainer = null;
		}
	}
}