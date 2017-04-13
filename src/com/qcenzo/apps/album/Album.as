package com.qcenzo.apps.album
{
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DCompareMode;
	import flash.display3D.Context3DProfile;
	import flash.display3D.Context3DRenderMode;
	import flash.display3D.Context3DTriangleFace;
	import flash.events.ErrorEvent;
	import flash.events.Event;

	public class Album
	{
		private var _stage:Stage;
		private var _antia:int;
		private var _cont:Context3D;
		private var _bgv:BackgroundVideo;
		private var _atl:Atlas;

		public function Album(stage:Stage, antialias:int = 0)
		{
			_stage = stage;
			_antia = antialias;
			
			_bgv = new BackgroundVideo();
			_atl = new Atlas(stage.stageWidth, stage.stageHeight);
			
			_stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE, onCreate);
			_stage.stage3Ds[0].addEventListener(ErrorEvent.ERROR, onError);
			_stage.stage3Ds[0].requestContext3D(Context3DRenderMode.AUTO, Context3DProfile.STANDARD_CONSTRAINED);
		}
		
		public function addTexture(index:int, bitmapData:BitmapData, n:int):void
		{
			_atl.add(index, bitmapData, n);
		}
		
		public function playVideo(url:String, onComplete:Function):void
		{
			_bgv.play(url, onComplete);
		}
		
		public function prevEffect():void
		{
			_atl.effector.prev();
		}
		
		public function nextEffect():void
		{
			_atl.effector.next();
		}
		
		private function onCreate(event:Event):void
		{
			var c:Context3D = _cont;
			
			_cont = (event.target as Stage3D).context3D;
			_cont.configureBackBuffer(_stage.stageWidth, _stage.stageHeight, _antia);
			_cont.setDepthTest(true, Context3DCompareMode.ALWAYS);
			_cont.setCulling(Context3DTriangleFace.BACK);
			_cont.enableErrorChecking = true;
			
			if (c == null)
			{
				_bgv.setup(_cont);
				_atl.setup(_cont);
				
				_stage.addEventListener(Event.ENTER_FRAME, onFrames);
				_stage.addEventListener(Event.RESIZE, onResize);
			}
		}
		
		private function onFrames(event:Event):void
		{
			if (_cont == null || _cont.driverInfo == "Disposed")
				return;
			_cont.clear();
			_bgv.render();
			_atl.render();
			_cont.present();
		}
		
		private function onResize(event:Event):void
		{
			if (_cont == null || _cont.driverInfo == "Disposed")
				return;
			_cont.configureBackBuffer(_stage.stageWidth, _stage.stageHeight, _antia);
		}
		
		private function onError(event:ErrorEvent):void
		{
		}
	}
}