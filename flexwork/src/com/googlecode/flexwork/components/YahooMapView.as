package com.googlecode.flexwork.components
{
	import com.yahoo.maps.api.YahooMap;
	import com.yahoo.maps.api.YahooMapEvent;
	import com.yahoo.maps.api.core.location.Address;
	import com.yahoo.maps.webservices.geocoder.GeocoderResult;
	import com.yahoo.maps.webservices.geocoder.events.GeocoderEvent;

	import flash.geom.Point;

	import mx.containers.Box;
	import mx.events.FlexEvent;
	import mx.events.ResizeEvent;

	import com.googlecode.flexdock.views.DockView;

	//http://developer.yahoo.com/flash/maps/examples/YahooMap_FlexExample/srcview/index.html

	public class YahooMapView extends DockView
	{

		[Embed(source="assets/logo_map_yahoo.gif")]
		protected var iconClass:Class;

		private var map:YahooMap=null;
		private var mapContainer:Box=null;
		private var _address:Address;

		public function YahooMapView()
		{
			super();
			this.icon=iconClass;
			this.label="YahooMap";
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

				map=new YahooMap();
				//Alert.show("map is UIComponent=" + String(map is UIComponent));
				// list for the MAP_INITIALIZE event from YahooMap
				map.addEventListener(YahooMapEvent.MAP_INITIALIZE, handleMapInitialize);

				// initialize the map, passing the app-id, width and height.
				map.init("i6LijAHV34H618a7PHfVo1btdNFdJfIx3YsCqPnragIhFYR6HTh3tVBH5T.RHd2nA6nn", this.mapContainer.width, this.mapContainer.height); //
				this.mapContainer.rawChildren.addChild(map);

				this.addEventListener(ResizeEvent.RESIZE, handleContainerResize);

				map.addPanControl();
				map.addScaleBar();
				//				map.addCrosshair();
				map.addZoomWidget();
				map.addTypeWidget();
			}

		}



		private function handleMapInitialize(event:YahooMapEvent):void
		{
			// creating a new address object, passing our address string as the single parameter. 
			_address=new Address("141 pike st. seattle,wa");

			// listen for the GEOCODER_SUCCESS event dispatched when the data comes back from the webservice.
			_address.addEventListener(GeocoderEvent.GEOCODER_SUCCESS, handleGeocodeSuccess);

			// send the geocode request.
			_address.geocode();
		}

		private function handleGeocodeSuccess(event:GeocoderEvent):void
		{
			// retrieve the first result returned by the geocoder. 
			var result:GeocoderResult=_address.geocoderResultSet.firstResult;

			// then we'll get the zoom level and center latlon to position the map on. 
			map.zoomLevel=result.zoomLevel;
			map.centerLatLon=result.latlon;
			//			map.setCenterByPixels(new Point(40.736072, -73.992062));
		}

		private function handleContainerResize(event:ResizeEvent):void
		{
			// set the size of the map based on its containers size.
			map.setSize(this.mapContainer.width, this.mapContainer.height);
		}


	}
}