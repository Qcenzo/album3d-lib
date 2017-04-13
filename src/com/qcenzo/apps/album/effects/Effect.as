package com.qcenzo.apps.album.effects
{
	import flash.display3D.Context3D;
	import flash.display3D.VertexBuffer3D;
	import flash.geom.Matrix3D;

	public class Effect
	{
		protected var _vx:Vector.<Number>;
		protected var _nvx:int;
		protected var _modStat1:Matrix3D;
		protected var _cmrStat:Matrix3D;
		private var _vxb:VertexBuffer3D;

		public function Effect()
		{
			_vx = new Vector.<Number>();
			_modStat1 = new Matrix3D();
			initModelStat();
			_cmrStat = new Matrix3D();
			initCameraStat();
		}
		
		public function createVertexBuffer(context:Context3D, numQuads:int):void
		{
			generateMesh(numQuads);
			
			_nvx /= 4;
			_vxb = context.createVertexBuffer(_nvx, 4);
			_vxb.uploadFromVector(_vx, 0, _nvx);
		}
		
		public function get vxb():VertexBuffer3D
		{
			return _vxb;
		}
		
		public function get modelStatus1():Matrix3D
		{
			return _modStat1;
		}
		
		public function get cameraStatus():Matrix3D
		{
			return _cmrStat;
		}
		
		public function moveFunc(model:Matrix3D):void
		{
		}
		
		protected function initCameraStat():void
		{
			throw new Error("OVERRIDE");
		}
		
		protected function initModelStat():void
		{
		}
		
		protected function generateMesh(numQuads:int):void
		{
			throw new Error("OVERRIDE");
		}
	}
}