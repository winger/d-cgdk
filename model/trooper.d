module model.trooper;

import model.unit, model.bonus;

enum TrooperType : byte {
	UNKNOWN_TROOPER = -1,
	COMMANDER = 0,
	FIELD_MEDIC = 1,
	SOLDIER = 2,
	SNIPER = 3,
	SCOUT = 4
};

enum TrooperStance : byte {
	UNKNOWN_STANCE = -1,
	PRONE = 0,
	KNEELING = 1,
	STANDING = 2
};

class Trooper : Unit {
    immutable long playerId;
    immutable int teammateIndex;
    immutable bool teammate;
    immutable TrooperType type;
    immutable TrooperStance stance;
    immutable int hitpoints;
    immutable int maximalHitpoints;
    immutable int actionPoints;
    immutable int initialActionPoints;
    immutable double visionRange;
    immutable double shootingRange;
    immutable int shootCost;
    immutable int[TrooperStance.max + 1] damage;
    immutable bool[BonusType.max + 1] holdingBonus;
    
    this(long id, int x, int y, long playerId,
        int teammateIndex, bool teammate, TrooperType type, TrooperStance stance,
        int hitpoints, int maximalHitpoints, int actionPoints, int initialActionPoints,
        double visionRange, double shootingRange, int shootCost,
        immutable int[TrooperStance.max + 1] damage, immutable bool[BonusType.max + 1] holdingBonus) {
    	super(id, x, y);
    	this.playerId = playerId;
    	this.teammateIndex = teammateIndex;
    	this.teammate = teammate;
    	this.type = type;
    	this.stance = stance;
    	this.hitpoints = hitpoints;
    	this.maximalHitpoints = maximalHitpoints;
    	this.actionPoints = actionPoints;
    	this.initialActionPoints = initialActionPoints;
    	this.visionRange = visionRange;
    	this.shootingRange = shootingRange;
    	this.shootCost = shootCost;
    	this.damage = damage;
    	this.holdingBonus = holdingBonus;
	}
};