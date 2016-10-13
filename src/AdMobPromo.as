package
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import so.cuo.platform.admob.Admob;
	import so.cuo.platform.admob.AdmobEvent;
	import so.cuo.platform.admob.AdmobPosition;
	
	public class AdMobPromo
	{	
		private var admob:Admob;
		private var timer:Timer;
			
		public function AdMobPromo()
		{
			super();
				
			admob = Admob.getInstance();
			admob.setKeys("ca-app-pub-5258470592664938/1520299006");
			admob.showBanner(Admob.SMART_BANNER,AdmobPosition.BOTTOM_CENTER);
				
			admob.addEventListener(AdmobEvent.onBannerFailedReceive,onBannerFailedReceive);
			admob.addEventListener(AdmobEvent.onBannerReceive,onBannerReceive);
			admob.addEventListener(AdmobEvent.onBannerLeaveApplication,onBannerLeaveApplication);
				
			timer = new Timer(210*1000,1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,timerComplete);
				
//			bannersAdMobId = "ca-app-pub-5258470592664938/7470931003";		
		}
//		======================================================================
		protected function onBannerLeaveApplication(event:AdmobEvent):void
		{
			timer.start();
			admob.hideBanner();
		}
//		======================================================================
		protected function onBannerReceive(event:AdmobEvent):void
		{
			
		}
//		======================================================================
		protected function onBannerFailedReceive(event:AdmobEvent):void
		{
			
		}
//		======================================================================
		protected function timerComplete(event:TimerEvent):void
		{
			timer.reset();
			admob.showBanner(Admob.BANNER,AdmobPosition.BOTTOM_CENTER);
		}
	}
}