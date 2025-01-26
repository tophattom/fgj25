package;

typedef Zone = {
	var depth:Int;
	var depthMultiplier:Float;
	var title:String;
	var logs:Array<String>;
	var radioResponse:String;
	var allowReturn:Bool;
}

typedef ZoneLimit = {
	min:Float,
	max:Float,
}

class GameData {
	public static inline var MaxDepth = 8740;

	public static var Zones:Array<Zone> = [
		{
			depth: 0,
			depthMultiplier: 1,
			title: "I. THE EPIPELAGIC ZONE",
			logs: [
				"10/07/1991\n\nExpedition day one, no hiccups.\nWe're in luck.",
				"10/09/1991\n\nSimmons has a stick further\nup his ass than usual.\n\nOr a bigger stick.",
				"10/13/1991\n\nThe ocean is beautiful.\nIt's a damn shame we spend\nso much time collecting samples.\n\nCan't wait to go deeper.",
				"10/13/1991\n\nMy promotion to team leader\ncan't be far away.\nI know my job too well.\n\nSimmons does not."
			],
			radioResponse: "Copy\nBathysphere,\ndo you confirm\nreturn to\nsurface?\n\n(Y/N)",
			allowReturn: true
		},
		{
			depth: 200,
			depthMultiplier: 4,
			title: "II. THE MESOPELAGIC ZONE",
			logs: [
				"10/28/1991\n\nWhy is everyone tense?",
				"11/02/1991\n\nSimmons is a thorn in my side.\nI know damn well how\nto calibrate the equipment.",
				"11/13/1991\n\nI'm held back by incompetence\n and politics. The chain of command\nwon't listen.\n\nNo one listens.",
			],
			radioResponse: "Copy\nBathysphere,\ndo you confirm\nreturn to\nsurface?\n\n(Y/N)",
			allowReturn: true
		},
		{
			depth: 1000,
			depthMultiplier: 8,
			title: "III. THE BATHYPELAGIC ZONE",
			logs: [
				"11/25/1991\n\nI can't work with this\nlack of respect. Feeling my\npassion for marine geology\nfade away is torture.",
				"11/26/1991\n\nI need a day off and a drink,\nor several. 36 days to go.",
				"11/29/1991\n\nEveryone is coughing?\n\nFlu onboard?",
			],
			radioResponse: "Bathysphere,\nare you sure\nyou want to\nreturn to\nsurface?\n\n(Y/N)",
			allowReturn: true
		},
		{
			depth: 4000,
			depthMultiplier: 7,
			title: "IV. THE ABYSSOPELAGIC ZONE",
			logs: [
				"you\n    dont\n    understand\nthe\n      depths",
				"12/15/1991\n\nI couldn't stop my nosebleed\nlast night.",
				"12/17/1991\n\nAll samples from today\nare unusable.\n\nWhat are we doing?",
				"12/23/1991\n\nThe next time Simmons tries\nto pin the blame on me,\nI will snap."
			],
			radioResponse: "Bathysphere,\nare you sure\nyou want to\nreturn to\nsurface?\n\n(Y/N)",
			allowReturn: true
		},
		{
			depth: 6000,
			depthMultiplier: 7,
			title: "V. THE HADOPELAGIC ZONE",
			logs: [
				"you\n   are\n    not\n     a\n      deep\nsea       \nresearcher",
				"12/27/1991\n\nA brawl on Christmas.\nIronic.\nWe broke some very expensive\nequipment and the team doesn't\nwant to resurface to face\nthe consequences.",
				"01/13/1992\n\nThere is no food. We need to\ndeal with the repercussions.\n\nNo one listens.",
				"01/16/1992\n\nMy shoulder won't heal.",
				"01/18/1992\n\nI'm still bleeding."
			],
			radioResponse: "Negative.\nYou cannot risk\nthe investigation\nat this point.\n\nContinue\ndescent.",
			allowReturn: false
		},
		{
			depth: 8000,
			depthMultiplier: 4,
			title: "VI. THE DEMERSAL ZONE",
			logs: [
				"why\n      do\n      you\n      keep on\n            descending",
				"01/29/1992\n\nWhy haven't we starved to death?",
			],
			radioResponse: "",
			allowReturn: false
		},
		{
			depth: 8600,
			depthMultiplier: 0.5,
			title: "VII. THE BENTHIC ZONE",
			logs: [
				"02/14/1992\n\nI smashed the nav station to pieces.\n\nThey had their chance.",
				"the\n   depths\n        \nshow\n   their\nbeauty"
			],
			radioResponse: "",
			allowReturn: false
		}
	];

	public static var ZonePixelLimits = getZonePixelLimits();

	private static function getZonePixelLimits():Array<ZoneLimit> {
		var result:Array<ZoneLimit> = [];
		var startY = 0.0;
		for (i in 0...Zones.length) {
			var currentZone = Zones[i];
			var nextZone = (i + 1) < Zones.length ? Zones[i + 1] : null;
			var nextStartDepth = nextZone == null ? MaxDepth : nextZone.depth;

			var max = startY + (nextStartDepth - currentZone.depth) / currentZone.depthMultiplier;
			result.push({ min: startY, max: max });
			startY = max;
		}

		return result;
	}

	public static function getZoneIndex(depth:Float):Int {
		for (i in 0...Zones.length - 1) {
			if (depth < Zones[i + 1].depth) {
				return i;
			}
		}

		return Zones.length - 1;
	}

	public static function getZone(depth:Float):Zone {
		return Zones[getZoneIndex(depth)];
	}

	public static function getZoneIndexByY(y:Float):Int {
		for (i in 0...ZonePixelLimits.length) {
			var limits = ZonePixelLimits[i];
			if (y >= limits.min && y < limits.max) {
				return i;
			}
		}

		return -1;
	}
}
