/**
 * Created by newkrok on 20/03/16.
 */
package net.fpp.starlingtowerdefense.game.module.unitcontroller.view
{
	import caurina.transitions.Tweener;

	import net.fpp.common.starling.StaticAssetManager;
	import net.fpp.common.starling.module.AModuleView;
	import net.fpp.starlingtowerdefense.constant.CSkin;

	import starling.display.DisplayObject;

	import starling.display.Image;

	import net.fpp.starlingtowerdefense.game.module.unitcontroller.UnitControllerModel;

	public class UnitControllerModuleView extends AModuleView
	{
		private var _selectionMarker:Image;

		override protected function onInit():void
		{
			this._selectionMarker = new Image( StaticAssetManager.instance.getTexture( CSkin.UNIT_SELECTION_MARKER ) );

			this.addChild( this._selectionMarker );
			this._selectionMarker.touchable = false;
			this._selectionMarker.visible = false;
			this._selectionMarker.pivotX = this._selectionMarker.width / 2;
			this._selectionMarker.pivotY = this._selectionMarker.height / 2;
		}

		public function updateSelectionMarkerVisibility():void
		{
			this._selectionMarker.visible = ( this._model as UnitControllerModel ).getTarget() != null;

			if ( this._selectionMarker.visible )
			{
				this.animateSelectionMarker();
			}
			else
			{
				this._selectionMarker.scaleX = this._selectionMarker.scaleY = 1;
				Tweener.removeTweens( this._selectionMarker );
			}
		}

		public function updateSelectionMarkerPosition():void
		{
			var targetView:DisplayObject = ( this._model as UnitControllerModel ).getTarget().getView() as DisplayObject;

			this._selectionMarker.x = targetView.x;
			this._selectionMarker.y = targetView.y;
		}

		private function animateSelectionMarker():void
		{
			if ( this._selectionMarker.scaleX == 1 )
			{
				Tweener.addTween( this._selectionMarker, { scaleX: 1.1, scaleY: 1.1, time: .5, transition: 'linear', onComplete: animateSelectionMarker } );
			}
			else
			{
				Tweener.addTween( this._selectionMarker, { scaleX: 1, scaleY: 1, time: .5, transition: 'linear', onComplete: animateSelectionMarker } );
			}
		}

		override public function dispose():void
		{
			Tweener.removeTweens( this._selectionMarker );
			this._selectionMarker.removeFromParent( true );
			this._selectionMarker = null;

			super.dispose();
		}
	}
}