package form 
{
	import fl.controls.CheckBox;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import server.Connector;
	
	/**
	 * Контроллер в цепочке модель-вьювер-контроллер
	 * @author ivms
	 */
	public class Action 
	{
		private var head:Head;
		private var serverConnector:Connector = new Connector();
		
		public function Action(head:Head) 
		{
			this.head = head;
			addEvents();
			addValues();
			checkStatus();
		}
		
		/**
		 * Установка значений
		 */
		private function addValues():void 
		{
			(head.mc.login.login as TextField).restrict = "a-z0-9";
			(head.mc.reg.login as TextField).restrict = "a-z0-9";
			head.setDefTexts((head.mc.login.login as TextField));
			head.setDefTexts((head.mc.login.pass1 as TextField), true);
			head.setDefTexts((head.mc.reg.login as TextField));
			head.setDefTexts((head.mc.reg.pass1 as TextField), true);
			head.setDefTexts((head.mc.reg.pass2 as TextField), true);
		}
		
		/**
		 * Проверяем статус юзера, может быть он уже залогинен
		 */
		private function checkStatus():void 
		{
			serverConnector.sendCheck(head.onCheck);
		}
		
		/**
		 * Прописывает события для вьювера, задействуя модель приложения
		 */
		private function addEvents():void 
		{
			(head.mc.login.login as TextField).addEventListener(FocusEvent.FOCUS_IN, head.onFocusIn, false, 0, true);
			(head.mc.login.login as TextField).addEventListener(FocusEvent.FOCUS_OUT, head.onFocusOut, false, 0, true);
			(head.mc.login.pass1 as TextField).addEventListener(FocusEvent.FOCUS_IN, head.onFocusIn, false, 0, true);
			(head.mc.login.pass1 as TextField).addEventListener(FocusEvent.FOCUS_OUT, head.onFocusOut, false, 0, true);
			(head.mc.reg.login as TextField).addEventListener(FocusEvent.FOCUS_IN, head.onFocusIn, false, 0, true);
			(head.mc.reg.login as TextField).addEventListener(FocusEvent.FOCUS_OUT, head.onFocusOut, false, 0, true);
			(head.mc.reg.pass1 as TextField).addEventListener(FocusEvent.FOCUS_IN, head.onFocusIn, false, 0, true);
			(head.mc.reg.pass1 as TextField).addEventListener(FocusEvent.FOCUS_OUT, head.onFocusOut, false, 0, true);
			(head.mc.reg.pass2 as TextField).addEventListener(FocusEvent.FOCUS_IN, head.onFocusIn, false, 0, true);
			(head.mc.reg.pass2 as TextField).addEventListener(FocusEvent.FOCUS_OUT, head.onFocusOut, false, 0, true);
			head.mc.login.go.addEventListener(MouseEvent.CLICK, onGoLogin, false, 0, true);
			head.mc.login.go2.addEventListener(MouseEvent.CLICK, head.openRegistration, false, 0, true);
			head.mc.reg.go.addEventListener(MouseEvent.CLICK, onGoRegistration, false, 0, true);
			head.mc.reg.go2.addEventListener(MouseEvent.CLICK, head.openLogin, false, 0, true);
			head.mc.welcome.go.addEventListener(MouseEvent.CLICK, onGoLogout, false, 0, true);
		}
		
		private function onGoLogin(e:MouseEvent):void 
		{
			if (head.mc.login.login.text=="")
			{
				head.mc.login.loginfon.gotoAndPlay(2);
				return;
			}
			if (head.mc.login.pass1.text=="")
			{
				head.mc.login.pass1fon.gotoAndPlay(2);
				return;
			}
			
			var obj:Object = { };
			obj.login = head.mc.login.login.text;
			obj.password = head.mc.login.pass1.text;
			obj.not_attach_ip = !(head.mc.login.ip as CheckBox).selected;
			
			serverConnector.sendLogin(head.onLogin, obj);
		}
		
		private function onGoRegistration(e:MouseEvent):void 
		{
			if (head.mc.reg.pass1.text != head.mc.reg.pass2.text)
			{
				head.mc.reg.pass1fon.gotoAndPlay(2);
				head.mc.reg.pass2fon.gotoAndPlay(2);
				head.onRegister("Введенные пароли не совпадают");
				return;
			}
			if (head.mc.reg.login.text=="")
			{
				head.mc.reg.loginfon.gotoAndPlay(2);
				return;
			}
			if (head.mc.reg.pass1.text=="")
			{
				head.mc.reg.pass1fon.gotoAndPlay(2);
				return;
			}
			if (head.mc.reg.pass2.text=="")
			{
				head.mc.reg.pass2fon.gotoAndPlay(2);
				return;
			}
			
			var obj:Object = { };
			obj.login = head.mc.reg.login.text;
			obj.password = head.mc.reg.pass1.text;
			serverConnector.sendRegister(head.onRegister, obj);
		}
		
		private function onGoLogout(e:MouseEvent):void 
		{
			serverConnector.sendLogout(head.onLogout);
		}
		
	}

}