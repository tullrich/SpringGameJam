package SpringGameJam {
	
	public class Fireman extends Actor
	{

		public function Fireman() 
		{
			movementSpeed = 3;
			bPlayerControlled = true;
			IdleAnimation = "FiremanIdle";
			AttackAnimation = "FiremanAttack";
			movementAnimation = "";
		}
		
		override public function Interact(interact:Tile):void
		{
			if (tile.IsOpen())
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
			if (tile.IsOpen())
			{
				return false;
			}
			
			var unit:Unit = interact.resident;
			
			return unit is Fire;
		}

	}
	
}
