package com.kvchen.ui.fillstyle.data
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class BitmapFillData
	{
		public var bitmap:BitmapData;
		public var matrix:Matrix;
		public var repeat:Boolean;
		public var smooth:Boolean;
		
		public function BitmapFillData(bitmap:BitmapData, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false)
		{
			this.bitmap = bitmap;
			this.matrix = matrix;
			this.repeat = repeat;
			this.smooth = smooth;
		}
		
		public static function createByFourColors(color1:uint, color2:uint, color3:uint, color4:uint, width:Number, height:Number, center:Point):BitmapFillData
		{
			var bitmap:BitmapData = new BitmapData(width, height, false, 0x00ff00);
			var color1Rect:Rectangle = new Rectangle(0, 0, center.x, center.y);
			var color2Rect:Rectangle = new Rectangle(center.x, 0, width-center.x, center.y);
			var color3Rect:Rectangle = new Rectangle(0, center.y, center.x, height-center.y);
			var color4Rect:Rectangle = new Rectangle(center.x, center.y, width-center.x, height-center.y);
			bitmap.fillRect(color1Rect, color1);
			bitmap.fillRect(color2Rect, color2);
			bitmap.fillRect(color3Rect, color3);
			bitmap.fillRect(color4Rect, color4);
			return new BitmapFillData(bitmap);
		}
		
		public static function createByFourColorsGrid(color1:uint, color2:uint, color3:uint, color4:uint, size:Number):BitmapFillData
		{
			var bitmap:BitmapData = new BitmapData(size*2, size*2, false, 0x00ff00);
			var color1Rect:Rectangle = new Rectangle(0, 0, size, size);
			var color2Rect:Rectangle = new Rectangle(size, 0, size, size);
			var color3Rect:Rectangle = new Rectangle(0, size, size, size);
			var color4Rect:Rectangle = new Rectangle(size, size, size, size);
			bitmap.fillRect(color1Rect, color1);
			bitmap.fillRect(color2Rect, color2);
			bitmap.fillRect(color3Rect, color3);
			bitmap.fillRect(color4Rect, color4);
			return new BitmapFillData(bitmap);
		}
		
		public static function createByHorizontalTwoColors(color1:uint, color2:uint, color1Height:int = 2, color2Height:int = 5):BitmapFillData
		{
			var bitmap:BitmapData = new BitmapData(1, color1Height+color2Height, false, 0x00ff00);
			var color1Rect:Rectangle = new Rectangle(0, 0, 1, color1Height);
			var color2Rect:Rectangle = new Rectangle(0, color1Height, 1, color2Height);
			bitmap.fillRect(color1Rect, color1);
			bitmap.fillRect(color2Rect, color2);
			return new BitmapFillData(bitmap);
		}
		
		public static function createBySlantTwoColors(color1:uint, color2:uint, color1Height:int = 2, color2Height:int = 5, angle:Number = 45):BitmapFillData
		{
			var bitmap:BitmapData = new BitmapData(1, color1Height+color2Height, false, 0x00ff00);
			var color1Rect:Rectangle = new Rectangle(0, 0, 1, color1Height);
			var color2Rect:Rectangle = new Rectangle(0, color1Height, 1, color2Height);
			bitmap.fillRect(color1Rect, color1);
			bitmap.fillRect(color2Rect, color2);
			var matrix:Matrix = new Matrix();
			matrix.rotate(Math.PI*angle/180);
			return new BitmapFillData(bitmap);
		}
		
		public static function createByVerticalTwoColors(color1:uint, color2:uint, color1Width:int = 2, color2Width:int = 5):BitmapFillData
		{
			var bitmap:BitmapData = new BitmapData(color1Width+color2Width, 1, false, 0x00ff00);
			var color1Rect:Rectangle = new Rectangle(0, 0, color1Width, 1);
			var color2Rect:Rectangle = new Rectangle(color1Width, 0, color2Width, 1);
			bitmap.fillRect(color1Rect, color1);
			bitmap.fillRect(color2Rect, color2);
			return new BitmapFillData(bitmap);
		}
		
		public function toString():String
		{
			var result:String = "var BitmapFillData:BitmapFillData = BitmapFillData.createByFourColorsGrid(0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 5);"
			return result;
		}
	}
}