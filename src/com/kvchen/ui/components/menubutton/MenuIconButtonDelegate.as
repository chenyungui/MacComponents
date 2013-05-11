package com.kvchen.ui.components.menubutton
{
	public interface MenuIconButtonDelegate
	{
		function menuIconButtonDidSelectMenuItem(menuIconButton:MenuIconButton, menuItemLabel:String):void;
	}
}