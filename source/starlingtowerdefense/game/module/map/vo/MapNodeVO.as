/**
 * Created by newkrok on 13/03/16.
 */
package starlingtowerdefense.game.module.map.vo
{
	public class MapNodeVO
	{
		public var h:Number;
		public var g:Number;
		public var f:Number;
		public var parent:MapNodeVO;

		public var x:Number;
		public var y:Number;

		public var isWalkable:Boolean = true;

		public function MapNodeVO( x:Number, y:Number )
		{
			this.x = x;
			this.y = y;
		}
	}
}