package
{
	import net.fpp.common.starling.StaticAssetManager;
	import net.fpp.common.starling.constant.CAspectRatio;
	import net.fpp.common.starling.display.AStarlingMain;

	import starling.core.Starling;

	[SWF(width="480", height="320", frameRate="60", backgroundColor="#000000")]
	public class Main extends AStarlingMain
	{
		public function Main()
		{
			this.setPreAppConfig();

			super();
		}

		override protected function onInit():void
		{
			this.createStarling( God );

			this.setAppConfig();
		}

		private function setPreAppConfig():void
		{
			this._aspectRatio = CAspectRatio.LANDSCAPE;

			StaticAssetManager.scaleFactor = 2;

			Starling.multitouchEnabled = true;
		}

		private function setAppConfig():void
		{
			this._starlingObject.simulateMultitouch = false;
			this._starlingObject.enableErrorChecking = false;
			this._starlingObject.antiAliasing = 3;

			Starling.current.showStats = true;
		}
	}
}