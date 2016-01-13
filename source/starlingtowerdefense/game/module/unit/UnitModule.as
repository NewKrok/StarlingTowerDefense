/**
 * Created by newkrok on 07/01/16.
 */
package starlingtowerdefense.game.module.unit
{
	import net.fpp.starling.module.AModule;

	import caurina.transitions.Tweener

	import starlingtowerdefense.game.module.unit.view.UnitView;
	import starlingtowerdefense.game.service.animatedgraphic.AnimatedGraphicService;

	public class UnitModule extends AModule implements IUnitModule
	{
		private var _speed:Number = 200; // pixel / sec

		private var _unitView:UnitView;

		public function UnitModule( animatedGraphicService:AnimatedGraphicService ):void
		{
			this._view = new UnitView( animatedGraphicService );
			this._unitView = this._view as UnitView;
		}

		public function moveTo( x:Number, y:Number ):void
		{
			if ( x == this._view.x && y == this._view.y )
			{
				return;
			}

			this._view.scaleX = this.calculateScaleByEndX( x );

			Tweener.removeTweens( this._unitView );

			Tweener.addTween( this._unitView, {
				x: x,
				y: y,
				time: this.calculateMoveTimeByEndPosition( x, y ),
				transition: 'linear',
				onComplete: this.onMoveEnd
			} );

			this._unitView.run();
		}

		private function calculateScaleByEndX( x:Number ):Number
		{
			return this._view.x > x ? 1 : -1;
		}

		private function calculateMoveTimeByEndPosition( x:Number, y:Number ):Number
		{
			var distanceX:Number = this._view.x - x;
			var distanceY:Number = this._view.y - y;

			var distance:Number = Math.sqrt( Math.pow( distanceX, 2 ) + Math.pow( distanceY, 2 ) );

			return distance / _speed;
		}

		private function onMoveEnd():void
		{
			this._unitView.idle();
		}

		public function setPosition( x:Number, y:Number ):void
		{
			this._unitView.x = x;
			this._unitView.y = y;
		}

		public function attack():void
		{
			Tweener.removeTweens( this._unitView );

			this._unitView.attack();
		}
	}
}