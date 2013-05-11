package com.kvchen.ui.components.scrollbar
{
	public interface IHorizontalScrollContent
	{
		function get visibleWidth():Number;
		function get contentWidth():Number;
		function get minX():Number;
		function get maxX():Number;
		function get xpos():Number;
		function set xpos(value:Number):void;
	}
}