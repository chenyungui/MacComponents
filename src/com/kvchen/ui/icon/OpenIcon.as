package com.kvchen.ui.icon
{
	import com.kvchen.ui.fillstyle.LineFillStyle;
	import com.kvchen.ui.fillstyle.ShapeFillStyle;

	public class OpenIcon extends IconBase
	{
		public function OpenIcon(size:Number = 14, lineFillStyle:LineFillStyle = null, shapeFillStyle:ShapeFillStyle = null)
		{
			var data:Vector.<Number> = new Vector.<Number>();
			data.push(5.6678,2.4784,5.6678,2.7485,5.4488,2.9675,5.1786,2.9675,5.1786,2.9675,-3.8710,2.9675,-3.8710,2.9675,-4.1412,2.9675,-4.3602,2.7485,-4.3602,2.4784,-4.3602,2.4784,-3.4125,-3.5640,-3.4125,-3.5640,-3.4125,-3.8342,-3.1935,-4.0532,-2.9233,-4.0532,-2.9233,-4.0532,6.1264,-4.0532,6.1264,-4.0532,6.3966,-4.0532,6.6155,-3.8342,6.6155,-3.5640,6.6155,-3.5640,5.6678,2.4784,5.6678,2.4784,4.5534,-4.3431,3.7585,-4.3431,-2.8927,-4.3431,-3.1679,-4.3431,-3.3207,-4.3278,-3.6570,-4.1902,-3.7335,-3.7010,-3.7335,-3.7010,-4.7730,2.9681,-4.7730,2.9681,-4.7730,2.9681,-5.2469,2.8327,-5.3080,2.3741,-5.3691,1.9156,-6.2558,-5.6260,-6.2558,-5.6260,-6.2558,-5.6260,-6.4086,-6.2986,-5.8277,-6.2986,-5.2469,-6.2986,-2.2812,-6.2986,-1.8533,-6.2986,-1.4252,-6.2986,-1.2112,-5.6260,-1.2112,-5.6260,-1.2112,-5.6260,-1.0583,-5.1678,-0.7526,-5.1678,-0.4469,-5.1678,3.8197,-5.1678,4.5840,-5.1678,5.3484,-5.1678,5.3484,-4.3431,4.5534,-4.3431);
			var command:Vector.<int> = new Vector.<int>();
			command.push(1,6,6,6,6,6,6,6,6,1,6,6,6,6,6,6,6,6,6,6,6);
			super(data, command, size, lineFillStyle, shapeFillStyle);
		}
	}
}
