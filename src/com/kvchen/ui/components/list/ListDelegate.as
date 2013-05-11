package com.kvchen.ui.components.list
{
	public interface ListDelegate
	{
		function listDidChangeSelection(list:List):void;
		function listDidPickItem(list:List, item:Object):void;
		function listItemDidChange(list:List, item:Object):void;
	}
}