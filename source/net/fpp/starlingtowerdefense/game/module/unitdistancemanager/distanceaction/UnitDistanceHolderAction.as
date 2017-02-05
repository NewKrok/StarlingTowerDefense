/**
 * Created by newkrok on 19/07/16.
 */
package net.fpp.starlingtowerdefense.game.module.unitdistancemanager.distanceaction
{
	import net.fpp.common.util.GeomUtil;
	import net.fpp.starlingtowerdefense.game.module.unitdistancemanager.vo.UnitDistanceVO;

	import starling.display.DisplayObject;

	public class UnitDistanceHolderAction implements IUnitDistanceAction
	{
		private const PUSHING_FORCE_WITH_SAME_RADIUS:Number = .8;
		private const PUSHING_FORCE_WITH_DIFFERENT_RADIUS:Number = 5;

		public function execute( value:UnitDistanceVO ):void
		{
			var unitARadius:Number = value.unitA.getSizeRadius();
			var unitBRadius:Number = value.unitB.getSizeRadius();

			if( value.distance < unitARadius / 2 + unitBRadius / 2 && value.unitA.getTarget() == null && value.unitB.getTarget() == null )
			{
				var unitAView:DisplayObject = value.unitA.getView();
				var unitBView:DisplayObject = value.unitB.getView();

				var unitAOffset:Number = 0;
				var unitBOffset:Number = 0;

				if( unitARadius == unitBRadius )
				{
					unitAOffset = unitBOffset = this.PUSHING_FORCE_WITH_SAME_RADIUS;
				}
				else if( unitARadius > unitBRadius )
				{
					unitAOffset = 0;
					unitBOffset = this.PUSHING_FORCE_WITH_DIFFERENT_RADIUS;
				}
				else
				{
					unitAOffset = this.PUSHING_FORCE_WITH_DIFFERENT_RADIUS;
					unitBOffset = 0;
				}

				var angle:Number = GeomUtil.atan2( unitAView.y - unitBView.y, unitAView.x - unitBView.x );

				value.unitA.setPosition( unitAView.x + unitAOffset * Math.cos( angle ), unitAView.y + unitAOffset * Math.sin( angle ) );
				value.unitB.setPosition( unitBView.x - unitBOffset * Math.cos( angle ), unitBView.y - unitBOffset * Math.sin( angle ) );
			}
		}
	}
}