package com.googlecode.flexwork.work.components
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
	import com.afcomponents.umap.display.geocodermanager.*;
	import com.afcomponents.umap.gui.MapTypeControl;
	import com.afcomponents.umap.gui.PositionControl;
	import com.afcomponents.umap.gui.ScaleControl;
	import com.afcomponents.umap.gui.ZoomControl;
	import com.afcomponents.umap.types.LatLng;
	import com.afcomponents.umap.events.*;
	import com.afcomponents.umap.overlays.*;
	import com.googlecode.flexwork.core.events.MessageEvent;
	import mx.containers.Box;
	import mx.events.FlexEvent;
	import mx.events.ResizeEvent;
	import com.afcomponents.umap.providers.microsoft.MapPointProxy;
	import com.afcomponents.umap.providers.microsoft.MapPointTokenRequest;
	import com.afcomponents.umap.events.MapPointProxyEvent;
	import com.googlecode.flexwork.core.components.DockingView;

	//http://www.afcomponents.com/tutorials/umap_as3/215/
	//Geo https://www.afcomponents.com/tutorials/umap_as3/208/print/
	//http://www.afcomponents.com/content/documentation/umap_as3/com/afcomponents/umap/display/geocodermanager/BingGeocodeService.html
	public class UMapView extends DockingView
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
			}
			this.addChild(mapContainer);
			this.subscribe(MessageEvent.SAMPLE_CITY_DOUBLE_CLICK, onCityDoubleClick);
		}


		private function onCreationComplete(event:FlexEvent):void
		{
			if (null == map)
			{
				// create map
				map=new UMap();
				map.setSize(this.mapContainer.width, this.mapContainer.height);
				map.setCenter(new LatLng(40.736072, -73.992062), 12); //47.25976, 9.58423				
				// add map to canvas
				this.mapContainer.rawChildren.addChild(map); //

				this.addEventListener(ResizeEvent.RESIZE, onContainerResize);

				map.addControl(new ZoomControl());
				map.addControl(new MapTypeControl());
				map.addControl(new ScaleControl());
				map.addControl(new PositionControl());
			}

		}

		private function onCityDoubleClick(event:MessageEvent):void
		{
			var node:XML=event.value as XML;
			var geo:GeocoderManager=new GeocoderManager();





			var layer:Layer;
			geo.addEventListener(GeocoderEvent.SUCCESS, function(event:GeocoderEvent):void
				{
					if (layer != null)
					{
						layer.clearOverlays();
					}
					layer=geo.getLayer(event.results);
					map.addOverlay(layer);
					map.setBounds(layer.getBoundsLatLng());
				});

			geo.addEventListener(GeocoderEvent.ERROR, function(event:GeocoderEvent):void
				{
					//					this.logError("GeocoderEvent");
					trace(event);
				});

			//geo.service.geocodeAddress(node.@label, 20, {verbosity: GeoNamesService.FULL});
			//geo.service.geocodeAddress(node.@label, 20);



			// initalize proxy
			MapPointProxy.initialize("http://www.umapper.com/demo/dmitry/msproxy.php");

			// request token, and wait for valid token
			var proxy:MapPointProxy=MapPointProxy.getInstance();

			proxy.addEventListener(MapPointProxyEvent.REQUEST_COMPLETE, function(event:MapPointProxyEvent):void
				{
					if (event.request is MapPointTokenRequest)
					{
						// token ready, perform geocoding
						geo.service.geocodeAddress(node.@label, 20);
					}
				});
			proxy.getToken();
		}

		private function onContainerResize(event:ResizeEvent):void
		{
			// set the size of the map based on its containers size.
			map.setSize(this.mapContainer.width, this.mapContainer.height);
		}
	}
}