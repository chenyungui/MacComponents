package com.kvchen.ui.fillstyle
{
	import com.kvchen.ui.fillstyle.data.BitmapFillData;
	import com.kvchen.ui.fillstyle.data.GradientFillData;
	import com.kvchen.ui.fillstyle.data.LineStyleData;
	import com.kvchen.ui.fillstyle.data.SolidFillData;
	import com.kvchen.ui.fillstyle.enum.FillType;
	import com.kvchen.ui.fillstyle.protocol.IFillStyle;

	public class LineFillStyle implements IFillStyle
	{
		public var lineStyleData:LineStyleData = null;
		public var gradientFillData:GradientFillData = null;
		public var bitmapFillData:BitmapFillData = null;
		
		protected var mFillType:int = 0;
		
		public function LineFillStyle(fillType:int)
		{
			mFillType = fillType;
		}
		
		public function get fillType():int
		{
			return mFillType;
		}
		
		public static function createByLineStyleData(data:LineStyleData):LineFillStyle
		{
			var lineFillStyle:LineFillStyle = new LineFillStyle(FillType.SOLIDE);
			lineFillStyle.lineStyleData = data;
			return lineFillStyle;
		}
		public static function createByGradientFillData(data:GradientFillData):LineFillStyle
		{
			var lineFillStyle:LineFillStyle = new LineFillStyle(FillType.GRADIENT);
			lineFillStyle.gradientFillData = data;
			return lineFillStyle;
		}
		public static function createByBitmapFillData(data:BitmapFillData):LineFillStyle
		{
			var lineFillStyle:LineFillStyle = new LineFillStyle(FillType.BITMPA);
			lineFillStyle.bitmapFillData = data;
			return lineFillStyle;
		}
		
		public function toString():String
		{
			var result:String = "";
			switch(mFillType){
				case FillType.BITMPA:
					result += bitmapFillData.toString() + "\n";
					result += "LineFillStyle.createByBitmapFillData(bitmapFillData);";
					break;
				case FillType.GRADIENT:
					result += gradientFillData.toString() + "\n";
					result += "LineFillStyle.createByGradientFillData(gradientFillData);";
					break;
				case FillType.SOLIDE:
					result += lineStyleData.toString() + "\n";
					result += "LineFillStyle.createByLineStyleData(lineStyleData);";
					break;
			}
			return result;
		}
	}
}