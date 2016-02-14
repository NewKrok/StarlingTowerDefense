/**
 * Created by newkrok on 14/02/16.
 */
package starlingtowerdefense.game.service.level
{
	import starlingtowerdefense.vo.LevelDataVO;

	public class AreaDataVO
	{
		protected var _id:uint;

		protected var _jsonLevelDatas:Vector.<String> = new Vector.<String>;

		public var levelDatas:Vector.<LevelDataVO>;

		public function get jsonLevelDatas():Vector.<String>
		{
			return this._jsonLevelDatas;
		}

		public function get id():uint
		{
			return this._id;
		}
	}
}