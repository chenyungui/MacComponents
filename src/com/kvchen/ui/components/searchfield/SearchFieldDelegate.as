package com.kvchen.ui.components.searchfield
{
	public interface SearchFieldDelegate
	{
		function searchFieldDidPickResult(result:String):void;
		function searchFieldRequestDataForSearch():Array;//need be string array
	}
}