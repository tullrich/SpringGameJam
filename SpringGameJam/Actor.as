package SpringGameJam 
{
	import starling.text.textField;
	
	public class Actor extends Unit
	{
		var currentHealth:int;
		var maxHealth:int;
		var hpString:String;
		var movementSpeed:int;
		var damage:int;
		var bHasMoved:Boolean;
		var bHasAttacked:Boolean;
		
		public function Actor() 
		{
			super();
			maxHealth = 50;
			currentHealth = 50;
			hpString = "HP:" + currentHealth +"/"+ maxHealth;
			movementSpeed = 3;
			damage = 10;
			bHasMoved = false;
			bHasAttacked = false;
		}
		
		public function init(e:Event):void
		{	
			super(e);
			var _hp:textField = new textField(64,16,hpString,"Verdana",12,0x0,false);		 
			addChild(_hp);
			Starling.juggler.add(_hp);
		}
		
		public function takeDamage(d:int)
		{
			currentHealth -= d;
			if(currentHealth >= 0)
			{
				_hp.text = "HP:" + currentHealth +"/"+ maxHealth;
			}
		}

	}
	
}
