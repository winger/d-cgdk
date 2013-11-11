module model.unit;

import std.math;

class Unit {
    immutable long id;
    immutable int x;
    immutable int y;
    
    this(long id, int x, int y) {
		this.id = id;
		this.x = x;
		this.y = y;
	}

    double getDistanceTo(int x, int y) immutable {
	    double xRange = x - this.x;
	    double yRange = y - this.y;
	    return sqrt(xRange * xRange + yRange * yRange);
	}

    double getDistanceTo(ref Unit unit) immutable {
    	return getDistanceTo(unit.x, unit.y);
	}
};