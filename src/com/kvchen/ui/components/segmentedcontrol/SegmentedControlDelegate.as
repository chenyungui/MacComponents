package com.kvchen.ui.components.segmentedcontrol
{
	public interface SegmentedControlDelegate
	{
		function segmentedControlDidSelectButton(segmentedControl:SegmentedControl, buttonName:String):void;
	}
}