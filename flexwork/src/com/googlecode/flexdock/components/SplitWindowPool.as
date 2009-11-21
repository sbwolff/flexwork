package com.googlecode.flexdock.components
{
	import com.googlecode.pattern.ObjectPool;

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