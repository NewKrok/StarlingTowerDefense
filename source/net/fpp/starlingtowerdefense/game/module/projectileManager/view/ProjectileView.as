/**
 * Created by newkrok on 27/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.projectileManager.view
{
	import net.fpp.common.starling.StaticAssetManager;

	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;

	public class ProjectileView extends Sprite
	{
		private var _view:DisplayObject;

		public function ProjectileView( skinId:String )
		{
			this._view = new Image( StaticAssetManager.instance.getTexture( skinId ) );
			this._view.pivotX = this._view.width;
			this._view.pivotY = this._view.height;

			this.addChild( this._view );
		}

		override public function dispose():void
		{
			this._view.removeFromParent( true );
			this._view = null;

			super.dispose();
		}
	}
}