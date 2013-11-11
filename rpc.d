import std.array;
import std.bitmanip;
import std.socket;
import std.algorithm;
import std.stdio;
import model.world, model.player, model.trooper, model.bonus, model.player_context, model.game, model.move;

enum MessageType : byte {
    UNKNOWN_MESSAGE,
    GAME_OVER,
    AUTHENTICATION_TOKEN,
    TEAM_SIZE,
    PROTOCOL_VERSION,
    GAME_CONTEXT,
    PLAYER_CONTEXT,
    MOVE_MESSAGE
};

class RemoteProcessClient {
public:
    this(string host, string port) {
        Address addr = getAddress(host, port)[0];
        socket = new Socket(addr.addressFamily, SocketType.STREAM);
        socket.connect(addr);
    }

    void writeToken(string token) {
        write(MessageType.AUTHENTICATION_TOKEN);
        write(token);
    }
    
    int readTeamSize() {
        assert(read!MessageType == MessageType.TEAM_SIZE);
        return read!int;
    }
    
    void writeProtocolVersion() {
        write(MessageType.PROTOCOL_VERSION);
        write!int(2);
    }
    
    Game readGameContext() {
        return read!Game;
    }
    
    PlayerContext readPlayerContext() {
        return read!PlayerContext;
    }
    
    void writeMove(Move move) {
        write(MessageType.MOVE_MESSAGE);
    
        write!bool(true);
    
        write(move.action);
        write(move.direction);
        write(move.x);
        write(move.y);
    }

    void close() {
        socket.close;
    }
private:
    Socket socket;
    
    CellType[][] cells = null;
    bool[] cellVisibilities = null;
    
    T read(T : Game)() {
        assert(read!MessageType == MessageType.GAME_CONTEXT);
        assert(read!bool);
    
        int moveCount = read!int;
        int lastPlayerEliminationScore = read!int;
        int playerEliminationScore = read!int;
        int trooperEliminationScore = read!int;
        double trooperDamageScoreFactor = read!double;
        int stanceChangeCost = read!int;
        int[TrooperStance.max + 1] moveCost = read!(int[TrooperStance.max + 1]).reverse;
        int commanderAuraBonusActionPoints = read!int;
        double commanderAuraRange = read!double;
        int commanderRequestEnemyDispositionCost = read!int;
        int commanderRequestEnemyDispositionMaxOffset = read!int;
        int fieldMedicHealCost = read!int;
        int fieldMedicHealBonusHitpoints = read!int;
        int fieldMedicHealSelfBonusHitpoints = read!int;
        double[TrooperStance.max + 1] sniperStealthBonus = read!(double[TrooperStance.max + 1]).reverse;
        double[TrooperStance.max + 1] sniperShootingRangeBonus = read!(double[TrooperStance.max + 1]).reverse;
        double scoutStealthBonusNegation = read!double;
        int grenadeThrowCost = read!int;
        double grenadeThrowRange = read!double;
        int grenadeDirectDamage = read!int;
        int grenadeCollateralDamage = read!int;
        int medikitUseCost = read!int;
        int medikitBonusHitpoints = read!int;
        int medikitHealSelfBonusHitpoints = read!int;
        int fieldRationEatCost = read!int;
        int fieldRationBonusActionPoints = read!int;
    
        return new Game(moveCount,
            lastPlayerEliminationScore, playerEliminationScore,
            trooperEliminationScore, trooperDamageScoreFactor,
            stanceChangeCost, cast(immutable) moveCost,
            commanderAuraBonusActionPoints, commanderAuraRange,
            commanderRequestEnemyDispositionCost, commanderRequestEnemyDispositionMaxOffset,
            fieldMedicHealCost, fieldMedicHealBonusHitpoints, fieldMedicHealSelfBonusHitpoints,
            cast(immutable) sniperStealthBonus,
            cast(immutable) sniperShootingRangeBonus, scoutStealthBonusNegation,
            grenadeThrowCost, grenadeThrowRange, grenadeDirectDamage, grenadeCollateralDamage,
            medikitUseCost, medikitBonusHitpoints, medikitHealSelfBonusHitpoints,
            fieldRationEatCost, fieldRationBonusActionPoints);
    }
    
    T read(T : PlayerContext)() {
        auto messageType = read!MessageType;
        if (messageType == MessageType.GAME_OVER) {
            return null;
        }
    
        assert(messageType == MessageType.PLAYER_CONTEXT);
    
        if (!read!bool) {
            return null;
        }
    
        auto trooper = read!Trooper;
        auto world = read!World;
    
        return new PlayerContext(cast(immutable) trooper, cast(immutable) world);
    }
    
    T read(T : Player)() {
        assert(read!bool);
        long id = read!long;
        string name = read!string;
        int score = read!int;
        bool strategyCrashed = read!bool;
        int approximateX = read!int;
        int approximateY = read!int;
        return new Player(id, name, score, strategyCrashed, approximateX, approximateY);
    }
    
    T read(T : Trooper)() {
        assert(read!bool);
        long id = read!long;
        int x = read!int;
        int y = read!int;
        long playerId = read!long;
        int teammateIndex = read!int;
        bool teammate = read!bool;
        TrooperType type = read!TrooperType;
        TrooperStance stance = read!TrooperStance;
        int hitpoints = read!int;
        int maximalHitpoints = read!int;
        int actionPoints = read!int;
        int initialActionPoints = read!int;
        double visionRange = read!double;
        double shootingRange = read!double;
        int shootCost = read!int;
        int[TrooperStance.max + 1] damage = read!(int[TrooperStance.max + 1]).reverse;
        int currentDamage = read!int;
        assert(currentDamage == damage[stance]);
        auto holdingBonus = read!(bool[BonusType.max + 1]);
    
        return new Trooper(id, x, y, playerId, teammateIndex, teammate, type,
            stance, hitpoints, maximalHitpoints, actionPoints, initialActionPoints,
            visionRange, shootingRange, shootCost, damage, holdingBonus); 
    }
    
    Bonus read(T : Bonus)() {
        assert(read!bool);
        long id = read!long;
        int x = read!int;
        int y = read!int;
        auto bonusType = read!BonusType;
    
        return new Bonus(id, x, y, bonusType); 
    }
    
    T read(T : World)() {
        assert(read!bool);
        int moveIndex = read!int;
        int width = read!int;
        int height = read!int;
        auto players = read!(Player[]);
        auto troopers = read!(Trooper[]);
        auto bonuses = read!(Bonus[]);
        if (cells is null) {
            cells = read!(CellType[][]);
        }
        if (cellVisibilities is null) {
            cellVisibilities = readCellVisibilities();
        }
    
        return new World(moveIndex, width, height, cast(immutable) players, cast(immutable) troopers,
            cast(immutable) bonuses, cast(immutable) cells, cast(immutable) cellVisibilities);
    }
    
    //irregular case
    bool[] readCellVisibilities() {
        int width = read!int;
        assert(width >= 0);
        int height = read!int;
        assert(height >= 0);
        int stanceCount = read!int;
        assert(stanceCount == TrooperStance.max + 1);
        auto data = readBytesRuntime(width * height * width * height * stanceCount);
        return array(map!"a != 0"(data));
    }
    
    T[c] read(T : T[c], ulong c)() {
        T ret[c] = void;
        foreach (ref val; ret) {
            val = read!T;
        }
        return ret;
    }
    
    string read(T : string)() {
        int len = read!int;
        assert(len >= 0);
        return cast(string) readBytesRuntime(len);
    }
    
    void write(T : string)(T value) {
        write(cast(int) value.length);
        writeBytes(cast(ubyte[]) value);
    }
    
    T[] read(T : T[])() {
        int len = read!int;
        assert(len >= 0);
        
        T[] ret = new T[len];
        foreach (ref elem; ret) {
            elem = read!T;
        }
        return ret;
    }
    
    void write(T : const T[])(T[] value) {
        write!int(cast(int) value.length);
        foreach (elem; value) {
            write(elem);
        }
    }
    
    T read(T)() {
        return littleEndianToNative!T(readBytes!(T.sizeof));
    }
    
    void write(T)(T value) {
        writeBytes(nativeToLittleEndian(value));
    }
    
    ubyte[byteCount] readBytes(size_t byteCount)() {
        ubyte bytes[byteCount] = readBytesRuntime(byteCount);
        return bytes;
    }
    
    ubyte[] readBytesRuntime(size_t byteCount) {
        auto bytes = new ubyte[byteCount];
        size_t offset = 0;
        while (offset < byteCount) {
            offset += socket.receive(bytes[offset .. bytes.length]);
        }
        debug writeln("read: ", bytes);
        return bytes;
    }
    
    void writeBytes(const ubyte[] bytes) {
        size_t offset = 0;
        while (offset < bytes.length) {
            auto sent = socket.send(bytes);
            assert(sent > 0);
            offset += sent;
        }
        debug writeln("write: ", bytes);
    }
}