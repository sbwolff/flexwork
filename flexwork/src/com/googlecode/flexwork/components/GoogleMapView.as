package com.googlecode.flexwork.components
{
	import com.google.maps.*;
	import com.google.maps.services.*;
	import com.google.maps.controls.*;
	import com.google.maps.geom.*;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	import com.google.maps.styles.FillStyle;
	import com.google.maps.styles.StrokeStyle;
	import com.googlecode.flexdock.views.DockView;
	import com.googlecode.flexwork.events.MessageEvent;
	import flash.events.Event;

	public class GoogleMapView extends DockView
	{

		[Embed(source="assets/logo_map_google.gif")]
		protected var iconClass:Class;


		private var map:Map3D=null;
//		private var geocoder:ClientGeocoder=null;

		public function GoogleMapView()
		{
			super();
			this.icon=iconClass;
			this.label="GoogleMap";
			this.map=new Map3D();
			//			this.map.setStyle("borderThickness", 0);
			//this.map.setStyle("border", 0);
			this.map.percentWidth=100;
			this.map.percentHeight=100;

			this.map.addControl(new NavigationControl());
			this.map.addControl(new MapTypeControl());
			//this.map.enableScrollWheelZoom();
			this.map.addEventListener(MapEvent.MAP_READY, onMapReady);
			this.map.addEventListener(MapEvent.MAP_PREINITIALIZE, onMapPreinitialize);

		}


		override protected function createChildren():void
		{
			super.createChildren();
			if (null == map)
			{
				//				this.map.addEventListener(MapEvent.MAP_READY, onMapReady);
				//				this.addChild(map);
			}
			this.map.key="ABQIAAAA9cp0V2dBzGwfuKQP75tb3hS2-CMcR61MtLXStQf53r7KqAH1nhSBS9odQHjndXSWzkBX_jQyCwqqvA";
			this.addChild(map);
			//
//			if (null == geocoder)
//			{
//				
//			}

			this.subscribe(MessageEvent.CITY_DOUBLE_CLICK, onCityDoubleClick);
		}

		private function onCityDoubleClick(event:MessageEvent):void
		{
			var node:XML=event.value as XML;
			//			var x:Number = Number(node.@x);
			//			var y:Number = Number(node.@y);
			//			addSimpleMarker(x, y);
			map.clearOverlays();
			var geocoder:ClientGeocoder = new ClientGeocoder();
				geocoder.addEventListener(GeocodingEvent.GEOCODING_SUCCESS, onGeocodingSuccess);
				geocoder.addEventListener(GeocodingEvent.GEOCODING_FAILURE, onGeocodingFailure);
			
			geocoder.geocode(node.@label);
		}

		private function onGeocodingSuccess(event:GeocodingEvent):void
		{
			var placemarks:Array=event.response.placemarks;
			if (placemarks.length > 0)
			{
				map.setCenter(placemarks[0].point);
				var marker:Marker=new Marker(placemarks[0].point);
				map.addOverlay(marker);
//				marker.addEventListener(MapEvent..CLICK, function(event:MapEvent):void
//					{
//						marker.openInfoWindow(new InfoWindowOptions({title: "Geocoded Result", content: placemarks[0].address}));
//					});
			}

		}

		private function onGeocodingFailure(event:GeocodingEvent):void
		{
			this.logError("Geocoding failed");
		}


		private function onMapPreinitialize(event:MapEvent):void
		{
			var mapOptions:MapOptions=new MapOptions();
			mapOptions.zoom=12;
			mapOptions.center=new LatLng(40.736072, -73.992062);
			mapOptions.mapType=MapType.NORMAL_MAP_TYPE;
			mapOptions.viewMode=com.google.maps.View.VIEWMODE_PERSPECTIVE;
			mapOptions.attitude=new Attitude(0, 0, 0);//new Attitude(0, 20, 0);
			map.setInitOptions(mapOptions);
		}

		private function onMapReady(event:Event):void
		{
			//			this.map.setInitOptions(new MapOptions({
			//							viewMode : com.google.maps.View.VIEWMODE_PERSPECTIVE,
			//							attitude : new Attitude(0, 0, 0)
			//						})); 

			this.map.setCenter(new LatLng(40.736072, -73.992062), 12, MapType.NORMAL_MAP_TYPE);
		}

		private function addSimpleMarker(x:Number, y:Number):void
		{
			var latLng:LatLng=new LatLng(x, y);
			var marker:Marker=new Marker(latLng, new MarkerOptions({strokeStyle: new StrokeStyle({color: 0x987654}), fillStyle: new FillStyle({color: 0x223344, alpha: 0.8}), radius: 12, hasShadow: true}));
			map.setCenter(latLng, 12, MapType.NORMAL_MAP_TYPE);
			map.addOverlay(marker);

		}
	}
}