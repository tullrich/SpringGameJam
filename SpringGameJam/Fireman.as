package SpringGameJam {
	
	public class Fireman extends Actor
	{

		public function Fireman() 
		{
			movementSpeed = 3;
			IdleAnimation = "FiremanIdle";
			AttackAnimation = "FiremanAttack";
			movementAnimation = "";
		}
		
		override public function Interact(interact:Tile):void
		{
			if (tile.HasRoom())
			{
				trace("Error: Interacting with an empty tile");
				return;
			}
			
			var unit:Unit = interact.resident;
			
			if(unit is Fire)
			{
				Attack(unit);
			}
		}
		
		override public function CanInteract(interact:Tile):Boolean
		{
			if (tile.HasRoom())
			{
				return false;
			}
			
			var unit:Unit = interact.resident;
			
			return unit is Fire;
		}

	}
	
}
