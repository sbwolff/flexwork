package com.googlecode.flexwork.components
{

	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;

	import mx.binding.utils.*;
	import mx.containers.*;
	import mx.controls.*;
	import mx.core.*;
	import mx.events.*;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.mxml.HTTPService;

	import com.googlecode.flexdock.views.DockView
	;


	//http://www.airia.cn/FLEX_Directory/Flex_httpservice/
	public class FlickrView1 extends DockView
	{
		//Flickr RSS feed 的命名空间是 http://www.w3.org/2005/Atom。你必须定义一个命名空间，然后设置他的唯一URL，然后将用户语句包含到命名空间中。否则你不能存取加载进来的XML文档的内容。
		private namespace atom="http://www.w3.org/2005/Atom";

		use namespace atom;

		[Bindable]
		private var photoFeed:XMLList=null;

		private var photoService:HTTPService=null;
		private var photoRepeater:Repeater=null;

		public function FlickrView1()
		{
			this.label="Flickr";
			this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
			//
			photoService=new HTTPService();
			photoService.url="http://api.flickr.com/services/feeds/photos_public.gne";
			photoService.resultFormat="e4x";
			photoService.addEventListener(ResultEvent.RESULT, onPhotoResult);
			photoService.addEventListener(FaultEvent.FAULT, onPhotoFault);
		}

		//          <mx:Fade id="fadeIn" duration="3000" alphaFrom="0" alphaTo="1"/>
		//    <mx:Fade id="fadeOut" duration="3000" alphaFrom="1" alphaTo="0"/>

		override protected function createChildren():void
		{
			super.createChildren();

			var tile:Tile=new Tile();
			tile.percentWidth=100;
			tile.percentHeight=100;
			this.addChild(tile);
			//
			photoRepeater=new Repeater();
			photoRepeater.dataProvider="{photoFeed}";
			photoRepeater.id="photoRepeater";
			tile.addChild(photoRepeater);
			//
			var vbox:VBox=new VBox();
			vbox.setStyle("horizontalAlign", "center");
			photoRepeater.addChild(vbox);
			//
			var image:Image=new Image();
			image.id="image";
			image.source=parseImageUrl(photoRepeater.currentItem.content);
			//image.completeEffect={fadeIn}";			
			vbox.addChild(image);
			//
			var text:Text=new Text();
			text.text=photoRepeater.currentItem.title;
			vbox.addChild(text);
			//
			//			<mx:LinkButton 
			//                        label="{photos.currentItem.author.name}"
			//                        click="openAuthorPage(event);"
			//                    />  
		}


		private function onCreationComplete(event:FlexEvent):void
		{
			photoService.send();
		}

		private function onPhotoResult(event:ResultEvent):void
		{
			var xml:XML=event.result as XML;
			if (null != xml)
			{
				photoRepeater.dataProvider=xml.entry;
					//photoFeed
			}

		}

		private function onPhotoFault(event:FaultEvent):void
		{
			Alert.show(event.fault.message, "Could not load photo feed");
		}

		private function parseImageUrl(fromHtml:XMLList):String
		{

			var pattern:RegExp=/img src="(.+?)" /;
			var results:Array=pattern.exec(fromHtml);
			var imageURL:String=results[1]; // backreference 1 from pattern

			return imageURL;
		}


	}
}