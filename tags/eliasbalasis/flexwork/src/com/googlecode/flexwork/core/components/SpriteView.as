package com.googlecode.flexwork.core.components
{
	import com.googlecode.flexwork.core.components.DockingView;
	
	public class SpriteView extends DockingView
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
