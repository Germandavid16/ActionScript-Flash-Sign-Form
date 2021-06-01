package form 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.utils.setTimeout;
	
	/**
	 * Модель приложения в цепочке модель-вьювер-контроллер
	 * @author ivms
	 */
	public class Head extends MovieClip 
	{
		/**
		 * Ссылка на вьювер
		 */
		public var mc:HeadMc;
		
		/**
		 * Массив дефолтных текстов в полях
		 */
		private var defTexts:Object = new Object();
		
		public function Head(mc:HeadMc) 
		{
			super();
			this.mc = mc;
			
			defTexts.login = "Логин";
			defTexts.pass1 = "Пароль";
			defTexts.pass2 = "Пароль еще раз";
			
			headInit();
		}
		
		/**
		 * Инициализация вьювера
		 */
		private function headInit():void 
		{
			mc.login.visible = false;
			mc.login.err.text = "";
			mc.reg.err.text = "";
			mc.reg.visible = false;
			mc.welcome.visible = false;
		}
		
		/**
		 * Когда кликнули в текстовое поле
		 * @param	e
		 */
		public function onFocusIn(e:FocusEvent):void 
		{
			if (e.currentTarget.text == defTexts[e.currentTarget.name]) 
			{
				//e.currentTarget.text = "";
			}
		}
		
		/**
		 * Когда текстовое поле стало не активным
		 * @param	e
		 */
		public function onFocusOut(e:FocusEvent):void 
		{
			if (e.currentTarget.text == "") 
			{
				//e.currentTarget.text = defTexts[e.currentTarget.name];
			}
		}
		
		/**
		 * Устанавливает текстовому полю дефолтный текст
		 * @param	tf
		 */
		public function setDefTexts(tf:TextField, pass:Boolean = false):void
		{
			tf.text = "";
			//штука с дефолтными текстами оказалась не нужной, везде пустое делаем
			//tf.text = defTexts[tf.name];
			tf.displayAsPassword = pass;
		}
		
		/**
		 * Ответ от проверки статуса
		 * @param	answer	Или ошибка (err) или имя юзера
		 */
		public function onCheck(answer:String):void 
		{
			if (answer == "err")
			{
				openLogin();
			}
			else
			{
				openWelcome(answer);
			}
		}
		
		/**
		 * Ответ от залогинивания
		 * @param	answer	Или ошибка или все гуд (ok)
		 */
		public function onLogin(answer:String):void 
		{
			if (answer == "ok")
			{
				openWelcome(mc.login.login.text);
			}
			else
			{
				mc.login.err.text = answer;
				mc.login.loginfon.gotoAndPlay(2);
				setTimeout(function():void {
					mc.login.err.text = "";
				}, 1000);
			}
		}
		
		/**
		 * Ответ от регистрации
		 */
		public function onRegister(answer:String):void 
		{
			if (answer == "ok")
			{
				openLogin();
			}
			else
			{
				mc.reg.err.text = answer;
				mc.reg.loginfon.gotoAndPlay(2);
				setTimeout(function():void {
					mc.reg.err.text = "";
				}, 1000);
			}
		}
		
		/**
		 * Ответ от разлогинивания
		 */
		public function onLogout(answer:String):void 
		{
			openLogin();
		}
		
		/**
		 * Показывает экран вэлком
		 */
		private function openWelcome(login:String):void 
		{
			mc.login.visible = false;
			mc.reg.visible = false;
			mc.welcome.visible = true;
			mc.welcome.login.text = login;
		}
		
		/**
		 * Показывает экран регистрации
		 */
		public function openRegistration(e:*=null):void 
		{
			mc.login.visible = false;
			setDefTexts(mc.reg.login);
			setDefTexts(mc.reg.pass1);
			setDefTexts(mc.reg.pass2);
			mc.reg.visible = true;
			mc.stage.focus = (mc.reg.login as TextField);
			mc.welcome.visible = false;
		}
		
		/**
		 * Показывает экран логина
		 */
		public function openLogin(e:*=null):void 
		{
			setDefTexts(mc.login.login);
			setDefTexts(mc.login.pass1);
			mc.login.visible = true;
			mc.stage.focus = (mc.login.login as TextField);
			mc.reg.visible = false;
			mc.welcome.visible = false;
		}
	}
}