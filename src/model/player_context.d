module model.player_context;

import model.world, model.trooper;

class PlayerContext {
    immutable Trooper trooper;
    immutable World world;

    this(immutable Trooper trooper, immutable World world) {
    	this.trooper = trooper;
    	this.world = world;
    }
};