package com.googlecode.flexwork.work.components.springGraphClasses
{
	import mx.controls.Label;
	import mx.containers.VBox;
	import mx.binding.utils.ChangeWatcher;
	import com.googlecode.flexwork.work.components.SpringGraphView;
	import mx.binding.IBindingClient;
	
	/*
	   <fc:itemRenderer>
	   <mx:Component>
	   <mx:VBox backgroundAlpha="0.3" backgroundColor="0x444444"
	   paddingBottom="5" paddingLeft="5" paddingRight="5" paddingTop="5">
	   <mx:Label text="{data.id}" fontSize="{outerDocument.fontSizeSlider.value}" color="0xffffff"
	   textAlign="center"/>
	   </mx:VBox>
	   </mx:Component>
	   </fc:itemRenderer>
	 */
	public class SpringGraphItemRenderer extends VBox implements IBindingClient
	{
		private var nodeLabel:Label;

		[Bindable]
		public var outerDocument:SpringGraphView;

		public function SpringGraphItemRenderer()
		{
			super();
			this.width = this.height = 30;
			this.setStyle("backgroundAlpha", 0.5);
			this.setStyle("backgroundColor", 0x000000);
			
			this.setStyle("borderThickness", 1);
			this.setStyle("borderStyle", "solid");
			this.setStyle("borderColor", 0x000000);
			
			this.setStyle("paddingTop", 2);
			this.setStyle("paddingLeft", 2);
			this.setStyle("paddingRight", 2);
			this.setStyle("paddingBottom", 2);
		}

		override protected function createChildren():void
		{
			if (null == nodeLabel)
			{
				nodeLabel=new Label();
				nodeLabel.setStyle("color", 0x0000ff);
				nodeLabel.setStyle("backgroundColor", 0xFFFFFF);
				nodeLabel.setStyle("textAlign", "center");
				nodeLabel.setStyle("fontSize", 18); //				fontSize="{outerDocument.fontSizeSlider.value}"			
			}
			nodeLabel.text = String(nodeLabel.id);
			this.addChild(nodeLabel);
//			ChangeWatcher.watch(data, "id", onDataChange);
		}

		public function onDataChange(event:Event):void
		{
			var result:*=(data.id);
			nodeLabel.text=(result == undefined ? null : String(result));
		}
	}

}