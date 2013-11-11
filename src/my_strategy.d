import model.game, model.trooper, model.move, model.world;

class MyStrategy {
    Move move(immutable Trooper trooper, immutable World world, immutable Game game) {
        return Move.endTurn();
    }
}