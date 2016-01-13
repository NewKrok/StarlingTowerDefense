/**
 * Created by newkrok on 13/01/16.
 */
package starlingtowerdefense.game.service.animatedgraphic
{
	import dragonBones.Armature;
	import dragonBones.factories.StarlingFactory;

	import flash.events.Event;

	import flash.utils.ByteArray;

	import starling.events.EventDispatcher;

	import starlingtowerdefense.assets.UnitAssets;
	import starlingtowerdefense.game.service.animatedgraphic.events.AnimatedGraphicServiceEvent;

	public class AnimatedGraphicService extends EventDispatcher
	{
		private var _unitAssets:ByteArray;
		private var _dragonBonesFactory:StarlingFactory;

		public function AnimatedGraphicService()
		{
			this.loadUnitAssets( new UnitAssets().getResourcesDataObject() );
		}

		private function loadUnitAssets( unitAssets:ByteArray ):void
		{
			this._unitAssets = unitAssets;

			this._dragonBonesFactory = new StarlingFactory()
			this._dragonBonesFactory.addEventListener( Event.COMPLETE, this.onCompleteHandler );
			this._dragonBonesFactory.parseData( this._unitAssets );
		}

		private function onCompleteHandler( e:Event ):void
		{
			this._dragonBonesFactory.removeEventListener( Event.COMPLETE, this.onCompleteHandler );

			this.dispatchEvent( new AnimatedGraphicServiceEvent( AnimatedGraphicServiceEvent.COMPLETE ) );
		}

		public function buildArmature( name:String ):Armature
		{
			var armature:Armature = this._dragonBonesFactory.buildArmature( name );

			return armature;
		}

		public function dispose():void
		{
			if ( this._unitAssets )
			{
				this._unitAssets.clear();
				this._unitAssets = null;
			}

			if ( this._dragonBonesFactory )
			{
				this._dragonBonesFactory.removeEventListener( Event.COMPLETE, this.onCompleteHandler );
				this._dragonBonesFactory.dispose( true );
				this._dragonBonesFactory = null;
			}
		}
	}
}