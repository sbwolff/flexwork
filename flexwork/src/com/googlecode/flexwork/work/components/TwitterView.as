package com.googlecode.flexwork.work.components
{
	import mx.controls.*;
	import mx.core.ScrollPolicy;
	import mx.events.FlexEvent;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.mxml.HTTPService;

	import com.googlecode.flexwork.core.components.DockingView;

	public class TwitterView extends DockingView
	{

		[Embed(source="/assets/text.gif")]
		private var iconClass:Class;


		private var datagrid:DataGrid=null;
		private var httpService:HTTPService=null;


		[Bindable]
		private var _tweets:XMLList;


		public function TwitterView()
		{
			super();
			this.icon=iconClass;
			this.label="Twitter";

			httpService=new HTTPService("http://twitter.com/status/user_timeline/nathanpdaniel");
			httpService.addEventListener(ResultEvent.RESULT, onRes);
			httpService.addEventListener(FaultEvent.FAULT, onFault);

			this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
		}


		override protected function createChildren():void
		{
			super.createChildren();
			if (!datagrid)
			{
				datagrid=new DataGrid();
				datagrid.setStyle("borderThickness", 0);

				datagrid.setStyle("paddingTop", 0);
				datagrid.setStyle("paddingBottom", 0);

				datagrid.headerHeight=19;
				datagrid.rowHeight=16;
				datagrid.verticalScrollPolicy=ScrollPolicy.AUTO;
				datagrid.horizontalScrollPolicy=ScrollPolicy.AUTO;
				datagrid.percentWidth=100;
				datagrid.percentHeight=100;
				datagrid.dataProvider=_tweets;
				this.addChild(datagrid);
			}
		}

		private function onCreationComplete(event:FlexEvent):void
		{
			//httpService.send();
		}

		private function onRes(event:ResultEvent):void
		{
			_tweets=new XMLList(event.result.status);
		}

		private function onFault(event:FaultEvent):void
		{
			Alert.show("Unable to load feed!", "Error");
		}

	}
}