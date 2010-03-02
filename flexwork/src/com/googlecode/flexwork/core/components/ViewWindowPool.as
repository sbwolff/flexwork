package com.googlecode.flexwork.core.components
{


	import flash.utils.Dictionary;


	/*
	   public abstract class ObjectPool
	   {
	   private long expirationTime;
	   private Hashtable locked, unlocked;
	   abstract Object create();
	   abstract boolean validate( Object o );
	   abstract void expire( Object o );
	   synchronized Object checkOut(){...}
	   synchronized void checkIn( Object o ){...}
	 }*/ /*
	   public abstract class ObjectPool<T> {
	   private long expirationTime;

	   private Hashtable<T, Long> locked, unlocked;

	   public ObjectPool() {
	   expirationTime = 30000; // 30 seconds
	   locked = new Hashtable<T, Long>();
	   unlocked = new Hashtable<T, Long>();
	   }

	   protected abstract T create();

	   public abstract boolean validate(T o);

	   public abstract void expire(T o);

	   public synchronized T checkOut() {
	   long now = System.currentTimeMillis();
	   T t;
	   if (unlocked.size() > 0) {
	   Enumeration<T> e = unlocked.keys();
	   while (e.hasMoreElements()) {
	   t = e.nextElement();
	   if ((now - unlocked.get(t)) > expirationTime) {
	   // object has expired
	   unlocked.remove(t);
	   expire(t);
	   t = null;
	   } else {
	   if (validate(t)) {
	   unlocked.remove(t);
	   locked.put(t, now);
	   return (t);
	   } else {
	   // object failed validation
	   unlocked.remove(t);
	   expire(t);
	   t = null;
	   }
	   }
	   }
	   }
	   // no objects available, create a new one
	   t = create();
	   locked.put(t, now);
	   return (t);
	   }

	   public synchronized void checkIn(T t) {
	   locked.remove(t);
	   unlocked.put(t, System.currentTimeMillis());
	   }
	 } */
	public class ViewWindowPool
	{
		private var locked:Dictionary;

		private var unlocked:Dictionary;

		public function ViewWindowPool()
		{
			locked=new Dictionary();
			unlocked=new Dictionary();
		}

		private function create():ViewWindow
		{
			var viewWindow:ViewWindow=new ViewWindow();
			return viewWindow;
		}

		public function checkOut():ViewWindow
		{
			return create();
		}

		public function checkIn(viewWindow:ViewWindow):void
		{
		}
	}

}