import std.stdio;

import rpc;
import my_strategy;

import model.game, model.player_context, model.trooper, model.move;

void main(string[] args) {
    auto host = "127.0.0.1";
    auto port = "31001";
    auto token = "0000000000000000";
    if (args.length == 4) {
        host = args[1];
        port = args[2];
        token = args[3];
    }
    auto client = new RemoteProcessClient(host, port);
    client.writeToken(token);
    int teamSize = client.readTeamSize();
    debug writefln("Team size: %d", teamSize);
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