package com.googlecode.flexwork.work.components
{
	import com.googlecode.flexwork.core.components.ToolBar;
	import com.googlecode.flexwork.core.events.ToolBarEvent;
	import com.googlecode.flexwork.core.components.DockingView;
	import com.googlecode.flexwork.work.components.birdeyeClasses.EdgeRendererPopUpMenuButton;
	import com.googlecode.flexwork.work.components.birdeyeClasses.LayoutRendererPopUpMenuButton;
	import com.googlecode.flexwork.work.components.birdeyeClasses.NodeRendererPopUpMenuButton;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import fr.kapit.components.ResizableTitleWindow;
	
	import mx.containers.Canvas;
	import mx.containers.HBox;
	import mx.core.ScrollPolicy;
	import mx.events.FlexEvent;
	import mx.events.ResizeEvent;
	
	import org.un.cava.birdeye.ravis.components.ui.controls.vgraphControls.DegreesOfSeparation;
	import org.un.cava.birdeye.ravis.graphLayout.data.Graph;
	import org.un.cava.birdeye.ravis.graphLayout.layout.*;
	import org.un.cava.birdeye.ravis.graphLayout.visual.VisualGraph;

	public class BirdEyeView extends DockingView
	{
		[Embed(source="assets/point.png")]
		protected var iconPointClass:Class;

		[Embed(source="assets/hand.png")]
		protected var iconHandClass:Class;

		[Embed(source="assets/zoom_in.png")]
		protected var iconZoomInClass:Class;

		[Embed(source="assets/zoom_out.png")]
		protected var iconZoomOutClass:Class;

		[Embed(source="assets/logo_birdeye.gif")]
		protected var iconClass:Class;


		//
		private static const ZOOM_SCALE_LENGTH:Number=10;

		private static const ZOOM_SCALE_DELTA:Number=0.05;
		//
		private var box:HBox=null;

		//private var leftBox:VBox=null;
		//
		//		private var myLayoutSelector:LayoutSelector=null;

		//		private var myNodeRendererSelector:NodeRendererSelector=null;
		//
		//		private var myEdgeRendererSelector:EdgeRendererSelector=null;
		//
		//		private var myEdgeLabelControls:EdgeLabelControls=null;



		private var layoutRendererSelector:LayoutRendererPopUpMenuButton=null;

		private var nodeRendererSelector:NodeRendererPopUpMenuButton=null;

		private var edgeRendererSelector:EdgeRendererPopUpMenuButton=null;

		private var myDegreesOfSeparation:DegreesOfSeparation=null;

		private var canvas:Canvas=null;
		[Bindable]
		private var visualGraph:VisualGraph=null;

		public function BirdEyeView()
		{
			super();
			this.icon=iconClass;
			this.label="BirdEye";
			
			this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
			this.addEventListener(ResizeEvent.RESIZE, onResize);
			
			initChildren();

		}

		protected function initChildren():void
		{
			//			if (null == box)
			//			{
			//				box=new HBox();
			//				box.percentWidth=100;
			//				box.percentHeight=100;
			//					//this.addChild(box);
			//			}
			//			if (null == leftBox)
			//			{
			//				leftBox=new VBox();
			//				leftBox.percentWidth=30;
			//				leftBox.percentHeight=100;
			//					//box.addChild(leftBox);
			//			}
			//
			if (null == canvas)
			{
				canvas=new Canvas();
				//				canvas.percentWidth=70;
				canvas.percentWidth=100;
				canvas.percentHeight=100;
				//				canvas.setStyle("borderStyle","solid");
				//				canvas.setStyle("borderColor","CCCCCC"); 
				canvas.setStyle("backgroundColor", 0xCEEEEE);
				canvas.verticalScrollPolicy=ScrollPolicy.OFF;
				canvas.horizontalScrollPolicy=ScrollPolicy.OFF;
					//box.addChild(canvas);
			}
			if (null == visualGraph)
			{
				visualGraph=new VisualGraph();
				visualGraph.percentWidth=100;
				visualGraph.percentHeight=100;

				visualGraph.setStyle("paddingBottom", 5);
				visualGraph.setStyle("top", 0);
				visualGraph.setStyle("left", 0);
				visualGraph.setStyle("right", 0);
				visualGraph.setStyle("bottom", 0);
				visualGraph.setStyle("backgroundColor", 0xFDFEC1);
				visualGraph.setStyle("alpha", 1);
				//
				visualGraph.visibilityLimitActive=true;
				//

				visualGraph.addEventListener("resize", onVisualGraphResize);
				//

				//canvas.addChild(visualGraph);
				canvas.addEventListener(MouseEvent.MOUSE_WHEEL, onCanvasMouseWheel);

			}


			//
			//			if (null == myLayoutSelector)
			//			{
			//				myLayoutSelector=new LayoutSelector();
			//				myLayoutSelector.vgraph=visualGraph;
			//				leftBox.addChild(myLayoutSelector);
			//			}
			//			if (null == myNodeRendererSelector)
			//			{
			//				myNodeRendererSelector=new NodeRendererSelector();
			//				myNodeRendererSelector.vgraph=visualGraph;
			//					//leftBox.addChild(myNodeRendererSelector);
			//			}
			//			if (null == myEdgeRendererSelector)
			//			{
			//				myEdgeRendererSelector=new EdgeRendererSelector();
			//				myEdgeRendererSelector.vgraph=visualGraph;
			//					//leftBox.addChild(myEdgeRendererSelector);
			//			}
			//			if (null == myEdgeLabelControls) {
			//				myEdgeLabelControls = new EdgeLabelControls();
			//				myEdgeLabelControls.vgraph = visualGraph;
			//				leftBox.addChild(myEdgeLabelControls);
			//			}
			if (null == myDegreesOfSeparation)
			{
				myDegreesOfSeparation=new DegreesOfSeparation();
				myDegreesOfSeparation.vgraph=visualGraph;
					//leftBox.addChild(myDegreesOfSeparation);
			}
			//			



			//
			/* init a graph object with the XML data */
			visualGraph.graph=new Graph("XMLAsDocsGraph", false, graphData);

			/* assign start root */
			visualGraph.currentRootVNode=visualGraph.graph.nodeByStringId("1").vnode;

			//
			layoutRendererSelector=new LayoutRendererPopUpMenuButton();
			layoutRendererSelector.visualGraph=visualGraph;

			nodeRendererSelector=new NodeRendererPopUpMenuButton();
			nodeRendererSelector.visualGraph=visualGraph;

			edgeRendererSelector=new EdgeRendererPopUpMenuButton();
			edgeRendererSelector.visualGraph=visualGraph;
		}

	override protected function toolBarData():Array
		{	
			return [ //
				{name: "Point", icon: iconPointClass, toolTip: "Point"}, //
				{name: "Hand", icon: iconHandClass, toolTip: "Hand"}, //
				{name: "ZoomIn", icon: iconZoomInClass, toolTip: "ZoomIn"}, //
				{name: "ZoomOut", icon: iconZoomOutClass, toolTip: "ZoomOut"}, //
				{name: "Layout Renderer", type: ToolBar.TYPE_DISPLAY_OBJECT, displayObject: layoutRendererSelector, toolTip: "Layout Renderer"}, //
				{name: "Node Renderer", type: ToolBar.TYPE_DISPLAY_OBJECT, displayObject: nodeRendererSelector, toolTip: "Node Renderer"}, //
				{name: "Edge Renderer", type: ToolBar.TYPE_DISPLAY_OBJECT, displayObject: edgeRendererSelector, toolTip: "Edge Renderer"} //, //				
				//				{name: "todo", type: ToolBar.TYPE_VIEW_MENU, toolTip: "//TODO", //
				//					children: [ //
				//					{label: "b1", icon: tempIconClass, //
				//							children: [ //
				//							{label: "bb1", icon: tempIconClass}, //
				//								{label: "bb2", icon: tempIconClass} //
				//							]}, //
				//						{type: "separator"}, //
				//						{label: "b2", icon: tempIconClass} //
				//					] //
				//				}//
				];
			
			
		}
//		override protected function createToolBar():void
//		{
//			//[Flex]Flex编程注意之直接获取某个组件的对象（this[]用法）
//			//http://www.javaeye.com/topic/425214
//			toolBarDataProvider=new ArrayCollection(); //
//		}

		override protected function createChildren():void
		{
			super.createChildren();

			//			this.addChild(box);
			//			box.addChild(leftBox);
			//			box.addChild(canvas);
			this.addChild(canvas);
			canvas.addChild(visualGraph);


			//			leftBox.addChild(myNodeRendererSelector);
			//			leftBox.addChild(myEdgeRendererSelector);
			//			if (null == myEdgeLabelControls) {
			//				myEdgeLabelControls = new EdgeLabelControls();
			//				myEdgeLabelControls.vgraph = visualGraph;
			//				leftBox.addChild(myEdgeLabelControls);
			//			}
			//			leftBox.addChild(myDegreesOfSeparation);
			myDegreesOfSeparation.x=10;
			myDegreesOfSeparation.y=10;
			canvas.addChild(myDegreesOfSeparation);


		}

		private function onCanvasMouseWheel(event:MouseEvent):void
		{
			visualGraph.scale=visualGraph.scale + event.delta * ZOOM_SCALE_DELTA;
		}

		private function onVisualGraphResize(event:Event):void
		{
			visualGraph.draw(VisualGraph.DF_RESET_LL);
		}

		private function onCreationComplete(event:FlexEvent):void
		{



			//			nodeRendererSelector = new ToolBarButton();
			//			
			//			edgeRendererSelector = new ToolBarButton();


			layoutRendererSelector.changeLayouter();

			/* provide the control components with some initial settings */
			//			myLayoutSelector.selectedItem="ConcentricRadial";
			//			myLayoutSelector.changeLayouter();

			//			myNodeRendererSelector.selectedItem="Icons";
			//			myNodeRendererSelector.changeNodeRenderer();
			nodeRendererSelector.changeNodeRenderer();

			//			myEdgeRendererSelector.selectedItem="Default";
			//			myEdgeRendererSelector.changeEdgeRenderer();
			edgeRendererSelector.changeEdgeRenderer();

			//			myEdgeLabelControls.elselector.selectedItem = "Default";
			//			myEdgeLabelControls.elselector.changeEdgeLabelRenderer();

			myDegreesOfSeparation.updateMaxVisDist();

			visualGraph.draw();
		}

		private function onResize(event:ResizeEvent):void
		{
			//			// set the size of the map based on its containers size.
			//			map.setSize(this.mapContainer.width, this.mapContainer.height);
		}

		override public function onToolBarClick(event:ToolBarEvent):void
		{
			switch (event.name)
			{
				case "ZoomIn":
				{
					visualGraph.scale=visualGraph.scale + ZOOM_SCALE_LENGTH * ZOOM_SCALE_DELTA;
					break;
				}
				case "ZoomOut":
				{
					visualGraph.scale=visualGraph.scale - ZOOM_SCALE_LENGTH * ZOOM_SCALE_DELTA;
					break;
				}
			}
		}

		private var graphData:XML=<Graph>
				<Node id="1" name="0" desc="This is a description" nodeColor="0x333333" nodeSize="32" nodeClass="earth" nodeIcon="center" x="10" y="10" />
				<Node id="2" name="A" desc="This is a description" nodeColor="0x8F8FFF" nodeSize="12" nodeClass="tree" nodeIcon="2" x="10" y="15" />
				<Node id="3" name="B" desc="This is a description" nodeColor="0xF00000" nodeSize="36" nodeClass="tree" nodeIcon="3" x="10" y="20" />
				<Node id="4" name="C" desc="This is a description" nodeColor="0x00FF00" nodeSize="10" nodeClass="tree" nodeIcon="4" x="10" y="25" />
				<Node id="5" name="D" desc="This is a description" nodeColor="0xFFA500" nodeSize="14" nodeClass="tree" nodeIcon="5" x="10" y="30" />
				<Node id="6" name="E" desc="This is a description" nodeColor="0x191970" nodeSize="10" nodeClass="tree" nodeIcon="6" x="10" y="35" />
				<Node id="7" name="F" desc="This is a description" nodeColor="0x4682b4" nodeSize="18" nodeClass="tree" nodeIcon="7" x="10" y="40" />

				<Node id="8" name="A.1" desc="This is a description" nodeColor="0x8F8FFF" nodeSize="21" nodeClass="leaf" nodeIcon="10" x="20" y="20" />
				<Node id="9" name="A.2" desc="This is a description" nodeColor="0x8F8FFF" nodeSize="15" nodeClass="leaf" nodeIcon="11" x="20" y="25" />
				<Node id="10" name="A.3" desc="This is a description" nodeColor="0x8F8FFF" nodeSize="32" nodeClass="leaf" nodeIcon="12" x="20" y="30" />
				<Node id="11" name="A.4" desc="This is a description" nodeColor="0x8F8FFF" nodeSize="16" nodeClass="leaf" nodeIcon="13" x="20" y="35" />
				<Node id="12" name="A.5" desc="This is a description" nodeColor="0x8F8FFF" nodeSize="12" nodeClass="leaf" nodeIcon="14" x="20" y="40" />
				<Node id="13" name="A.6" desc="This is a description" nodeColor="0x8F8FFF" nodeSize="10" nodeClass="leaf" nodeIcon="15" x="20" y="45" />

				<Node id="14" name="B.1" desc="This is a description" nodeColor="0xF00000" nodeSize="27" nodeClass="leaf" nodeIcon="16" x="30" y="30" />
				<Node id="15" name="B.2" desc="This is a description" nodeColor="0xF00000" nodeSize="10" nodeClass="leaf" nodeIcon="17" x="30" y="35" />
				<Node id="16" name="B.3" desc="This is a description" nodeColor="0xF00000" nodeSize="13" nodeClass="leaf" nodeIcon="18" x="30" y="40" />
				<Node id="17" name="B.4" desc="This is a description" nodeColor="0xF00000" nodeSize="10" nodeClass="leaf" nodeIcon="19" x="30" y="45" />
				<Node id="18" name="B.5" desc="This is a description" nodeColor="0xF00000" nodeSize="10" nodeClass="leaf" nodeIcon="20" x="30" y="50" />
				<Node id="19" name="B.6" desc="This is a description" nodeColor="0xF00000" nodeSize="10" nodeClass="leaf" nodeIcon="21" x="30" y="55" />

				<Node id="20" name="C.1" desc="This is a description" nodeColor="0x00FF00" nodeSize="10" nodeClass="leaf" nodeIcon="22" x="40" y="40" />
				<Node id="21" name="C.2" desc="This is a description" nodeColor="0x00FF00" nodeSize="15" nodeClass="leaf" nodeIcon="23" x="40" y="45" />
				<Node id="22" name="C.3" desc="This is a description" nodeColor="0x00FF00" nodeSize="10" nodeClass="leaf" nodeIcon="24" x="40" y="50" />
				<Node id="23" name="C.4" desc="This is a description" nodeColor="0x00FF00" nodeSize="10" nodeClass="leaf" nodeIcon="25" x="40" y="55" />
				<Node id="24" name="C.5" desc="This is a description" nodeColor="0x00FF00" nodeSize="20" nodeClass="leaf" nodeIcon="26" x="40" y="60" />
				<Node id="25" name="C.6" desc="This is a description" nodeColor="0x00FF00" nodeSize="10" nodeClass="leaf" nodeIcon="27" x="40" y="65" />

				<Node id="26" name="D.1" desc="This is a description" nodeColor="0xFFA500" nodeSize="30" nodeClass="leaf" nodeIcon="28" x="50" y="50" />
				<Node id="27" name="D.2" desc="This is a description" nodeColor="0xFFA500" nodeSize="10" nodeClass="leaf" nodeIcon="29" x="50" y="55" />
				<Node id="28" name="D.3" desc="This is a description" nodeColor="0xFFA500" nodeSize="12" nodeClass="leaf" nodeIcon="30" x="50" y="60" />
				<Node id="29" name="D.4" desc="This is a description" nodeColor="0xFFA500" nodeSize="10" nodeClass="leaf" nodeIcon="31" x="50" y="65" />
				<Node id="30" name="D.5" desc="This is a description" nodeColor="0xFFA500" nodeSize="10" nodeClass="leaf" nodeIcon="32" x="50" y="70" />
				<Node id="31" name="D.6" desc="This is a description" nodeColor="0xFFA500" nodeSize="15" nodeClass="leaf" nodeIcon="33" x="50" y="75" />

				<Node id="32" name="E.1" desc="This is a description" nodeColor="0x191970" nodeSize="26" nodeClass="leaf" nodeIcon="34" x="60" y="60" />
				<Node id="33" name="E.2" desc="This is a description" nodeColor="0x191970" nodeSize="10" nodeClass="leaf" nodeIcon="35" x="60" y="65" />
				<Node id="34" name="E.3" desc="This is a description" nodeColor="0x191970" nodeSize="16" nodeClass="leaf" nodeIcon="36" x="60" y="70" />
				<Node id="35" name="E.4" desc="This is a description" nodeColor="0x191970" nodeSize="10" nodeClass="leaf" nodeIcon="37" x="60" y="75" />
				<Node id="36" name="E.5" desc="This is a description" nodeColor="0x191970" nodeSize="10" nodeClass="leaf" nodeIcon="38" x="60" y="80" />
				<Node id="37" name="E.6" desc="This is a description" nodeColor="0x191970" nodeSize="14" nodeClass="leaf" nodeIcon="39" x="60" y="85" />

				<Node id="38" name="F.1" desc="This is a description" nodeColor="0x4682b4" nodeSize="5" nodeClass="leaf" nodeIcon="40" x="70" y="70" />
				<Node id="39" name="F.2" desc="This is a description" nodeColor="0x4682b4" nodeSize="12" nodeClass="leaf" nodeIcon="41" x="70" y="75" />
				<Node id="40" name="F.3" desc="This is a description" nodeColor="0x4682b4" nodeSize="10" nodeClass="leaf" nodeIcon="42" x="70" y="80" />
				<Node id="41" name="F.4" desc="This is a description" nodeColor="0x4682b4" nodeSize="22" nodeClass="leaf" nodeIcon="43" x="70" y="85" />
				<Node id="42" name="F.5" desc="This is a description" nodeColor="0x4682b4" nodeSize="8" nodeClass="leaf" nodeIcon="44" x="70" y="90" />
				<Node id="43" name="F.6" desc="This is a description" nodeColor="0x4682b4" nodeSize="10" nodeClass="leaf" nodeIcon="45" x="70" y="95" />

				<Edge fromID="1" toID="2" edgeLabel="No Change" flow="50" color="0x556b2f" edgeClass="sun" edgeIcon="NoChange" />
				<Edge fromID="1" toID="3" edgeLabel="Bad" flow="400" color="0xcd5c5c" edgeClass="sun" edgeIcon="Bad" />
				<Edge fromID="1" toID="4" edgeLabel="Good" flow="80" color="0xb22222" edgeClass="sun" edgeIcon="Good" />
				<Edge fromID="1" toID="5" edgeLabel="Good" flow="100" color="0x607b8b" edgeClass="sun" edgeIcon="Good" />
				<Edge fromID="1" toID="6" edgeLabel="No Change" flow="120" color="0x333333" edgeClass="sun" edgeIcon="NoChange" />
				<Edge fromID="1" toID="7" edgeLabel="Bad" flow="150" color="0x6b8e23" edgeClass="sun" edgeIcon="Bad" />

				<Edge fromID="2" toID="8" edgeLabel="Good" flow="100" edgeClass="rain" edgeIcon="Good" />
				<Edge fromID="2" toID="9" edgeLabel="Bad" flow="400" edgeClass="rain" edgeIcon="Bad" />
				<Edge fromID="2" toID="10" edgeLabel="No Change" flow="800" edgeClass="rain" edgeIcon="NoChange" />
				<Edge fromID="2" toID="11" edgeLabel="Good" flow="100" edgeClass="rain" edgeIcon="Good" />
				<Edge fromID="2" toID="12" edgeLabel="Bad" flow="120" edgeClass="rain" edgeIcon="Bad" />
				<Edge fromID="2" toID="13" edgeLabel="No Change" flow="150" edgeClass="rain" edgeIcon="NoChange" />

				<Edge fromID="3" toID="14" edgeLabel="Good" flow="1" edgeClass="rain" edgeIcon="Good" />
				<Edge fromID="3" toID="15" edgeLabel="No Change" flow="40" edgeClass="rain" edgeIcon="NoChange" />
				<Edge fromID="3" toID="16" edgeLabel="Bad" flow="80" edgeClass="rain" edgeIcon="Bad" />
				<Edge fromID="3" toID="17" edgeLabel="Good" flow="100" edgeClass="rain" edgeIcon="Good" />
				<Edge fromID="3" toID="18" edgeLabel="Good" flow="120" edgeClass="rain" edgeIcon="Good" />
				<Edge fromID="3" toID="19" edgeLabel="Bad" flow="15" edgeClass="rain" edgeIcon="Bad" />

				<Edge fromID="4" toID="20" edgeLabel="Bad" flow="1" edgeClass="rain" edgeIcon="Bad" />
				<Edge fromID="4" toID="21" edgeLabel="Good" flow="40" edgeClass="rain" edgeIcon="Good" />
				<Edge fromID="4" toID="22" edgeLabel="No Change" flow="8" edgeClass="rain" edgeIcon="NoChange" />
				<Edge fromID="4" toID="23" edgeLabel="Good" flow="100" edgeClass="rain" edgeIcon="Good" />
				<Edge fromID="4" toID="24" edgeLabel="Good" flow="120" edgeClass="rain" edgeIcon="Good" />
				<Edge fromID="4" toID="25" edgeLabel="Bad" flow="150" edgeClass="rain" edgeIcon="Bad" />

				<Edge fromID="5" toID="26" edgeLabel="Bad" flow="1" edgeClass="rain" edgeIcon="Bad" />
				<Edge fromID="5" toID="27" edgeLabel="Good" flow="400" edgeClass="rain" edgeIcon="Good" />
				<Edge fromID="5" toID="28" edgeLabel="No Change" flow="8" edgeClass="rain" edgeIcon="NoChange" />
				<Edge fromID="5" toID="29" edgeLabel="Good" flow="100" edgeClass="rain" edgeIcon="Good" />
				<Edge fromID="5" toID="30" edgeLabel="Bad" flow="120" edgeClass="rain" edgeIcon="Bad" />
				<Edge fromID="5" toID="31" edgeLabel="No Change" flow="150" edgeClass="rain" edgeIcon="NoChange" />

				<Edge fromID="6" toID="32" edgeLabel="No Change" flow="1" edgeClass="rain" edgeIcon="NoChange" />
				<Edge fromID="6" toID="33" edgeLabel="Good" flow="40" edgeClass="rain" edgeIcon="Good" />
				<Edge fromID="6" toID="34" edgeLabel="Bad" flow="800" edgeClass="rain" edgeIcon="Bad" />
				<Edge fromID="6" toID="35" edgeLabel="Good" flow="100" edgeClass="rain" edgeIcon="Good" />
				<Edge fromID="6" toID="36" edgeLabel="Good" flow="12" edgeClass="rain" edgeIcon="Good" />
				<Edge fromID="6" toID="37" edgeLabel="No Change" flow="150" edgeClass="rain" edgeIcon="NoChange" />

				<Edge fromID="7" toID="38" edgeLabel="Bad" flow="100" edgeClass="rain" edgeIcon="Bad" />
				<Edge fromID="7" toID="39" edgeLabel="Good" flow="40" edgeClass="rain" edgeIcon="Good" />
				<Edge fromID="7" toID="40" edgeLabel="No Change" flow="80" edgeClass="rain" edgeIcon="NoChange" />
				<Edge fromID="7" toID="41" edgeLabel="Good" flow="1000" edgeClass="rain" edgeIcon="Good" />
				<Edge fromID="7" toID="42" edgeLabel="Good" flow="120" edgeClass="rain" edgeIcon="Good" />
				<Edge fromID="7" toID="43" edgeLabel="Bad" flow="150" edgeClass="rain" edgeIcon="Bad" />

			</Graph>;
	}



}