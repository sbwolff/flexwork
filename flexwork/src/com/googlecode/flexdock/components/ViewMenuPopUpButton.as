package com.googlecode.flexdock.components
{



	import flash.events.MouseEvent;

	import mx.controls.Menu;
	import mx.controls.PopUpButton;
	import mx.events.FlexEvent;
	import mx.events.MenuEvent;

	[Event(name="itemClick",type="mx.events.MenuEvent")]


	public class ViewMenuPopUpButton extends PopUpButton
	{
		private var _viewMenu:Menu;



		public function ViewMenuPopUpButton()
		{
			super();
			this.addEventListener(MouseEvent.CLICK, onClick);
			this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
		}


		public function set onCreationComplete(event:FlexEvent):void
		{
			viewMenu=Menu.createMenu(null, children, true);
			viewMenu.addEventListener(MenuEvent.ITEM_CLICK, onMenuItemClick);
		}

		public function set onClick(event:MouseEvent):void
		{
			this.viewMenu.show(event.target.x, event.target.y + event.target.height);

			event.stopImmediatePropagation();
		}

		public function set onMenuItemClick(event:MenuEvent):void
		{
			var newEvent=new MenuEvent(MenuEvent.ITEM_CLICK);
			dispatchEvent(newEvent);
		}


		public function set viewMenu(value:Menu):void
		{
			this._viewMenu=value;
		}

		public function get viewMenu():Menu
		{
			return this._viewMenu;
		}
	}
}