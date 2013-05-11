package com.kvchen.ui.fillstyle
{
	import com.kvchen.ui.fillstyle.data.BitmapFillData;
	import com.kvchen.ui.fillstyle.data.GradientFillData;
	import com.kvchen.ui.fillstyle.data.SolidFillData;
	import com.kvchen.ui.fillstyle.enum.FillType;
	import com.kvchen.ui.fillstyle.protocol.IFillStyle;

	public class ShapeFillStyle implements IFillStyle
	{
		public var solidFillData:SolidFillData = null;
		public var gradientFillData:GradientFillData = null;
		public var bitmapFillData:BitmapFillData = null;
		
		protected var mFillType:int = 0;
		
		public function ShapeFillStyle(fillType:int)
		{
			mFillType = fillType;
		}
		
		public function get fillType():int
		{
			return mFillType;
		}
		
		public static function createBySolidFillData(data:SolidFillData):ShapeFillStyle
		{
			var shapeFillStyle:ShapeFillStyle = new ShapeFillStyle(FillType.SOLIDE);
			shapeFillStyle.solidFillData = data;
			return shapeFillStyle;
		}
		public static function createByGradientFillData(data:GradientFillData):ShapeFillStyle
		{
			var shapeFillStyle:ShapeFillStyle = new ShapeFillStyle(FillType.GRADIENT);
			shapeFillStyle.gradientFillData = data;
			return shapeFillStyle;
		}
		public static function createByBitmapFillData(data:BitmapFillData):ShapeFillStyle
		{
			var shapeFillStyle:ShapeFillStyle = new ShapeFillStyle(FillType.BITMPA);
			shapeFillStyle.bitmapFillData = data;
			return shapeFillStyle;
		}
		
		public function toString():String
		{
			var result:String = "";
			switch(mFillType){
				case FillType.BITMPA:
					result += bitmapFillData.toString() + "\n";
					result += "var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createByBitmapFillData(bitmapFillData);";
					break;
				case FillType.GRADIENT:
					result += gradientFillData.toString() + "\n";
					result += "var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData);";
					break;
				case FillType.SOLIDE:
					result += solidFillData.toString() + "\n";
					result += "var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData);";
					break;
			}
			return result;
		}
	}
}