package com.kvchen.ui.components.popupbutton
{
	import com.kvchen.ui.components.label.Label;
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.fillstyle.data.GradientFillData;
	import com.kvchen.ui.fillstyle.data.SolidFillData;
	import com.kvchen.ui.shape.Circle;
	import com.kvchen.ui.shape.RingCircle;
	import com.kvchen.ui.shape.RoundFrameRect;
	
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.text.TextFormatAlign;
	
	public class PopupButton extends Sprite implements PopupListDelegate
	{
		protected var _items:Array;
		protected var _width:Number;
		protected var _listWidth:Number;
		protected var _selectedIndex:int;
		
		protected var _upSkin:DisplayObject;
		protected var _label:Label;
		protected var _popupListCon:Sprite;
		protected var _popupList:PopupList;
		
		protected var _clickHandler:Function = null;
		
		public function PopupButton(items:Array, selectedIndex:int = 0, width:Number = 100, clickHandler:Function = null, listWidth:Number = -1)
		{
			_items = items;
			_selectedIndex = selectedIndex;
			_width = width;
			_listWidth = listWidth > 0 ? listWidth : _width;
			_clickHandler = clickHandler;
			_upSkin = createUpSkin(_width);
			_label = new Label(items[selectedIndex], _width-10, TextFormatAlign.LEFT);
			_label.x = 10;
			_popupListCon = new Sprite();
			_popupList = new PopupList(items, selectedIndex, _listWidth);
			_popupList.delegate = this;
			_popupListCon.addChild(_popupList);
			addChild(_upSkin);
			addChild(_label);
			initEvent();
		}
		
		public function popupListDidSelectItem(popupListItem:PopupListItem):void{
			if(_selectedIndex != popupListItem.index){
				_selectedIndex = popupListItem.index;
				_label.text = popupListItem.label;
			}
			if(_clickHandler != null){
				_clickHandler();
			}
		}
		
		override public function get width():Number
		{
			return _width;
		}
		override public function get height():Number
		{
			return 22;
		}
		
		override public function set width(value:Number):void
		{
			
		}
		override public function set height(value:Number):void
		{
			
		}
		
		public function set label(value:String):void{
			var item:String = "";
			for (var i:int = 0; i < _items.length; i++) 
			{
				item = _items[i];
				if(item == value){
					this.selectedIndex = i;
					return;
				}
			}
		}
		
		public function set selectedIndex(value:int):void{
			_selectedIndex = value;
			_popupList.selectedIndex = value;
			var item:String = _items[value];
			_label.text = item;
		}
		
		public function get selectedIndex():int{
			return _selectedIndex;
		}
		
		public function get label():String{
			return _label.text;
		}
		
		protected function initEvent():void{
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		protected function onMouseDown(e:MouseEvent):void{
			
			var globalPos:Point = this.localToGlobal(new Point());
			
			_popupList.x = -10;
			_popupList.y = -(PopupList.LIST_ITEM_HEIGHT * _selectedIndex + 5);
			_popupList.selectedIndex = _selectedIndex;
			_popupListCon.x = globalPos.x;
			_popupListCon.y = globalPos.y;
			stage.addChild(_popupListCon);
			
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		protected function onMouseUp(e:MouseEvent):void{
			if(_popupListCon.parent)_popupListCon.parent.removeChild(_popupListCon);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}

		protected function createUpSkin(width:Number):DisplayObject{
			var con:Sprite = new Sprite();
			var solidFillData:SolidFillData = new SolidFillData(0x858585, 1);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData);
			var gradientFillData:GradientFillData = new GradientFillData(GradientType.LINEAR, [0xffffff,0xf0f0f0,0xe7e7e7,0xefefef],[1.00,1.00,1.00,1.00],[0,128,129,255],90);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData);
			var dropShadowFilter:DropShadowFilter = new DropShadowFilter(1, 90, 0, 0.2, 0, 1);
			var roundFrameRect:RoundFrameRect = new RoundFrameRect(width, 21, 4, 4, 4, 4, 1, null, borderFillStyle, shapeFillStyle);
			roundFrameRect.filters = [dropShadowFilter];
			var icon:DisplayObject = createUpSkinIcon();
			icon.x = width - 11;
			icon.y = 10.5;
			con.addChild(roundFrameRect);
			con.addChild(icon);
			
			return con;
		}
		
		protected function createUpSkinIcon():DisplayObject
		{
			var data0:Vector.<Number> = new Vector.<Number>();
			data0.push(-0.945,-1.680,-1.890,-1.680,-1.890,-1.680,-1.890,-1.680,-1.890,-1.680,-1.890,-1.680,-1.418,-2.327,-0.945,-2.975,0.000,-4.270,0.473,-4.918,0.945,-5.565,0.945,-5.565,0.945,-5.565,0.945,-5.565,0.945,-5.565,1.417,-4.918,1.890,-4.270,2.835,-2.975,3.308,-2.327,3.780,-1.680,3.780,-1.680,3.780,-1.680,3.780,-1.680,3.780,-1.680,2.835,-1.680,1.890,-1.680,-0.000,-1.680,-0.945,-1.680);
			var command0:Vector.<int> = new Vector.<int>();
			command0.push(1,6,6,6,6,6,6,6,6,6);
			var data:Vector.<Number> = new Vector.<Number>();
			data.push(2.846,1.483,3.791,1.491,3.791,1.491,3.791,1.491,3.791,1.491,3.791,1.491,3.314,2.134,2.837,2.777,1.883,4.064,1.406,4.707,0.929,5.350,0.929,5.350,0.929,5.350,0.929,5.350,0.929,5.350,0.461,4.699,-0.007,4.048,-0.943,2.746,-1.411,2.095,-1.879,1.444,-1.879,1.444,-1.879,1.444,-1.879,1.444,-1.879,1.444,-0.935,1.452,0.010,1.459,1.901,1.475,2.846,1.483);
			var command:Vector.<int> = new Vector.<int>();
			command.push(1,6,6,6,6,6,6,6,6,6);
			
			var s:Shape = new Shape();
			s.graphics.beginFill(0x414141, 1);
			s.graphics.drawPath(command0, data0);
			s.graphics.drawPath(command, data);
			s.graphics.endFill();
			return s;
		}
		
	}
}