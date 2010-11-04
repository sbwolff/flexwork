package com.googlecode.flexwork.work.components.workflowClasses
{
	import mx.containers.HBox;
	import mx.containers.VBox;
	import mx.core.Container;
	import com.anotherflexdev.diagrammer.Diagram;
	import com.anotherflexdev.diagrammer.Link;

	import mx.core.ScrollPolicy;
	import mx.events.FlexEvent;
	import mx.controls.Text;
	import mx.core.EdgeMetrics;

	import com.googlecode.flexwork.work.components.workflowClasses.*;

	public class WorkflowDigrammer extends Container
	{
		private var tasksBox:VBox;

		private var processBox:VBox;

		private var servicesBox:VBox;

		private var diagram:Diagram;

		public function WorkflowDigrammer()
		{
			super();
			this.percentWidth=this.percentHeight=100;
			this.setStyle("verticalGap", 0);
			this.setStyle("horizontalGap", 0);

			this.setStyle("backgroundColor", 0xFFFFFF);
			this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
			this.verticalScrollPolicy=ScrollPolicy.ON;
			this.horizontalScrollPolicy=ScrollPolicy.OFF;
		}

		override protected function createChildren():void
		{
			super.createChildren();

			if (!tasksBox)
			{
				tasksBox=new VBox();
				tasksBox.enabled=true;
				tasksBox.width=100;
				tasksBox.percentHeight=100;
				tasksBox.setStyle("borderThickness", 1);
				tasksBox.setStyle("borderStyle", "solid");
				tasksBox.setStyle("borderSides", "right");
				tasksBox.setStyle("borderColor", 0xACA899);
				tasksBox.setStyle("horizontalAlign", "center");
				tasksBox.setStyle("horizontalGap", 0);
				tasksBox.setStyle("verticalGap", 0);
				tasksBox.setStyle("backgroundColor", 0xF0F0F0);
				this.rawChildren.addChild(tasksBox);
				//
				var tasksText:Text=new Text();
				tasksText.text="Tasks";
				tasksBox.addChild(tasksText);
			}

			if (!servicesBox)
			{
				servicesBox=new VBox();
				servicesBox.enabled=true;
				servicesBox.width=100;
				servicesBox.percentHeight=100;
				servicesBox.setStyle("borderThickness", 1);
				servicesBox.setStyle("borderStyle", "solid");
				servicesBox.setStyle("borderSides", "left");
				servicesBox.setStyle("borderColor", 0xACA899);
				servicesBox.setStyle("horizontalAlign", "center");
				servicesBox.setStyle("horizontalGap", 0);
				servicesBox.setStyle("verticalGap", 0);
				servicesBox.setStyle("backgroundColor", 0xF0F0F0);
				this.rawChildren.addChild(servicesBox);
				//
				var servicesText:Text=new Text();
				servicesText.text="Services";
				servicesBox.addChild(servicesText);
			}


//			if (!processBox)
//			{
//				processBox = new VBox();
////				processBox.width = 99;
//				processBox.percentHeight = 100;
//				processBox.verticalScrollPolicy = ScrollPolicy.OFF;
//				processBox.horizontalScrollPolicy = ScrollPolicy.OFF;
//				this.addChild(processBox);
//			}

			if (!diagram)
			{
				diagram=new Diagram();
				diagram.visible=true;
				diagram.enabled=true;
				diagram.verticalScrollPolicy=ScrollPolicy.OFF;
				diagram.horizontalScrollPolicy=ScrollPolicy.AUTO;
				diagram.styleName="diagram";
//				diagram.setStyle("top" ,0);
//				diagram.setStyle("left" ,0);
//				diagram.setStyle("right" ,0);
//				diagram.setStyle("bottom" ,0);
				diagram.percentWidth=100;
				diagram.percentHeight=100;
				this.addChild(diagram);
			}
		}

		override public function get viewMetrics():EdgeMetrics
		{
			var vm:EdgeMetrics=super.viewMetrics;
			vm.left+=tasksBox.getExplicitOrMeasuredHeight();
			vm.right+=servicesBox.getExplicitOrMeasuredHeight();
			return vm;
		}

		override public function get borderMetrics():EdgeMetrics
		{
			return new EdgeMetrics(tasksBox.getExplicitOrMeasuredWidth(), 0, servicesBox.getExplicitOrMeasuredWidth(), 0);
		}

		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			diagram.x=0;
			diagram.y=0;
			diagram.width=unscaledWidth;
			diagram.height=unscaledHeight;



		}

//		override protected function measure():void
//		{
//			super.measure();
//			var bm:EdgeMetrics=EdgeMetrics.EMPTY//borderMetrics;
//
////        	if (controlBar && controlBar.includeInLayout)
////	        {
//			var tempWidth:Number=this.tasksBox.getExplicitOrMeasuredWidth() + this.servicesBox.getExplicitOrMeasuredWidth();
//			//bm.left + bm.right;
//
//			measuredWidth=Math.max(measuredWidth, tempWidth);
////	        }
//
//		}


		override protected function layoutChrome(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.layoutChrome(unscaledWidth, unscaledHeight);
			var bm:EdgeMetrics=borderMetrics;

			var tx:Number=tasksBox.x;
			var ty:Number=tasksBox.y;
			var tw:Number=tasksBox.width;
			var th:Number=tasksBox.height;

			var sx:Number=servicesBox.x;
			var sy:Number=servicesBox.y;
			var sw:Number=servicesBox.width;
			var sh:Number=servicesBox.height;

			tasksBox.setActualSize(tasksBox.getExplicitOrMeasuredWidth(), unscaledHeight);

			tasksBox.move(0, bm.top);

			servicesBox.setActualSize(servicesBox.getExplicitOrMeasuredWidth(), unscaledHeight);

			servicesBox.move(unscaledWidth - servicesBox.getExplicitOrMeasuredWidth(), bm.top);
//
//			if (tx != tasksBox.x || //
//				ty != tasksBox.y || //
//				tw != tasksBox.width || //
//				th != tasksBox.height || //
//				sx != servicesBox.x || //
//				sy != servicesBox.y || //
//				sw != servicesBox.width || //
//				sh != servicesBox.height //
//				)
//			{
			var vm:EdgeMetrics=viewMetrics;

			if (verticalScrollBar)
			{
				var h:Number=unscaledHeight - vm.top - vm.bottom;

				verticalScrollBar.setActualSize(verticalScrollBar.minWidth, h);

				verticalScrollBar.move(unscaledWidth - verticalScrollBar.minWidth, vm.top);
			}


			invalidateDisplayList();
//			}

		}


		private function onCreationComplete(event:FlexEvent):void
		{
			var link:Link=new Link();
			link.fromNode=new QuotationInProcess();
			link.fromNode.x=100;
			link.fromNode.y=100;
			link.toNode=new WaitingCustomerConfirmation();
			link.toNode.x=400;
			link.toNode.y=91;
			link.linkName="After Research";
			link.fromNode.addLeavingLink(link);
			link.toNode.addArrivingLink(link);
			this.diagram.addChild(link.fromNode);
			this.diagram.addChild(link.toNode);
			this.diagram.addChildAt(link, 0);
		}

	}
}