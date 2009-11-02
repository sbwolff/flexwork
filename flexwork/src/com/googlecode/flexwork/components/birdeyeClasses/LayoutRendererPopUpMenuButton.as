package com.googlecode.flexwork.components.birdeyeClasses
{import com.googlecode.flexdock.components.ToolBarPopUpMenuButton;

	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	import mx.events.MenuEvent;

	import mx.controls.Menu;

	
	import org.un.cava.birdeye.ravis.graphLayout.layout.*;
	import org.un.cava.birdeye.ravis.graphLayout.visual.VisualGraph;

	public class LayoutRendererPopUpMenuButton extends ToolBarPopUpMenuButton
	{

		[Embed(source="assets/layout.gif")]
		protected var iconLayoutClass:Class;

		private var _visualGraph:VisualGraph;

		public function LayoutRendererPopUpMenuButton()
		{
			super();
			//
			this.setStyle("icon", iconLayoutClass);
			this.width=33;
			this.styleName="toolBarPopUpViewMenuButton";
			//
			this.toolTip="Layout Type";
			//			
			this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
			this.addEventListener(MenuEvent.ITEM_CLICK, onItemClick);
		}

		private function onCreationComplete(event:FlexEvent):void
		{
			this.dataProvider=new ArrayCollection([ //
				{groupName: "layoutGroup", type: "radio", name: "ConcentricRadial", label: "ConcentricRadial", toggled: "true"}, //						
				{groupName: "layoutGroup", type: "radio", name: "ParentCenteredRadial", label: "ParentCenteredRadial", groupName: "layoutGroup", type: "radio"}, //
				{groupName: "layoutGroup", type: "radio", name: "SingleCycleCircle", label: "SingleCycleCircle", groupName: "layoutGroup", type: "radio"}, //			
				{groupName: "layoutGroup", type: "radio", name: "Hyperbolic", label: "Hyperbolic", groupName: "layoutGroup", type: "radio"}, //
				{type: "separator"}, //
				{groupName: "layoutGroup", type: "radio", name: "Hierarchical", label: "Hierarchical", groupName: "layoutGroup", type: "radio"}, //
				{type: "separator"}, //
				{groupName: "layoutGroup", type: "radio", name: "ForceDirected", label: "ForceDirected", groupName: "layoutGroup", type: "radio"}, //
				{groupName: "layoutGroup", type: "radio", name: "ISOM", label: "ISOM", groupName: "layoutGroup", type: "radio"}, //
				{type: "separator"}, //
				{groupName: "layoutGroup", type: "radio", name: "DirectPlacement", label: "DirectPlacement", groupName: "layoutGroup", type: "radio"}, //
				{type: "separator"}, //
				{groupName: "layoutGroup", type: "radio", name: "Phyllotactic", label: "Phyllotactic", groupName: "layoutGroup", type: "radio"} //
				] //
				); //
			Menu(this.popUp).variableRowHeight=true;
		}

		private function onItemClick(event:MenuEvent):void
		{	event.stopImmediatePropagation();
			var layouterName:String=event.item.name;
			changeLayouter(layouterName);
		}

		public function changeLayouter(layouterName:String="ConcentricRadial"):void
		{
			/* check if we have a vgraph at all */
			if (_visualGraph == null)
			{
				//					LogUtil.warn(_LOG, "Cannot change Layouter without vgraph.");
				return;
			}
			setLayouter(layouterName);
			_visualGraph.draw(); // run the layout
		}

		/**
		 * Set/Activate the layouter set in the selector.
		 * */
		public function setLayouter(layouterName:String):void
		{

			var layouter:ILayoutAlgorithm;

			/* check if we have a vgraph at all */
			if (_visualGraph == null)
			{
				//					LogUtil.warn(_LOG, "Cannot change Layouter without vgraph.");
				return;
			}

			/* kill off animation in old layouter if present */
			if (_visualGraph.layouter != null)
			{
				_visualGraph.layouter.resetAll();
				/* remove also existing references thus
				 * destroying the object (maybe this is not needed?) */
				_visualGraph.layouter=null;
			}

			/* now choose the selected layouter */
			switch (layouterName)
			{
				case "ConcentricRadial":
					layouter=new ConcentricRadialLayouter(_visualGraph);
					break;
				case "ParentCenteredRadial":
					layouter=new ParentCenteredRadialLayouter(_visualGraph);
					break;
				case "SingleCycleCircle":
					layouter=new CircularLayouter(_visualGraph);

					/* set the hyperbolic edge renderer type *
					   _visualGraph.edgeRenderer = new CircularEdgeRenderer();
					   _visualGraph.scrollBackgroundInDrag = false;
					   _visualGraph.moveNodeInDrag = false;
					   absoluteScaling = true;
					   updateScale();
					 */
					break;
				case "Hyperbolic":
					layouter=new Hyperbolic2DLayouter(_visualGraph);

					/* set some layouter specific defaults:
					   _visualGraph.edgeRenderer = new HyperbolicEdgeRenderer((layouter as Hyperbolic2DLayouter).projector);
					   _visualGraph.scrollBackgroundInDrag = false;
					   _visualGraph.moveNodeInDrag = false;
					   absoluteScaling = false;
					 */
					break;
				case "Hierarchical":
					layouter=new HierarchicalLayouter(_visualGraph);
					break;
				case "ForceDirected":
					layouter=new ForceDirectedLayouter(_visualGraph);
					break;
				case "ISOM":
					layouter=new ISOMLayouter(_visualGraph);
					break;
				case "DirectPlacement":
					layouter=new DirectPlacementLayouter(_visualGraph);
					/* set some layouter specific values, i.e. create a control
					 * for these first, also they could be prepopulated from
					 * XML data
					   (layouter as DirectPlacementLayouter).relativeHeight = 400;
					   (layouter as DirectPlacementLayouter).relativeWidth = 400;
					 */ /*
					   /* set the orthogonal edge renderer type *
					   _visualGraph.edgeRenderer = new OrthogonalEdgeRenderer();
					   _visualGraph.scrollBackgroundInDrag = true;
					   _visualGraph.moveNodeInDrag = true;
					   absoluteScaling = true;
					   updateScale();
					 */
					break;
				case "Phyllotactic":
					layouter=new PhylloTreeLayouter(_visualGraph);
					break;
				default:
					//						LogUtil.warn(_LOG, "Illegal Layouter selected, defaulting to ConcentricRadial"+
					//							layouterName);
					layouter=new ConcentricRadialLayouter(_visualGraph);
					break;
			}
			_visualGraph.layouter=layouter;
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