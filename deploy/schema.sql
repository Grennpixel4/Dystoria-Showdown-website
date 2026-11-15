CREATE TABLE IF NOT EXISTS replays (
	id TEXT PRIMARY KEY,
	format TEXT NOT NULL,
	players TEXT NOT NULL,
	log TEXT NOT NULL,
	inputlog TEXT,
	uploadtime BIGINT NOT NULL,
	views INTEGER NOT NULL DEFAULT 0,
	formatid TEXT NOT NULL,
	rating INTEGER,
	private SMALLINT NOT NULL DEFAULT 0,
	password TEXT
);
CREATE INDEX IF NOT EXISTS replays_recent ON replays (private, uploadtime DESC);
CREATE INDEX IF NOT EXISTS replays_format ON replays (private, formatid, uploadtime DESC);

CREATE TABLE IF NOT EXISTS replayplayers (
	playerid TEXT NOT NULL,
	formatid TEXT NOT NULL,
	id TEXT NOT NULL REFERENCES replays(id) ON DELETE CASCADE,
	rating INTEGER,
	uploadtime BIGINT NOT NULL,
	private SMALLINT NOT NULL DEFAULT 0,
	password TEXT,
	format TEXT NOT NULL,
	players TEXT NOT NULL,
	PRIMARY KEY (playerid, id)
);
CREATE INDEX IF NOT EXISTS replayplayers_player ON replayplayers (playerid, private, uploadtime DESC);
