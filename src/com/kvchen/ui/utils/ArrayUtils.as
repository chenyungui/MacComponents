package com.kvchen.ui.utils
{
	public class ArrayUtils
	{
		public static function compareVars(defaults:Array, news:Array):int
		{
			if(defaults.length != news.length) return 0;
			var len:int = defaults.length;
			var resultLen:int = len;
			var results:Array = new Array();
			for(var i:int=0; i<len; ++i){
				results.push(defaults[i] == news[i]);
			}
			for(i = len-1; i>=0; --i)
			{
				if(results[i])
					resultLen--;
				else
					return resultLen;
			}
			return 0;
		}
		
		public static function removeNullObject(ary:Array):Array
		{
			var newAry:Array = [];
			for (var i:int = 0; i < ary.length; i++) 
			{
				if(ary[i] != null){
					newAry.push(ary[i]);
				}
			}
			return newAry;
		}
	}
}