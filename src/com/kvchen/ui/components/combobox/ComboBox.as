package com.kvchen.ui.components.combobox
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class ComboBox extends Sprite
	{
		public function ComboBox()
		{
			super();
		}
		
		protected function createDropDownBtnIcon():DisplayObject
		{
			var data:Vector.<Number> = new Vector.<Number>();
			data.push(2.240,-2.294,3.360,-2.294,3.360,-2.294,3.360,-2.294,3.360,-2.294,3.360,-2.294,2.800,-1.494,2.240,-0.693,1.120,0.908,0.560,1.709,0.000,2.509,0.000,2.509,0.000,2.509,0.000,2.509,0.000,2.509,-0.560,1.709,-1.120,0.908,-2.240,-0.693,-2.800,-1.494,-3.360,-2.294,-3.360,-2.294,-3.360,-2.294,-3.360,-2.294,-3.360,-2.294,-2.240,-2.294,-1.120,-2.294,1.120,-2.294,2.240,-2.294);
			var command:Vector.<int> = new Vector.<int>();
			command.push(1,6,6,6,6,6,6,6,6,6);
			var s:Shape = new Shape();
			s.graphics.beginFill(0x434343, 1);
			s.graphics.drawPath(command, data);
			s.graphics.endFill();
			return s;
		}
	}
}