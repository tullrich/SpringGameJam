package SpringGameJam {
	
	import starling.display.MovieClip;
	
	public class Medic extends Actor {

		public function Medic() {
			
			movementSpeed = 5;
			bPlayerControlled = true;
			IdleAnimation = "MedicIdle";
			AttackAnimation = "FiremanAttack";
			WalkAnimation = "MechanicWalk";
		}
		
		
		override public function Interact(unit:Unit):void
		{
			if (unit == null)
			{
				trace("Error: Interacting with a null unit");
				return;
			}
			
			if(unit is Actor)
			{
				Heal(unit);
			}
		}
		
		override public function CanInteract(unit:Unit):Boolean
		{
			return unit is Actor && Actor(unit).bPlayerControlled && unit.currentHealth < 5;
		}
		
		public function Heal(u:Unit):void
		{
			var anim:MovieClip = new MovieClip(Assets.getTexturesFromAtlas(AttackAnimation), 4);
			anim.pivotX = anim.x = (anim.height) / 2;
			anim.pivotY = anim.y = (anim.width) / 2;
			Victim = u;
			PlayAnimation(anim, HealComplete);
			LookTowards(u._tile);
		}
		
		public function HealComplete():void
		{	
			if( Victim != null)
			{
				Victim.GainHealth(1);
				Victim =  null;
				EndTurn();
			}
			
			Game.GetInstance().ToggleCinematic(false);
		}

	}
	
}
