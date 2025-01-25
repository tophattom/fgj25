package;

typedef Zone = {
	var depth:Int;
	var depthMultiplier:Float;
	var title:String;
	var logs:Array<String>;
	var radioResponse:String;
	var allowReturn:Bool;
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
				"10/09/1991\n\nSimmons has a stick further up his ass than usual.\n\nOr a bigger stick.",
				"10/13/1991\n\nThe ocean is beautiful. It's a damn shame we spend so much time collecting samples. Can't wait to go deeper.",
				"10/13/1991\n\nMy promotion to team leader can't be far away. I know my job too well.\n\nSimmons does not."
			],
			radioResponse: "Copy Bathysphere, do you confirm return to surface?\n\nNo: S or N\nYes: W or Y",
			allowReturn: true
		},
		{
			depth: 200,
			depthMultiplier: 3,
			title: "II. THE MESOPELAGIC ZONE",
			logs: [
				"10/28/1991\n\nWhy is everyone tense?",
				"11/02/1991\n\nSimmons is a thorn in my side. I know damn well how to calibrate the equipment.",
				"11/13/1991\n\nI'm held back by incompetence and politics. The chain of command won't listen.\n\nNo one listens.",
			],
			radioResponse: "Copy Bathysphere, do you confirm return to surface?\n\nNo: S or N\nYes: W or Y",
			allowReturn: true
		},
		{
			depth: 1000,
			depthMultiplier: 5,
			title: "III. THE BATHYPELAGIC ZONE",
			logs: [
				"11/25/1991\n\nI can't work with this lack of respect. Feeling my passion for marine geology fade away is torture.",
				"11/26/1991\n\nI need a day off and a drink, or several. 36 days to go.",
				"11/29/1991\n\nEveryone is coughing?\n\nFlu onboard?",
			],
			radioResponse: "Bathysphere, are you sure you want toreturn to surface?\n\nNo: S or N\nYes: W or Y",
			allowReturn: true
		},
		{
			depth: 4000,
			depthMultiplier: 4,
			title: "IV. THE ABYSSOPELAGIC ZONE",
			logs: [
				"you\n    dont\n    understand\nthe\n      depths",
				"12/15/1991\n\nI couldn't stop my nosebleed last night.",
				"12/17/1991\n\nAll samples from today are unusable.\n\nWhat are we doing?",
				"12/23/1991\n\nThe next time Simmons tries to pin the blame on me, I will snap."
			],
			radioResponse: "Bathysphere, are you sure you want toreturn to surface?\n\nNo: S or N\nYes: W or Y",
			allowReturn: true
		},
		{
			depth: 6000,
			depthMultiplier: 3,
			title: "V. THE HADOPELAGIC ZONE",
			logs: [
				"you\n   are\n    not\n     a\n      deep\nsea       \nresearcher",
				"12/27/1991\n\nA brawl on Christmas.\nIronic.\nWe broke some very expensive equipment and the team doesn't want to resurface to face the consequences.",
				"01/13/1992\n\nThere is no food. We need to deal with the repercussions.\n\nNo one listens.",
				"01/16/1992\n\nMy shoulder won't heal.",
				"01/18/1992\n\nI'm still bleeding."
			],
			radioResponse: "Negative.\n\nYou cannot risk the investigation at this point.\n\nContinue descent.",
			allowReturn: false
		},
		{
			depth: 8000,
			depthMultiplier: 2,
			title: "VI. THE DEMERSAL ZONE",
			logs: [
				"why\n      do\n      you\n      keep on\n            descending",
				"01/29/1992\n\nWhy haven't we starved to death?",
			],
			radioResponse: "Negative.\n\nYou cannot risk the investigation at this point.\n\nContinue descent.",
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
			radioResponse: "...",
			allowReturn: false
		}
	];
}
