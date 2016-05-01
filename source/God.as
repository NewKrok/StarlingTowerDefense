/**
 * Created by newkrok on 18/12/15.
 */
package
{
	import starling.display.Sprite;

	import starlingtowerdefense.game.GameMain;
	import starlingtowerdefense.game.service.level.LevelDataService;
	import starlingtowerdefense.menu.MenuMain;

	public class God extends Sprite
	{
		private var _menuMain:MenuMain;
		private var _gameMain:GameMain;

		private var _levelDataService:LevelDataService;

		public function start():void
		{
			this.createServices();
			this.createGame();
		}

		private function createServices():void
		{
			this._levelDataService = new LevelDataService();
			this._levelDataService.loadAreaData( 0 );
		}

		private function createMenu():void
		{
			this._menuMain = new MenuMain();
			this.addChild( this._menuMain );
		}

		private function createGame():void
		{
			this._gameMain = new GameMain();
			this._gameMain.setLevelDataVO( this._levelDataService.getLevelData( 0, 0 ) );

			this.addChild( this._gameMain );
		}
	}
}