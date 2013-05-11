package com.kvchen.ui.components.alert
{
	import com.kvchen.ui.components.button.Button;
	import com.kvchen.ui.components.label.Label;
	import com.kvchen.ui.components.panel.PromptPanel;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextFormatAlign;
	import flash.ui.Keyboard;
	
	public class Alert extends PromptPanel
	{
		public var delegate:AlertDelegate;
		
		protected var _messageLabel:Label;
		protected var _okButton:Button;
		protected var _cancelButton:Button;
		
		public function Alert(title:String, message:String, stage:Stage, cancelLabel:String = "Cancel", okLabel:String = "OK")
		{
			super(220, 23, 90, title, stage);
			
			var container:Sprite = new Sprite();
			
			_messageLabel = new Label(message, 180, TextFormatAlign.CENTER);
			_messageLabel.x = 20;
			_messageLabel.y = 20;
			
			_cancelButton = new Button(cancelLabel, 85, false, handleClickCancelBtn);
			_cancelButton.x = _messageLabel.x;
			_cancelButton.y = _messageLabel.y + _messageLabel.height + 15;
			
			_okButton = new Button(okLabel, 85, true, handleClickOKBtn);
			_okButton.x = _cancelButton.x + _cancelButton.width + 10;
			_okButton.y = _cancelButton.y;
			
			container.addChild(_messageLabel);
			container.addChild(_okButton);
			container.addChild(_cancelButton);
			
			this.content = container;
			
			_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		public function get message():String{
			return _messageLabel.text;
		}
		
		protected function onKeyUp(e:KeyboardEvent):void{
			
			switch(e.keyCode){
				case Keyboard.ENTER:
					handleClickOKBtn(null);
					break;
			}
		}
		
		protected function handleClickOKBtn(e:MouseEvent):void{
			
			if(delegate != null){
				delegate.alertDidClickOK(this);
			}
			hide();
		}
		
		protected function handleClickCancelBtn(e:MouseEvent):void{
			
			if(delegate != null){
				delegate.alertDidClickCancel(this);
			}
			hide();
		}
		
		override public function hide():void{
			_stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			super.hide();
		}
	}
}