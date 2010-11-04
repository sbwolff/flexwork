package com.googlecode.flexwork.core.patterns
{

	//http://elromdesign.com/blog/2008/03/15/boost-flex-performance-with-object-pooling-manager-api/
	//http://elromdesign.com/blog/2009/11/05/object-pooling-in-flex-actionsctipt/
	//http://code.google.com/p/eladlib/source/browse/trunk/EladLibFlex/src/com/elad/framework/objectpoolmanager/ReusablePool.as
	//http://www.insideria.com/2008/03/flex-performance-memory-manage.html
	import flash.utils.Dictionary;
//var obj:SomeClass = ObjectPool.getObject( SomeClass );
//ObjectPool.disposeObject( obj );

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
	 }*/
	//
	/*
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
	public class ObjectPool
	{
		private var locked:Dictionary;

		private var unlocked:Dictionary;

		public function ObjectPool()
		{
			locked=new Dictionary();
			unlocked=new Dictionary();
		}

		public function create():Object
		{
			return null;
		}

		protected function _checkOut():Object
		{
			return null;
		}

		protected function _checkIn(object:Object):void
		{
		}
	}

}