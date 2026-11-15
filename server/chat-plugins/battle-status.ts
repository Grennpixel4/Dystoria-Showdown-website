const WRITE_INTERVAL = 30 * 1000;

function countActiveBattles() {
	let count = 0;
	for (const room of Rooms.rooms.values()) {
		if (room.battle && !room.battle.ended) count++;
	}
	return count;
}

function writeStatus() {
	Monitor.logPath('active-battles.txt').writeUpdate(() => `${Date.now()} ${countActiveBattles()}`);
}

const timer = setInterval(writeStatus, WRITE_INTERVAL);
process.nextTick(writeStatus);

export const destroy = () => clearInterval(timer);
