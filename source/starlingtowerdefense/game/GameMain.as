/**
 * Created by newkrok on 07/01/16.
 */
package starlingtowerdefense.game
{
	import dragonBones.animation.WorldClock;

	import net.fpp.geom.SimplePoint;

	import net.fpp.starling.StaticAssetManager;

	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	import starlingtowerdefense.assets.GameAssets;
	import starlingtowerdefense.game.module.background.BackgroundModule;
	import starlingtowerdefense.game.module.background.IBackgroundModule;
	import starlingtowerdefense.game.module.map.IMapModule;
	import starlingtowerdefense.game.module.map.MapModule;
	import starlingtowerdefense.game.module.map.constant.CMapSize;
	import starlingtowerdefense.game.module.map.vo.MapNodeVO;
	import starlingtowerdefense.game.module.unit.IUnitModule;
	import starlingtowerdefense.game.module.unit.UnitModule;
	import starlingtowerdefense.game.module.unit.view.UnitModuleView;
	import starlingtowerdefense.game.service.animatedgraphic.DragonBonesGraphicService;
	import starlingtowerdefense.game.service.animatedgraphic.events.DragonBonesGraphicServiceEvent;
	import starlingtowerdefense.game.service.pathfinder.PathFinderService;
	import starlingtowerdefense.game.service.pathfinder.vo.RouteRequestVO;
	import starlingtowerdefense.vo.LevelDataVO;

	public class GameMain extends Sprite
	{
		private var _pathFinderService:PathFinderService;
		private var _dragonBonesGraphicService:DragonBonesGraphicService;

		private var _backgroundModule:IBackgroundModule;
		private var _mapModule:IMapModule;

		private var _units:Vector.<IUnitModule> = new <IUnitModule>[];

		private var _levelDataVO:LevelDataVO;

		public function GameMain()
		{
			this._pathFinderService = new PathFinderService();
			this._dragonBonesGraphicService = new DragonBonesGraphicService();

			this.loadDragonBonesGraphicAssets();
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
			this.addChild( new Quad( stage.stageWidth, stage.stageHeight, 0, false ) );

			this._mapModule = new MapModule();

			this._backgroundModule = new BackgroundModule();
			this.addChild( this._backgroundModule.getView() );

			this._backgroundModule.setPolygons( this._levelDataVO.polygons );

			/*for ( var i:int = 0; i < 1; i++ )
			{
				this.createUnit( 50, i * 50 + 200 );
				this._units[0].asd();

				this.createUnit( stage.stageWidth - 50, i * 50 + 200 );
			}*/

			this.createUnit( stage.stageWidth - 100, 250 );
			this._units[this._units.length - 1].changeSkin();
			this.createUnit( stage.stageWidth - 100, 300 );
			this._units[this._units.length - 1].changeSkin();
			this.createUnit( stage.stageWidth - 100, 400 );
			this._units[this._units.length - 1].changeSkin();
			this.createUnit( stage.stageWidth - 100, 450 );
			this._units[this._units.length - 1].changeSkin();

			this.createUnit( stage.stageWidth - 150, 250 );
			this._units[this._units.length - 1].changeSkin();
			this.createUnit( stage.stageWidth - 150, 300 );
			this._units[this._units.length - 1].changeSkin();
			this.createUnit( stage.stageWidth - 150, 400 );
			this._units[this._units.length - 1].changeSkin();
			this.createUnit( stage.stageWidth - 150, 450 );
			this._units[this._units.length - 1].changeSkin();

			this.createUnit( stage.stageWidth - 200, 250 );
			this._units[this._units.length - 1].changeSkin();
			this.createUnit( stage.stageWidth - 200, 300 );
			this._units[this._units.length - 1].changeSkin();
			this.createUnit( stage.stageWidth - 200, 400 );
			this._units[this._units.length - 1].changeSkin();
			this.createUnit( stage.stageWidth - 200, 450 );
			this._units[this._units.length - 1].changeSkin();

			this.createUnit( 100, 250 );
			this._units[this._units.length - 1].changeSkin();
			this.createUnit( 100, 300 );
			this._units[this._units.length - 1].changeSkin();
			this.createUnit( 100, 400 );
			this._units[this._units.length - 1].changeSkin();
			this.createUnit( 100, 450 );
			this._units[this._units.length - 1].changeSkin();

			this.createUnit( 150, 250 );
			this._units[this._units.length - 1].changeSkin();
			this.createUnit( 150, 300 );
			this._units[this._units.length - 1].changeSkin();
			this.createUnit( 150, 400 );
			this._units[this._units.length - 1].changeSkin();
			this.createUnit( 150, 450 );
			this._units[this._units.length - 1].changeSkin();

			this.createUnit( 100, 250 );
			this._units[this._units.length - 1].changeSkin();
			this.createUnit( 100, 300 );
			this._units[this._units.length - 1].changeSkin();
			this.createUnit( 100, 400 );
			this._units[this._units.length - 1].changeSkin();
			this.createUnit( 100, 450 );
			this._units[this._units.length - 1].changeSkin();

			this.addEventListener( EnterFrameEvent.ENTER_FRAME, this.onEnterFrameHandler );
			this.stage.addEventListener( TouchEvent.TOUCH, this.onTouchHandler );

			this.drawDebugDatas();
		}

		private function drawDebugDatas():void
		{
			var debugLayer:Sprite = this.addChild( new Sprite() ) as Sprite;
			var map:Vector.<Vector.<MapNodeVO>> = this._mapModule.getMapNodes();

			for ( var i:int = 0; i < map.length; i++ )
			{
				for ( var j:int = 0; j < map[i].length; j++ )
				{
					var nodeColor:uint = map[i][j].isWalkable ? 0x00FF00 : 0xFF0000;

					var debugNodeView:Quad = new Quad( CMapSize.NODE_SIZE, CMapSize.NODE_SIZE, nodeColor );
					debugNodeView.alpha = .2;
					debugNodeView.x = i * CMapSize.NODE_SIZE;
					debugNodeView.y = j * CMapSize.NODE_SIZE;

					debugLayer.addChild( debugNodeView );
				}
			}
		}

		private function createUnit( x:Number, y:Number ):void
		{
			var unitModule:IUnitModule = new UnitModule( this._dragonBonesGraphicService );
			this._units.push( unitModule );

			unitModule.setPosition( x, y );
			this.addChild( unitModule.getView() );
		}

		private function onEnterFrameHandler( e:EnterFrameEvent ):void
		{
			WorldClock.clock.advanceTime( -1 );

			this.zOrder();

			this.runUnitDistanceHandler();
		}

		private function zOrder():void
		{
			var unitPositionInfos:Array = [];

			for ( var i:int = 0; i < this._units.length; i++ )
			{
				unitPositionInfos.push( {y: _units[ i ].getView().y, content: _units[ i ]} );
			}

			unitPositionInfos.sortOn ( "y", Array.NUMERIC );

			for ( i = 0; i < unitPositionInfos.length; i++ )
			{
				this.addChild( unitPositionInfos[ i ].content.getView() );
			}
		}

		private function runUnitDistanceHandler():void
		{
			var length:int = this._units.length;
			for ( var i:int = 0; i < length; i++ )
			{
				for( var j:int = 0; j < length; j++ )
				{
					if ( i != j )
					{
						var unitAModule:IUnitModule = this._units[i] as IUnitModule;
						var unitBModule:IUnitModule = this._units[j] as IUnitModule;

						var unitAView:UnitModuleView = unitAModule.getView() as UnitModuleView;
						var unitBView:UnitModuleView = unitBModule.getView() as UnitModuleView;

						var distance:Number = Math.sqrt( Math.pow( unitAView.x - unitBView.x, 2 ) + Math.pow( unitAView.y - unitBView.y, 2 ) );

						var unitARadius:Number = unitAModule.getSizeRadius();
						var unitBRadius:Number = unitBModule.getSizeRadius();

						if ( distance < unitARadius / 2 + unitBRadius / 2 )
						{
							var unitAOffset:Number;
							var unitBOffset:Number;

							if ( unitARadius == unitBRadius )
							{
								unitAOffset = unitBOffset = .5;
							}
							else if ( unitARadius > unitBRadius )
							{
								unitAOffset = 0;//unitBRadius / unitARadius / 2;
								unitBOffset = 5;
							}
							else
							{
								unitAOffset = 5;
								unitBOffset = 0;//unitBRadius / unitARadius / 2;
							}

							var angle:Number = Math.atan2( unitAView.y - unitBView.y, unitAView.x - unitBView.x );

							unitAModule.setPosition( unitAView.x + unitAOffset * Math.cos( angle ), unitAView.y + unitAOffset * Math.sin( angle ) );
							unitBModule.setPosition( unitBView.x - unitBOffset * Math.cos( angle ), unitBView.y - unitBOffset * Math.sin( angle ) );
						}
					}
				}
			}
		}

		private function onTouchHandler(e:TouchEvent):void
		{
			if ( e.touches[0].phase == TouchPhase.ENDED )
			{
				for ( var i:int = 0; i < this._units.length; i++ )
				{
					if ( this._units[ i ].getView().x < 250 )
					{
						this.unitMoveTo( this._units[ i ], new SimplePoint( stage.stageWidth - 100, stage.stageHeight * Math.random() ) );
					}
					else
					{
						this.unitMoveTo( this._units[ i ], new SimplePoint( 100, stage.stageHeight / 2 ) );
					}
				}
			}
		}

		private function unitMoveTo( unit:IUnitModule, endPosition:SimplePoint ):void
		{
			var routeRequestVO = new RouteRequestVO();
			routeRequestVO.startPosition = new SimplePoint( unit.getView().x, unit.getView().y );
			routeRequestVO.endPosition = endPosition;
			routeRequestVO.mapNodes = this._mapModule.getMapNodes();

			unit.moveTo( this._pathFinderService.getRoute( routeRequestVO ) );
		}

		override public function dispose():void
		{
			this._backgroundModule.dispose();

			this._dragonBonesGraphicService.dispose();
			this._dragonBonesGraphicService = null;
		}
	}
}