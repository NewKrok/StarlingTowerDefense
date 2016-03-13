/**
 * Created by newkrok on 13/03/16.
 */
package starlingtowerdefense.game.module.map
{
	import starlingtowerdefense.game.module.map.vo.MapNodeVO;

	public interface IMapModule
	{
		function getMapNodes():Vector.<Vector.<MapNodeVO>>;
	}
}