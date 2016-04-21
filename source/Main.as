package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.media.SoundMixer;
	import flash.system.Capabilities;

	import starling.events.Event;

	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;

	CONFIG::IS_MOBILE_VERSION
	{
		import flash.media.AudioPlaybackMode;
	}

	import net.fpp.starling.StaticAssetManager;

	import starling.core.Starling;

	[SWF(width="480", height="320", frameRate="60", backgroundColor="#000000")]
	public class Main extends Sprite
	{
		private var _starlingObject:*;

		public function Main()
		{
			this.addEventListener( flash.events.Event.ADDED_TO_STAGE, this.initSWF );
		}

		private function initSWF( e:flash.events.Event ):void
		{
			this.removeEventListener( flash.events.Event.ADDED_TO_STAGE, initSWF );

			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP;

			CONFIG::IS_MOBILE_VERSION
			{
				SoundMixer.audioPlaybackMode = AudioPlaybackMode.AMBIENT;
			}

			StaticAssetManager.scaleFactor = 2;

			var isIOS:Boolean = Capabilities.manufacturer.indexOf( "iOS" ) != -1;

			Starling.multitouchEnabled = true;

			if( isIOS )
			{
				this.initIOSVersion();
			}
			else
			{
				this.initPCVersion();
			}
		}

		private function initIOSVersion():void
		{
			var viewPort:Rectangle = this.getIOSLandscapeViewPort();

			this.initStarling( viewPort );
		}

		private function getIOSLandscapeViewPort():Rectangle
		{
			var viewPort:Rectangle = new Rectangle();

			viewPort.setTo(
					0,
					0,
					( this.stage.fullScreenWidth / this.stage.fullScreenHeight != 480 / 320 ) ? 568 : 480,
					320
			)

			viewPort = RectangleUtil.fit(
					new Rectangle( 0, 0, this.stage.stageWidth, this.stage.stageHeight ),
					new Rectangle( 0, 0, this.stage.fullScreenWidth, this.stage.fullScreenHeight ),
					ScaleMode.SHOW_ALL, true
			);

			return viewPort;
		}

		private function initPCVersion():void
		{
			var viewPort:Rectangle = this.getPCLandscapeViewPort();

			this.initStarling( viewPort );
		}

		private function getPCLandscapeViewPort():Rectangle
		{
			var viewPort:Rectangle = new Rectangle();

			viewPort.setTo(
					0,
					0,
					( this.stage.stageWidth / this.stage.stageHeight != 480 / 320 ) ? 568 : 480,
					320
			)

			viewPort = RectangleUtil.fit(
					new Rectangle( 0, 0, this.stage.stageWidth, this.stage.stageHeight ),
					new Rectangle( 0, 0, this.stage.stageWidth, this.stage.stageHeight ),
					ScaleMode.SHOW_ALL, true
			);

			return viewPort;
		}

		private function initStarling( viewPort:Rectangle ):void
		{
			this._starlingObject = new Starling( God, stage, viewPort, null, "auto", "auto" );
			this._starlingObject.stage.stageWidth = this.stage.stageWidth;
			this._starlingObject.stage.stageHeight = this.stage.stageHeight;
			this._starlingObject.simulateMultitouch = false;
			this._starlingObject.enableErrorChecking = false;
			this._starlingObject.antiAliasing = 3;

			Starling.current.showStats = true;

			this._starlingObject.addEventListener( starling.events.Event.ROOT_CREATED, this.starlingRootCreated );
		}

		private function starlingRootCreated( e:starling.events.Event ):void
		{
			var god:God = this._starlingObject.root as God;
			god.start();

			this._starlingObject.start();
		}
	}
}