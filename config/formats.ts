	export const Formats: import('../sim/dex-formats').FormatList = [

		{
			section: "Dystoria",
		},
{
    name: "[Gen 9] [ND] Dystoria OU",
	mod: 'gen9',
	ruleset: ['Standard NatDex', 'Terastal Clause'],
	banlist: [
		'ND Uber', 'ND AG', 'Arena Trap', 'Moody', 'Power Construct', 'Shadow Tag', 'King\'s Rock',
		'Quick Claw', 'Razor Fang', 'Assist', 'Baton Pass', 'Last Respects', 'Shed Tail', 'Hitmonchan-Dystorian', 'Skelaymore',
	],
	unbanlist: [
		// Pokemon Legends: Z-A Megas that are legal in Dystoria, with their Mega Stones.
		// Add or remove a pair to change which of them are legal (the forme and its stone go together).
		// Deliberately left out: Heatran, Darkrai, Magearna, Zeraora, Tatsugiri, Zygarde.
		'Raichu-Mega-X', 'Raichunite X',
		'Raichu-Mega-Y', 'Raichunite Y',
		'Clefable-Mega', 'Clefablite',
		'Victreebel-Mega', 'Victreebelite',
		'Starmie-Mega', 'Starminite',
		'Dragonite-Mega', 'Dragoninite',
		'Meganium-Mega', 'Meganiumite',
		'Feraligatr-Mega', 'Feraligite',
		'Skarmory-Mega', 'Skarmorite',
		'Chimecho-Mega', 'Chimechite',
		'Absol-Mega-Z', 'Absolite Z',
		'Staraptor-Mega', 'Staraptite',
		'Garchomp-Mega-Z', 'Garchompite Z',
		'Lucario-Mega-Z', 'Lucarionite Z',
		'Dusknoir-Mega', 'Dusknoite',
		'Froslass-Mega', 'Froslassite',
		'Emboar-Mega', 'Emboarite',
		'Excadrill-Mega', 'Excadrite',
		'Scolipede-Mega', 'Scolipite',
		'Scrafty-Mega', 'Scraftinite',
		'Eelektross-Mega', 'Eelektrossite',
		'Chandelure-Mega', 'Chandelurite',
		'Golurk-Mega', 'Golurkite',
		'Chesnaught-Mega', 'Chesnaughtite',
		'Delphox-Mega', 'Delphoxite',
		'Greninja-Mega', 'Greninjite',
		'Pyroar-Mega', 'Pyroarite',
		'Floette-Mega', 'Floettite',
		// Meowsticite is one stone for both formes, so it is only listed once
		'Meowstic-M-Mega', 'Meowsticite',
		'Meowstic-F-Mega',
		'Malamar-Mega', 'Malamarite',
		'Barbaracle-Mega', 'Barbaracite',
		'Dragalge-Mega', 'Dragalgite',
		'Hawlucha-Mega', 'Hawluchanite',
		'Crabominable-Mega', 'Crabominite',
		'Golisopod-Mega', 'Golisopite',
		'Drampa-Mega', 'Drampanite',
		'Falinks-Mega', 'Falinksite',
		'Scovillain-Mega', 'Scovillainite',
		'Glimmora-Mega', 'Glimmoranite',
	],
},
{
	name: "[Gen 8] National Dex",
	mod: 'gen8',
	ruleset: ['Standard NatDex', 'Dynamax Clause'],
	banlist: ['ND Uber', 'ND AG', 'Arena Trap', 'Moody', 'Power Construct', 'Shadow Tag', 'King\'s Rock', 'Razor Fang', 'Quick Claw', 'Baton Pass'],
},
{
	// Nothing is banned: any Pokemon, any ability, any item, any move, any level, any EVs.
	// `debug: true` is what does it - the team validator skips every ban and every
	// legality check in a debug format, so there is no banlist to keep in sync.
	name: "[Gen 9] Dystoria Custom Game",
	mod: 'gen9',
	debug: true,
	// challenge-only: no ladder search, no tournaments
	searchShow: false,
	tournamentShow: false,
	rated: false,
	// debug skips every ban, but these two limits are still enforced by the engine itself
	ruleset: ['Team Preview', 'HP Percentage Mod', 'Cancel Mod', 'Max Level = 99999', 'Max Move Count = 24'],
},
];
