package com.kvchen.ui.icon
{
	import com.kvchen.ui.fillstyle.LineFillStyle;
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	
	public class Icon extends IconBase
	{
		public function Icon(size:Number = 14, lineFillStyle:LineFillStyle = null, shapeFillStyle:ShapeFillStyle = null)
		{
			var data:Vector.<Number> = new Vector.<Number>();
			data.push(-0.0860,-8.8232,4.7398,-8.8232,8.6519,-4.9111,8.6519,-0.0853,8.6519,4.7405,4.7398,8.6525,-0.0860,8.6525,-4.9118,8.6525,-8.8239,4.7405,-8.8239,-0.0853,-8.8239,-4.9111,-4.9118,-8.8232,-0.0860,-8.8232);
			var command:Vector.<int> = new Vector.<int>();
			command.push(1,6,6,6,6);
			super(data, command, size, lineFillStyle, shapeFillStyle);
		}
	}
}