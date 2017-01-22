package
{
	import net.fpp.common.starling.StaticAssetManager;
	import net.fpp.common.starling.constant.CAspectRatio;
	import net.fpp.common.starling.core.AStarlingMain;

	import starling.core.Starling;

	[SWF(width="480", height="320", frameRate="60", backgroundColor="#000000")]
	public class Main extends AStarlingMain
	{
		public function Main()
		{
			this.setPreAppConfig();

			super();
		}

		private function setPreAppConfig():void
		{
			this._aspectRatio = CAspectRatio.LANDSCAPE;

			StaticAssetManager.scaleFactor = 2;

			Starling.multitouchEnabled = true;
		}

		override protected function onInit():void
		{
			this.createStarling( God );

			this.setAppConfig();
		}

		private function setAppConfig():void
		{
			this._starlingObject.simulateMultitouch = false;
			this._starlingObject.enableErrorChecking = false;
			this._starlingObject.antiAliasing = 3;

			Starling.current.showStats = true;
		}

		override protected function onStarlingRootCreated():void
		{
			var mainContext:God = this._starlingObject.root as God;
			mainContext.start();
		}
	}
}