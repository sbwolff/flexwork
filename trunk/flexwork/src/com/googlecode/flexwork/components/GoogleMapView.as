package com.googlecode.flexwork.components
{
	import com.googlecode.flexdock.views.DockView;

	import flash.events.Event;

	import com.google.maps.*;
	import com.google.maps.controls.*;
	import com.google.maps.geom.*;

	public class GoogleMapView extends DockView
	{

		[Embed(source="assets/logo_map_google.gif")]
		protected var iconClass:Class;


		private var map:Map3D=null;

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
		}

		private function onMapPreinitialize(event:MapEvent):void
		{
			var mapOptions:MapOptions=new MapOptions();
			mapOptions.zoom=12;
			mapOptions.center=new LatLng(40.756054, -73.986951);
			mapOptions.mapType=MapType.NORMAL_MAP_TYPE;
			mapOptions.viewMode=com.google.maps.View.VIEWMODE_PERSPECTIVE;
			mapOptions.attitude=new Attitude(20, 30, 0);
			map.setInitOptions(mapOptions);
		}

		private function onMapReady(event:Event):void
		{
			//			this.map.setInitOptions(new MapOptions({
			//							viewMode : com.google.maps.View.VIEWMODE_PERSPECTIVE,
			//							attitude : new Attitude(0, 0, 0)
			//						})); 

			this.map.setCenter(new LatLng(40.736072, -73.992062), 14, MapType.NORMAL_MAP_TYPE);
		}
	}
}