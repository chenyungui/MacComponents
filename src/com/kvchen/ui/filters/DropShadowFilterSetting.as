package com.kvchen.ui.filters
{
	import com.kvchen.ui.utils.ArrayUtils;
	
	import flash.filters.DropShadowFilter;

	public class DropShadowFilterSetting
	{
		public function DropShadowFilterSetting()
		{
		}
		
		public var alpha:Number;
		public var angle:Number;
		public var blurX:Number;
		public var blurY:Number;
		public var color:uint;
		public var distance:Number;
		public var hideObject:Boolean;
		public var inner:Boolean;
		public var knockout:Boolean;
		public var quality:int;
		public var strength:int;
		
		public function toString():String
		{
			var defaultValues:Array = [DropShadowFilterDefault.distance, DropShadowFilterDefault.angle, DropShadowFilterDefault.color, DropShadowFilterDefault.alpha, DropShadowFilterDefault.blurX, DropShadowFilterDefault.blurY, DropShadowFilterDefault.strength, DropShadowFilterDefault.quality, DropShadowFilterDefault.inner, DropShadowFilterDefault.knockout, DropShadowFilterDefault.hideObject];
			var newValues:Array = [distance, angle, color, alpha, blurX, blurY, strength, quality, inner, knockout, hideObject];
			var len:int = ArrayUtils.compareVars(defaultValues, newValues);
			var str:String = "var dropShadowFilter:DropShadowFilter = new DropShadowFilter(";
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
		
		public static function createFromDropShadowFilter(filter:DropShadowFilter):DropShadowFilterSetting
		{
			var dropShadowSettings:DropShadowFilterSetting = new DropShadowFilterSetting();
			dropShadowSettings.alpha = filter.alpha;
			dropShadowSettings.angle = filter.angle;
			dropShadowSettings.blurX = filter.blurX;
			dropShadowSettings.blurY = filter.blurY;
			dropShadowSettings.color = filter.color;
			dropShadowSettings.distance = filter.distance;
			dropShadowSettings.hideObject = filter.hideObject;
			dropShadowSettings.inner = filter.inner;
			dropShadowSettings.knockout = filter.knockout;
			dropShadowSettings.quality = filter.quality;
			dropShadowSettings.strength = filter.strength;
			return dropShadowSettings;
		}
	}
}