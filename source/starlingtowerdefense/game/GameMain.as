/**
 * Created by newkrok on 07/01/16.
 */
package starlingtowerdefense.game
{
	import dragonBones.animation.WorldClock;

	import net.fpp.starling.StaticAssetManager;

	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	import starlingtowerdefense.assets.GameAssets;
	import starlingtowerdefense.game.module.background.BackgroundModule;
	import starlingtowerdefense.game.module.background.IBackgroundModule;
	import starlingtowerdefense.game.module.unit.IUnitModule;
	import starlingtowerdefense.game.module.unit.UnitModule;
	import starlingtowerdefense.game.service.animatedgraphic.DragonBonesGraphicService;
	import starlingtowerdefense.game.service.animatedgraphic.events.DragonBonesGraphicServiceEvent;
	import starlingtowerdefense.vo.LevelDataVO;

	public class GameMain extends Sprite
	{
		private var _dragonBonesGraphicService:DragonBonesGraphicService;

		private var _backgroundModule:IBackgroundModule;

		private var _units:Vector.<IUnitModule> = new <IUnitModule>[];

		private var _levelDataVO:LevelDataVO;

		public function GameMain()
		{
			this.loadDragonBonesGraphicAssets();
		}

		public function setLevelDataVO( value:LevelDataVO ):void
		{
			this._levelDataVO = value;
		}

		private function loadDragonBonesGraphicAssets():void
		{
			this._dragonBonesGraphicService = new DragonBonesGraphicService();
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

			this._backgroundModule = new BackgroundModule();
			this.addChild( this._backgroundModule.getView() );

			this._backgroundModule.setPolygons( this._levelDataVO.polygons );

			for ( var i:int = 0; i < 10; i++ )
			{
				this.createUnit( stage.stageWidth * Math.random(), stage.stageHeight * Math.random() );
			}

			this.addEventListener( EnterFrameEvent.ENTER_FRAME, this.onEnterFrameHandler );
			this.stage.addEventListener( TouchEvent.TOUCH, this.onTouchHandler );
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
		}

		private function zOrder():void
		{
			var unitPositionInfos:Array = [];

			for ( var i:int = 0; i < this._units.length; i++ )
			{
				unitPositionInfos.push( {y: _units[ i ].getView().y, content: _units[ i ]} );
			}

			unitPositionInfos.sortOn ( "y" );

			for ( i = 0; i < unitPositionInfos.length; i++ )
			{
				this.addChild( unitPositionInfos[ i ].content.getView() );
			}
		}

		private function onTouchHandler(e:TouchEvent):void
		{
			if ( e.touches[0].phase == TouchPhase.ENDED )
			{
				for ( var i:int = 0; i < this._units.length; i++ )
				{
					switch ( Math.floor( Math.random() * 3 ) )
					{
						case 0:
							this._units[ i ].moveTo( stage.stageWidth * Math.random(), stage.stageHeight * Math.random() );
							break;
						case 1:
							this._units[ i ].attack();
							break;
						case 2:
							this._units[ i ].changeSkin();
							break;
					}
				}
			}
		}

		override public function dispose():void
		{
			this._backgroundModule.dispose();

			this._dragonBonesGraphicService.dispose();
			this._dragonBonesGraphicService = null;
		}
	}
}