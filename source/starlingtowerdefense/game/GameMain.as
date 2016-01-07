/**
 * Created by newkrok on 07/01/16.
 */
package starlingtowerdefense.game
{
	import net.fpp.starling.StaticAssetManager;

	import starling.display.DisplayObject;

	import starlingtowerdefense.game.module.background.BackgroundModule;
	import starlingtowerdefense.game.module.unit.IUnitModule;
	import starlingtowerdefense.game.module.unit.UnitModule;

	import starling.display.Sprite;

	import starlingtowerdefense.assets.GameAssets;

	public class GameMain extends Sprite
	{
		private var _backgroundModule:BackgroundModule;

		public function GameMain()
		{
			this.loadAssets();
		}

		private function loadAssets():void
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
			//this._backgroundModule = new BackgroundModule();
			//this.addChild( this._backgroundModule().getView() );

			var unitModule:IUnitModule = new UnitModule();
			var temp:DisplayObject = this.addChild( unitModule.getView() );
			unitModule.setPosition( this.stage.stageWidth / 2, this.stage.stageHeight / 2 );
		}

		override public function dispose():void
		{
			this._backgroundModule.dispose();
		}
	}
}