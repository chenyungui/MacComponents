package com.kvchen.ui.components.togglebutton
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class ToggleButton extends Sprite
	{
		protected var _selected:Boolean = false;
		protected var _over:Boolean = false;
		protected var _selectedSkin:DisplayObject = null;
		protected var _deselectedSkin:DisplayObject = null;

		public function ToggleButton(selectedSkin:DisplayObject, deselectedSkin:DisplayObject, selected:Boolean = false, clickHandler:Function = null)
		{
			_selectedSkin = selectedSkin;
			_deselectedSkin = deselectedSkin;
			_selected = selected;
			if(clickHandler != null){
				addEventListener(MouseEvent.CLICK, clickHandler);
			}
			updateState(_selected);
			buttonMode = true;
			useHandCursor = true;
			initEvent();
		}
		
		public function set selected(s:Boolean):void
		{
			_selected = s;
			updateState(_selected);
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}

		
		protected function updateState(selected:Boolean):void{
			
			this.removeChildren();
			switch(selected){
				case true:
					this.addChild(_selectedSkin);
					break;
				case false:
					this.addChild(_deselectedSkin);
					break;
			}
		}
		
		protected function initEvent():void{
			addEventListener(MouseEvent.MOUSE_DOWN, onPressThis);
			addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
		}
		
		protected function onMouseOver(event:MouseEvent):void
		{
			_over = true;
			addEventListener(MouseEvent.ROLL_OUT, onMouseOut);
		}

		protected function onMouseOut(event:MouseEvent):void
		{
			_over = false;
			removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
		}
		
		protected function onPressThis(e:MouseEvent):void{
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
		}
		
		protected function onMouseGoUp(event:MouseEvent):void
		{
			if(_over){
				_selected = !_selected;
				updateState(_selected);
			}
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
		}
	}
}