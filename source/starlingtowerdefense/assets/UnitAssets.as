/**
 * Created by newkrok on 13/01/16.
 */
package starlingtowerdefense.assets
{
	import flash.utils.ByteArray;

	public class UnitAssets
	{
		[Embed(source = "../../../assets/texture/unit_atlas.dbswf", mimeType = "application/octet-stream")]
		private static const ResourcesData:Class;

		public function getResourcesDataObject():ByteArray
		{
			return new ResourcesData();
		}
	}
}