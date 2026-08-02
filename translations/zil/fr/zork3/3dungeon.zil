"DUNGEON3 pour ZORK III: Le Maître du Donjon Le Grand Empire Souterrain (Partie 3) c) Copyright 1982 Infocom, Inc. Tous droits réservés."

<DIRECTIONS NORTH EAST WEST SOUTH NE NW SE SW UP DOWN IN OUT LAND CROSS>

"SOUS-TITRE GLOBAL OBJECTS"

<OBJECT RUBBLE
	(IN LOCAL-GLOBALS)
	(SYNONYM ROCK ROCKS BOULDER RUBBLE)
	(DESC "décombres")
	(FLAGS NDESCBIT)>

<OBJECT DEBRIS
	(IN GLOBAL-OBJECTS)
	(SYNONYM DUST DEBRIS)
	(DESC "poussière et débris")
	(FLAGS NDESCBIT)>

<OBJECT CHASM
	(IN LOCAL-GLOBALS)
	(SYNONYM CHASM GORGE RAVINE)
	(ADJECTIVE ROCKY DEEP)
	(DESC "gouffre")
	(ACTION CHASM-FCN)
	(FLAGS NDESCBIT)>

<OBJECT TUNNEL
	(IN GLOBAL-OBJECTS)
	(SYNONYM PASSAGE CRAWLWAY)
        (ADJECTIVE DARK SMOKY)
	(DESC "tunnel")
	(FLAGS NDESCBIT)
	(ACTION TUNNEL-OBJECT)>

<OBJECT EAST-WALL	;"was EAST-WALL"
	(IN GLOBAL-OBJECTS)
	(SYNONYM WALL)
	(ADJECTIVE EAST EASTERN)
	(DESC "est mur")
	(FLAGS NDESCBIT)
	(ACTION RANDOM-WALL)>

<OBJECT SOUTH-WALL	;"was SOUTH-WALL"
	(IN GLOBAL-OBJECTS)
	(SYNONYM WALL)
	(ADJECTIVE SOUTH SOUTHE) ;"only 6 chars count and southeast exists"
	(DESC "mur sud")
	(FLAGS NDESCBIT)
	(ACTION RANDOM-WALL)>

<OBJECT WEST-WALL	;"was WEST-WALL"
	(IN GLOBAL-OBJECTS)
	(SYNONYM WALL)
	(ADJECTIVE WEST WESTERN)
	(DESC "mur ouest")
	(FLAGS NDESCBIT)
	(ACTION RANDOM-WALL)>

<OBJECT NORTH-WALL	;"was NORTH-WALL"
	(IN GLOBAL-OBJECTS)
	(SYNONYM WALL)
	(ADJECTIVE NORTH NORTHE)	;"only six chars used..."
	(DESC "nord mur")
	(FLAGS NDESCBIT)
	(ACTION RANDOM-WALL)>

<OBJECT GLOBAL-WATER	;"was GLOBAL-WATER"
	(IN LOCAL-GLOBALS)
	(SYNONYM WATER QUANTITY)
	(DESC "eau")
	(FLAGS DRINKBIT)
	(ACTION WATER-FCN)>

<OBJECT WATER
	(SYNONYM WATER QUANTITY LIQUID H2O)
	(DESC "quantité d'eau")
	(FLAGS TAKEBIT DRINKBIT)
	(ACTION WATER-FCN)
	(LDESC "Il y a de l'eau ici.")
	(SIZE 4)>

<OBJECT BROKEN-LAMP	;"was BLAMP"
	(SYNONYM LAMP LANTERN)
	(ADJECTIVE BROKEN BRASS)
	(DESC "lanterne brisée")
	(FLAGS TAKEBIT)
	(SIZE 15)>

<OBJECT LAMP	;"was LAMP"
	(IN CP-ANTE)
	(SYNONYM LAMP LANTERN)
	(ADJECTIVE BRASS)
	(DESC "lampe")
	(FLAGS TAKEBIT LIGHTBIT)
	(FDESC "Votre vieil ami, la lanterne en laiton, est à vos pieds.")
	(ACTION LANTERN)
	(SIZE 15)>

<OBJECT SWORD	;"was SWORD"
	(IN STONE)
	(SYNONYM SWORD ORCRIST GLAMDRING BLADE)
	(ADJECTIVE ELVISH OLD ANTIQUE)
	(DESC "épée")
	(FLAGS TAKEBIT WEAPONBIT TRYTAKEBIT)
	(ACTION SWORD-FCN)
	(SIZE 25)
	(VALUE 0)>

"SALLES/OBJETS DE PUZZLE CHINOIS"

<ROOM CP-ANTE
      (IN ROOMS)
      (DESC "Puzzle Royal Entrée")
      (WEST TO CP-OUT)
      (NORTH TO MUSEUM-ENTRANCE)
      (UP TO MUSEUM-ENTRANCE)
      (DOWN PER CPENTER)
      (FLAGS RLANDBIT ONBIT)
      (ACTION CPANT-ROOM)
      (GLOBAL STAIRS)>

<ROOM CP-OUT
      (IN ROOMS)
      (DESC "Pièce latérale")
      (NORTH TO CP-ANTE)
      (UP TO CP-ANTE)
      (EAST TO CP IF CP-FLAG ELSE "La porte en acier est fermée.")
      (FLAGS RLANDBIT ONBIT)
      (ACTION CPOUT-ROOM)
      (GLOBAL CPDOOR STAIRS)>

<ROOM CP
      (IN ROOMS)
      (DESC "Chambre dans un Puzzle")
      (NORTH PER CPEXIT)
      (SOUTH PER CPEXIT)
      (EAST PER CPEXIT)
      (WEST PER CPEXIT)
      (NE PER CPEXIT)
      (NW PER CPEXIT)
      (SE PER CPEXIT)
      (UP PER CPEXIT)
      (SW PER CPEXIT)
      (ACTION CP-ROOM)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL CPLADDER CPDOOR CPEWL CPWWL CPNWL CPSWL)>

;"SUBTITLE CHINESE PUZZLE OBJECTS"

<OBJECT WARNING-NOTE
	(IN CP-ANTE)
	(DESC "note d'avertissement")
	(SYNONYM NOTE WARNING TEXT)
	(ADJECTIVE WARNING SMALL)
	(FDESC "Une petite note se trouve sur le sol.")
	(FLAGS TAKEBIT READBIT BURNBIT)
	(SIZE 2)
	(TEXT
"Avertissement:| Le Puzzle Royal est dangereux et il est possible de se faire piéger dans ses limites. Veuillez ne pas entrer dans le puzzle après les heures où le personnel du musée n'est pas présent.| La direction")>

<OBJECT CP-SLOT
	(SYNONYM CPSLT SLIT SLOT)
	(ADJECTIVE SMALL)
	(DESC "petite fente")
	(FLAGS NDESCBIT OPENBIT)
	(ACTION CP-SLOT-FCN)
	(CAPACITY 4)>

<OBJECT CPDOOR
	(IN LOCAL-GLOBALS)
	(SYNONYM DOOR)
	(ADJECTIVE STEEL METAL)
	(DESC "porte en acier")
	(FLAGS NDESCBIT)
	(ACTION CPDOOR-F)>

<OBJECT LORE-BOOK
	(SYNONYM BOOK LORE TEXT)
	(ADJECTIVE LORE OLD STRANGE)
	(DESC "très ancienne livre")
	(FLAGS TAKEBIT READBIT)
	(LDESC
	 "Il y a un vieux livre ici.")
	(FDESC
	 "Niché à l'intérieur de la niche se trouve un livre vieux et poussiéreux.")
	(TEXT
"Le livre est écrit dans une main forte et élégante et est rempli d'images étranges et merveilleuses. Le texte, écrit dans de nombreuses couleurs, est dans une langue que vous ignorez. Les mots semblent changer de couleur en les lisant. Le livre lui-même est très vieux et les pages sont sèches et fragiles.")
	(SIZE 4)
	(ACTION LORE-BOOK-F)>

<GLOBAL CP-FLAG <>>

<OBJECT CPEWL		;"defined CPWALL"
        (IN LOCAL-GLOBALS)
	(SYNONYM WALL)
	(ADJECTIVE EAST EASTERN)
	(DESC "est mur")
	(FLAGS NDESCBIT)
	(ACTION CPWALL-OBJECT)>

<OBJECT CPWWL		;"defined CPWALL"
        (IN LOCAL-GLOBALS)
	(SYNONYM WALL)
	(ADJECTIVE WEST WESTERN)
	(DESC "mur ouest")
	(FLAGS NDESCBIT)
	(ACTION CPWALL-OBJECT)>

<OBJECT CPSWL		;"defined CPWALL"
        (IN LOCAL-GLOBALS)
	(SYNONYM WALL)
	(ADJECTIVE SOUTH)
	(DESC "mur sud")
	(FLAGS NDESCBIT)
	(ACTION CPWALL-OBJECT)>

<OBJECT CPNWL		;"defined CPWALL"
        (IN LOCAL-GLOBALS)
	(SYNONYM WALL)
	(ADJECTIVE NORTH)
	(DESC "nord mur")
	(FLAGS NDESCBIT)
	(ACTION CPWALL-OBJECT)>

<OBJECT CPLADDER		;"defined CPLADDER"
        (IN GLOBAL-OBJECTS)
	(SYNONYM LADDER)
	(DESC "échelle")
	(ACTION CPLADDER-OBJECT)>

;"Objects/rooms for old end-game"

<OBJECT INTDIR
	(IN GLOBAL-OBJECTS)
	(SYNONYM INTDIR)
	(FLAGS TOOLBIT)
	(DESC "direction")>

<OBJECT GUARDIAN
	(IN LOCAL-GLOBALS)
	(DESC "Gardiens de Zork")
	(SYNONYM STATUE GUARDIAN GUARD GUARDS)
	(FLAGS ACTORBIT)
	(ACTION GUARDIANS)>

<OBJECT ROSE
	(IN LOCAL-GLOBALS)
	(DESC "rose des vents")
	(SYNONYM ROSE)
	(ADJECTIVE COMPASS)
	(ACTION ROSE-F)>

<OBJECT MASTER
	(IN LOCAL-GLOBALS)
	(DESC "maître du donjon")
	(SYNONYM MASTER MAN)
	(ADJECTIVE DUNGEON)
	(FLAGS ACTORBIT)
	(ACTION MASTER-F)>

<OBJECT DUNGEON-MASTER
	(IN BEHIND-DOOR)
	(DESC "maître du donjon")
	(LDESC
"Le maître du donjon est tranquillement s'appuyant ici sur son bâton.")
	(SYNONYM MASTER DUNGEON MAN)
	(ADJECTIVE DUNGEON)
	(FLAGS ACTORBIT)
	(ACTION DUNGEON-MASTER-F)>

<OBJECT MIRROR
	(IN LOCAL-GLOBALS)
	(DESC "miroir")
	(SYNONYM MIRROR STRUCTURE)
	(ACTION MIRROR-FUNCTION)>

<OBJECT PANEL
	(IN LOCAL-GLOBALS)
	(DESC "panneau")
	(SYNONYM PANEL)
	(ACTION PANEL-FUNCTION)>

<OBJECT CHANNEL
	(IN LOCAL-GLOBALS)
	(DESC "pierre canal")
	(SYNONYM CHANNEL HOLE)
	(ADJECTIVE STONE)>

<ROOM MRD
      (IN ROOMS)
      (DESC "Couloir")
      (LDESC " ")
      (NORTH TO FRONT-DOOR)
      (NE TO FRONT-DOOR)
      (NW TO FRONT-DOOR)
      (SOUTH PER MRGO)
      (SE PER MRGO)
      (SW PER MRGO)
      (ACTION MRDF)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL ROSE CHANNEL GUARDIAN WOODEN-WALL)>

<ROOM MRG
      (IN ROOMS)
      (DESC "Couloir")
      (LDESC " ")
      (NORTH PER MRGO)
      (NW PER MRGO)
      (NE PER MRGO)
      (ENTER PER MIRIN)
      (SOUTH PER MRGO)
      (SW PER MRGO)
      (SE PER MRGO)
      (ACTION GUARDIANS)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL GUARDIAN)>

<ROOM MRC
      (IN ROOMS)
      (DESC "Couloir")
      (LDESC " ")
      (NORTH PER MRGO)
      (NW PER MRGO)
      (NE PER MRGO)
      (ENTER PER MIRIN)
      (SOUTH PER MRGO)
      (SW PER MRGO)
      (SE PER MRGO)
      (ACTION MRCF)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL MIRROR PANEL ROSE CHANNEL GUARDIAN WOODEN-WALL)>

<ROOM MRB
      (IN ROOMS)
      (DESC "Couloir")
      (LDESC " ")
      (NORTH PER MRGO)
      (NW PER MRGO)
      (NE PER MRGO)
      (ENTER PER MIRIN)
      (SOUTH PER MRGO)
      (SW PER MRGO)
      (SE PER MRGO)
      (ACTION MRBF)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL MIRROR PANEL ROSE CHANNEL WOODEN-WALL)>

<ROOM MRA
      (IN ROOMS)
      (DESC "Couloir")
      (LDESC " ")
      (NORTH PER MRGO)
      (NW PER MRGO)
      (NE PER MRGO)
      (ENTER PER MIRIN)
      (SOUTH TO MREYE)
      (ACTION MRAF)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL MIRROR PANEL ROSE CHANNEL WOODEN-WALL)>

<ROOM MRDE
      (IN ROOMS)
      (DESC "Pièce étroite")
      (LDESC " ")
      (ENTER PER MIRIN)
      (WEST PER MIRIN)
      (NORTH TO FRONT-DOOR)
      (SOUTH TO MRG)
      (ACTION MRDEW)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL MIRROR PANEL GUARDIAN)>

<ROOM MRDW
      (IN ROOMS)
      (DESC "Pièce étroite")
      (LDESC " ")
      (ENTER PER MIRIN)
      (WEST PER MIRIN)
      (NORTH TO FRONT-DOOR)
      (SOUTH TO MRG)
      (ACTION MRDEW)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL MIRROR PANEL GUARDIAN)>

<ROOM MRGE
      (IN ROOMS)
      (DESC "Pièce étroite")
      (LDESC " ")
      (ENTER PER MIRIN)
      (WEST PER MIRIN)
      (NORTH TO MRD)
      (SOUTH TO MRC)
      (ACTION GUARDIANS)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL MIRROR PANEL GUARDIAN)>

<ROOM MRGW
      (IN ROOMS)
      (DESC "Pièce étroite")
      (LDESC " ")
      (ENTER PER MIRIN)
      (EAST PER MIRIN)
      (NORTH TO MRD)
      (SOUTH TO MRC)
      (ACTION GUARDIANS)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL MIRROR PANEL GUARDIAN)>

<ROOM MRCE
      (IN ROOMS)
      (DESC "Pièce étroite")
      (LDESC " ")
      (ENTER PER MIRIN)
      (WEST PER MIRIN)
      (NORTH TO MRG)
      (SOUTH TO MRB)
      (ACTION MRCEW)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL MIRROR PANEL GUARDIAN)>

<ROOM MRCW
      (IN ROOMS)
      (DESC "Pièce étroite")
      (LDESC " ")
      (ENTER PER MIRIN)
      (EAST PER MIRIN)
      (NORTH TO MRG)
      (SOUTH TO MRB)
      (ACTION MRCEW)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL MIRROR PANEL GUARDIAN)>

<ROOM MRBE
      (IN ROOMS)
      (DESC "Pièce étroite")
      (LDESC " ")
      (ENTER PER MIRIN)
      (WEST PER MIRIN)
      (NORTH TO MRC)
      (SOUTH TO MRA)
      (ACTION MRBEW)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL MIRROR PANEL GUARDIAN)>

<ROOM MRBW
      (IN ROOMS)
      (DESC "Pièce étroite")
      (LDESC " ")
      (ENTER PER MIRIN)
      (EAST PER MIRIN)
      (NORTH TO MRC)
      (SOUTH TO MRA)
      (ACTION MRBEW)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL MIRROR PANEL GUARDIAN)>

<ROOM MRAE
      (IN ROOMS)
      (DESC "Pièce étroite")
      (LDESC " ")
      (ENTER PER MIRIN)
      (WEST PER MIRIN)
      (NORTH TO MRB)
      (SOUTH TO MREYE)
      (ACTION MRAEW)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL MIRROR PANEL GUARDIAN)>

<ROOM MRAW
      (IN ROOMS)
      (DESC "Pièce étroite")
      (LDESC " ")
      (ENTER PER MIRIN)
      (EAST PER MIRIN)
      (NORTH TO MRB)
      (SOUTH TO MREYE)
      (ACTION MRAEW)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL MIRROR PANEL GUARDIAN)>

<ROOM IN-MIRROR
      (IN ROOMS)
      (DESC "Intérieur Miroir")
      (LDESC " ")
      (OUT PER MIROUT)
      (NORTH PER MIROUT)
      (SOUTH PER MIROUT)
      (NW PER MIROUT)
      (NE PER MIROUT)
      (SE PER MIROUT)
      (SW PER MIROUT)
      (WEST PER MIROUT)
      (EAST PER MIROUT)
      (ACTION MAGIC-MIRROR)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL ROSE CHANNEL GUARDIAN)>

<ROOM MR-ANTE
      (IN ROOMS)
      (DESC "Salle des boutons")
      (LDESC
"Vous êtes à l'extrémité sud d'une longue salle. Au sud, les escaliers montent dans l'obscurité. Au nord le couloir est éclairé par des torches placées haut dans les murs, hors de portée. Sur un mur est un bouton rouge.")
       (SOUTH TO MSTAIRS IF SECRET-DOOR IS OPEN)
       (UP TO MSTAIRS IF SECRET-DOOR IS OPEN)
       (NORTH TO MREYE)
       (FLAGS RLANDBIT ONBIT)
       (GLOBAL SECRET-DOOR STAIRS)
       (PSEUDO "TORCHE" TORCH-PSEUDO "TORCHE" TORCH-PSEUDO)>

<ROOM MREYE
      (IN ROOMS)
      (DESC "Faisceau Salle")
      (LDESC " ")
      (NORTH PER MRGO)
      (NW PER MRGO)
      (NE PER MRGO)
      (SOUTH TO MR-ANTE)
      (ACTION MREYE-ROOM)
      (FLAGS RLANDBIT ONBIT)>

<ROOM MSTAIRS
      (IN ROOMS)
      (DESC "Salle des gravures")
      (NORTH TO MR-ANTE IF SECRET-DOOR IS OPEN ELSE "Vous ne pouvez pas aller jusque là. chemin.")
      (DOWN TO MR-ANTE IF SECRET-DOOR IS OPEN ELSE "Vous ne pouvez pas aller jusque là. chemin.")
      (SW TO DAMP-PASSAGE)
      (SE TO DEAD-END)
      (FLAGS RLANDBIT)
      (ACTION MSTAIRS-F)
      (GLOBAL SECRET-DOOR STAIRS)>

<ROOM DEAD-END
      (IN ROOMS)
      (DESC "Mort Fin")
      (LDESC
"Vous êtes arrivés au bout de deux passages adjacents à l'ouest et au nord-ouest.")
      (WEST TO DAMP-PASSAGE)
      (NW TO MSTAIRS)
      (FLAGS RLANDBIT)>

<ROOM DAMP-PASSAGE
      (IN ROOMS)
      (DESC "Passage humide")
      (LDESC
"C'est un endroit particulièrement humide même selon les normes du donjon. On peut voir la jonction à l'ouest, et deux passages similaires à l'est et au nord-est. Un large canal de pierre descend abruptement dans la pièce du sud. Il est couvert de mousse glissante et de lichen. Le canal traverse la pièce, mais l'ouverture où il a une fois continué au nord est maintenant bloqué par des décombres.")
      (WEST TO JUNCTION)
      (EAST TO DEAD-END)
      (NE TO MSTAIRS)
      (NORTH "L'ouverture est bloquée par des tonnes de débris.")
      (UP "Le canal est trop raide et la mousse aussi. glissant.")
      (SOUTH "Le canal est trop raide et la mousse aussi. glissant.")
      (FLAGS RLANDBIT)
      (GLOBAL MOSS RUBBLE WATER-CHANNEL)>

<ROOM EAST-CORRIDOR
      (IN ROOMS)
      (DESC "Couloir Est")
      (LDESC
"Il s'agit d'un hall avec des murs en marbre poli. Il s'élargit légèrement en tournant vers l'ouest à ses extrémités nord et sud.")
      (NORTH TO NORTH-CORRIDOR)
      (SOUTH TO SOUTH-CORRIDOR)
      (FLAGS RLANDBIT ONBIT)>

<ROOM WEST-CORRIDOR
      (IN ROOMS)
      (DESC "Couloir ouest")
      (LDESC
"Il s'agit d'un hall avec des murs en marbre poli. Il s'élargit légèrement en tournant vers l'est à ses extrémités nord et sud.")
      (NORTH TO NORTH-CORRIDOR)
      (SOUTH TO SOUTH-CORRIDOR)
      (FLAGS RLANDBIT ONBIT)>

<ROOM SOUTH-CORRIDOR
      (IN ROOMS)
      (DESC "Corridor sud")
      (EAST TO EAST-CORRIDOR)
      (WEST TO WEST-CORRIDOR)
      (NORTH PER BRONZE-DOOR-EXIT)
      (SOUTH TO BEHIND-DOOR)
      (ACTION SOUTH-CORRIDOR-F)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL BRONZE-DOOR)>

<ROOM BEHIND-DOOR
      (IN ROOMS)
      (DESC "Corridor étroit")
      (NORTH TO SOUTH-CORRIDOR)
      (SOUTH TO FRONT-DOOR IF DUNGEON-DOOR IS OPEN)
      (ACTION BEHIND-DOOR-F)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL DUNGEON-DOOR DUNGEON-PANEL)>

<ROOM FRONT-DOOR
      (IN ROOMS)
      (DESC "Entrée du donjon")
      (LDESC " ")
      (NORTH TO BEHIND-DOOR IF DUNGEON-DOOR IS OPEN)
      (ENTER TO BEHIND-DOOR IF DUNGEON-DOOR IS OPEN)
      (SOUTH PER MRGO)
      (SE TO MRDE)
      (SW TO MRDW)
      (ACTION FRONT-DOOR-F)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL MASTER DUNGEON-DOOR DUNGEON-PANEL WOODEN-WALL)>

<OBJECT WOODEN-WALL
	(IN LOCAL-GLOBALS)
	(DESC "mur en bois")
	(SYNONYM WALL)
	(ADJECTIVE WOOD WOODEN)
	(ACTION WOODEN-WALL-F)>

<ROOM NORTH-CORRIDOR
      (IN ROOMS)
      (DESC "Nord Couloir")
      (LDESC " ")
      (EAST TO EAST-CORRIDOR)
      (WEST TO WEST-CORRIDOR)
      (NORTH TO PARAPET)
      (SOUTH TO CELL IF CELL-DOOR IS OPEN)
      (ENTER TO CELL IF CELL-DOOR IS OPEN)
      (ACTION NORTH-CORRIDOR-F)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL MASTER CELL-DOOR PARAPET-OBJ FLAMING-PIT)>

<ROOM PARAPET
      (IN ROOMS)
      (DESC "Parapet")
      (LDESC " ")
      (SOUTH TO NORTH-CORRIDOR)
      (NORTH "Vous seriez brûlé vif en un rien de temps.")
      (ACTION PARAPET-F)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL MASTER PARAPET-OBJ FLAMING-PIT)>

<ROOM CELL
      (IN ROOMS)
      (DESC "Prison Cellule")
      (LDESC " ")
      (OUT TO NORTH-CORRIDOR IF CELL-DOOR IS OPEN)
      (NORTH TO NORTH-CORRIDOR IF CELL-DOOR IS OPEN)
      (ACTION CELL-ROOM)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL MASTER BRONZE-DOOR CELL-DOOR PARAPET-OBJ FLAMING-PIT)>

<ROOM PRISON-CELL
      (IN ROOMS)
      (DESC "Prison Cellule")
      (LDESC
"Vous êtes dans une cellule de prison nue. Sa porte en bois est solidement attachée, et vous ne pouvez voir que des flammes et de la fumée par sa petite fenêtre.")
      (OUT "La porte est solidement fermée.")
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL LOCKED-DOOR MASTER FLAMING-PIT)>

<ROOM GOOD-CELL
      (IN ROOMS)
      (DESC "Prison Cellule")
      (LDESC " ")
      (OUT TO NIRVANA IF BRONZE-DOOR IS OPEN)
      (SOUTH TO NIRVANA IF BRONZE-DOOR IS OPEN)
      (ACTION NCELL-ROOM)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL GOOD-LOCKED-DOOR MASTER BRONZE-DOOR FLAMING-PIT)>

<ROOM NIRVANA
      (IN ROOMS)
      (DESC "Trésor de Zork")
      (LDESC
"Il s'agit d'une grande pièce richement aménagée dans un style qui évoque l'exquise
goût. A en juger par son contenu, c'est l'ultime entrepôt du
richesse du Grand Empire Souterrain.|
|
Il y a des coffres contenant des bijoux précieux, des montagnes de
zorkmids, peintures rares, statuaire ancienne et curiosités séduisantes.|
|
Sur un mur se trouve une carte annotée de l'Empire, montrant l'emplacement des
divers trésors et de nombreuses vues panoramiques supérieures.|
|
Sur un bureau au fond de la pièce se trouvent des certificats d'actions
représentant une participation majoritaire dans FrobozzCo International, la
conglomérat multinational et société mère de
le Frobozz Magic Boat Co., etc.|
")
      (ACTION NIRVANA-F)
      (FLAGS RLANDBIT ONBIT)>

\

<OBJECT RUNES
	(IN MSTAIRS)
	(DESC "runes")
	(SYNONYM ENGRAV TEXT WALL RUNES)
	(ADJECTIVE CARVED)
	(FLAGS NDESCBIT READBIT)
	(ACTION RUNES-F)>

<OBJECT T-BAR
	(IN IN-MIRROR)
	(DESC "Barre en T")
	(SYNONYM T-BAR BAR)
	(FLAGS NDESCBIT)
	(ACTION T-BAR-F)>

<OBJECT BLACK-PANEL
	(IN IN-MIRROR)
	(DESC "noir panneau")
	(SYNONYM WALL PANEL)
	(ADJECTIVE BLACK)
	(FLAGS NDESCBIT)
	(ACTION MPANELS)>

<OBJECT BRONZE-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "porte en bronze")
	(SYNONYM DOOR)
	(ADJECTIVE BRONZE)
	(FLAGS CONTBIT DOORBIT INVISIBLE)
	(ACTION BRONZE-DOOR-F)>

<OBJECT CELL-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "porte de cellule")
	(SYNONYM DOOR)
	(ADJECTIVE WOOD WOODEN CELL)
	(FLAGS CONTBIT DOORBIT)
	(ACTION CELL-DOOR-F)>

<OBJECT COMPASS-ARROW
	(IN IN-MIRROR)
	(DESC "boussole flèche")
	(SYNONYM ARROW)
	(ADJECTIVE COMPASS)
	(FLAGS NDESCBIT)>

<OBJECT DIAL-BUTTON
	(IN PARAPET)
	(DESC "gros bouton")
	(SYNONYM BUTTON)
	(ADJECTIVE LARGE)
	(FLAGS NDESCBIT)
	(ACTION DIALBUTTON)>

<OBJECT GOOD-LOCKED-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "porte de cellule")
	(SYNONYM DOOR)
	(ADJECTIVE LOCKED WOOD WOODEN CELL)
	(FLAGS NDESCBIT)
	(ACTION LOCKED-DOOR-F)>

<OBJECT LOCKED-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "porte de cellule")
	(SYNONYM DOOR)
	(ADJECTIVE LOCKED WOOD WOODEN CELL)
	(FLAGS NDESCBIT)
	(ACTION LOCKED-DOOR-F)>

<OBJECT LONG-POLE
	(IN IN-MIRROR)
	(DESC "perche longue")
	(SYNONYM POLE)
	(ADJECTIVE LONG CENTER)
	(FLAGS NDESCBIT)>

<OBJECT MAHOGANY-PANEL
	(IN IN-MIRROR)
	(DESC "acajou panneau")
	(SYNONYM WALL PANEL)
	(ADJECTIVE MAHOGANY)
	(FLAGS NDESCBIT)
	(ACTION MENDS)>

<OBJECT FLAMING-PIT
	(IN LOCAL-GLOBALS)
	(DESC "fosse enflammée")
	(SYNONYM PIT ABYSS)
	(ADJECTIVE FIERY FLAMING)
	(FLAGS NDESCBIT)
	(ACTION FLAMING-PIT-F)>

<OBJECT PARAPET-OBJ
	(IN LOCAL-GLOBALS)
	(DESC "parapet")
	(SYNONYM PARAPET)
	(FLAGS NDESCBIT)
	(ACTION PARAPET-OBJ-F)>

<OBJECT PINE-PANEL
	(IN IN-MIRROR)
	(DESC "pin panneau")
	(SYNONYM PANEL WALL)
	(ADJECTIVE PINE)
	(FLAGS NDESCBIT)
	(ACTION MENDS)>

<OBJECT BEAM
	(IN MREYE)
	(DESC "faisceau de lumière rouge")
	(SYNONYM BEAM LIGHT)
	(ADJECTIVE RED)
	(FLAGS NDESCBIT OPENBIT CONTBIT)
	(CAPACITY 100)
	(ACTION BEAM-FUNCTION)>

<OBJECT RED-BUTTON
	(IN MR-ANTE)
	(DESC "bouton rouge")
	(SYNONYM BUTTON)
	(ADJECTIVE RED)
	(FLAGS NDESCBIT)
	(ACTION MRSWITCH)>

<OBJECT RED-PANEL
	(IN IN-MIRROR)
	(DESC "panneau rouge")
	(SYNONYM PANEL WALL)
	(ADJECTIVE RED)
	(FLAGS NDESCBIT)
	(ACTION MPANELS)>

<OBJECT SHORT-POLE
	(IN IN-MIRROR)
	(DESC "court pôle")
	(SYNONYM POLE POST HANDGRIP GRIP)
	(ADJECTIVE SHORT SMALL HAND)
	(FLAGS NDESCBIT)
	(ACTION SHORT-POLE-F)>

<OBJECT SUNDIAL
	(IN PARAPET)
	(DESC "cadran solaire")
	(SYNONYM DIAL INDICATOR ARROW SUNDIAL)
	(ADJECTIVE INDICATOR SUN)
	(FLAGS NDESCBIT TURNBIT)
	(ACTION DIAL)>

<OBJECT YELLOW-PANEL
	(IN IN-MIRROR)
	(DESC "panneau jaune")
	(SYNONYM PANEL WALL)
	(ADJECTIVE YELLOW)
	(FLAGS NDESCBIT)
	(ACTION MPANELS)>

<OBJECT WHITE-PANEL
	(IN IN-MIRROR)
	(DESC "blanc panneau")
	(SYNONYM PANEL WALL)
	(ADJECTIVE WHITE)
	(FLAGS NDESCBIT)
	(ACTION MPANELS)>

<OBJECT WOODEN-BAR
	(IN IN-MIRROR)
	(DESC "barre en bois")
	(SYNONYM BAR)
	(ADJECTIVE WOOD WOODEN)
	(FLAGS NDESCBIT)>

<OBJECT DUNGEON-PANEL
	(IN LOCAL-GLOBALS)
	(DESC "panneau")
	(SYNONYM PANEL)
	(FLAGS NDESCBIT)
	(ACTION DUNGEON-PANEL-F)>

<OBJECT DUNGEON-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "en bois porte")
	(SYNONYM DOOR)
	(ADJECTIVE WOOD WOODEN)
	(FLAGS NDESCBIT DOORBIT CONTBIT)
	(ACTION DUNGEON-DOOR-F)>

<OBJECT SECRET-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "porte secrète")
	(SYNONYM DOOR)
	(ADJECTIVE SECRET)
	(FLAGS DOORBIT CONTBIT INVISIBLE)
	(ACTION SECRET-DOOR-F)>

<OBJECT OLD-MAN
	(DESC "vieil homme")
	(SYNONYM MAN)
	(ADJECTIVE OLD)
	(FLAGS ACTORBIT)
	(ACTION OLD-MAN-F)
	(DESCFCN OLD-MAN-F)>

<OBJECT CP-HOLE
	(IN CP-ANTE)
	(DESC "trou")
	(SYNONYM HOLE)
	(ADJECTIVE ROUND)
	(FLAGS NDESCBIT)
	(ACTION CP-HOLE-F)>

<ROUTINE GO () 
	 ;"put interrupts on clock chain"
	 <QUEUE I-LANTERN 200>
;"clean up junk compiler can't do"
	 <SETG CURRENT-LAMP ,LAMP>
	 <PUT ,CPOBJS <* 8 21> 1>
	 <PUT ,CPOBJS <+ <* 8 21> 1> ,LORE-BOOK>
	 <PUT ,CPOBJS <* 8 32> 1>
	 <PUT ,CPOBJS <+ <* 8 32> 1> ,CP-SLOT>
 ;"set up and go"
	 <SETG LIT T>
	 <SETG WINNER ,ADVENTURER>
	 <SETG PLAYER ,WINNER>
	 <SETG MLOC ,MRB>
	 <SETG HERE ,ZORK2-STAIR>
	 <MOVE ,WINNER ,HERE>
	 ;<ENABLE <QUEUE I-CLEFT <+ 70 <RANDOM 70>>>>
	 <ENABLE <QUEUE I-VIEW-CHANGE 4>>
	 <SETG P-IT-OBJECT <>>
	 <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		<TELL
"Comme dans un rêve, vous vous voyez dévaler un immense escalier obscur. Autour de vous défilent les ombres de combats contre des adversaires féroces et de pièges diaboliques. Puis viennent d'autres images : d'imposantes statues de pierre, un lac limpide et frais, et enfin un homme âgé, pourtant étrangement jeune. Il se tourne lentement vers vous, ses longs cheveux argentés dansant dans une brise légère. \"Vous avez atteint l'épreuve finale, mon ami ! Vous avez fait preuve d'intelligence et de puissance, mais cela ne suffit pas encore ! Cherchez-moi lorsque vous vous en sentirez digne !\" Le rêve se dissipe tandis que ses derniers mots résonnent dans le vide...." CR>
		<CRLF>
		<V-VERSION>
		<CRLF>)>
	 <MOVE ,WINNER ,HERE>
	 <MOVE ,LAMP ,HERE>
	 <V-LOOK>
	 <MAIN-LOOP>
	 <AGAIN>>

<GLOBAL CLEFT-QUEUED? <>>
