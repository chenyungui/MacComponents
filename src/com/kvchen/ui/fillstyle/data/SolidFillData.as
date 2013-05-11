package com.kvchen.ui.fillstyle.data
{	
	public class SolidFillData
	{
		public var color:uint;
		public var alpha:Number;
		
		public function SolidFillData(color:uint = 0, alpha:Number = 1)
		{
			this.color = color;
			this.alpha = alpha;
		}
		
		public function toString():String{
			var result:String = "var solidFillData:SolidFillData = new SolidFillData(";
			result += "0x" + color.toString(16) + ", ";
			result += alpha + ");";
			return result;
		}
	}
}