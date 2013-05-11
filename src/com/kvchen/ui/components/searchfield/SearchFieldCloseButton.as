package com.kvchen.ui.components.searchfield
{
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.fillstyle.data.SolidFillData;
	import com.kvchen.ui.shape.Circle;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	
	import spark.components.supportClasses.DisplayLayer;
	
	public class SearchFieldCloseButton extends SimpleButton
	{
		public function SearchFieldCloseButton()
		{
			var upState:DisplayObject = createButtonState(0xababab);
			var downState:DisplayObject = createButtonState(0x747474);
			var hitState:DisplayObject = createHitState();
			super(upState, upState, downState, hitState);
		}
		
		protected function createHitState():DisplayObject{
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(new SolidFillData(0x0));
			var circle:Circle = new Circle(7, null, shapeFillStyle);
			return circle;
		}
		
		protected function createButtonState(color:uint):DisplayObject{
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(new SolidFillData(color));
			var circle:Circle = new Circle(7, null, shapeFillStyle);
			circle.addChild(createCloseIcon());
			return circle;
		}
		
		protected function createCloseIcon():DisplayObject{
			var data:Vector.<Number> = new Vector.<Number>();
			data.push(1.892,-3.112,2.271,-3.471,2.271,-3.471,2.271,-3.471,2.271,-3.471,2.271,-3.471,2.376,-3.495,2.480,-3.520,2.690,-3.570,2.919,-3.479,3.148,-3.388,3.397,-3.157,3.494,-2.931,3.592,-2.706,3.536,-2.486,3.509,-2.376,3.481,-2.266,3.481,-2.266,3.481,-2.266,3.481,-2.266,3.481,-2.266,3.123,-1.897,2.765,-1.527,2.048,-0.788,1.689,-0.419,1.331,-0.049,1.331,-0.049,1.331,-0.049,1.331,-0.049,1.331,-0.049,1.684,0.298,2.037,0.645,2.743,1.340,3.096,1.688,3.449,2.035,3.449,2.035,3.449,2.035,3.449,2.035,3.449,2.035,3.497,2.158,3.546,2.281,3.643,2.526,3.551,2.775,3.460,3.023,3.179,3.274,2.913,3.366,2.647,3.458,2.396,3.390,2.271,3.356,2.145,3.322,2.145,3.322,2.145,3.322,2.145,3.322,2.145,3.322,1.797,2.980,1.448,2.638,0.752,1.954,0.403,1.612,0.055,1.271,0.055,1.271,0.055,1.271,0.055,1.271,0.055,1.271,-0.280,1.597,-0.614,1.923,-1.283,2.576,-1.618,2.902,-1.952,3.229,-1.952,3.229,-1.952,3.229,-1.952,3.229,-1.952,3.229,-2.088,3.281,-2.224,3.333,-2.495,3.438,-2.757,3.373,-3.019,3.309,-3.273,3.076,-3.353,2.823,-3.434,2.570,-3.342,2.297,-3.296,2.161,-3.251,2.024,-3.251,2.024,-3.251,2.024,-3.251,2.024,-3.251,2.024,-2.913,1.678,-2.576,1.333,-1.901,0.642,-1.564,0.296,-1.226,-0.049,-1.226,-0.049,-1.226,-0.049,-1.226,-0.049,-1.226,-0.049,-1.557,-0.386,-1.888,-0.722,-2.550,-1.395,-2.881,-1.732,-3.212,-2.068,-3.212,-2.068,-3.212,-2.068,-3.212,-2.068,-3.212,-2.068,-3.264,-2.209,-3.316,-2.350,-3.421,-2.633,-3.365,-2.887,-3.309,-3.140,-3.093,-3.366,-2.835,-3.437,-2.578,-3.507,-2.279,-3.423,-2.129,-3.381,-1.980,-3.339,-1.980,-3.339,-1.980,-3.339,-1.980,-3.339,-1.980,-3.339,-1.651,-3.002,-1.322,-2.666,-0.664,-1.993,-0.335,-1.656,-0.006,-1.320,-0.006,-1.320,-0.006,-1.320,-0.006,-1.320,-0.006,-1.320,0.374,-1.678,0.753,-2.037,1.513,-2.754,1.892,-3.112);
			var command:Vector.<int> = new Vector.<int>();
			command.push(1,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6);
			var s:Shape = new Shape();
			s.graphics.beginFill(0xf7f7f7);
			s.graphics.drawPath(command, data);
			s.graphics.endFill();
			return s;
		}
	}
}