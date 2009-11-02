package com.googlecode.flexwork.components.birdeyeClasses
{
	import com.googlecode.flexdock.components.ToolBarPopUpMenuButton;
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	import mx.events.MenuEvent;
	import mx.core.ClassFactory;

	import mx.controls.Menu;
	import org.un.cava.birdeye.ravis.graphLayout.visual.VisualGraph;
	import org.un.cava.birdeye.ravis.components.renderers.nodes.*;

	public class NodeRendererPopUpMenuButton extends ToolBarPopUpMenuButton
	{

		[Embed(source="assets/node.gif")]
		protected var iconNodeClass:Class;

		private var _visualGraph:VisualGraph;

		public function NodeRendererPopUpMenuButton()
		{
			super();
			//
			this.setStyle("icon", iconNodeClass);
			this.width=33;
			this.styleName="toolBarPopUpViewMenuButton";
			//
			this.toolTip="Node Type";
			//			
			this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
			this.addEventListener(MenuEvent.ITEM_CLICK, onItemClick);
		}

		private function onCreationComplete(event:FlexEvent):void
		{
			this.dataProvider=new ArrayCollection([ //
				{groupName: "nodeRendererGroup", type: "radio", name: "Default", label: "Default"}, //
				{groupName: "nodeRendererGroup", type: "radio", name: "Basic", label: "Basic"}, //
				{groupName: "nodeRendererGroup", type: "radio", name: "Basic+Effects", label: "Basic+Effects"}, //
				{groupName: "nodeRendererGroup", type: "radio", name: "SimpleCircle", label: "SimpleCircle"}, //	
				{groupName: "nodeRendererGroup", type: "radio", name: "SimpleCircle+Effects", label: "SimpleCircle+Effects"}, //
				{groupName: "nodeRendererGroup", type: "radio", name: "Icons", label: "Icons", toggled: "true"}, //
				{groupName: "nodeRendererGroup", type: "radio", name: "Rotated Rectangle", label: "Rotated Rectangle"}, //
				{groupName: "nodeRendererGroup", type: "radio", name: "Size by Value", label: "Size by Value"}, //						
				{groupName: "nodeRendererGroup", type: "radio", name: "WFB", label: "WFB"} //
				] //
				); //

		}

		private function onItemClick(event:MenuEvent):void
		{event.stopImmediatePropagation();
			var nodeName:String=event.item.name;
			changeNodeRenderer(nodeName);
		}


		public function changeNodeRenderer(nodeName:String="Icons"):void
		{


			if (_visualGraph == null)
			{
				//					LogUtil.warn(_LOG, "Cannot change NodeRenderer, no valid vgraph!");
				return;
			}


			switch (nodeName)
			{
				case "Default":
					_visualGraph.itemRenderer=new ClassFactory(DefaultNodeRenderer);
					break;
				case "Basic":
					_visualGraph.itemRenderer=new ClassFactory(BaseNodeRenderer);
					break;
				case "Basic+Effects":
					_visualGraph.itemRenderer=new ClassFactory(EffectBaseNodeRenderer);
					break;
				case "SimpleCircle":
					_visualGraph.itemRenderer=new ClassFactory(SimpleCircleNodeRenderer);
					break;
				case "SimpleCircle+Effects":
					_visualGraph.itemRenderer=new ClassFactory(FilteredSimpleCircleNodeRenderer);
					break;
				case "Icons":
					_visualGraph.itemRenderer=new ClassFactory(IconNodeRenderer);
					break;
				case "Rotated Rectangle":
					_visualGraph.itemRenderer=new ClassFactory(RotatedRectNodeRenderer);
					break;
				case "Size by Value":
					_visualGraph.itemRenderer=new ClassFactory(SizeByValueNodeRenderer);
					break;
				case "WFB":
					_visualGraph.itemRenderer=new ClassFactory(WFBNodeRenderer);
					break;

				default:
					//						LogUtil.warn(_LOG, "Illegal NodeRenderer selected:"+nr);
					_visualGraph.itemRenderer=new ClassFactory(DefaultNodeRenderer);
					break;
			}
			_visualGraph.draw();
		}

		public function set visualGraph(value:VisualGraph):void
		{
			_visualGraph=value;
		}

		public function get visualGraph():VisualGraph
		{
			return _visualGraph;

		}
	}
}