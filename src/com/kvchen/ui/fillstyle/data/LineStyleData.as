package com.kvchen.ui.fillstyle.data
{

	public class LineStyleData
	{
		public var thickness:Number;
		public var color:uint;
		public var alpha:Number;
		public var pixelHinting:Boolean;
		public var scaleMode:String;
		public var caps:String;
		public var joints:String;
		public var miterLimit:Number;
		
		public function LineStyleData(thickness:Number = NaN, color:uint = 0, alpha:Number = 1.0, pixelHinting:Boolean = false, scaleMode:String = "normal", caps:String = null, joints:String = null, miterLimit:Number = 3):void
		{
			this.thickness = thickness;
			this.color = color;
			this.alpha = alpha;
			this.pixelHinting = pixelHinting;
			this.scaleMode = scaleMode;
			this.caps = caps;
			this.joints = joints;
			this.miterLimit = miterLimit;
		}
		
		public function toString():String
		{
			var result:String = "var lineStyleData:LineStyleData = new LineStyleData(";
			if(isNaN(thickness)) result += "0, ";
			else result += thickness + ", ";
			result += "0x" + color.toString(16) + ", ";
			result += alpha + ");";
			return result;
		}
	}
}