package com.kvchen.ui.components.panel
{
	import flash.display.Sprite;
	import flash.display.Stage;
	
	public class PromptPanel extends Panel
	{
		public var STAGE_MASK:Sprite = null;
		
		protected var _stage:Stage;

		public function PromptPanel(width:Number=300, barHeight:Number=23, bgHeight:Number=250, title:String="", stage:Stage = null)
		{
			super(width, barHeight, bgHeight, title);
			
			this.draggable = true;
			this.enableShadow = true;
			
			_stage = stage;
		}
		
		protected function createStageMask():Sprite{
			var s:Sprite = new Sprite();
			s.graphics.beginFill(0x0, 0.2);
			s.graphics.drawRect(-1500, -1000, 3000, 2000);
			s.graphics.endFill();
			return s;
		}
		
		public function show():void{
			
			if(STAGE_MASK == null){
				STAGE_MASK = createStageMask();
			}
			
			STAGE_MASK.x = this.x = int((_stage.stageWidth - width)/2);
			STAGE_MASK.y = this.y = int((_stage.stageHeight - height)/2);
			
			_stage.addChild(STAGE_MASK);
			_stage.addChild(this);
		}
		
		public function hide():void{
			if(STAGE_MASK.parent != null){
				STAGE_MASK.parent.removeChild(STAGE_MASK);
			}
			if(this.parent != null){
				this.parent.removeChild(this);
			}
		}
	}
}