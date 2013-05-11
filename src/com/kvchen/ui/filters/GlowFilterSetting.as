package com.kvchen.ui.filters
{
	
	import com.kvchen.ui.utils.ArrayUtils;
	
	import flash.filters.GlowFilter;

	public class GlowFilterSetting
	{
		public var alpha:Number;
		public var blurX:Number;
		public var blurY:Number;
		public var color:uint;
		public var inner:Boolean;
		public var knockout:Boolean;
		public var quality:int;
		public var strength:Number;
		
		public function GlowFilterSetting()
		{
		}
		
		public function toString():String
		{
			var defaultValues:Array = [GlowFilterDefault.color, GlowFilterDefault.alpha, GlowFilterDefault.blurX, GlowFilterDefault.blurY, GlowFilterDefault.strength, GlowFilterDefault.quality, GlowFilterDefault.inner, GlowFilterDefault.knockout];
			var newValues:Array = [color, alpha, blurX, blurY, strength, quality, inner, knockout];
			var len:int = ArrayUtils.compareVars(defaultValues, newValues);
			var str:String = "var glowFilter:GlowFilter = new GlowFilter(";
			for(var i:int=0; i<len; ++i)
			{
				if(i == len-1){
					str += String(newValues[i]) + ");";
				}else{
					str += String(newValues[i]) + ", ";
				}
			}
			return str;
		}
		
		public static function createFromGlowFilter(filter:GlowFilter):GlowFilterSetting
		{
			var glowSettings:GlowFilterSetting = new GlowFilterSetting();
			glowSettings.alpha = filter.alpha;
			glowSettings.blurX = filter.blurX;
			glowSettings.blurY = filter.blurY;
			glowSettings.color = filter.color;
			glowSettings.inner = filter.inner;
			glowSettings.knockout = filter.knockout;
			glowSettings.quality = filter.quality;
			glowSettings.strength = filter.strength;
			return glowSettings;
		}
	}
}