import std.stdio;

import rpc;
import my_strategy;

import model.game, model.player_context, model.trooper, model.move;

void main(string[] args) {
    auto host = "localhost";
    auto port = "31001";
    auto token = "0000000000000000";
    if (args.length == 4) {
        host = args[0];
        port = args[1];
        token = args[2];
    }
    auto client = new RemoteProcessClient(host, port);
    client.writeToken(token);
    int teamSize = client.readTeamSize();
    client.writeProtocolVersion();
    immutable game = cast(immutable) client.readGameContext();

    auto strategies = new MyStrategy[teamSize];
    foreach (ref strategy; strategies) {
        strategy = new MyStrategy();
    }

    PlayerContext playerContext;

    while ((playerContext = client.readPlayerContext()) !is null) {
        immutable Trooper playerTrooper = playerContext.trooper;

        Move move = strategies[playerTrooper.teammateIndex].move(playerTrooper, playerContext.world, game);
        client.writeMove(move);
    }
}