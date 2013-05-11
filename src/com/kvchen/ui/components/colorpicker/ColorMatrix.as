package com.kvchen.ui.components.colorpicker
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class ColorMatrix extends Sprite
	{
		protected var _colors:Array;
		protected var _cellWidth:Number;
		protected var _cellHeight:Number;
		
		protected var _selectedColor:uint = 0x0;
		
		protected var _colorBoxes:Array;
		protected var _selectedColorBox:ColorBox = null;
		protected var _overedColorBox:ColorBox = null;
		
		public var delegate:ColorMatrixDelegate;
		
		public function ColorMatrix(colors:Array, cellWidth:Number = 8, cellHeight:Number = 8)
		{
			_colors = colors || getDefaultColors();
			_cellWidth = cellWidth;
			_cellHeight = cellHeight;
			init();
			initEvent();
			
			_selectedColorBox = _colorBoxes[0][0];
			_selectedColorBox.selected = true;
			addChild(_selectedColorBox);
		}
		
		protected function getDefaultColors():Array{
			
			var colors:Array = [
				[0xffffff,      0x9900ff, 0x9900cc, 0x990099, 0x990066, 0x990033, 0x990000,       0x0000ff, 0x0000cc, 0x000099, 0x000066, 0x000033, 0x000000],
				[0xeeeeee,      0x9933ff, 0x9933cc, 0x993399, 0x993366, 0x993333, 0x993300,       0x0033ff, 0x0033cc, 0x003399, 0x003366, 0x003333, 0x003300],
				[0xdddddd,      0x9966ff, 0x9966cc, 0x996699, 0x996666, 0x996633, 0x996600,       0x0066ff, 0x0066cc, 0x006699, 0x006666, 0x006633, 0x006600],
				[0xcccccc,      0x9999ff, 0x9999cc, 0x999999, 0x999966, 0x999933, 0x999900,       0x0099ff, 0x0099cc, 0x009999, 0x009966, 0x009933, 0x009900],
				[0xbbbbbb,      0x99ccff, 0x99cccc, 0x99cc99, 0x99cc66, 0x99cc33, 0x99cc00,       0x00ccff, 0x00cccc, 0x00cc99, 0x00cc66, 0x00cc33, 0x00cc00],
				[0xaaaaaa,      0x99ffff, 0x99ffcc, 0x99ff99, 0x99ff66, 0x99ff33, 0x99ff00,       0x00ffff, 0x00ffcc, 0x00ff99, 0x00ff66, 0x00ff33, 0x00ff00],

				[0x999999,      0xcc00ff, 0xcc00cc, 0xcc0099, 0xcc0066, 0xcc0033, 0xcc0000,       0x3300ff, 0x3300cc, 0x330099, 0x330066, 0x330033, 0x330000],
				[0x888888,      0xcc33ff, 0xcc33cc, 0xcc3399, 0xcc3366, 0xcc3333, 0xcc3300,       0x3333ff, 0x3333cc, 0x333399, 0x333366, 0x333333, 0x333300],
				[0x777777,      0xcc66ff, 0xcc66cc, 0xcc6699, 0xcc6666, 0xcc6633, 0xcc6600,       0x3366ff, 0x3366cc, 0x336699, 0x336666, 0x336633, 0x336600],
				[0x666666,      0xcc99ff, 0xcc99cc, 0xcc9999, 0xcc9966, 0xcc9933, 0xcc9900,       0x3399ff, 0x3399cc, 0x339999, 0x339966, 0x339933, 0x339900],
				[0x555555,      0xccccff, 0xcccccc, 0xcccc99, 0xcccc66, 0xcccc33, 0xcccc00,       0x33ccff, 0x33cccc, 0x33cc99, 0x33cc66, 0x33cc33, 0x33cc00],
				[0x444444,      0xccffff, 0xccffcc, 0xccff99, 0xccff66, 0xccff33, 0xccff00,       0x33ffff, 0x33ffcc, 0x33ff99, 0x33ff66, 0x33ff33, 0x33ff00],

				[0x333333,      0xff00ff, 0xff00cc, 0xff0099, 0xff0066, 0xff0033, 0xff0000,       0x6600ff, 0x6600cc, 0x660099, 0x660066, 0x660033, 0x660000],
				[0x222222,      0xff33ff, 0xff33cc, 0xff3399, 0xff3366, 0xff3333, 0xff3300,       0x6633ff, 0x6633cc, 0x663399, 0x663366, 0x663333, 0x663300],
				[0x111111,      0xff66ff, 0xff66cc, 0xff6699, 0xff6666, 0xff6633, 0xff6600,       0x6666ff, 0x6666cc, 0x666699, 0x666666, 0x666633, 0x666600],
				[0x000000,      0xff99ff, 0xff99cc, 0xff9999, 0xff9966, 0xff9933, 0xff9900,       0x6699ff, 0x6699cc, 0x669999, 0x669966, 0x669933, 0x669900],
				[0x000000,      0xffccff, 0xffcccc, 0xffcc99, 0xffcc66, 0xffcc33, 0xffcc00,       0x66ccff, 0x66cccc, 0x66cc99, 0x66cc66, 0x66cc33, 0x66cc00],
				[0x000000,      0xffffff, 0xffffcc, 0xffff99, 0xffff66, 0xffff33, 0xffff00,       0x66ffff, 0x66ffcc, 0x66ff99, 0x66ff66, 0x66ff33, 0x66ff00]
			];
			
			return colors;
		}
		
		public function get selectedColor():uint
		{
			return _selectedColor;
		}
		
		public function init():void{
			
			_colorBoxes = [];
			
			var x:int = -1, y:int = -1;
			var len1:int = _colors.length;
			var len2:int;
			var row:Array;
			
			
			while(++y < len1){
				row = _colors[y];
				x = -1;
				len2 = row.length;
				var colorBoxRow:Array = [];
				
				while(++x < len2){
					
					var colorBox:ColorBox = new ColorBox(row[x], _cellWidth+1, _cellHeight+1);
					colorBox.x = x * _cellWidth;
					colorBox.y = y * _cellHeight;
					addChild(colorBox);
					colorBoxRow.push(colorBox);
				}
				_colorBoxes.push(colorBoxRow);
			}
		}
		
		protected function initEvent():void{
			addEventListener(MouseEvent.MOUSE_OVER, onOverThis);
			addEventListener(MouseEvent.MOUSE_OUT, onOutThis);
			addEventListener(MouseEvent.CLICK, onClickThis);
		}
		
		protected function onOverThis(e:MouseEvent):void{
			var local:Point = this.globalToLocal(new Point(e.stageX, e.stageY));
			var box:ColorBox = getColorBoxUnderPoint(local.x, local.y);
			if(_overedColorBox != null){
				if(box == _overedColorBox){
					return;
				}
			}
			_overedColorBox = box;
			if(delegate != null){
				delegate.colorMatrixMouseOverColor(this, _overedColorBox.color);
			}
		}
		
		protected function onOutThis(e:MouseEvent):void{
			_overedColorBox = null;
			if(delegate != null){
				if(_selectedColorBox != null){
					delegate.colorMatrixMouseOverColor(this, _selectedColorBox.color);
				}
			}
		}
		
		protected function onClickThis(e:MouseEvent):void{
			var local:Point = this.globalToLocal(new Point(e.stageX, e.stageY));
			var box:ColorBox = getColorBoxUnderPoint(local.x, local.y);
			if(_selectedColorBox != null){
				if(box != _selectedColorBox){
					_selectedColorBox.selected = false;
				}
			}
			_selectedColorBox = box;
			_selectedColorBox.selected = true;
			addChild(_selectedColorBox);
			
			if(delegate != null){
				delegate.colorMatrixDidSelectColor(this, _selectedColorBox.color);
			}
		}
		
		protected function getColorBoxUnderPoint(x:Number, y:Number):ColorBox{
			var indexX:int = Math.floor(x/_cellWidth);
			var indexY:int = Math.floor(y/_cellHeight);
			indexX = (indexX >= (_colors[0].length) ? (_colors[0].length-1) : indexX);
			indexY = indexY >= _colors.length ? _colors.length-1 : indexY;
			return _colorBoxes[indexY][indexX];
		}
	}
}