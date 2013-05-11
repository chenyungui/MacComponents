package com.kvchen.ui.components.list
{
	import com.kvchen.ui.components.label.Label;
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.fillstyle.data.SolidFillData;
	import com.kvchen.ui.shape.RoundRect;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class ListCell extends Sprite
	{
		protected var _data:Object;
		protected var _selected:Boolean = false;
		protected var _inited:Boolean = false;
		
		protected var _normalBg:RoundRect;
		protected var _selectedBg:RoundRect;
		protected var _label:Label;
		
		protected var _width:Number;
		protected var _height:Number = 22;
		
		public function ListCell()
		{
			
		}
		
		public function setCellAttributes(width:Number, data:Object, selected:Boolean):void{
			if(_inited){
				_data = data;
				_selected = selected;
				this.width = width;
				this._label.text = getLabelText();
				updateCell(_selected);
			}else{
				init(width, data, selected);
			}
		}
		
		protected function init(width:Number, data:Object, selected:Boolean):void
		{
			_width = width;
			_data = data;
			_selected = selected;

			var normalBgFill:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(new SolidFillData(0xffffff));
			_normalBg = new RoundRect(_width, _height, 0, 0, 0, 0, null, normalBgFill);

			var selectedBgFill:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(new SolidFillData(0x3c3c3c));
			_selectedBg = new RoundRect(_width, _height, 0, 0, 0, 0, null, selectedBgFill);
			
			_label = new Label(getLabelText(), _width, TextFormatAlign.LEFT, 0x00);
			
			updateCell(_selected);
			
			_inited = true;
		}
		
		protected function updateCell(selected:Boolean):void{
			
			this.removeChildren();
			if(selected){
				this.addChild(_selectedBg);
				_label.textColor = 0xffffff;
			}else{
				this.addChild(_normalBg);
				_label.textColor = 0x3c3c3c;
			}
			
			this.addChild(_label);
		}
		
		protected function getLabelText():String
		{
			if(data != null){
				if(data is String){
					return String(data);
				}else if(data.hasOwnProperty("name")){
					return data["name"];
				}else if(data.hasOwnProperty("label")){
					return data["label"];
				}else if(data.hasOwnProperty("data")){
					var d:Object = data["data"];
					return d.toString();
				}else{
					return data.toString();
				}
			}else{
				return "";
			}
		}
				
		override public function get width():Number
		{
			return _width;
		}
		override public function get height():Number
		{
			return _height;
		}
		
		override public function set width(value:Number):void
		{
			_width = value;
			_normalBg.width = value;
			_selectedBg.width = value;
			_label.textWidth = value;
		}
		
		override public function set height(value:Number):void
		{
			_height = value;
			_normalBg.height = value;
			_selectedBg.height = value;
			_label.y = int((_height-_label.height)/2);
		}
		
		public function set data(value:Object):void
		{
			_data = value;
			updateCell(_selected);
		}
		
		public function get data():Object
		{
			return _data;
		}
		
		public function set selected(value:Boolean):void{
			if(_selected != value){
				_selected = value;
				updateCell(_selected);
			}
		}
		
		public function get selected():Boolean{
			return _selected;
		}
		
		public function get label():String{
			return _label.text;
		}
	}
}