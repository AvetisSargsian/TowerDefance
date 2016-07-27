package game.towers.models
{
	import game.enemys.models.UnitModel;

	public interface IFightStrategy
	{
		function findEnemy(tower:TowerModel, enemies:Vector.<UnitModel>):UnitModel;
	}
}