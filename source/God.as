/**
 * Created by newkrok on 18/12/15.
 */
package
{
	import starlingtowerdefense.game.GameMain;
	import starlingtowerdefense.menu.MenuMain;

	import starling.display.Sprite;

	public class God extends Sprite
	{
		private var _menuMain:MenuMain;
		private var _gameMain:GameMain;

		public function start():void
		{
			this.createGame();
		}

		private function createMenu():void
		{
			this._menuMain = new MenuMain();
			this.addChild( this._menuMain );
		}

		private function createGame():void
		{
			this._gameMain = new GameMain();
			this.addChild( this._gameMain );
		}
	}
}