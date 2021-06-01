package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import form.Action;
	import form.Head;

	/**
	 * Приложение авторизации/регистрации на основе распространенной технологии
	 * построения приложений MVC (модель/вьювер/контроллер)
	 * @author ivms
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{
		/**
		 * Модель, будет управлять вьювером
		 */
		private var head:Head;
		
		/**
		 * Контроллер, вся кухня там, он будет указывать что делать моделе, а следовательно и вьюверу
		 */
		private var action:Action;
		
		/**
		 * Вьювер приложения, собранная форма, берется из swc
		 */
		private var mc:HeadMc = new HeadMc();
		 
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			addChild(mc);
			head = new Head(mc)
			action = new Action(head);
		}

	}

}