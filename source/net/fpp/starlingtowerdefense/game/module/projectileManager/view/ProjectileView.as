/**
 * Created by newkrok on 27/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.projectilemanager.view
{
	import net.fpp.common.starling.StaticAssetManager;
	import net.fpp.common.util.objectpool.IPoolableObject;

	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;

	public class ProjectileView extends Sprite implements IPoolableObject
	{
		private var _view:DisplayObject;

		private var _lastSkinId:String;

		public function init():void
		{
		}

		public function setSkin( skinId:String ):void
		{
			if ( skinId == this._lastSkinId )
			{
				return;
			}
			else if ( this._lastSkinId )
			{
				this.clearView();
			}

			this._view = new Image( StaticAssetManager.instance.getTexture( skinId ) );
			this._view.pivotX = this._view.width;
			this._view.pivotY = this._view.height;

			this.addChild( this._view );

			this._lastSkinId = skinId;
		}

		public function reset():void
		{
		}

		private function clearView():void
		{
			this._view.removeFromParent( true );
			this._view = null;
		}

		override public function dispose():void
		{
			this.clearView();

			super.dispose();
		}
	}
}