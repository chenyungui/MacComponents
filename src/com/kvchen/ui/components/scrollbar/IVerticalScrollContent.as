package com.kvchen.ui.components.scrollbar
{
	public interface IVerticalScrollContent
	{
		function get visibleHeight():Number;
		function get contentHeight():Number;
		function get minY():Number;
		function get maxY():Number;
		function get ypos():Number;
		function set ypos(value:Number):void;
	}
}