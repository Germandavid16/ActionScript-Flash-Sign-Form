package server 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	/**
	 * Координатор связи с сервером, составляющая контроллера
	 * @author ivms
	 */
	public class Connector 
	{
		//private
		private var serverURL:String = "http://ivms-flash.ru/tmp/form/";
		//private const
		private static const checkStatusQuery:String 	= "check.php";
		private static const loginQuery:String 			= "login.php";
		private static const logoutQuery:String 		= "logout.php";
		private static const registerQuery:String 		= "register.php";
		private var onComplete:Function;
		//
		
		
		public function Connector() 
		{
			
		}
		
		/**
		 * Запрос проверки
		 * @param	complFunc
		 */
		public function sendCheck(complFunc:Function = null):void
		{
			sendRequest(checkStatusQuery, complFunc);
		}
		
		/**
		 * Залогинивание
		 * @param	complFunc
		 */
		public function sendLogin(complFunc:Function = null, obj:Object = null):void 
		{
			sendRequest(loginQuery, complFunc, obj);
		}
		
		/**
		 * Регистрация
		 * @param	complFunc
		 */
		public function sendRegister(complFunc:Function = null, obj:Object = null):void 
		{
			sendRequest(registerQuery, complFunc, obj);
		}
		
		/**
		 * Разлогинивание
		 * @param	complFunc
		 */
		public function sendLogout(complFunc:Function = null):void 
		{
			sendRequest(logoutQuery, complFunc);
		}
		
		/**
		 * Отправная точка всех запросов
		 * @param	query		куда запрос в нашем случае это ссылка на php-файл
		 * @param	onComplete	куда возвратить результат
		 */
		private function sendRequest(query:String, onComplete:Function = null, params:Object = null ):void
		{
			this.onComplete = onComplete;
			var url:String = serverURL + query;
			var url_request:URLRequest = new URLRequest(url);
			if (params)
			{
				var vars:URLVariables = new URLVariables();
				for (var key:String in params) {
					if (params[key] != null) {
						vars[key] = params[key];
					}
				}
			}
			url_request.method = URLRequestMethod.POST;
			url_request.data = vars;
			var ldr:URLLoader = new URLLoader(url_request); 
			ldr.addEventListener(Event.COMPLETE, onCompleteQuery, false, 0, true);
		}
		
		/**
		 * Результат запроса
		 * @param	e
		 */
		private function onCompleteQuery(e:Event):void 
		{
			(e.currentTarget as URLLoader).removeEventListener(Event.COMPLETE, onCompleteQuery);
			trace(e.target.data);
			if (onComplete != null)
			{
				onComplete(e.target.data);
				onComplete = null;
			}
		}
		
	}

}