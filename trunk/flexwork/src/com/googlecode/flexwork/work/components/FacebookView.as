package com.googlecode.flexwork.work.components
{
	import com.googlecode.flexwork.core.components.DockingView;

	import flash.events.Event;


	public class FacebookView extends DockingView
	{

		[Embed(source="/assets/text.gif")]
		private var iconClass:Class;


		public function FacebookView()
		{
			super();
			this.label="Facebook";
		}


		override protected function createChildren():void
		{
			super.createChildren();
			if (null != map)
			{
				//				this.map.addEventListener(MapEvent.MAP_READY, onMapReady);
				//				this.addChild(map);
			}
			//			this.map.key="ABQIAAAA9cp0V2dBzGwfuKQP75tb3hS2-CMcR61MtLXStQf53r7KqAH1nhSBS9odQHjndXSWzkBX_jQyCwqqvA";
			//			this.addChild(map);
		}



		//		private function onMapPreinitialize(event:MapEvent):void
		//		{
		//			var myMapOptions:MapOptions=new MapOptions();
		//			myMapOptions.zoom=12;
		//			myMapOptions.center=new LatLng(40.756054, -73.986951);
		//			myMapOptions.mapType=MapType.NORMAL_MAP_TYPE;
		//			myMapOptions.viewMode=com.google.maps.View.VIEWMODE_PERSPECTIVE;
		//			myMapOptions.attitude=new Attitude(20, 30, 0);
		//			map.setInitOptions(myMapOptions);
		//		}
		//
		//		private function onMapReady(event:Event):void
		//		{
		//			//			this.map.setInitOptions(new MapOptions({
		//			//							viewMode : com.google.maps.View.VIEWMODE_PERSPECTIVE,
		//			//							attitude : new Attitude(0, 0, 0)
		//			//						})); 
		//
		//			this.map.setCenter(new LatLng(40.736072, -73.992062), 14, MapType.NORMAL_MAP_TYPE);
		//		}
	}
}