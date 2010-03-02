package com.googlecode.flexwork.work.components.birdeyeClasses
{
	import com.googlecode.flexwork.core.components.IconArrowPopUpMenuButton;
	
	import flash.display.Graphics;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	import mx.events.MenuEvent;

	import org.un.cava.birdeye.ravis.graphLayout.layout.Hyperbolic2DLayouter;
	import org.un.cava.birdeye.ravis.graphLayout.visual.edgeRenderers.*;//
	import org.un.cava.birdeye.ravis.graphLayout.visual.VisualGraph;

	public class EdgeRendererPopUpMenuButton extends IconArrowPopUpMenuButton
	{

		[Embed(source="assets/edge.gif")]
		protected var iconEdgeClass:Class;

		private var _visualGraph:VisualGraph;

		public function EdgeRendererPopUpMenuButton()
		{
			super();
			//
			this.setIcon(iconEdgeClass);
			this.width=33;
			this.styleName="toolBarPopUpViewMenuButton";
			//
			this.toolTip="Edge Type";
			//			
			this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
			this.addEventListener(MenuEvent.ITEM_CLICK, onItemClick);
		}

		private function onCreationComplete(event:FlexEvent):void
		{
			this.dataProvider=new ArrayCollection([ //
				{groupName: "edgeRendererGroup", type: "radio", name: "Default", label: "Default", toggled: "true"}, //
				{groupName: "edgeRendererGroup", type: "radio", name: "DirectedArrows", label: "DirectedArrows"}, //
				{groupName: "edgeRendererGroup", type: "radio", name: "DirectedBalloons", label: "DirectedBalloons"}, //
				{groupName: "edgeRendererGroup", type: "radio", name: "Orthogonal", label: "Orthogonal"}, //
				{groupName: "edgeRendererGroup", type: "radio", name: "Flow", label: "Flow"}, //
				{groupName: "edgeRendererGroup", type: "radio", name: "Bezier", label: "Bezier"}, //
				{groupName: "edgeRendererGroup", type: "radio", name: "Circular", label: "Circular"}, //
				{groupName: "edgeRendererGroup", type: "radio", name: "Hyperbolic", label: "Hyperbolic"} //
				] //
				); //
		}

		private function onItemClick(event:MenuEvent):void
		{event.stopImmediatePropagation();
			var edgeName:String=event.item.name;
			changeEdgeRenderer(edgeName);
		}


		public function changeEdgeRenderer(edgeName:String="Default"):void
		{


			var g:Graphics;

			if (_visualGraph == null)
			{
				//					LogUtil.warn(_LOG, "Cannot change EdgeRenderer, no valid vgraph!");
				return;
			}
			g=_visualGraph.edgeDrawGraphics;

			/* get the currently selected EdgeRenderer */


			switch (edgeName)
			{
				case "Default":
					_visualGraph.edgeRenderer=new BaseEdgeRenderer(g);
					break;
				case "DirectedArrows":
					_visualGraph.edgeRenderer=new DirectedArrowEdgeRenderer(g);
					break;
				case "DirectedBalloons":
					_visualGraph.edgeRenderer=new DirectedBalloonEdgeRenderer(g);
					break;
				case "Orthogonal":
					_visualGraph.edgeRenderer=new OrthogonalEdgeRenderer(g);
					break;
				case "Flow":
					_visualGraph.edgeRenderer=new FlowEdgeRenderer(g);
					break;
				case "Bezier":
					_visualGraph.edgeRenderer=new FlowCurveEdgeRenderer(g);
					break;
				case "Circular":
					_visualGraph.edgeRenderer=new CircularEdgeRenderer(g);
					break;
				case "Hyperbolic":
					if (_visualGraph.layouter is Hyperbolic2DLayouter)
					{
						if ((_visualGraph.layouter as Hyperbolic2DLayouter).projector != null)
						{
							_visualGraph.edgeRenderer=new HyperbolicEdgeRenderer(g, (_visualGraph.layouter as Hyperbolic2DLayouter).projector);
						}
						else
						{
							//							LogUtil.warn(_LOG, "Cannot access projector of layouter, cannot use this edgerenderer!");
							_visualGraph.edgeRenderer=new BaseEdgeRenderer(g);
								//TODO: this.selectedIndex=0;
						}
					}
					else
					{
						//						LogUtil.warn(_LOG, "Layouter MUST be hyperbolic, otherwise cannot use this edgerenderer!");
						_visualGraph.edgeRenderer=new BaseEdgeRenderer(g);
							//TODO: this.selectedIndex=0;
					}
					break;
				default:
					//						LogUtil.warn(_LOG, "Illegal EdgeRenderer selected:"+er);
					_visualGraph.edgeRenderer=new BaseEdgeRenderer(g);
					break;
			}
			_visualGraph.refresh();
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