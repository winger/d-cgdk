module model.bonus;

import model.unit;

enum BonusType : byte {
    UNKNOWN_BONUS = -1,
    GRENADE = 0,
    MEDIKIT = 1,
    FIELD_RATION = 2
};

class Bonus : Unit {
    immutable BonusType type;
    
    this(long id, int x, int y, BonusType type) {
    	super(id, x, y);
    	this.type = type;
	}
};