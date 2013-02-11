package SpringGameJam {
	
	public class Fireman extends Actor
	{

		public function Fireman() 
		{
			movementSpeed = 3;
			bPlayerControlled = true;
			IdleAnimation = "FiremanIdle";
			AttackAnimation = "FiremanAttack";
			WalkAnimation = "FiremanWalk";
		}
		
		override public function Interact(unit:Unit):void
		{
			if (unit == null)
			{
				trace("Error: Interacting with a null unit");
				return;
			}
			
			if(unit is Fire)
			{
				power = 2;
				Attack(unit);
			}
			else
			{
				power = 1;
				Attack(unit);
			}
		}
		
		override public function CanInteract(unit:Unit):Boolean
		{
			return unit is Fire || unit is Snake;
		}
		
		override public function AttackComplete():void
		{	
			if (!(Victim is Fire))
			{
				super.AttackComplete();
				return;
			}
		
			for each(var a:Tile in Game.GetInstance()._level.GetAdjacentTiles(_tile, true))
			{
				if(!a.IsOpen() && a.bIsActive)
				{
					if(a.resident is Fire)
					{
						a.resident.TakeDamage(power);
					}
				}
			}
			
			if( Victim != null)
			{
				Victim = null;
				EndTurn();
			}
			
			Game.GetInstance().ToggleCinematic(false);
		}

	}
	
}
