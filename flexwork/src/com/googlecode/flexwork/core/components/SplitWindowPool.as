package com.googlecode.flexwork.core.components
{
	import com.googlecode.flexwork.core.patterns.ObjectPool;

	public class SplitWindowPool extends ObjectPool
	{
		public function SplitWindowPool()
		{
			super();
		}

		override public function create():Object
		{
			var splitWindow:SplitWindow=new SplitWindow();
			return splitWindow;
		}

		public function checkOut():SplitWindow
		{
			return SplitWindow(create()); //TODO
		}

		public function checkIn(splitWindow:SplitWindow):void
		{
		}
	}
}