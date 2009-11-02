package com.googlecode.flexdock.components
{
	import com.googlecode.flexdock.views.DockView;
	
	public class SpriteView extends DockView
	{
		[Embed(source="assets/text.gif")]
		private var iconClass:Class;

		public function SpriteView()
		{
			this.icon=iconClass;
			this.label="TextArea";
			this.setStyle("backgroundColor", 0xFFFFFF);
		}


	}
}
