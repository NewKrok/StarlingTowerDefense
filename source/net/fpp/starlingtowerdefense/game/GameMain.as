/**
 * Created by newkrok on 07/01/16.
 */
package net.fpp.starlingtowerdefense.game
{
	import dragonBones.animation.WorldClock;

	import net.fpp.common.geom.SimplePoint;
	import net.fpp.common.starling.StaticAssetManager;
	import net.fpp.common.starling.module.AApplicationContext;
	import net.fpp.common.util.jsonbitmapatlas.JSONBitmapAtlas;
	import net.fpp.common.util.pathfinding.PathfFindingUtil;
	import net.fpp.common.util.pathfinding.vo.PathRequestVO;
	import net.fpp.common.util.pathfinding.vo.PathVO;

	import starling.display.Quad;
	import starling.events.EnterFrameEvent;

	import assets.GameAssets;
	import assets.TerrainTextures;
	import net.fpp.starlingtowerdefense.game.config.unit.WarriorUnitConfigVO;
	import net.fpp.starlingtowerdefense.game.module.background.pathbackground.IPathBackgroundModule;
	import net.fpp.starlingtowerdefense.game.module.background.pathbackground.PathBackgroundModule;
	import net.fpp.starlingtowerdefense.game.module.distancechecker.DistanceCheckerModule;
	import net.fpp.starlingtowerdefense.game.module.distancechecker.IDistanceCheckerModule;
	import net.fpp.starlingtowerdefense.game.module.helper.DamageCalculator;
	import net.fpp.starlingtowerdefense.game.module.map.IMapModule;
	import net.fpp.starlingtowerdefense.game.module.map.MapModule;
	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;
	import net.fpp.starlingtowerdefense.game.module.unit.UnitModule;
	import net.fpp.starlingtowerdefense.game.module.unit.events.UnitModuleEvent;
	import net.fpp.starlingtowerdefense.game.module.unit.view.UnitModuleView;
	import net.fpp.starlingtowerdefense.game.module.unit.vo.UnitConfigVO;
	import net.fpp.starlingtowerdefense.game.module.unitcontroller.IUnitControllerModule;
	import net.fpp.starlingtowerdefense.game.module.unitcontroller.UnitControllerModule;
	import net.fpp.starlingtowerdefense.game.module.unitcontroller.events.UnitControllerModuleEvent;
	import net.fpp.starlingtowerdefense.game.module.unitcontroller.request.UnitMoveToRequest;
	import net.fpp.starlingtowerdefense.game.module.wavehandler.IWaveHandlerModule;
	import net.fpp.starlingtowerdefense.game.module.wavehandler.WaveHandlerModule;
	import net.fpp.starlingtowerdefense.game.service.animatedgraphic.DragonBonesGraphicService;
	import net.fpp.starlingtowerdefense.game.service.animatedgraphic.events.DragonBonesGraphicServiceEvent;
	import net.fpp.starlingtowerdefense.game.util.MapPositionUtil;
	import net.fpp.starlingtowerdefense.vo.LevelDataVO;

	public class GameMain extends AApplicationContext
	{
		private var _dragonBonesGraphicService:DragonBonesGraphicService;

		private var _damageCalculator:DamageCalculator;

		private var _pathBackgroundModule:IPathBackgroundModule;
		private var _mapModule:IMapModule;
		private var _unitControllerModule:IUnitControllerModule;
		private var _distanceCheckerModule:IDistanceCheckerModule;
		private var _waveHandlerModule:IWaveHandlerModule;

		private var _units:Vector.<IUnitModule> = new <IUnitModule>[];

		private var _levelDataVO:LevelDataVO;

		public function GameMain()
		{
			this.configureInjector();

			this._dragonBonesGraphicService = new DragonBonesGraphicService();

			this._damageCalculator = new DamageCalculator();

			this.loadDragonBonesGraphicAssets();
		}

		private function configureInjector():void
		{
			this._mapModule = new MapModule();
			this.injector.mapValue( IMapModule, this._mapModule );
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
			this.addChild( new Quad( stage.stageWidth, stage.stageHeight, 0 ) );

			this._pathBackgroundModule = this.createModule( PathBackgroundModule ) as PathBackgroundModule;
			this.addChild( this._pathBackgroundModule.getView() );
			this._pathBackgroundModule.setTerrainInformations( JSONBitmapAtlas.getBitmapDataVOs( new TerrainTextures.AtlasImage, new TerrainTextures.AtlasDescription ) );
			this._pathBackgroundModule.setPathPolygons( this._levelDataVO.polygons );

			this._unitControllerModule = this.createModule( UnitControllerModule ) as UnitControllerModule;
			this._unitControllerModule.setGameContainer( this );
			this._unitControllerModule.addEventListener( UnitControllerModuleEvent.UNIT_MOVE_TO_REQUEST, this.unitMoveToRequest );
			this.addChild( this._unitControllerModule.getView() );

			this._distanceCheckerModule = this.createModule( DistanceCheckerModule ) as DistanceCheckerModule;

			this.createUnit( 100, 200, new WarriorUnitConfigVO() );
			this._units[ this._units.length - 1 ].setPlayerGroup( '1' );
			this._unitControllerModule.setTarget( this._units[ 0 ] );

			this._waveHandlerModule = this.createModule( WaveHandlerModule ) as WaveHandlerModule;

			this.addEventListener( EnterFrameEvent.ENTER_FRAME, this.onEnterFrameHandler );

			//this.drawDebugDatas();
		}

		private function drawDebugDatas():void
		{
			/*			var debugLayer:Sprite = this.addChild( new Sprite() ) as Sprite;
			 var map:Vector.<Vector.<PathNodeVO>> = this._mapModule.getMapNodes();

			 for( var i:int = 0; i < map.length; i++ )
			 {
			 for( var j:int = 0; j < map[ i ].length; j++ )
			 {
			 var nodeColor:uint = map[ i ][ j ].isWalkable ? 0x00FF00 : 0xFF0000;

			 var debugNodeView:Quad = new Quad( CMapSize.NODE_SIZE, CMapSize.NODE_SIZE, nodeColor );
			 debugNodeView.alpha = .2;
			 debugNodeView.x = i * CMapSize.NODE_SIZE;
			 debugNodeView.y = j * CMapSize.NODE_SIZE;

			 debugLayer.addChild( debugNodeView );
			 }
			 }*/
		}

		private function createUnit( x:Number, y:Number, unitConfigVO:UnitConfigVO ):void
		{
			var unitModule:UnitModule = new UnitModule( unitConfigVO, this._damageCalculator, this._dragonBonesGraphicService );

			unitModule.addEventListener( UnitModuleEvent.UNIT_DIED, removeUnit );

			this.injector.injectInto( unitModule );

			this._units.push( unitModule );
			this._distanceCheckerModule.registerUnit( unitModule );

			unitModule.setPosition( x, y );
			this.addChild( unitModule.getView() );
		}

		private function removeUnit( e:UnitModuleEvent ):void
		{
			var length:int = this._units.length;

			for( var i:int = 0; i < length; i++ )
			{
				if( this._units[ i ] != e.target && this._units[ i ].getTarget() == e.target )
				{
					this._units[ i ].removeTarget();
				}
			}

			for( i = 0; i < length; i++ )
			{
				if( this._units[ i ] == e.target )
				{
					this._units[ i ].dispose();
					this._units[ i ] = null;
					this._units.splice( i, 1 );

					break;
				}
			}

			this._unitControllerModule.setTarget( this._units[ 0 ] );
		}

		private function onEnterFrameHandler( e:EnterFrameEvent ):void
		{
			WorldClock.clock.advanceTime( -1 );

			this.zOrder();

			this.runUnitDistanceHandler();

			this._unitControllerModule.update();
			this._distanceCheckerModule.update();
		}

		private function zOrder():void
		{
			var unitPositionInfos:Array = [];

			for( var i:int = 0; i < this._units.length; i++ )
			{
				unitPositionInfos.push( {y: _units[ i ].getView().y, content: _units[ i ]} );
			}

			unitPositionInfos.sortOn( "y", Array.NUMERIC );

			for( i = 0; i < unitPositionInfos.length; i++ )
			{
				this.addChild( unitPositionInfos[ i ].content.getView() );
			}
		}

		private function runUnitDistanceHandler():void
		{
			var length:int = this._units.length;
			for( var i:int = 0; i < length; i++ )
			{
				for( var j:int = 0; j < length; j++ )
				{
					if( i != j )
					{
						var unitAModule:IUnitModule = this._units[ i ] as IUnitModule;
						var unitBModule:IUnitModule = this._units[ j ] as IUnitModule;

						if( unitAModule.getIsDead() || unitBModule.getIsDead() )
						{
							break;
						}

						var unitAView:UnitModuleView = unitAModule.getView() as UnitModuleView;
						var unitBView:UnitModuleView = unitBModule.getView() as UnitModuleView;

						var distance:Number = Math.sqrt( Math.pow( unitAView.x - unitBView.x, 2 ) + Math.pow( unitAView.y - unitBView.y, 2 ) );

						var unitARadius:Number = unitAModule.getSizeRadius();
						var unitBRadius:Number = unitBModule.getSizeRadius();

						if( distance < unitARadius / 2 + unitBRadius / 2 && unitAModule.getTarget() == null && unitBModule.getTarget() == null )
						{
							var unitAOffset:Number;
							var unitBOffset:Number;

							if( unitARadius == unitBRadius )
							{
								unitAOffset = unitBOffset = .8;
							}
							else if( unitARadius > unitBRadius )
							{
								unitAOffset = 0;
								unitBOffset = 5;
							}
							else
							{
								unitAOffset = 5;
								unitBOffset = 0;
							}

							var angle:Number = Math.atan2( unitAView.y - unitBView.y, unitAView.x - unitBView.x );

							unitAModule.setPosition( unitAView.x + unitAOffset * Math.cos( angle ), unitAView.y + unitAOffset * Math.sin( angle ) );
							unitBModule.setPosition( unitBView.x - unitBOffset * Math.cos( angle ), unitBView.y - unitBOffset * Math.sin( angle ) );
						}

						if( distance < unitAModule.getUnitDetectionRadius() && unitAModule.getPlayerGroup() != unitBModule.getPlayerGroup() && unitAModule.getTarget() == null )
						{
							unitAModule.setTarget( unitBModule );
						}

						if( unitAModule.getTarget() == unitBModule )
						{
							if( distance < unitAModule.getAttackRadius() )
							{
								unitAModule.attack();

								if( Math.abs( unitAView.x - unitBView.x ) < 40 )
								{
									unitAModule.setPosition( unitAView.x + ( unitAView.x > unitBView.x ? 1 : -1 ), unitAView.y );
									unitBModule.setPosition( unitBView.x + ( unitBView.x > unitBView.x ? 1 : -1 ), unitBView.y );
								}

								if( Math.abs( unitAView.y - unitBView.y ) > 10 )
								{
									unitAModule.setPosition( unitAView.x, unitAView.y + ( unitAView.y > unitBView.y ? -1 : 1 ) );
									unitBModule.setPosition( unitBView.x, unitBView.y + ( unitBView.y > unitAView.y ? -1 : 1 ) );
								}
							}
							else if( !unitAModule.getIsMoving() )
							{
								unitAModule.removeTarget();
							}
						}
					}
				}
			}
		}

		private function unitMoveToRequest( e:UnitControllerModuleEvent, request:UnitMoveToRequest ):void
		{
			this.unitMoveTo( request.unit, request.position );
		}

		private function unitMoveTo( unit:IUnitModule, position:SimplePoint ):void
		{
			var pathRequestVO:PathRequestVO = new PathRequestVO();
			pathRequestVO.startPosition = MapPositionUtil.changePositionToMapNodePoint( unit.getPosition() );
			pathRequestVO.endPosition = MapPositionUtil.changePositionToMapNodePoint( position );
			pathRequestVO.mapNodes = this._mapModule.getMapNodes();

			var pathVO:PathVO = PathfFindingUtil.getPath( pathRequestVO );
			pathVO.path = MapPositionUtil.changeMapNodePointVectorToPositionVector( pathVO.path );

			unit.moveTo( pathVO );
		}

		override public function dispose():void
		{
			this._pathBackgroundModule.dispose();

			this._dragonBonesGraphicService.dispose();
			this._dragonBonesGraphicService = null;
		}
	}
}