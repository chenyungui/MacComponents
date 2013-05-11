package com.kvchen.ui.components.loading
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	public class CircleLoading extends Sprite
	{
		protected static const START_ALPHA:Number = 1.0;
		protected static const END_ALPHA:Number = 0.1;

		//use cubicBezier to draw a round corner (radius is 1). the two controls point special value will be following
		public static const CBR0:Number = 0.455877279275103; //CUBIC_BEZIER_ROUND_RATIO_0
		public static const CBR1:Number = 0.544122720724897; //CUBIC_BEZIER_ROUND_RATIO_1
		
		//use cubicBezier to draw a round corner(radius is 1) container, will contains 4 points(8 values), the following values precalculate for each corner
		public static const tlCubicData:Array = [0,1,0,CBR0,CBR0,0,1,0];
		public static const trCubicData:Array = [0,0,CBR1,0,1,CBR0,1,1];
		public static const brCubicData:Array = [1,0,1,CBR1,CBR1,1,0,1];
		public static const blCubicData:Array = [1,1,CBR0,1,0,CBR1,0,0];

		protected var _color:uint = 0x0;
		protected var _radius:Number = 40;
		protected var _aliquots:int = 12;
		protected var _unitWidth:Number = 12;
		protected var _unitHeight:Number = 20;
		protected var _unitRadius:Number = 6;
		protected var _rotateFPS:Number = 12;//fps

		protected var _rotateStep:int = 0;
		protected var _rotateAngleStep:Number = 0;
		
		protected var _rotateDuration:Number = 0;
		protected var _rotateTime:Number = 0;
		protected var _lastRotateTime:Number = 0;
		
		protected var _minUnitRadius:Number = 0;
		protected var _maxUnitRadius:Number = 0;
		
		protected var _pathData:Vector.<Number>;
		protected var _pathCommands:Vector.<int>;
		
		/**
		 * Constructor
		 * @param color The color of this component
		 * @param radius Think the loading as a circle, the radius is the circle radius
		 * @param aliquots The count of unit
		 * @param unitWidth (Reference to the zero angled round rect) The width of the round rect
		 * @param unitHeight (Reference to the zero angled round rect) The height of the round rect
		 * @param unitRadius (Reference to the zero angled round rect) The radius of the round rect
		 * @param rotateFPS The rotation speed, frame per second
		 * 
		 */		
		public function CircleLoading(color:uint = 0x0, radius:Number = 30, aliquots:int = 12, unitWidth:Number = 15, unitHeight:Number = 4, unitRadius:Number = 2, rotateFPS:Number = 20)
		{
			_color = color;
			_radius = radius;
			_aliquots = aliquots;
			_unitWidth = unitWidth;
			_unitHeight = unitHeight;
			_unitRadius = unitRadius;
			_rotateFPS = rotateFPS;
			_rotateDuration = 1000.0/rotateFPS;
			
			_pathData = new Vector.<Number>();
			_pathCommands = new Vector.<int>();
			
			updateLoading();
			initEvents();
		}
		
		/**
		 * Sets / gets the color for this component.
		 */		
		public function get color():uint
		{
			return _color;
		}
		public function set color(value:uint):void
		{
			_color = value;
			updateLoading();
		}

		/**
		 * Sets / gets the radius for this component.
		 */	
		public function get radius():Number
		{
			return _radius;
		}
		public function set radius(value:Number):void
		{
			_radius = value;
			updateLoading();
		}

		/**
		 * Sets / gets the aliquots for this component. the min value is 3
		 */	
		public function get aliquots():int
		{
			return _aliquots;
		}
		public function set aliquots(value:int):void
		{
			_aliquots = value;
			updateLoading();
		}

		/**
		 * (Reference to the zero angled round rect) Sets / gets the width for the round rect.
		 */	
		public function get unitWidth():Number
		{
			return _unitWidth;
		}
		public function set unitWidth(value:Number):void
		{
			_unitWidth = value;
			updateLoading();
		}

		/**
		 * (Reference to the zero angled round rect) Sets / gets the height for the round rect.
		 */	
		public function get unitHeight():Number
		{
			return _unitHeight;
		}
		public function set unitHeight(value:Number):void
		{
			_unitHeight = value;
			updateLoading();
		}
		
		/**
		 * (Reference to the zero angled round rect) Sets / gets the radius for the round rect.
		 */	
		public function get unitRadius():Number
		{
			return _unitRadius;
		}
		public function set unitRadius(value:Number):void
		{
			_unitRadius = value;
			updateLoading();
		}

		/**
		 * Sets / gets the rotation animation frame rate (frame per seconds).
		 */	
		public function get rotateFPS():Number
		{
			return _rotateFPS;
		}
		public function set rotateFPS(value:Number):void
		{
			_rotateFPS = value;
			_rotateDuration = 1000.0/value;
		}
		
		/**
		 * help method for make sure the unit radius is half of the shorter edge length
		 * @param value need to correct unit radius value
		 * @return the correct unit radius value
		 * 
		 */		
		protected function correctUnitRadius(value:Number):Number
		{
			_maxUnitRadius = _unitHeight < _unitWidth ? _unitHeight*0.5 : _unitWidth*0.5;
			return value > _maxUnitRadius ? _maxUnitRadius : value;
		}
		
		/**
		 * redraw this component, this is using "graphics.drawPath()" to draw component, for better performance
		 */		
		protected function updateLoading():void{
			
			_rotateStep = 0;
			_rotateAngleStep = 360.0/_aliquots;
			
			var unitRadius:Number = correctUnitRadius(_unitRadius);
			var xl:Number = _radius - _unitWidth;
			var xr:Number = _radius - unitRadius;
			var yt:Number = -_unitHeight * 0.5;
			var yb:Number = _unitHeight*0.5 - unitRadius;
			
			_pathData.length = 0;
			_pathCommands.length = 0;
			
			//push top left corner
			pushRoundCorner(_pathData, tlCubicData, unitRadius, xl, yt);
			_pathCommands.push(1, 6);
			
			//push top right corner
			pushRoundCorner(_pathData, trCubicData, unitRadius, xr, yt);
			_pathCommands.push(2, 6);
			
			//push bottom right corner
			pushRoundCorner(_pathData, brCubicData, unitRadius, xr, yb);
			_pathCommands.push(2, 6);
			
			//push bottom left corner
			pushRoundCorner(_pathData, blCubicData, unitRadius, xl, yb);
			_pathCommands.push(2, 6);
			
			_pathData.push(xl, yt+unitRadius);
			_pathCommands.push(2);
			
			//clear graphics, prepare for redraw component
			this.graphics.clear();
			
			var i:int = -1;
			var alphaStep:Number = (START_ALPHA-END_ALPHA)/_aliquots;
			var radianStep:Number = (Math.PI*2)/_aliquots;
			var alpha:Number, radian:Number;
			while(++i < _aliquots){
				alpha = END_ALPHA + alphaStep * i;
				radian = radianStep * i;
				drawRoundRect(radian, alpha);
			}
			
			this.graphics.endFill();
		}
		
		/**
		 * Help method for push corner graphics data
		 * @param data The data will push new values
		 * @param corner The precalculated template value 
		 * @param size	The corner radius
		 * @param offsetX The corner top left coordinate x
		 * @param offsetY The corner top left coordinate y
		 */		
		protected function pushRoundCorner(data:Vector.<Number>, corner:Array, size:Number, offsetX:Number, offsetY:Number):void
		{
			var len:int = corner.length;
			for(var i:int=0; i<len; i+=2){
				data.push(corner[i] * size + offsetX);
				data.push(corner[i+1] * size + offsetY);
			}
		}
		
		/**
		 * draw a angled round rect
		 * @param radians The angle of the round rect, rotate center is origin. use radian to save calculation
		 * @param alpha The alpha of the round rect
		 */		
		protected function drawRoundRect(radians:Number, alpha:Number):void{
			
			this.graphics.beginFill(_color, alpha);
			if(radians == 0){
				this.graphics.drawPath(_pathCommands, _pathData);
			}else{
				var data:Vector.<Number> = new Vector.<Number>(_pathData.length);
				var i:int = -1;
				var cos:Number = Math.cos(radians);
				var sin:Number = Math.sin(radians);

				while(++i < _pathData.length){
					data[i] = cos*_pathData[i] - sin*_pathData[i+1];
					data[i+1] = cos*_pathData[i+1] + sin*_pathData[i];
					++i;
				}
				this.graphics.drawPath(_pathCommands, data);
			}
		}
		
		/**
		 * add event listener to listen ADD_TO_STAGE event
		 */		
		protected function initEvents():void{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		/**
		 * Once showing will auto start listen ENTER_FRAME event to start animation
		 */		
		protected function onAddToStage(e:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		}
		
		/**
		 * Once hided will auto remove listen ENTER_FRAME event to stop animation
		 */		
		protected function onRemoveFromStage(e:Event):void{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		/**
		 * calculate the rotation to perform animation
		 */		
		protected function onEnterFrame(e:Event):void{
			_rotateTime = getTimer();
			if(_rotateTime - _lastRotateTime >= _rotateDuration){
				this.rotation = _rotateStep++ * _rotateAngleStep; 
				_rotateStep = _rotateStep >= _aliquots ? 0 : _rotateStep;
				_lastRotateTime = _rotateTime;
			}
		}
		
		/**
		 * @return Initial code string
		 */		
		public function toCodeString():String{
			return "var loading:CircleLoading = new CircleLoading(0x"+ color.toString(16) +", "+ radius +", "+ aliquots +", "+ unitWidth +", "+ unitHeight +", "+ unitRadius +", "+ rotateFPS +");";
		}
	}
}






















