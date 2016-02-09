if(isServer) exitWith {};

waitUntil {!isNull player && player == player};
if(player diarySubjectExists "rules")exitwith{};

player createDiarySubject ["serverrules","Règles générales"];

player createDiarySubject ["controls","Controls"];

/*  Example
	player createDiaryRecord ["", //Container
		[
			"", //Subsection
				"
				TEXT HERE<br/><br/>
				"
		]
	];
*/

		player createDiaryRecord ["serverrules",
		[
			"Règles générales", 
				"
           <br/> Merci de vous rendre sur le forum http://stark-gaming.com/Forum<br/><br/>

				"
		]
	];				
	
// Controls Section

	player createDiaryRecord ["controls",
		[
			"Commandes",
				"
				Y: Ouvrir le menu principal<br/>
				U: Verrouiller/déverouiller cars<br/>
				F: Sirène de police<br/>
				T: Coffre du véhicule<br/>
				Shift + R: Menotter<br/>
				Shift + G: Assomer (Civ seulement, permet de voler de l'argent)<br/>
				Windows: Touche d'action principale, utile pour récolter, intéragir avec des véhicules (réparer etc...). Vous pouvez changer cette touche dans ESC->Configurer->Commandes->Personnalisée-> Action 10<br/>
				Shift + L: Gyrophares<br/>
				Shift + H: Ranger son arme<br/>
				Shift + V: Mains sur la tête<br/>
				"
		]
	];