package com.googlecode.flexwork.work.components
{
	//	import com.yahoo.maps.api.YahooMap;
	//	import com.yahoo.maps.api.YahooMapEvent;
	//	import com.yahoo.maps.api.core.location.Address;
	//	import com.yahoo.maps.webservices.geocoder.GeocoderResult;
	//	import com.yahoo.maps.webservices.geocoder.events.GeocoderEvent;
	
	import com.adobe.flex.extras.controls.springgraph.Graph;
	import com.adobe.flex.extras.controls.springgraph.Item;
	import com.adobe.flex.extras.controls.springgraph.SpringGraph;
	import com.googlecode.flexwork.core.components.DockingView;
	import com.googlecode.flexwork.work.components.springGraphClasses.SpringGraphItemRenderer;
	import com.googlecode.flexwork.core.events.ToolBarEvent;
	
	import mx.core.ClassFactory;

	//http://www.afcomponents.com/tutorials/umap_as3/215/

	public class SpringGraphView extends DockingView
	{
		[Embed(source="assets/node.gif")]
		protected var iconNodeClass:Class;
		
		[Embed(source="assets/icon_springgraph.gif")]
		protected var iconClass:Class;

		private var g: Graph = new Graph();
        private var prevItem: Item;
        private var itemCount: int = 0;

		private var springGraph:SpringGraph;
		
		public function SpringGraphView()
		{
			super();
			this.icon=iconClass;
			this.label="SpringGraph";
//			this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
			
			initChildren();
		}

		protected function initChildren():void
		{
			
			
			if (null == springGraph)
			{
				springGraph = new SpringGraph();
				springGraph.percentWidth=100;
				springGraph.percentHeight=100;
				springGraph.setStyle("backgroundColor", 0x777777);
				springGraph.lineColor=0x6666FF;
				springGraph.itemRenderer = springGraphItemRendererFactory();
				springGraph.repulsionFactor=0.5;
				/*
				fc:SpringGraph id="s" backgroundColor="#777777" 
        lineColor="#6666ff" repulsionFactor="{repulsionSlider.value}" left="10" right="10" top="124" bottom="10">
        
    </fc:SpringGraph>*/
				//				canvas.percentWidth=70;
//				canvas.percentWidth=100;
//				canvas.percentHeight=100;
//				//				canvas.setStyle("borderStyle","solid");
//				//				canvas.setStyle("borderColor","CCCCCC"); 
//				canvas.setStyle("backgroundColor", 0xCEEEEE);
//				canvas.verticalScrollPolicy=ScrollPolicy.OFF;
//				canvas.horizontalScrollPolicy=ScrollPolicy.OFF;			
			}
		}
		override protected function createChildren():void
		{
			super.createChildren();
			this.addChild(springGraph);
		}
		private function springGraphItemRendererFactory():ClassFactory
		{
			var itemRendererFactory:ClassFactory = new ClassFactory();
			itemRendererFactory.generator = SpringGraphItemRenderer;
			itemRendererFactory.properties = {outerDocument: this};
			return itemRendererFactory;
		}
	
        private function newItem(): void {
            var item: Item = new Item(new Number(++itemCount).toString());
            g.add(item);
            if(prevItem != null){
                g.link(item, prevItem);
            }
            prevItem = item;
            this.springGraph.dataProvider = g;
        }
//        
//        private function linkItems(fromId: String, toId: String): void {
//            var fromItem: Item = g.find(fromId);
//            var toItem: Item = g.find(toId);
//            g.link(fromItem, toItem);
//            s.dataProvider = g;
//        }        
//        
//        private function unlinkItems(fromId: String, toId: String): void {
//            var fromItem: Item = g.find(fromId);
//            var toItem: Item = g.find(toId);
//            g.unlink(fromItem, toItem);
//            s.dataProvider = g;
//        }
        
        override protected function toolBarData():Array
		{	
			return [ //
				{name: "NewNode", icon: iconNodeClass, toolTip: "New Node"} //
							
				];
			
			
		}
        override public function onToolBarClick(event:ToolBarEvent):void
		{
			switch (event.name)
			{
				case "NewNode":
				{
					newItem();
					break;
				}
			}
		}

	}	
	
}