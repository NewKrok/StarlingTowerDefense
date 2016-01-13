/**
 * Created by newkrok on 07/01/16.
 */
package starlingtowerdefense.game
{
	import dragonBones.animation.WorldClock;

	import net.fpp.starling.StaticAssetManager;

	import starling.events.EnterFrameEvent;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	import starlingtowerdefense.game.module.background.BackgroundModule;
	import starlingtowerdefense.game.module.unit.IUnitModule;
	import starlingtowerdefense.game.module.unit.UnitModule;

	import starling.display.Sprite;

	import starlingtowerdefense.assets.GameAssets;
	import starlingtowerdefense.game.service.animatedgraphic.AnimatedGraphicService;
	import starlingtowerdefense.game.service.animatedgraphic.events.AnimatedGraphicServiceEvent;

	public class GameMain extends Sprite
	{
		private var _animatedGraphicService:AnimatedGraphicService;

		private var _backgroundModule:BackgroundModule;

		private var _units:Vector.<IUnitModule> = new <IUnitModule>[];

		public function GameMain()
		{
			this.loadAnimatedGraphicAssets();
		}

		private function loadAnimatedGraphicAssets():void
		{
			this._animatedGraphicService = new AnimatedGraphicService();
			this._animatedGraphicService.addEventListener( AnimatedGraphicServiceEvent.COMPLETE, this.loadStarlingAssets );
		}

		private function loadStarlingAssets( e:AnimatedGraphicServiceEvent ):void
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
			for ( var i:int = 0; i < 50; i++ )
			{
				this.createUnit( stage.stageWidth * Math.random(), stage.stageHeight * Math.random() );
			}

			this.addEventListener( EnterFrameEvent.ENTER_FRAME, this.onEnterFrameHandler );
			this.stage.addEventListener( TouchEvent.TOUCH, this.onTouchHandler );
		}

		private function createUnit( x:Number, y:Number ):void
		{
			var unitModule:IUnitModule = new UnitModule( this._animatedGraphicService );
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
					switch ( Math.floor( Math.random() * 2 ) )
					{
						case 0:
							this._units[ i ].moveTo( stage.stageWidth * Math.random(), stage.stageHeight * Math.random() );
							break;
						case 1:
							this._units[ i ].attack();
							break;
					}
				}
			}
		}

		override public function dispose():void
		{
			this._backgroundModule.dispose();

			this._animatedGraphicService.dispose();
			this._animatedGraphicService = null;
		}
	}
}