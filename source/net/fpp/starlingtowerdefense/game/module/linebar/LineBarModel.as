/**
 * Created by newkrok on 26/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.linebar
{
	import net.fpp.common.starling.module.AModel;

	public class LineBarModel extends AModel
	{
		private var percentage:Number = 0;

		public function setPercentage( value:Number ):void
		{
			this.percentage = value;
		}

		public function getPercentage():Number
		{
			return this.percentage;
		}
	}
}