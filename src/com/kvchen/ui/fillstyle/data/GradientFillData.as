package com.kvchen.ui.fillstyle.data
{
	import flash.display.GradientType;
	import flash.geom.Matrix;
	
	public class GradientFillData
	{
		public var type:String;
		public var colors:Array;
		public var alphas:Array;
		public var ratios:Array;
		public var spreadMethod:String;
		public var interpolationMethod:String;
		public var focalPointRatio:Number;
		public var angle:Number;
		
		public function GradientFillData(type:String, colors:Array, alphas:Array, ratios:Array, angle:Number = 0, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0)
		{
			this.type = type;
			this.colors = colors;
			this.alphas = alphas;
			this.ratios = ratios;
			this.spreadMethod = spreadMethod;
			this.interpolationMethod = interpolationMethod;
			this.focalPointRatio = focalPointRatio;
			this.angle = angle;
		}
		
		public function toString():String
		{
			var result:String = "var gradientFillData:GradientFillData = new GradientFillData(";
			if(type == GradientType.LINEAR) result += "GradientType.LINEAR, ";
			else if(type == GradientType.RADIAL) result += "GradientType.RADIAL, ";
			
			var colorsStr:String = "[";
			var alphasStr:String = "[";
			var ratiosStr:String = "[";
			var i:int = 0, len:int = colors.length;

			for(i=0; i<len; ++i){
				colorsStr += "0x" + colors[i].toString(16) + ",";
				alphasStr += Number(alphas[i]).toFixed(2) + ",";
				ratiosStr += int(ratios[i]) + ",";
			}
			
			colorsStr = colorsStr.slice(0, colorsStr.length-1);
			alphasStr = alphasStr.slice(0, alphasStr.length-1);
			ratiosStr = ratiosStr.slice(0, ratiosStr.length-1);
			
			colorsStr += "]";
			alphasStr += "]";
			ratiosStr += "]";
			
			result += colorsStr + ",";
			result += alphasStr + ",";
			result += ratiosStr + ",";
			result += angle + ");";
			
			return result;
		}
	}
}