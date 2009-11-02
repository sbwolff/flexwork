package com.googlecode.flexwork.components
{
	import mx.events.FlexEvent;

	import com.googlecode.flexdock.views.DockView;
	import com.adobe.webapis.youtube.YouTubeService;
	import com.adobe.webapis.youtube.events.YouTubeServiceEvent;
	import com.adobe.webapis.youtube.methodgroups.Videos;

	//http://www.seantheflashguy.com/flex/YouTubeBasicExample/
	public class YouTubeView1 extends DockView
	{

		private var YOUTUBE_API_KEY:String=" YOUR YOUTUBE API KEY HERE ";
		[Bindable]
		private var featuredVideos:ArrayCollection

		public function YouTubeView1()
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
			this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);

		}

		private function onCreationComplete(event:FlexEvent):void
		{
			CursorManager.setBusyCursor();
			setupYTService();
		}

		private function setupYTService():void
		{
			// Create the YouTube service. This is the entry point
			// into the youtubelib API.
			var youTubeService:YouTubeService=new YouTubeService(YOUTUBE_API_KEY);
			// Register the method that will be used to handle the
			// "featured" video data from the YouTube service.
			youTubeService.addEventListener(YouTubeServiceEvent.VIDEOS_LIST_FEATURED, onFeaturedVideos);
			// Use an instance of the Videos class to make the 
			// actual call to retrieve the videos array from YouTube.
			// NOTE: The videosList property that is returned from the
			// youtubelib API will contain the top 100 "featured" YouTube
			// videos.
			var vids:Videos=new Videos(youTubeService);
			// Asynchronous call to get 100 "featured" YouTube videos
			// This method call is handled by the onFeaturedVideos method.
			vids.listFeatured();
		}

		private function onFeaturedVideos(event:YouTubeServiceEvent):void
		{
			var vids:Array=event.data.videoList;
			var vidsArray:Array=new Array();

			// Step through the first ten "featured" YouTube videos.
			// Create a VideoVO object instance on each pass through
			// the for loop. Push the VideoVO object into vidsArray.
			for (var i:uint=0; i < 9; i++)
			{
				var videoVO:Object=new VideoVO();
				videoVO.author=vids[i].author;
				videoVO.title=vids[i].title;
				videoVO.lengthSeconds=vids[i].lengthSeconds;
				videoVO.ratingAvg=vids[i].ratingAvg;
				videoVO.ratingCount=vids[i].ratingCount;
				videoVO.description=vids[i].description;
				videoVO.viewCount=vids[i].viewCount;
				videoVO.commentCount=vids[i].commentCount;
				videoVO.tags=vids[i].tags;
				videoVO.url=vids[i].url;
				videoVO.thumbnailUrl=vids[i].thumbnailUrl;
				videoVO.playerURL=vids[i].playerURL;
				vidsArray.push(videoVO);
			}

			// Populate the YTFeatVideosTileList's dataProvider.
			// NOTE: List based Flex components should have thier
			// dataProvider's data set as an ArrayCollection, vs an
			// array for example.
			featuredVideos=new ArrayCollection(vidsArray);
			YTFeatVideosTileList.visible=true;
			CursorManager.removeBusyCursor();
		}

		/**
		 * Handle mouse down gesture by launching the Video's url
		 * in a new (_blank) browser window.
		 */
		private function onTileListClicked(event:Event):void
		{
			var request:URLRequest=new URLRequest(event.currentTarget.selectedItem.url);
			navigateToURL(request, "_blank");
		}
	}
}