/**
 * Created by newkrok on 14/02/16.
 */
package starlingtowerdefense.game.module.background.view
{
	import flash.geom.Point;

	import net.fpp.starling.module.AModel;
	import net.fpp.starling.module.AModuleView;

	import starling.display.Sprite;

	import starlingtowerdefense.game.module.background.BackgroundModel;

	public class BackgroundModuleView extends AModuleView
	{
		private var _backgroundModel:BackgroundModel;

		private var _polygonLayer:Sprite;

		public function BackgroundModuleView()
		{
		}

		override public function setModel( model:AModel ):void
		{
			this._backgroundModel = model as BackgroundModel;

			super.setModel( model );
		}

		override protected function onInit():void
		{
			this._polygonLayer = new Sprite();
			this.addChild( this._polygonLayer );
		}

		public function drawPolygons():void
		{
			var polygons:Vector.<Vector.<Point>> = this._backgroundModel.getPolygons();

			for( var i:int = 0; i < polygons.length; i++ )
			{
				this._polygonLayer.addChild( new PolygonView( polygons[ i ] ) );
			}
		}

		override public function dispose():void
		{
			this._backgroundModel = null;

			this._polygonLayer.removeFromParent( true );
			this._polygonLayer = null;
		}
	}
}