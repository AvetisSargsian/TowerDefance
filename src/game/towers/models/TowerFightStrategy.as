package game.towers.models
{
	import game.enemys.models.UnitModel;

	public class TowerFightStrategy implements IFightStrategy
	{
		public function findEnemy(tower:TowerModel, enemies:Vector.<UnitModel>):UnitModel
		{
			for (var i:int = 0,len:int = enemies.length; i < len; ++i) 
			{
				if (enemies[i].isDead || enemies[i].isEscaped || !tower.isInRange(enemies[i]))
				{
					enemies.removeAt(i);
					if (enemies.length == 0)
						break;
					--i;
				}else
					return enemies[i]; 
			}
			return null;
		}
	}
}