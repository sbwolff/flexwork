package com.googlecode.flexwork.components
{
	//	import com.yahoo.maps.api.YahooMap;
	//	import com.yahoo.maps.api.YahooMapEvent;
	//	import com.yahoo.maps.api.core.location.Address;
	//	import com.yahoo.maps.webservices.geocoder.GeocoderResult;
	//	import com.yahoo.maps.webservices.geocoder.events.GeocoderEvent;
	import com.afcomponents.umap.control.*;
	import com.afcomponents.umap.core.UMap;
	import com.afcomponents.umap.providers.MapType;
	import com.afcomponents.umap.display.routemanager.*;
	import com.afcomponents.umap.gui.MapTypeControl;
	import com.afcomponents.umap.gui.PositionControl;
	import com.afcomponents.umap.gui.ScaleControl;
	import com.afcomponents.umap.gui.ZoomControl;
	import com.afcomponents.umap.types.LatLng;

	import mx.containers.Box;
	import mx.events.FlexEvent;
	import mx.events.ResizeEvent;

	import com.googlecode.flexdock.views.DockView;

	//http://www.afcomponents.com/tutorials/umap_as3/215/

	public class UMapView extends DockView
	{

		[Embed(source="assets/logo_map_umap.gif")]
		protected var iconClass:Class;

		private var map:UMap=null;
		private var mapContainer:Box=null;

		public function UMapView()
		{
			super();
			this.icon=iconClass;
			this.label="UMap";
			this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);


		}

		//var appid:String = Application.application.parameters.appid;
		override protected function createChildren():void
		{
			super.createChildren();

			if (null == mapContainer)
			{

				mapContainer=new Box();
				mapContainer.percentWidth=100;
				mapContainer.percentHeight=100;
				this.addChild(mapContainer);
			}
		}


		private function onCreationComplete(event:FlexEvent):void
		{
			if (null == map)
			{
				// create map
				map=new UMap();
				map.setSize(this.mapContainer.width, this.mapContainer.height);
				map.setCenter(new LatLng(40.736072, -73.992062), 5); //47.25976, 9.58423				
				// add map to canvas
				this.mapContainer.rawChildren.addChild(map); //

				this.addEventListener(ResizeEvent.RESIZE, handleContainerResize);

				map.addControl(new ZoomControl());
				map.addControl(new MapTypeControl());
				map.addControl(new ScaleControl());
				map.addControl(new PositionControl());
			}
		}

		private function handleContainerResize(event:ResizeEvent):void
		{
			// set the size of the map based on its containers size.
			map.setSize(this.mapContainer.width, this.mapContainer.height);
		}
	}
}