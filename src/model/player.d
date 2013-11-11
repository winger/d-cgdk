module model.player;

class Player {
    immutable long id;
    immutable string name;
    immutable int score;
    immutable bool strategyCrashed;
    immutable int approximateX;
    immutable int approximateY;

    this(long id, string name, int score, bool strategyCrashed, int approximateX, int approximateY) {
		this.id = id;
		this.name = name;
		this.score = score;
		this.strategyCrashed = strategyCrashed;
		this.approximateX = approximateX;
		this.approximateY = approximateY;
	}
};