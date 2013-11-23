module model.move;

import std.conv;

enum ActionType : byte {
    UNKNOWN_ACTION = -1,
    END_TURN = 0,
    MOVE = 1,
    SHOOT = 2,
    RAISE_STANCE = 3,
    LOWER_STANCE = 4,
    THROW_GRENADE = 5,
    USE_MEDIKIT = 6,
    EAT_FIELD_RATION = 7,
    HEAL = 8,
    REQUEST_ENEMY_DISPOSITION = 9
};

enum Direction : byte {
    UNKNOWN_DIRECTION = -1,
    CURRENT_POINT = 0,
    NORTH = 1,
    EAST = 2,
    SOUTH = 3,
    WEST = 4
};

class Move {
    immutable ActionType action;
    immutable Direction direction;
    immutable int x;
    immutable int y;
    
    this(ActionType action, Direction direction, int x, int y) {
        this.action = action;
        this.direction = direction;
        this.x = x;
        this.y = y;
    }
    
    static Move endTurn() {
    	return new Move(ActionType.END_TURN, Direction.UNKNOWN_DIRECTION, -1, -1);
    }
    
    static Move move(Direction dir) {
    	return new Move(ActionType.MOVE, dir, -1, -1);
    }
    
    static Move shoot(int x, int y) {
    	return new Move(ActionType.SHOOT, Direction.UNKNOWN_DIRECTION, x, y);
    }
    
    static Move raiseStance() {
    	return new Move(ActionType.RAISE_STANCE, Direction.UNKNOWN_DIRECTION, -1, -1);
    }
    
    static Move lowerStance() {
    	return new Move(ActionType.LOWER_STANCE, Direction.UNKNOWN_DIRECTION, -1, -1);
    }
    
    static Move throwGrenade(int x, int y) {
    	return new Move(ActionType.THROW_GRENADE, Direction.UNKNOWN_DIRECTION, x, y);
    }
    
    static Move useMedkit(Direction dir) {
    	return new Move(ActionType.USE_MEDIKIT, dir, -1, -1);
    }
    
    static Move useMedkit(int x, int y) {
        return new Move(ActionType.USE_MEDIKIT, Direction.UNKNOWN_DIRECTION, x, y);
    }
    
    static Move eatFieldRation() {
    	return new Move(ActionType.EAT_FIELD_RATION, Direction.UNKNOWN_DIRECTION, -1, -1);
    }
    
    static Move heal(Direction dir) {
    	return new Move(ActionType.HEAL, dir, -1, -1);
    }
    
    static Move heal(int x, int y) {
        return new Move(ActionType.HEAL, Direction.UNKNOWN_DIRECTION, x, y);
    }
    
    static Move requestEnemyDisposition() {
    	return new Move(ActionType.REQUEST_ENEMY_DISPOSITION, Direction.UNKNOWN_DIRECTION, -1, -1);
    }
    
    override string toString() {
        string ret = to!string(action);
        if (direction != Direction.UNKNOWN_DIRECTION) {
            ret ~= " " ~ to!string(direction);
        }
        if (x != -1 && y != -1) {
            ret ~= " " ~ to!string(x) ~ ":" ~ to!string(y);
        }
        return ret;
    }
};