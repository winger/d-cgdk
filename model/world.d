module model.world;

import std.algorithm;
import model.trooper, model.player, model.bonus;

enum CellType : byte {
    UNKNOWN_CELL = -1,
    FREE = 0,
    LOW_COVER = 1,
    MEDIUM_COVER = 2,
    HIGH_COVER = 3
};

class World {
    immutable int moveIndex;
    immutable int width;
    immutable int height;
    immutable Player[] players;
    immutable Trooper[] troopers;
    immutable Bonus[] bonuses;
    immutable CellType[][] cells;
    immutable bool[] cellVisibilities;

    this(int moveIndex, int width, int height, immutable Player[] players,
    	immutable Trooper[] troopers, immutable Bonus[] bonuses,
    	immutable CellType[][] cells, immutable bool[] cellVisibilities) {
		assert(cells.length == width);
		assert(all!(a => a.length == height)(cells));
    	this.moveIndex = moveIndex;
    	this.width = width;
    	this.height = height;
    	this.players = players;
    	this.troopers = troopers;
    	this.bonuses = bonuses;
    	this.cells = cells;
    	this.cellVisibilities = cellVisibilities;
	}
        
	pure bool isVisible(double maxRange,	
    	int viewerX, int viewerY, TrooperStance viewerStance,
        int objectX, int objectY, TrooperStance objectStance) immutable {
	    int minStanceIndex = min(viewerStance, objectStance);
	    int xRange = objectX - viewerX;
	    int yRange = objectY - viewerY;
	    return xRange * xRange + yRange * yRange <= maxRange * maxRange
	        && cellVisibilities[
            viewerX * height * width * height * (TrooperStance.max + 1)
                + viewerY * width * height * (TrooperStance.max + 1)
                + objectX * height * (TrooperStance.max + 1)
                + objectY * (TrooperStance.max + 1)
                + minStanceIndex
        ];
	}
};