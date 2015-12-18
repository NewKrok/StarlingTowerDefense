/**
 * Created by newkrok on 18/12/15.
 */
package
{
	import net.fpp.starling.StaticAssetManager;

	import starling.core.Starling;
	import starling.display.Sprite;

	import starlingtowerdefense.assets.EmbeddedAssets2x;

	public class God extends Sprite
	{
		public function start():void
		{
			this.loadAssets();
		}

		private function loadAssets():void
		{
			StaticAssetManager.instance.enqueue( EmbeddedAssets2x );
			StaticAssetManager.instance.loadQueue( this.onLoadQueue );
		}

		private function onLoadQueue( ratio:Number ):void
		{
			if( ratio == 1 )
			{
				this.init();
			}
		}

		private function init():void
		{
			trace('inited')
		}
	}
}