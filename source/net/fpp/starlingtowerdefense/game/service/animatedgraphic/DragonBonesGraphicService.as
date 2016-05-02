/**
 * Created by newkrok on 13/01/16.
 */
package net.fpp.starlingtowerdefense.game.service.animatedgraphic
{
	import dragonBones.Armature;
	import dragonBones.factories.StarlingFactory;

	import flash.events.Event;

	import flash.utils.ByteArray;

	import starling.events.EventDispatcher;

	import assets.UnitAssets;
	import net.fpp.starlingtowerdefense.game.service.animatedgraphic.events.DragonBonesGraphicServiceEvent;

	public class DragonBonesGraphicService extends EventDispatcher
	{
		private var _unitAssets:ByteArray;
		private var _dragonBonesFactory:StarlingFactory;

		public function DragonBonesGraphicService()
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

			this.dispatchEvent( new DragonBonesGraphicServiceEvent( DragonBonesGraphicServiceEvent.COMPLETE ) );
		}

		public function buildArmature( name:String ):Armature
		{
			return this._dragonBonesFactory.buildArmature( name );
		}

		public function getTextureDisplay( name:String ):Object
		{
			return this._dragonBonesFactory.getTextureDisplay( name );
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