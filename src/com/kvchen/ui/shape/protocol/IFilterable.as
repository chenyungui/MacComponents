package com.kvchen.ui.shape.protocol
{
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;

	public interface IFilterable
	{
		function get dropShadowFilter():DropShadowFilter;
		function set dropShadowFilter(value:DropShadowFilter):void;
		
		function get glowFilter():GlowFilter;
		function set glowFilter(value:GlowFilter):void;
	}
}