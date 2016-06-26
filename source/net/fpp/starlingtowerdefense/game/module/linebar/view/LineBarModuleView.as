/**
 * Created by newkrok on 26/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.linebar.view
{
	import net.fpp.common.geom.SimplePoint;
	import net.fpp.common.starling.module.AModel;
	import net.fpp.common.starling.module.AModuleView;
	import net.fpp.starlingtowerdefense.game.module.linebar.LineBarModel;

	import starling.display.Quad;

	public class LineBarModuleView extends AModuleView
	{
		private var _lineBarModel:LineBarModel;

		private var _background:Quad;
		private var _line:Quad;

		public function LineBarModuleView()
		{
			this._background = new Quad( 100, 10, 0x0 );
			this.addChild( this._background );

			this._line = new Quad( this._background.width, this._background.height, 0xFFFFFF );
			this.addChild( this._line );
		}

		override public function setModel( model:AModel ):void
		{
			super.setModel( model );

			this._lineBarModel = model as LineBarModel;
		}

		public function setSize( size:SimplePoint ):void
		{
			this._background.width = size.x;
			this._background.height = size.y;

			this._line.height = this._background.height;

			this.updatePercentage();
		}

		public function setBackgroundColor( value:uint ):void
		{
			this._background.color = value;
		}

		public function setBackgroundAlpha( value:Number ):void
		{
			this._background.alpha = value;
		}

		public function setLineColor( value:uint ):void
		{
			this._line.color = value;
		}

		public function updatePercentage():void
		{
			this._line.width = this._background.width * this._lineBarModel.getPercentage();
		}

		override public function dispose():void
		{
			this._background.removeFromParent( true );
			this._background = null;

			this._line.removeFromParent( true );
			this._line = null;

			this._lineBarModel.dispose();
			this._lineBarModel = null;

			super.dispose();
		}
	}
}