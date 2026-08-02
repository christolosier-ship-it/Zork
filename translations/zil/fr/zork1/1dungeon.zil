"1DUNGEON pour Zork I: Le Grand Empire Souterrain (c) Copyright 1983 Infocom, Inc. Tous droits réservés."

<DIRECTIONS NORTH EAST WEST SOUTH NE NW SE SW UP DOWN IN OUT LAND>

<GLOBAL SCORE-MAX 350>

<GLOBAL FALSE-FLAG <>>

"OBJETS DE SOUS-TITRE"

<OBJECT BOARD
	(IN LOCAL-GLOBALS)
	(SYNONYM BOARDS BOARD)
	(DESC "planche")
	(FLAGS NDESCBIT)
	(ACTION BOARD-F)>

<OBJECT TEETH
	(IN GLOBAL-OBJECTS)
	(SYNONYM OVERBOARD TEETH)
	(DESC "dents")
	(FLAGS NDESCBIT)
	(ACTION TEETH-F)>

<OBJECT WALL
	(IN GLOBAL-OBJECTS)
	(SYNONYM WALL WALLS)
	(ADJECTIVE SURROUNDING)
	(DESC "mur d'enceinte")>

<OBJECT GRANITE-WALL
	(IN GLOBAL-OBJECTS)
	(SYNONYM WALL)
	(ADJECTIVE GRANITE)
	(DESC "mur de granit")
	(ACTION GRANITE-WALL-F)>

<OBJECT SONGBIRD
	(IN LOCAL-GLOBALS)
	(SYNONYM BIRD SONGBIRD)
	(ADJECTIVE SONG)
	(DESC "oiseau chanteur")
	(FLAGS NDESCBIT)
	(ACTION SONGBIRD-F)>

<OBJECT WHITE-HOUSE	
	(IN LOCAL-GLOBALS)
	(SYNONYM HOUSE)
	(ADJECTIVE WHITE BEAUTI COLONI)
	(DESC "maison blanche")
	(FLAGS NDESCBIT)
	(ACTION WHITE-HOUSE-F)>

<OBJECT FOREST
	(IN LOCAL-GLOBALS)
	(SYNONYM FOREST TREES PINES HEMLOCKS)
	(DESC "forêt")
	(FLAGS NDESCBIT)
	(ACTION FOREST-F)>

<OBJECT TREE
	(IN LOCAL-GLOBALS)
	(SYNONYM TREE BRANCH)
	(ADJECTIVE LARGE STORM ;"-TOSSED")
	(DESC "arbre")
	(FLAGS NDESCBIT CLIMBBIT)>

<OBJECT MOUNTAIN-RANGE
	(IN MOUNTAINS)
	(DESC "chaîne de montagnes")
	(SYNONYM MOUNTAIN RANGE)
	(ADJECTIVE IMPASSABLE FLATHEAD)
	(FLAGS NDESCBIT CLIMBBIT)
	(ACTION MOUNTAIN-RANGE-F)>

<OBJECT GLOBAL-WATER
	(IN LOCAL-GLOBALS)
	(SYNONYM WATER QUANTITY)
	(DESC "eau")
	(FLAGS DRINKBIT)
	(ACTION WATER-F)>

<OBJECT WATER
	(IN BOTTLE)
	(SYNONYM WATER QUANTITY LIQUID H2O)
	(DESC "eau")
	(FLAGS TRYTAKEBIT TAKEBIT DRINKBIT)
	(ACTION WATER-F)
	(SIZE 4)>

<OBJECT	KITCHEN-WINDOW
	(IN LOCAL-GLOBALS)
	(SYNONYM WINDOW)
	(ADJECTIVE KITCHEN SMALL)
	(DESC "fenêtre de la cuisine")
	(FLAGS DOORBIT NDESCBIT)
	(ACTION KITCHEN-WINDOW-F)>

<OBJECT CHIMNEY
	(IN LOCAL-GLOBALS)
	(SYNONYM CHIMNEY)
	(ADJECTIVE DARK NARROW)
	(DESC "cheminée")
	(ACTION CHIMNEY-F)
	(FLAGS CLIMBBIT NDESCBIT)>

<OBJECT GHOSTS
	(IN ENTRANCE-TO-HADES)
	(SYNONYM GHOSTS SPIRITS FIENDS FORCE)
	(ADJECTIVE INVISIBLE EVIL)
	(DESC "groupe de fantômes")
	(FLAGS ACTORBIT NDESCBIT)
	(ACTION GHOSTS-F)>

<OBJECT SKULL
	(IN LAND-OF-LIVING-DEAD)
	(SYNONYM SKULL HEAD TREASURE)
	(ADJECTIVE CRYSTAL)
	(DESC "crâne de cristal")
	(FDESC
"Dans un coin de la pièce repose un crâne de cristal magnifiquement sculpté. Son rictus semble vous être destiné, et il n'a rien d'amical.")
	(FLAGS TAKEBIT)
	(VALUE 10)
	(TVALUE 10)>

<OBJECT LOWERED-BASKET
	(IN LOWER-SHAFT)
	(SYNONYM CAGE DUMBWAITER BASKET)
	(ADJECTIVE LOWERED)
	(LDESC "Un panier est suspendu à la chaîne.")
	(DESC "panier")
	(FLAGS TRYTAKEBIT)
	(ACTION BASKET-F)>

<OBJECT RAISED-BASKET
	(IN SHAFT-ROOM)
	(SYNONYM CAGE DUMBWAITER BASKET)
	(DESC "panier")
	(FLAGS TRANSBIT TRYTAKEBIT CONTBIT OPENBIT)
	(ACTION BASKET-F)
	(LDESC "Au bout de la chaîne est un panier.")
	(CAPACITY 50)>

<OBJECT LUNCH
	(IN SANDWICH-BAG)
	(SYNONYM FOOD SANDWICH LUNCH DINNER)
	(ADJECTIVE HOT PEPPER)
	(DESC "déjeuner")
	(FLAGS TAKEBIT FOODBIT)
	(LDESC "Un sandwich aux piments forts est ici.")>

<OBJECT BAT
	(IN BAT-ROOM)
	(SYNONYM BAT VAMPIRE)
	(ADJECTIVE VAMPIRE DERANGED)
	(DESC "chauve-souris")
	(FLAGS ACTORBIT TRYTAKEBIT)
	(DESCFCN BAT-D)
	(ACTION BAT-F)>

<OBJECT BELL
	(IN NORTH-TEMPLE)
	(SYNONYM BELL)
	(ADJECTIVE SMALL BRASS)
	(DESC "cloche en laiton")
	(FLAGS TAKEBIT)
	(ACTION BELL-F)>

<OBJECT HOT-BELL
	(SYNONYM BELL)
	(ADJECTIVE BRASS HOT RED SMALL)
	(DESC "cloche en laiton chauffée au rouge")
	(FLAGS TRYTAKEBIT)
	(ACTION HOT-BELL-F)
	(LDESC "Au sol se trouve une cloche rougeoyante.")>

<OBJECT AXE
	(IN TROLL)
	(SYNONYM AXE AX)
	(ADJECTIVE BLOODY)
	(DESC "hache ensanglantée")
	(FLAGS WEAPONBIT TRYTAKEBIT TAKEBIT NDESCBIT)
	(ACTION AXE-F)
	(SIZE 25)>

<OBJECT BOLT
	(IN DAM-ROOM)
	(SYNONYM BOLT NUT)
	(ADJECTIVE METAL LARGE)
	(DESC "boulon")
	(FLAGS NDESCBIT TURNBIT TRYTAKEBIT)
	(ACTION BOLT-F)>

<OBJECT BUBBLE
	(IN DAM-ROOM)
	(SYNONYM BUBBLE)
	(ADJECTIVE SMALL GREEN PLASTIC)
	(DESC "bulle verte")
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION BUBBLE-F)>

<OBJECT ALTAR
	(IN SOUTH-TEMPLE)
	(SYNONYM ALTAR)
	(DESC "autel")
	(FLAGS NDESCBIT SURFACEBIT CONTBIT OPENBIT)
	(CAPACITY 50)>

<OBJECT BOOK
	(IN ALTAR)
	(SYNONYM BOOK PRAYER PAGE BOOKS)
	(ADJECTIVE LARGE BLACK)
	(DESC "livre noir")
	(FLAGS READBIT TAKEBIT CONTBIT BURNBIT TURNBIT)
	(ACTION BLACK-BOOK)
	(FDESC "Sur l'autel se trouve un grand livre noir, ouvert à la page 569.")
	(SIZE 10)
	(TEXT
"Commandement no 12592| |Ô vous qui saluez chacun d'un « Bonjour, marin ! » :|Mesurez-vous l'immensité de votre péché devant les dieux ?|Oui, en vérité, vous serez broyé entre deux pierres.|Les dieux courroucés jetteront-ils votre corps dans le tourbillon ?|À coup sûr, un bâton pointu vous crèvera l'oeil !|Jusqu'aux confins de la terre vous errerez, et|Au Royaume des Morts, enfin, vous serez envoyé.|Alors, à coup sûr, vous regretterez votre malice." )>

<OBJECT BROKEN-LAMP
	(SYNONYM LAMP LANTERN)
	(ADJECTIVE BROKEN)
	(DESC "lanterne brisée")
	(FLAGS TAKEBIT)>

<OBJECT SCEPTRE
	(IN COFFIN)
	(SYNONYM SCEPTRE SCEPTER TREASURE)
	(ADJECTIVE SHARP EGYPTIAN ANCIENT ENAMELED)
	(DESC "sceptre")
	(FLAGS TAKEBIT WEAPONBIT)
	(ACTION SCEPTRE-FUNCTION)
	(LDESC
"Sceptre orné, effilé vers une pointe acérée se trouve ici.")
	(FDESC
"Un sceptre, peut-être originaire de l'Égypte antique elle-même, repose dans le cercueil. Orné d'émaux colorés, il s'effile jusqu'à former une pointe acérée.")
	(SIZE 3)
	(VALUE 4)
	(TVALUE 6)>

<OBJECT TIMBERS
	(IN TIMBER-ROOM)
	(SYNONYM TIMBERS PILE)
	(ADJECTIVE WOODEN BROKEN)
	(DESC "poutre brisée")
	(FLAGS TAKEBIT)
	(SIZE 50)>

<OBJECT	SLIDE
	(IN LOCAL-GLOBALS)
	(SYNONYM CHUTE RAMP SLIDE)
	(ADJECTIVE STEEP METAL TWISTING)
	(DESC "conduit")
	(FLAGS CLIMBBIT)
	(ACTION SLIDE-FUNCTION)>

<OBJECT KITCHEN-TABLE
	(IN KITCHEN)
	(SYNONYM TABLE)
	(ADJECTIVE KITCHEN)
	(DESC "table de la cuisine")
	(FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT)
	(CAPACITY 50)>

<OBJECT ATTIC-TABLE
	(IN ATTIC)
	(SYNONYM TABLE)
	(DESC "table")
	(FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT)
	(CAPACITY 40)>

<OBJECT SANDWICH-BAG
	(IN KITCHEN-TABLE)
	(SYNONYM BAG SACK)
	(ADJECTIVE BROWN ELONGATED SMELLY)
	(DESC "sac brun")
	(FLAGS TAKEBIT CONTBIT BURNBIT)
	(FDESC
"Sur la table repose un long sac brun qui sent le piment.")
	(CAPACITY 9)
	(SIZE 9)
	(ACTION SANDWICH-BAG-FCN)>

<OBJECT TOOL-CHEST
	(IN MAINTENANCE-ROOM)
	(SYNONYM CHEST CHESTS GROUP TOOLCHESTS)
	(ADJECTIVE TOOL)
	(DESC "coffres à outils")
	(FLAGS CONTBIT OPENBIT TRYTAKEBIT SACREDBIT)
	(ACTION TOOL-CHEST-FCN)>

<OBJECT YELLOW-BUTTON
	(IN MAINTENANCE-ROOM)
	(SYNONYM BUTTON SWITCH)
	(ADJECTIVE YELLOW)
	(DESC "bouton jaune")
	(FLAGS NDESCBIT)
	(ACTION BUTTON-F)>

<OBJECT BROWN-BUTTON
	(IN MAINTENANCE-ROOM)
	(SYNONYM BUTTON SWITCH)
	(ADJECTIVE BROWN)
	(DESC "bouton brun")
	(FLAGS NDESCBIT)
	(ACTION BUTTON-F)>

<OBJECT RED-BUTTON
	(IN MAINTENANCE-ROOM)
	(SYNONYM BUTTON SWITCH)
	(ADJECTIVE RED)
	(DESC "bouton rouge")
	(FLAGS NDESCBIT)
	(ACTION BUTTON-F)>

<OBJECT BLUE-BUTTON
	(IN MAINTENANCE-ROOM)
	(SYNONYM BUTTON SWITCH)
	(ADJECTIVE BLUE)
	(DESC "bouton bleu")
	(FLAGS NDESCBIT)
	(ACTION BUTTON-F)>

<OBJECT TROPHY-CASE	;"first obj so L.R. desc looks right."
	(IN LIVING-ROOM)
	(SYNONYM CASE)
	(ADJECTIVE TROPHY)
	(DESC "vitrine à trophées")
	(FLAGS TRANSBIT CONTBIT NDESCBIT TRYTAKEBIT SEARCHBIT)
	(ACTION TROPHY-CASE-FCN)
	(CAPACITY 10000)>

<OBJECT RUG
	(IN LIVING-ROOM)
	(SYNONYM RUG CARPET)
	(ADJECTIVE LARGE ORIENTAL)
	(DESC "tapis")
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION RUG-FCN)>

<OBJECT CHALICE
	(IN TREASURE-ROOM)
	(SYNONYM CHALICE CUP SILVER TREASURE)
	(ADJECTIVE SILVER ENGRAVINGS) ;"engravings exists..."
	(DESC "calice")
	(FLAGS TAKEBIT TRYTAKEBIT CONTBIT)
	(ACTION CHALICE-FCN)
	(LDESC "Il y a un calice en argent, finement gravé, ici.")
	(CAPACITY 5)
	(SIZE 10)
	(VALUE 10)
	(TVALUE 5)>

<OBJECT GARLIC
	(IN SANDWICH-BAG)
	(SYNONYM GARLIC CLOVE)
	(DESC "gousse d'ail")
	(FLAGS TAKEBIT FOODBIT)
	(ACTION GARLIC-F)
	(SIZE 4)>

<OBJECT TRIDENT
	(IN ATLANTIS-ROOM)
	(SYNONYM TRIDENT FORK TREASURE)
	(ADJECTIVE POSEIDON OWN CRYSTAL)
	(DESC "trident de cristal")
	(FLAGS TAKEBIT)
	(FDESC "Sur le rivage se trouve le propre cristal de Poséidon trident.")
	(SIZE 20)
	(VALUE 4)
	(TVALUE 11)>

<OBJECT CYCLOPS
	(IN CYCLOPS-ROOM)
	(SYNONYM CYCLOPS MONSTER EYE)
	(ADJECTIVE HUNGRY GIANT)
	(DESC "cyclope")
	(FLAGS ACTORBIT NDESCBIT TRYTAKEBIT)
	(ACTION CYCLOPS-FCN)
	(STRENGTH 10000)>

<OBJECT DAM
	(IN DAM-ROOM)
	(SYNONYM DAM GATE GATES FCD\#3)
	(DESC "barrage")
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION DAM-FUNCTION)>

<OBJECT TRAP-DOOR
	(IN LIVING-ROOM)
	(SYNONYM DOOR TRAPDOOR TRAP-DOOR COVER)
	(ADJECTIVE TRAP DUSTY)
	(DESC "trappe")
	(FLAGS DOORBIT NDESCBIT INVISIBLE)
	(ACTION TRAP-DOOR-FCN)>

<OBJECT BOARDED-WINDOW
	(IN LOCAL-GLOBALS)
        (SYNONYM WINDOW)
	(ADJECTIVE BOARDED)
	(DESC "fenêtre condamnée")
	(FLAGS NDESCBIT)
	(ACTION BOARDED-WINDOW-FCN)>

<OBJECT FRONT-DOOR
	(IN WEST-OF-HOUSE)
	(SYNONYM DOOR)
	(ADJECTIVE FRONT BOARDED)
	(DESC "porte")
	(FLAGS DOORBIT NDESCBIT)
	(ACTION FRONT-DOOR-FCN)>

<OBJECT BARROW-DOOR	
	(IN STONE-BARROW)
	(SYNONYM DOOR)
	(ADJECTIVE HUGE STONE)
	(DESC "porte de pierre")
	(FLAGS DOORBIT NDESCBIT OPENBIT)
	(ACTION BARROW-DOOR-FCN)>

<OBJECT BARROW
	(IN STONE-BARROW)
	(SYNONYM BARROW TOMB)
	(ADJECTIVE MASSIVE STONE)
	(DESC "tumulus de pierre")
	(FLAGS NDESCBIT)
	(ACTION BARROW-FCN)>

<OBJECT BOTTLE
	(IN KITCHEN-TABLE)
	(SYNONYM BOTTLE CONTAINER)
	(ADJECTIVE CLEAR GLASS)
	(DESC "bouteille en verre")
	(FLAGS TAKEBIT TRANSBIT CONTBIT)
	(ACTION BOTTLE-FUNCTION)
	(FDESC "Une bouteille est posée sur la table.")
	(CAPACITY 4)>

<OBJECT CRACK
	(IN LOCAL-GLOBALS)
	(SYNONYM CRACK)
	(ADJECTIVE NARROW)
	(DESC "fissure")
	(FLAGS NDESCBIT)
	(ACTION CRACK-FCN)>

<OBJECT COFFIN
	(IN EGYPT-ROOM)
	(SYNONYM COFFIN CASKET TREASURE)
	(ADJECTIVE SOLID GOLD)
	(DESC "cercueil d'or")
	(FLAGS TAKEBIT CONTBIT SACREDBIT SEARCHBIT)
	(LDESC
"Le cercueil en or massif utilisé pour l'enterrement de Ramsès II est ici.")
	(CAPACITY 35)
	(SIZE 55)
	(VALUE 10)
	(TVALUE 15)>

<OBJECT GRATE
	(IN LOCAL-GLOBALS)
	(SYNONYM GRATE GRATING)
	(DESC "grille")
	(FLAGS DOORBIT NDESCBIT INVISIBLE)
	(ACTION GRATE-FUNCTION)>

<OBJECT PUMP
	(IN RESERVOIR-NORTH)
	(SYNONYM PUMP AIR-PUMP TOOL TOOLS)
	(ADJECTIVE SMALL HAND-HELD)
	(DESC "pompe à air portative")
	(FLAGS TAKEBIT TOOLBIT)>

<OBJECT DIAMOND
	(SYNONYM DIAMOND TREASURE)
	(ADJECTIVE HUGE ENORMOUS)
	(DESC "énorme diamant")
	(FLAGS TAKEBIT)
	(LDESC "Il y a ici un énorme diamant (parfaitement taillé).")
	(VALUE 10)
	(TVALUE 10)>

<OBJECT JADE
	(IN BAT-ROOM)
	(SYNONYM FIGURINE TREASURE)
	(ADJECTIVE EXQUISITE JADE)
	(DESC "figurine de jade")
	(FLAGS TAKEBIT)
	(LDESC "Il y a une figurine de jade exquise ici.")
	(SIZE 10)
	(VALUE 5)
	(TVALUE 5)>

<OBJECT KNIFE
	(IN ATTIC-TABLE)
	(SYNONYM KNIVES KNIFE BLADE)
	(ADJECTIVE NASTY UNRUSTY)
	(DESC "couteau menaçant")
	(FLAGS TAKEBIT WEAPONBIT TRYTAKEBIT)
	(FDESC "Sur une table se trouve un méchant couteau.")
	(ACTION KNIFE-F)>

<OBJECT BONES
	(IN MAZE-5)
	(SYNONYM BONES SKELETON BODY)
	(DESC "squelette")
	(FLAGS TRYTAKEBIT NDESCBIT)
	(ACTION SKELETON)>

<OBJECT BURNED-OUT-LANTERN
	(IN MAZE-5)
	(SYNONYM LANTERN LAMP)
	(ADJECTIVE RUSTY BURNED DEAD USELESS)
	(DESC "lanterne hors d'usage")
	(FLAGS TAKEBIT)
	(FDESC "La lanterne inutile de l'aventurier décédé est ici.")
	(SIZE 20)>

<OBJECT BAG-OF-COINS
	(IN MAZE-5)
	(SYNONYM BAG COINS TREASURE)
	(ADJECTIVE OLD LEATHER)
	(DESC "sac de cuir rempli de pièces")
	(FLAGS TAKEBIT)
	(LDESC "Un vieux sac en cuir, bombé de pièces de monnaie, se trouve ici.")
	(ACTION BAG-OF-COINS-F)
	(SIZE 15)
	(VALUE 10)
	(TVALUE 5)>

<OBJECT LAMP
	(IN LIVING-ROOM)
	(SYNONYM LAMP LANTERN LIGHT)
	(ADJECTIVE BRASS)
	(DESC "lanterne en laiton")
	(FLAGS TAKEBIT LIGHTBIT)
	(ACTION LANTERN)
	(FDESC "Une lanterne en laiton alimentée par des piles est posée sur la vitrine à trophées.")
	(LDESC "Il y a ici une lanterne en laiton (alimentée par batterie).")
	(SIZE 15)>

<OBJECT EMERALD
	(IN BUOY)
	(SYNONYM EMERALD TREASURE)
	(ADJECTIVE LARGE)
	(DESC "grande émeraude")
	(FLAGS TAKEBIT)
	(VALUE 5)
	(TVALUE 10)>

<OBJECT ADVERTISEMENT
	(IN MAILBOX)
	(SYNONYM ADVERTISEMENT LEAFLET BOOKLET MAIL)
	(ADJECTIVE SMALL)
	(DESC "dépliant")
	(FLAGS READBIT TAKEBIT BURNBIT)
	(LDESC "Un petit dépliant est posé au sol.")
	(TEXT
"\"BIENVENUE DANS ZORK !|
|
ZORK est un jeu d'aventure, de danger et de ruse. Vous y explorerez certains des territoires les plus étonnants jamais contemplés par des mortels. Aucun ordinateur ne devrait s'en passer !\"")
	(SIZE 2)>

<OBJECT LEAK
	(IN MAINTENANCE-ROOM)
	(SYNONYM LEAK DRIP PIPE)
	(DESC "fuite")
	(FLAGS NDESCBIT INVISIBLE)
	(ACTION LEAK-FUNCTION)>

<OBJECT MACHINE
	(IN MACHINE-ROOM)
	(SYNONYM MACHINE PDP10 DRYER LID)
	(DESC "machine")
	(FLAGS CONTBIT NDESCBIT TRYTAKEBIT)
	(ACTION MACHINE-F)
	(CAPACITY 50)>

<OBJECT INFLATED-BOAT
	(SYNONYM BOAT RAFT)
	(ADJECTIVE INFLAT MAGIC PLASTIC SEAWORTHY)
	(DESC "bateau magique")
	(FLAGS TAKEBIT BURNBIT VEHBIT OPENBIT SEARCHBIT)
	(ACTION RBOAT-FUNCTION)
	(CAPACITY 100)
	(SIZE 20)
	(VTYPE NONLANDBIT)>

<OBJECT MAILBOX
	(IN WEST-OF-HOUSE)
	(SYNONYM MAILBOX BOX)
	(ADJECTIVE SMALL)
	(DESC "petite boîte aux lettres")
	(FLAGS CONTBIT TRYTAKEBIT)
	(CAPACITY 10)
	(ACTION MAILBOX-F)>

<OBJECT MATCH
	(IN DAM-LOBBY)
	(SYNONYM MATCH MATCHES MATCHBOOK)
	(ADJECTIVE MATCH)
	(DESC "carnet d'allumettes")
	(FLAGS READBIT TAKEBIT)
	(ACTION MATCH-FUNCTION)
	(LDESC
"Une boîte d'allumettes dont la couverture indique \"Visitez le magnifique FCD no 3\" se trouve ici.")
	(SIZE 2)
	(TEXT
"|
(Refermez le couvercle avant de gratter l'allumette)|
|
VOUS aussi, gagnez BEAUCOUP D'ARGENT dans le domaine passionnant de la PAPERASSERIE !|
|
M. Anderson, de Muddle (Massachusetts), témoigne : \"Avant cette formation, je n'étais qu'un humble tripatouilleur de bits. Grâce à ce que j'ai appris à GUE Tech, je me sens désormais important et je peux embrouiller les choses comme les meilleurs.\"|
|
Le docteur Blank déclare : \"Il y a dix jours à peine, je n'avais pour seul avenir qu'un emploi sans perspective comme médecin. À présent, mon avenir est prometteur et je gagne énormément de zorkmids.\"|
|
GUE Tech ne peut garantir à tous des résultats aussi fabuleux. Mais avec un diplôme de GUE Tech, votre avenir sera plus radieux." )>

<OBJECT MIRROR-2
	(IN MIRROR-ROOM-2)
	(SYNONYM REFLECTION MIRROR ENORMOUS)
	(DESC "miroir")
	(FLAGS TRYTAKEBIT NDESCBIT)
	(ACTION MIRROR-MIRROR)>

<OBJECT MIRROR-1
	(IN MIRROR-ROOM-1)
	(SYNONYM REFLECTION MIRROR ENORMOUS)
	(DESC "miroir")
	(FLAGS TRYTAKEBIT NDESCBIT)
	(ACTION MIRROR-MIRROR)>

<OBJECT PAINTING
	(IN GALLERY)
	(SYNONYM PAINTING ART CANVAS TREASURE)
	(ADJECTIVE BEAUTI)
	(DESC "tableau")
	(FLAGS TAKEBIT BURNBIT)
	(ACTION PAINTING-FCN)
	(FDESC
"Heureusement, il vous reste une occasion de jouer les vandales : sur le mur du fond est accroché un tableau d'une beauté sans égale.")
	(LDESC "Un tableau d'un génie négligé se trouve ici.")
	(SIZE 15)
	(VALUE 4)
	(TVALUE 6)>

<OBJECT CANDLES
	(IN SOUTH-TEMPLE)
	(SYNONYM CANDLES PAIR)
	(ADJECTIVE BURNING)
	(DESC "paire de bougies")
	(FLAGS TAKEBIT FLAMEBIT ONBIT LIGHTBIT)
	(ACTION CANDLES-FCN)
	(FDESC "Sur les deux des bougies brûlent aux extrémités de l'autel.")
	(SIZE 10)>

<OBJECT GUNK
	(SYNONYM GUNK PIECE SLAG)
	(ADJECTIVE SMALL VITREOUS)
	(DESC "petit morceau de scorie vitrifiée")
	(FLAGS TAKEBIT TRYTAKEBIT)
	(ACTION GUNK-FUNCTION)
	(SIZE 10)>

<OBJECT BODIES
	(IN LOCAL-GLOBALS)
	(SYNONYM BODIES BODY REMAINS PILE)
	(ADJECTIVE MANGLED)
	(DESC "amas de cadavres")
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION BODY-FUNCTION)>

<OBJECT LEAVES
	(IN GRATING-CLEARING)
	(SYNONYM LEAVES LEAF PILE)
	(DESC "tas de feuilles")
	(FLAGS TAKEBIT BURNBIT TRYTAKEBIT)
	(ACTION LEAF-PILE)
	(LDESC "Au sol se trouve un tas de feuilles.")
	(SIZE 25)>

<OBJECT PUNCTURED-BOAT
	(SYNONYM BOAT PILE PLASTIC)
	(ADJECTIVE PLASTIC PUNCTURE LARGE)
	(DESC "bateau crevé")
	(FLAGS TAKEBIT BURNBIT)
	(ACTION DBOAT-FUNCTION)
	(SIZE 20)>

<OBJECT INFLATABLE-BOAT
	(IN DAM-BASE)
	(SYNONYM BOAT PILE PLASTIC VALVE)
	(ADJECTIVE PLASTIC INFLAT)
	(DESC "tas de plastique")
	(FLAGS TAKEBIT BURNBIT)
	(ACTION IBOAT-FUNCTION)
	(LDESC
"Il y a ici une pile de plastique pliée qui a une petite valve attachée.")
	(SIZE 20)>

<OBJECT BAR
	(IN LOUD-ROOM)
	(SYNONYM BAR PLATINUM TREASURE)
	(ADJECTIVE PLATINUM LARGE)
	(DESC "lingot de platine")
	(FLAGS TAKEBIT SACREDBIT)
	(LDESC "Au sol se trouve une grande barre de platine.")
	(SIZE 20)
	(VALUE 10)
	(TVALUE 5)>

<OBJECT POT-OF-GOLD
	(IN END-OF-RAINBOW)
	(SYNONYM POT GOLD TREASURE)
	(ADJECTIVE GOLD)
	(DESC "pot d'or")
	(FLAGS TAKEBIT INVISIBLE)
	(FDESC "Au bout de l'arc-en-ciel se trouve un pot d'or.")
	(SIZE 15)
	(VALUE 10)
	(TVALUE 10)>

<OBJECT PRAYER
	(IN NORTH-TEMPLE)
	(SYNONYM PRAYER INSCRIPTION)
	(ADJECTIVE ANCIENT OLD)
	(DESC "prière")
	(FLAGS READBIT SACREDBIT NDESCBIT)
	(TEXT
"La prière est gravée dans une écriture ancienne, rarement employée de nos jours. Elle semble être une violente diatribe contre les petits insectes, les étourderies et la manie de ramasser puis de laisser tomber de menus objets. Le dernier vers voue les intrus au Royaume des Morts. Tout porte à croire que les croyances des anciens Zorkiens étaient pour le moins obscures." )>

<OBJECT RAILING
	(IN DOME-ROOM)
	(SYNONYM RAILING RAIL)
	(ADJECTIVE WOODEN)
	(DESC "balustrade en bois")
	(FLAGS NDESCBIT)>

<OBJECT RAINBOW
	(IN LOCAL-GLOBALS)
	(SYNONYM RAINBOW)
	(DESC "arc-en-ciel")
	(FLAGS NDESCBIT CLIMBBIT)
	(ACTION RAINBOW-FCN)>

<OBJECT RIVER
	(IN LOCAL-GLOBALS)
	(DESC "rivière")
	(SYNONYM RIVER)
	(ADJECTIVE FRIGID)
	(ACTION RIVER-FUNCTION)
	(FLAGS NDESCBIT)>

<OBJECT BUOY
	(IN RIVER-4)
	(SYNONYM BUOY)
	(ADJECTIVE RED)
	(DESC "bouée rouge")
	(FLAGS TAKEBIT CONTBIT)
	(FDESC "Il y a une bouée rouge ici (probablement un avertissement).")
	(CAPACITY 20)
	(SIZE 10)
	(ACTION TREASURE-INSIDE)>

<ROUTINE TREASURE-INSIDE ()
	 <COND (<VERB? OPEN>
		<SCORE-OBJ ,EMERALD>
		<RFALSE>)>>
<OBJECT ROPE
	(IN ATTIC)
	(SYNONYM ROPE HEMP COIL)
	(ADJECTIVE LARGE)
	(DESC "corde")
	(FLAGS TAKEBIT SACREDBIT TRYTAKEBIT)
	(ACTION ROPE-FUNCTION)
	(FDESC "Une grande bobine de corde repose dans le coin.")
	(SIZE 10)>

<OBJECT RUSTY-KNIFE
	(IN MAZE-5)
	(SYNONYM KNIVES KNIFE)
	(ADJECTIVE RUSTY)
	(DESC "couteau rouillé")
	(FLAGS TAKEBIT TRYTAKEBIT WEAPONBIT TOOLBIT)
	(ACTION RUSTY-KNIFE-FCN)
	(FDESC "À côté du squelette se trouve un couteau.")
	(SIZE 20)>

<OBJECT SAND
	(IN SANDY-CAVE)
	(SYNONYM SAND)
	(DESC "sable")
	(FLAGS NDESCBIT)
	(ACTION SAND-FUNCTION)>

<OBJECT BRACELET
	(IN GAS-ROOM)
	(SYNONYM BRACELET JEWEL SAPPHIRE TREASURE)
	(ADJECTIVE SAPPHIRE)
	(DESC "bracelet serti de saphirs")
	(FLAGS TAKEBIT)
	(SIZE 10)
	(VALUE 5)
	(TVALUE 5)>

<OBJECT SCREWDRIVER
	(IN MAINTENANCE-ROOM)
	(SYNONYM SCREWDRIVER TOOL TOOLS DRIVER)
	(ADJECTIVE SCREW)
	(DESC "tournevis")
	(FLAGS TAKEBIT TOOLBIT)>

<OBJECT KEYS
	(IN MAZE-5)
	(SYNONYM KEY)
	(ADJECTIVE SKELETON)
	(DESC "passe-partout")
	(FLAGS TAKEBIT TOOLBIT)
	(SIZE 10)>

<OBJECT SHOVEL
	(IN SANDY-BEACH)
	(SYNONYM SHOVEL TOOL TOOLS)
	(DESC "pelle")
	(FLAGS TAKEBIT TOOLBIT)
	(SIZE 15)>

<OBJECT COAL
	(IN DEAD-END-5)
	(SYNONYM COAL PILE HEAP)
	(ADJECTIVE SMALL)
	(DESC "petit tas de charbon")
	(FLAGS TAKEBIT BURNBIT)
	(SIZE 20)>

<OBJECT LADDER
	(IN LOCAL-GLOBALS)
	(SYNONYM LADDER)
	(ADJECTIVE WOODEN RICKETY NARROW)
	(DESC "échelle en bois")
	(FLAGS NDESCBIT CLIMBBIT)>

<OBJECT SCARAB
	(IN SANDY-CAVE)
	(SYNONYM SCARAB BUG BEETLE TREASURE)
	(ADJECTIVE BEAUTI CARVED JEWELED)
	(DESC "magnifique scarabée orné de joyaux")
	(FLAGS TAKEBIT INVISIBLE)
	(SIZE 8)
	(VALUE 5)
	(TVALUE 5)>

<OBJECT LARGE-BAG
	(IN THIEF)
	(SYNONYM BAG)
	(ADJECTIVE LARGE THIEFS)
	(DESC "grand sac")
	(ACTION LARGE-BAG-F)
	(FLAGS TRYTAKEBIT NDESCBIT)>  

<OBJECT STILETTO
	(IN THIEF)
	(SYNONYM STILETTO)
	(ADJECTIVE VICIOUS)
	(DESC "stylet")
	(ACTION STILETTO-FUNCTION)
	(FLAGS WEAPONBIT TRYTAKEBIT TAKEBIT NDESCBIT)
	(SIZE 10)>

<OBJECT MACHINE-SWITCH
	(IN MACHINE-ROOM)
	(SYNONYM SWITCH)
	(DESC "interrupteur")
	(FLAGS NDESCBIT TURNBIT)
	(ACTION MSWITCH-FUNCTION)>

<OBJECT WOODEN-DOOR
	(IN LIVING-ROOM)
	(SYNONYM DOOR LETTERING WRITING)
	(ADJECTIVE WOODEN GOTHIC STRANGE WEST)
	(DESC "porte en bois")
	(FLAGS READBIT DOORBIT NDESCBIT TRANSBIT)
	(ACTION FRONT-DOOR-FCN)
	(TEXT
"Les gravures se traduisent par \"Cet espace intentionnellement laissé vide.\"")>

<OBJECT SWORD
	(IN LIVING-ROOM)
	(SYNONYM SWORD ORCRIST GLAMDRING BLADE)
	(ADJECTIVE ELVISH OLD ANTIQUE)
	(DESC "épée")
	(FLAGS TAKEBIT WEAPONBIT TRYTAKEBIT)
	(ACTION SWORD-FCN)
	(FDESC
"Une très ancienne épée elfique est suspendue au-dessus de la vitrine à trophées.")
	(SIZE 30)
	(TVALUE 0)>

<OBJECT MAP
	(IN TROPHY-CASE)
	(SYNONYM PARCHMENT MAP)
	(ADJECTIVE ANTIQUE OLD ANCIENT)
	(DESC "carte ancienne")
	(FLAGS INVISIBLE READBIT TAKEBIT)
	(FDESC
"Dans l'écrin du trophée se trouve un parchemin ancien qui semble être une carte.")
	(SIZE 2)
	(TEXT
"La carte représente une forêt percée de trois clairières. La plus grande abrite une maison, d'où partent trois sentiers. Celui qui mène au sud-ouest porte la mention « Vers le tumulus de pierre ».")>

<OBJECT BOAT-LABEL
	(IN INFLATED-BOAT)
	(SYNONYM LABEL FINEPRINT PRINT)
	(ADJECTIVE TAN FINE)
	(DESC "étiquette beige")
	(FLAGS READBIT TAKEBIT BURNBIT)
	(SIZE 2)
	(TEXT
" !!!! COMPAGNIE DES BATEAUX MAGIQUES FROBOZZ !!!!|
|
Bonjour, marin !|
|
Mode d'emploi :|
|
   Pour mettre le bateau à l'eau, tapez \"METTRE LE BATEAU À L'EAU\".|
   Pour rejoindre la rive, tapez \"ACCOSTER\" ou indiquez la direction dans laquelle vous souhaitez manoeuvrer le bateau.|
|
Garantie :|
|
  Ce bateau est garanti contre tout défaut pendant 76 millisecondes à compter de la date d'achat, ou jusqu'à sa première utilisation si celle-ci survient avant.|
|
Avertissement :|
   Ce bateau est fabriqué en plastique mince.|
   Bonne chance !" )>

<OBJECT THIEF
	(IN ROUND-ROOM)
	(SYNONYM THIEF ROBBER MAN PERSON)
	(ADJECTIVE SHADY SUSPICIOUS SEEDY)
	(DESC "voleur")
	(FLAGS ACTORBIT INVISIBLE CONTBIT OPENBIT TRYTAKEBIT)
	(ACTION ROBBER-FUNCTION)
	(LDESC
"Un individu a l'air louche, un grand sac à la main, est adossé au mur. Il est armé d'un stylet mortel.")
	(STRENGTH 5)>

<OBJECT PEDESTAL
	(IN TORCH-ROOM)
	(SYNONYM PEDESTAL)
	(ADJECTIVE WHITE MARBLE)
	(DESC "piédestal")
	(FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT)
	(ACTION DUMB-CONTAINER)
	(CAPACITY 30)>

<OBJECT TORCH
	(IN PEDESTAL)
	(SYNONYM TORCH IVORY TREASURE)
	(ADJECTIVE FLAMING IVORY)
	(DESC "torche")
	(FLAGS TAKEBIT FLAMEBIT ONBIT LIGHTBIT)
	(ACTION TORCH-OBJECT)
	(FDESC "Assis sur le piédestal se trouve une flamme enflammée. torche, en ivoire.")
	(SIZE 20)
	(VALUE 14)
	(TVALUE 6)>

<OBJECT GUIDE
	(IN DAM-LOBBY)
	(SYNONYM GUIDE BOOK BOOKS GUIDEBOOKS)
	(ADJECTIVE TOUR GUIDE)
	(DESC "guide touristique")
	(FLAGS READBIT TAKEBIT BURNBIT)
	(FDESC
"Certains guides intitulés \"Flood Control Dam #3\" sont sur la réception.")
	(TEXT
"\"	Barrage de régulation des crues no 3| |Le BRC no 3 fut construit en l'an 783 du Grand Empire Souterrain afin de dompter la puissante Rivière Glaciale. Les travaux bénéficièrent d'une subvention de 37 millions de zorkmids accordée par votre tyran local omnipotent, le seigneur Nigaud Tête-Plate l'Excessif. Cet impressionnant ouvrage est composé de 370 000 pieds cubes de béton ; il mesure 256 pieds de haut en son centre et 193 pieds de large à son sommet. Le lac formé derrière le barrage contient 1,7 milliard de pieds cubes d'eau, couvre 12 millions de pieds carrés et possède 36 000 pieds de rivage.| |La construction du BRC no 3, du premier coup de pioche à l'inauguration, dura 112 jours. Elle mobilisa 384 esclaves, 34 contremaîtres d'esclaves, 12 ingénieurs, deux tourterelles et une perdrix dans un poirier. Les travaux furent dirigés par une équipe de commandement réunissant 2 345 bureaucrates, 2 347 secrétaires -- dont au moins deux savaient taper à la machine --, 12 256 brasseurs de paperasse, 52 469 préposés aux tampons, 245 193 spécialistes des tracasseries administratives et près d'un million d'arbres morts.| |Nous allons maintenant attirer votre attention sur quelques-uns des aspects les plus intéressants du BRC no 3 au cours de cette visite guidée :| |        1) Votre visite commence ici, dans le hall du barrage. Vous remarquerez sur votre droite que..." )>

<OBJECT TROLL
	(IN TROLL-ROOM)
	(SYNONYM TROLL)
	(ADJECTIVE NASTY)
	(DESC "troll")
	(FLAGS ACTORBIT OPENBIT TRYTAKEBIT)
	(ACTION TROLL-FCN)
	(LDESC
"Un sale troll, brandissant une hache, bloque tous les passages de la pièce.")
	(STRENGTH 2)>

<OBJECT TRUNK
	(IN RESERVOIR)
	(SYNONYM TRUNK CHEST JEWELS TREASURE)
	(ADJECTIVE OLD)
	(DESC "coffre rempli de joyaux")
	(FLAGS TAKEBIT INVISIBLE)
	(FDESC
"À moitié enfoui dans la boue se trouve un vieux coffre bombé de bijoux.")
	(LDESC "Un vieux coffre rempli de joyaux de toutes sortes se trouve ici.")
	(ACTION TRUNK-F)
	(SIZE 35)
	(VALUE 15)
	(TVALUE 5)>

<OBJECT TUBE
	(IN MAINTENANCE-ROOM)
	(SYNONYM TUBE TOOTH PASTE)
	(DESC "tube")
	(FLAGS TAKEBIT CONTBIT READBIT)
	(ACTION TUBE-FUNCTION)
	(LDESC
	 "Il y a un objet qui ressemble à un tube de dentifrice. ici.")
	(CAPACITY 7)
	(SIZE 5)
	(TEXT
"---> Compagnie de pâte magique Frobozz <---|
	  Pâte à tout faire")>

<OBJECT PUTTY
	(IN TUBE)
	(SYNONYM MATERIAL GUNK)
	(ADJECTIVE VISCOUS)
	(DESC "matière visqueuse")
	(FLAGS TAKEBIT TOOLBIT)
	(SIZE 6)
	(ACTION PUTTY-FCN)>

<OBJECT ENGRAVINGS
	(IN ENGRAVINGS-CAVE)
	(SYNONYM WALL ENGRAVINGS INSCRIPTION)
	(ADJECTIVE OLD ANCIENT)
	(DESC "mur couvert de gravures")
	(FLAGS READBIT SACREDBIT)
	(LDESC "Il y a de vieilles gravures sur les murs ici.")
	(TEXT
"Une main inconnue a taillé ces gravures à même la roche de la paroi. Elles représentent, sous une forme symbolique, les croyances des anciens Zorkiens. Des extraits illustrant les grands préceptes religieux de l'époque s'entrelacent habilement aux bas-reliefs. Hélas, une génération ultérieure semble les avoir jugés blasphématoires et les a supprimés avec tout autant d'adresse.")>

<OBJECT OWNERS-MANUAL
	(IN STUDIO)
	(SYNONYM MANUAL PIECE PAPER)
	(ADJECTIVE ZORK OWNERS SMALL)
	(DESC "manuel de ZORK")
	(FLAGS READBIT TAKEBIT)
	(FDESC "Un petit morceau de papier est vaguement fixé à un mur.")
	(TEXT
"Félicitations !| |Vous êtes l'heureux propriétaire de ZORK I : Le Grand Empire Souterrain, un univers autonome qui assure lui-même son entretien. Utilisé et entretenu conformément aux pratiques normales d'exploitation des univers de petite taille, ZORK vous offrira de nombreux mois de fonctionnement sans incident.")>

<OBJECT CLIMBABLE-CLIFF
	(IN LOCAL-GLOBALS)
	(SYNONYM WALL CLIFF WALLS LEDGE)
	(ADJECTIVE ROCKY SHEER)
	(DESC "falaise")
	(ACTION CLIFF-OBJECT)
	(FLAGS NDESCBIT CLIMBBIT)>

<OBJECT WHITE-CLIFF
	(IN LOCAL-GLOBALS)
	(SYNONYM CLIFF CLIFFS)
	(ADJECTIVE WHITE)
	(DESC "falaises blanches")
	(FLAGS NDESCBIT CLIMBBIT)
	(ACTION WCLIF-OBJECT)>

<OBJECT WRENCH
	(IN MAINTENANCE-ROOM)
	(SYNONYM WRENCH TOOL TOOLS)
	(DESC "clé à molette")
	(FLAGS TAKEBIT TOOLBIT)
	(SIZE 10)>

<OBJECT CONTROL-PANEL
	(IN DAM-ROOM)
	(SYNONYM PANEL)
	(ADJECTIVE CONTROL)
	(DESC "panneau de commande")
	(FLAGS NDESCBIT)>

<OBJECT NEST
	(IN UP-A-TREE)
	(SYNONYM NEST)
	(ADJECTIVE BIRDS)
	(DESC "nid d'oiseau")
	(FLAGS TAKEBIT BURNBIT CONTBIT OPENBIT SEARCHBIT)
	(FDESC "À côté de vous, sur la branche, se trouve un petit nid d'oiseau.")
	(CAPACITY 20)>

<OBJECT EGG
	(IN NEST)
	(SYNONYM EGG TREASURE)
	(ADJECTIVE BIRDS ENCRUSTED JEWELED)
	(DESC "oeuf serti de joyaux")
	(FLAGS TAKEBIT CONTBIT SEARCHBIT)
	(ACTION EGG-OBJECT)
	(VALUE 5)
	(TVALUE 5)
	(CAPACITY 6)
	(FDESC
"Dans le nid repose un gros oeuf serti de pierres précieuses, apparemment chapardé par un oiseau chanteur sans progéniture. Il est couvert de fines incrustations d'or et orné de lapis-lazuli et de nacre. Contrairement à la plupart des oeufs, celui-ci est monté sur charnière et fermé par un fermoir d'apparence délicate. Il semble extrêmement fragile.")>

<OBJECT BROKEN-EGG
	(SYNONYM EGG TREASURE)
	(ADJECTIVE BROKEN BIRDS ENCRUSTED JEWEL)
	(DESC "oeuf brisé serti de joyaux")
	(FLAGS TAKEBIT CONTBIT OPENBIT)
	(CAPACITY 6)
	(TVALUE 2)
	(LDESC "Un oeuf passablement endommagé se trouve ici.")>

<OBJECT BAUBLE
	(SYNONYM BAUBLE TREASURE)
	(ADJECTIVE BRASS BEAUTI)
	(DESC "belle babiole en laiton")
	(FLAGS TAKEBIT)
	(VALUE 1)
	(TVALUE 1)>

<OBJECT CANARY
	(IN EGG)
	(SYNONYM CANARY TREASURE)
	(ADJECTIVE CLOCKWORK GOLD GOLDEN)
	(DESC "canari mécanique doré")
	(FLAGS TAKEBIT SEARCHBIT)
	(ACTION CANARY-OBJECT)
	(VALUE 6)
	(TVALUE 4)
	(FDESC
"Un canari mécanique doré est niché dans l'oeuf. Il a des yeux de rubis et un bec d'argent. Une fenêtre de cristal, sous son aile gauche, laisse entrevoir un mécanisme d'une grande complexité. Son ressort semble être arrivé au bout de sa course.")>

<OBJECT BROKEN-CANARY
	(IN BROKEN-EGG)
	(SYNONYM CANARY TREASURE)
	(ADJECTIVE BROKEN CLOCKWORK GOLD GOLDEN)
	(DESC "canari mécanique brisé")
	(FLAGS TAKEBIT)
	(ACTION CANARY-OBJECT)
	(TVALUE 1)
	(FDESC
"Un canari mécanique doré est niché dans l'oeuf. Il semble avoir récemment connu une fort mauvaise aventure. Les montures de ses yeux précieux sont vides et son bec d'argent est écrasé. À travers une fenêtre de cristal fêlée sous son aile gauche, on distingue les vestiges d'un mécanisme complexe. Difficile de savoir ce qui arriverait si on le remontait : le ressort moteur paraît détendu.")>

\

"SOUS-TITRE CHAMBRES"

"SOUS-TITRE SORTIE CONDITIONNELLE DRAPEAUX"

<GLOBAL CYCLOPS-FLAG <>>
<GLOBAL DEFLATE <>>
<GLOBAL DOME-FLAG <>>
<GLOBAL EMPTY-HANDED <>>
<GLOBAL LLD-FLAG <>>
<GLOBAL LOW-TIDE <>>
<GLOBAL MAGIC-FLAG <>>
<GLOBAL RAINBOW-FLAG <>>
<GLOBAL TROLL-FLAG <>>
<GLOBAL WON-FLAG <>>
<GLOBAL COFFIN-CURE <>>

"SOUS-TITRE FORÊT ET EXTÉRIEUR DE LA MAISON"

<ROOM WEST-OF-HOUSE
      (IN ROOMS)
      (DESC "À l'ouest de la maison")
      (NORTH TO NORTH-OF-HOUSE)
      (SOUTH TO SOUTH-OF-HOUSE)
      (NE TO NORTH-OF-HOUSE)
      (SE TO SOUTH-OF-HOUSE)
      (WEST TO FOREST-1)
      (EAST "La porte est condamnée par des planches que vous ne pouvez pas retirer.")
      (SW TO STONE-BARROW IF WON-FLAG)
      (IN TO STONE-BARROW IF WON-FLAG)
      (ACTION WEST-HOUSE)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL WHITE-HOUSE BOARD FOREST)>

<ROOM STONE-BARROW
      (IN ROOMS)
      (LDESC
"Vous vous tenez devant un imposant tumulus de pierre. Sur sa face orientale, une énorme porte de pierre est ouverte. Les ténèbres du tombeau vous empêchent de voir à l'intérieur.")
      (DESC "Tumulus de pierre")
      (NE TO WEST-OF-HOUSE)
      (ACTION STONE-BARROW-FCN)
      (FLAGS RLANDBIT ONBIT SACREDBIT)>

<ROOM NORTH-OF-HOUSE
      (IN ROOMS)
      (LDESC
"Vous faites face au côté nord d'une maison blanche. Il n'y a pas de porte ici et toutes les fenêtres sont condamnées. Au nord, un étroit sentier serpente entre les arbres.")
      (DESC "Au nord de la maison")
      (SW TO WEST-OF-HOUSE)
      (SE TO EAST-OF-HOUSE)
      (WEST TO WEST-OF-HOUSE)
      (EAST TO EAST-OF-HOUSE)
      (NORTH TO PATH)
      (SOUTH "Toutes les fenêtres sont condamnées par des planches.")
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL BOARDED-WINDOW BOARD WHITE-HOUSE FOREST)>

<ROOM SOUTH-OF-HOUSE
      (IN ROOMS)
      (LDESC
"Vous faites face au côté sud d'une maison blanche. Il n'y a pas de porte ici et toutes les fenêtres sont condamnées.")
      (DESC "Au sud de la maison")
      (WEST TO WEST-OF-HOUSE)
      (EAST TO EAST-OF-HOUSE)
      (NE TO EAST-OF-HOUSE)
      (NW TO WEST-OF-HOUSE)
      (SOUTH TO FOREST-3)
      (NORTH "Toutes les fenêtres sont condamnées par des planches.")
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL BOARDED-WINDOW BOARD WHITE-HOUSE FOREST)>

<ROOM EAST-OF-HOUSE
      (IN ROOMS)
      (DESC "Derrière la maison")
      (NORTH TO NORTH-OF-HOUSE)
      (SOUTH TO SOUTH-OF-HOUSE)
      (SW TO SOUTH-OF-HOUSE)
      (NW TO NORTH-OF-HOUSE)
      (EAST TO CLEARING)
      (WEST TO KITCHEN IF KITCHEN-WINDOW IS OPEN)
      (IN TO KITCHEN IF KITCHEN-WINDOW IS OPEN)
      (ACTION EAST-HOUSE)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL WHITE-HOUSE KITCHEN-WINDOW FOREST)>

<ROOM FOREST-1
      (IN ROOMS)
      (LDESC
"C'est une forêt, avec des arbres dans toutes les directions. À l'est, il semble y avoir du soleil.")
      (DESC "Forêt")
      (UP "Il n'y a pas d'arbre ici propice à l'escalade.")
      (NORTH TO GRATING-CLEARING)
      (EAST TO PATH)
      (SOUTH TO FOREST-3)
      (WEST "Vous auriez besoin d'une machette pour aller plus loin. ouest.")
      (ACTION FOREST-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE SONGBIRD WHITE-HOUSE FOREST)>

<ROOM FOREST-2
      (IN ROOMS)
      (LDESC "Il s'agit d'une forêt faiblement éclairée, avec de grands arbres tout autour.")
      (DESC "Forêt")
      (UP "Il n'y a pas d'arbre ici propice à l'escalade.")
      (NORTH "La forêt devient impénétrable au nord.")
      (EAST TO MOUNTAINS)
      (SOUTH TO CLEARING)
      (WEST TO PATH)
      (ACTION FOREST-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE SONGBIRD WHITE-HOUSE FOREST)>

<ROOM MOUNTAINS
      (IN ROOMS)
      (LDESC "La forêt s'amincit, révélant des montagnes infranchissables.")
      (DESC "Forêt")
      (UP "Les montagnes sont infranchissables.")
      (NORTH TO FOREST-2)
      (EAST "Les montagnes sont infranchissables.")
      (SOUTH TO FOREST-2)
      (WEST TO FOREST-2)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE WHITE-HOUSE)>

<ROOM FOREST-3
      (IN ROOMS)
      (LDESC "Il s'agit d'une forêt faiblement éclairée, avec de grands arbres tout autour.")
      (DESC "Forêt")
      (UP "Il n'y a pas d'arbre ici propice à l'escalade.")
      (NORTH TO CLEARING)
      (EAST "L'épais sous-bois vous empêche d'aller vers l'est.")
      (SOUTH "Des arbres secoués par la tempête bloquent votre chemin.")
      (WEST TO FOREST-1)
      (NW TO SOUTH-OF-HOUSE)
      (ACTION FOREST-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE SONGBIRD WHITE-HOUSE FOREST)>

<ROOM PATH
      (IN ROOMS)
      (LDESC
"Ce sentier serpente dans une forêt plongée dans la pénombre. Il s'étend ici du nord au sud. Un arbre particulièrement grand, aux branches basses, se dresse au bord du chemin.")
      (DESC "Sentier forestier")
      (UP TO UP-A-TREE)
      (NORTH TO GRATING-CLEARING)
      (EAST TO FOREST-2)
      (SOUTH TO NORTH-OF-HOUSE)
      (WEST TO FOREST-1)
      (ACTION FOREST-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE SONGBIRD WHITE-HOUSE FOREST)>

<ROOM UP-A-TREE
      (IN ROOMS)
      (DESC "Dans l'arbre")
      (DOWN TO PATH)
      (UP "Vous ne pouvez escalader aucun plus haut.")
      (ACTION TREE-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE FOREST SONGBIRD WHITE-HOUSE)>

<ROOM GRATING-CLEARING
      (IN ROOMS)
      (DESC "Clairière")
      (NORTH "La forêt devient impénétrable au nord.")
      (EAST TO FOREST-2)
      (WEST TO FOREST-1)
      (SOUTH TO PATH)
      (DOWN PER GRATING-EXIT)
      (ACTION CLEARING-FCN)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL WHITE-HOUSE GRATE)>

<ROUTINE GRATING-EXIT ()
	 <COND (,GRATE-REVEALED
		<COND (<FSET? ,GRATE ,OPENBIT>
		       ,GRATING-ROOM)
		      (T
		       <TELL "La grille est fermée !" CR>
		       <THIS-IS-IT ,GRATE>
		       <RFALSE>)>)
	       (T <TELL "Vous ne pouvez pas aller par là." CR> <RFALSE>)>>

<ROOM CLEARING
      (IN ROOMS)
      (LDESC
"Vous êtes dans une petite clairière traversée d'est en ouest par un sentier forestier bien marqué.")
      (DESC "Clairière")
      (UP "Il n'y a pas d'arbre ici propice à l'escalade.")
      (EAST TO CANYON-VIEW)
      (NORTH TO FOREST-2)
      (SOUTH TO FOREST-3)
      (WEST TO EAST-OF-HOUSE)
      (ACTION FOREST-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE SONGBIRD WHITE-HOUSE FOREST)>

\

"SOUS-TITRE MAISON"

<ROOM KITCHEN
      (IN ROOMS)
      (DESC "Cuisine")
      (EAST TO EAST-OF-HOUSE IF KITCHEN-WINDOW IS OPEN)
      (WEST TO LIVING-ROOM)
      (OUT TO EAST-OF-HOUSE IF KITCHEN-WINDOW IS OPEN)
      (UP TO ATTIC)
      (DOWN TO STUDIO IF FALSE-FLAG ELSE
	 "Seul le Père Noël descend par les cheminées.")
      (ACTION KITCHEN-FCN)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (VALUE 10)
      (GLOBAL KITCHEN-WINDOW CHIMNEY STAIRS)>

<ROOM ATTIC
      (IN ROOMS)
      (LDESC "Voici le grenier. La seule sortie est un escalier qui descend.")
      (DESC "Grenier")
      (DOWN TO KITCHEN)
      (FLAGS RLANDBIT SACREDBIT)
      (GLOBAL STAIRS)>

<ROOM LIVING-ROOM
      (IN ROOMS)
      (DESC "Salon")
      (EAST TO KITCHEN)
      (WEST TO STRANGE-PASSAGE IF MAGIC-FLAG ELSE "La porte est condamnée par des clous.")
      (DOWN PER TRAP-DOOR-EXIT)
      (ACTION LIVING-ROOM-FCN)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL STAIRS)
      (PSEUDO "NAILS" NAILS-PSEUDO "NAIL" NAILS-PSEUDO)>

\

"SOUS-TITRE CAVE ET ENVIRONS"

<ROOM CELLAR
      (IN ROOMS)
      (DESC "Cave")
      (NORTH TO TROLL-ROOM)
      (SOUTH TO EAST-OF-CHASM)
      (UP TO LIVING-ROOM IF TRAP-DOOR IS OPEN)
      (WEST
"Vous essayez de monter la rampe, mais c'est impossible et vous redescendez.")
      (ACTION CELLAR-FCN)
      (FLAGS RLANDBIT)
      (VALUE 25)
      (GLOBAL TRAP-DOOR SLIDE STAIRS)>

<ROOM TROLL-ROOM
      (IN ROOMS)
      (LDESC
"C'est une petite salle d'où partent des passages vers l'est et le sud, ainsi qu'un trou peu engageant à l'ouest. Des taches de sang et de profondes entailles -- peut-être laissées par une hache -- défigurent les murs.")
      (DESC "Salle du troll")
      (SOUTH TO CELLAR)
      (EAST TO EW-PASSAGE
       IF TROLL-FLAG ELSE "Le troll vous barre le passage d'un geste menaçant.")
      (WEST TO MAZE-1
       IF TROLL-FLAG ELSE "Le troll vous barre le passage d'un geste menaçant.")
      (FLAGS RLANDBIT)
      (ACTION TROLL-ROOM-F)>

<ROOM EAST-OF-CHASM
      (IN ROOMS)
      (LDESC
"Vous êtes au bord oriental d'un gouffre dont le fond demeure invisible. Un passage étroit part vers le nord, tandis que le chemin se poursuit vers l'est.")
      (DESC "À l'est du gouffre")
      (NORTH TO CELLAR)
      (EAST TO GALLERY)
      (DOWN "Ce gouffre mène probablement tout droit aux régions infernales.")
      (FLAGS RLANDBIT)
      (PSEUDO "CHASM" CHASM-PSEUDO)>

<ROOM GALLERY
      (IN ROOMS)
      (LDESC
"C'est une galerie d'art. La plupart des tableaux ont été dérobés par des vandales au goût exceptionnel, qui sont repartis par l'une des sorties au nord ou à l'ouest.")
      (DESC "Galerie")
      (WEST TO EAST-OF-CHASM)
      (NORTH TO STUDIO)
      (FLAGS RLANDBIT ONBIT)>

<ROOM STUDIO
      (IN ROOMS)
      (LDESC
"Cet endroit semble avoir été l'atelier d'un artiste. Les murs et le sol sont éclaboussés de peinture de soixante-neuf couleurs différentes. Curieusement, rien de précieux n'est accroché ici. À l'extrémité sud se trouve une porte ouverte, elle aussi couverte de peinture. Une cheminée sombre et étroite s'élève au-dessus de l'âtre ; vous pourriez sans doute y grimper, mais il paraît peu probable que vous puissiez ensuite redescendre.")
      (DESC "Atelier")
      (SOUTH TO GALLERY)
      (UP PER UP-CHIMNEY-FUNCTION)
      (FLAGS RLANDBIT)
      (GLOBAL CHIMNEY)
      (PSEUDO "DOOR" DOOR-PSEUDO "PAINT" PAINT-PSEUDO)>

\

"SOUS-TITRE LABYRINTHE"

<ROOM MAZE-1
      (IN ROOMS)
      (LDESC "Ceci fait partie d'un labyrinthe de petits passages sinueux, tous pareils.")
      (DESC "Labyrinthe")
      (EAST TO TROLL-ROOM)
      (NORTH TO MAZE-1)
      (SOUTH TO MAZE-2)
      (WEST TO MAZE-4)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-2
      (IN ROOMS)
      (LDESC "Ceci fait partie d'un labyrinthe de petits passages sinueux, tous pareils.")
      (DESC "Labyrinthe")
      (SOUTH TO MAZE-1)
      (DOWN PER MAZE-DIODES) ;"to MAZE-4"
      (EAST TO MAZE-3)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-3
      (IN ROOMS)
      (LDESC "Ceci fait partie d'un labyrinthe de petits passages sinueux, tous pareils.")
      (DESC "Labyrinthe")
      (WEST TO MAZE-2)
      (NORTH TO MAZE-4)
      (UP TO MAZE-5)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-4
      (IN ROOMS)
      (LDESC "Ceci fait partie d'un labyrinthe de petits passages sinueux, tous pareils.")
      (DESC "Labyrinthe")
      (WEST TO MAZE-3)
      (NORTH TO MAZE-1)
      (EAST TO DEAD-END-1)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM DEAD-END-1
      (IN ROOMS)
      (DESC "Impasse")
      (LDESC "Vous êtes dans une impasse dans le labyrinthe.")
      (SOUTH TO MAZE-4)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-5
      (IN ROOMS)
      (LDESC "Vous êtes dans une partie d'un labyrinthe de petits passages tortueux, tous semblables. Le squelette d'un aventurier malchanceux, sans doute, gît ici.")
      (DESC "Labyrinthe")
      (EAST TO DEAD-END-2)
      (NORTH TO MAZE-3)
      (SW TO MAZE-6)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM DEAD-END-2
      (IN ROOMS)
      (DESC "Impasse")
      (LDESC "Vous êtes dans une impasse dans le labyrinthe.")
      (WEST TO MAZE-5)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-6
      (IN ROOMS)
      (LDESC "Ceci fait partie d'un labyrinthe de petits passages sinueux, tous pareils.")
      (DESC "Labyrinthe")
      (DOWN TO MAZE-5)
      (EAST TO MAZE-7)
      (WEST TO MAZE-6)
      (UP TO MAZE-9)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-7
      (IN ROOMS)
      (LDESC "Ceci fait partie d'un labyrinthe de petits passages sinueux, tous pareils.")
      (DESC "Labyrinthe")
      (UP TO MAZE-14)
      (WEST TO MAZE-6)
      (DOWN PER MAZE-DIODES) ;"to DEAD-END-1"
      (EAST TO MAZE-8)
      (SOUTH TO MAZE-15)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-8
      (IN ROOMS)
      (LDESC "Ceci fait partie d'un labyrinthe de petits passages sinueux, tous pareils.")
      (DESC "Labyrinthe")
      (NE TO MAZE-7)
      (WEST TO MAZE-8)
      (SE TO DEAD-END-3)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM DEAD-END-3
      (IN ROOMS)
      (DESC "Impasse")
      (LDESC "Vous êtes dans une impasse dans le labyrinthe.")
      (NORTH TO MAZE-8)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-9
      (IN ROOMS)
      (LDESC "Ceci fait partie d'un labyrinthe de petits passages sinueux, tous pareils.")
      (DESC "Labyrinthe")
      (NORTH TO MAZE-6)
      (DOWN PER MAZE-DIODES) ;"to MAZE-11"
      (EAST TO MAZE-10)
      (SOUTH TO MAZE-13)
      (WEST TO MAZE-12)
      (NW TO MAZE-9)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-10
      (IN ROOMS)
      (LDESC "Ceci fait partie d'un labyrinthe de petits passages sinueux, tous pareils.")
      (DESC "Labyrinthe")
      (EAST TO MAZE-9)
      (WEST TO MAZE-13)
      (UP TO MAZE-11)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-11
      (IN ROOMS)
      (LDESC "Ceci fait partie d'un labyrinthe de petits passages sinueux, tous pareils.")
      (DESC "Labyrinthe")
       (NE TO GRATING-ROOM)
      (DOWN TO MAZE-10)
      (NW TO MAZE-13)
      (SW TO MAZE-12)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM GRATING-ROOM
      (IN ROOMS)
      (DESC "Salle de la grille")
      (SW TO MAZE-11)
      (UP TO GRATING-CLEARING
       IF GRATE IS OPEN ELSE "La grille est fermée.")
      (ACTION MAZE-11-FCN)
      (GLOBAL GRATE)
      (FLAGS RLANDBIT)>

<ROOM MAZE-12
      (IN ROOMS)
      (LDESC "Ceci fait partie d'un labyrinthe de petits passages sinueux, tous pareils.")
      (DESC "Labyrinthe")
      (DOWN PER MAZE-DIODES) ;"to MAZE-5"
      (SW TO MAZE-11)
      (EAST TO MAZE-13)
      (UP TO MAZE-9)
      (NORTH TO DEAD-END-4)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM DEAD-END-4
      (IN ROOMS)
      (DESC "Impasse")
      (LDESC "Vous êtes dans une impasse dans le labyrinthe.")
      (SOUTH TO MAZE-12)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-13
      (IN ROOMS)
      (LDESC "Ceci fait partie d'un labyrinthe de petits passages sinueux, tous pareils.")
      (DESC "Labyrinthe")
      (EAST TO MAZE-9)
      (DOWN TO MAZE-12)
      (SOUTH TO MAZE-10)
      (WEST TO MAZE-11)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-14
      (IN ROOMS)
      (LDESC "Ceci fait partie d'un labyrinthe de petits passages sinueux, tous pareils.")
      (DESC "Labyrinthe")
       (WEST TO MAZE-15)
      (NW TO MAZE-14)
      (NE TO MAZE-7)
      (SOUTH TO MAZE-7)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-15
      (IN ROOMS)
      (LDESC "Ceci fait partie d'un labyrinthe de petits passages sinueux, tous pareils.")
      (DESC "Labyrinthe")
      (WEST TO MAZE-14)
      (SOUTH TO MAZE-7)
      (SE TO CYCLOPS-ROOM)
      (FLAGS RLANDBIT MAZEBIT)>

\

"SOUS-TITRE CYCLOPE ET CACHÉE"

<ROOM CYCLOPS-ROOM
      (IN ROOMS)
      (DESC "Salle du cyclope")
      (NW TO MAZE-15)
      (EAST TO STRANGE-PASSAGE
       IF MAGIC-FLAG ELSE "Le mur oriental est fait de roche massive.")
      (UP TO TREASURE-ROOM IF CYCLOPS-FLAG
        ELSE "Le cyclope n'a pas l'air disposé à vous laisser passer.")
      (ACTION CYCLOPS-ROOM-FCN)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)>

<ROOM STRANGE-PASSAGE
      (IN ROOMS)
      (LDESC
"C'est un long passage. Une entrée se trouve à l'ouest. À l'est, une vieille porte en bois est percée d'une vaste ouverture, à peu près de la taille d'un cyclope.")
      (DESC "Passage étrange")
      (WEST TO CYCLOPS-ROOM)
      (IN TO CYCLOPS-ROOM)
      (EAST TO LIVING-ROOM)
      (FLAGS RLANDBIT)>

<ROOM TREASURE-ROOM
      (IN ROOMS)
      (LDESC
"C'est une vaste salle dont le mur oriental est en granit massif. Des sacs abandonnés, qui tombent en poussière au moindre contact, jonchent le sol. Un escalier permet de descendre.")
      (DESC "Salle du trésor")
      (DOWN TO CYCLOPS-ROOM)
      (ACTION TREASURE-ROOM-FCN)
      (FLAGS RLANDBIT ;"CANT-HAVE-ONBIT")
      (VALUE 25)
      (GLOBAL STAIRS)>

\

"ZONE DE RÉSERVOIR DE SOUS-TITRE"

<ROOM RESERVOIR-SOUTH
      (IN ROOMS)
      (DESC "Sud du réservoir")
      (SE TO DEEP-CANYON)
      (SW TO CHASM-ROOM)
      (EAST TO DAM-ROOM)
      (WEST TO STREAM-VIEW)
      (NORTH TO RESERVOIR
       IF LOW-TIDE ELSE "Vous vous noieriez.")
      (ACTION RESERVOIR-SOUTH-FCN)
      (FLAGS RLANDBIT)
      (GLOBAL GLOBAL-WATER)
      (PSEUDO "LAKE" LAKE-PSEUDO "CHASM" CHASM-PSEUDO)>

<ROOM RESERVOIR
      (IN ROOMS)
      (DESC "Réservoir")
      (NORTH TO RESERVOIR-NORTH)
      (SOUTH TO RESERVOIR-SOUTH)
      (UP TO IN-STREAM)
      (WEST TO IN-STREAM)
      (DOWN "Le barrage bloque votre ")
      (ACTION RESERVOIR-FCN)
      (FLAGS NONLANDBIT )
      (PSEUDO "STREAM" STREAM-PSEUDO)
      (GLOBAL GLOBAL-WATER)>

<ROOM RESERVOIR-NORTH
      (IN ROOMS)
      (DESC "Nord du réservoir")
      (NORTH TO ATLANTIS-ROOM)
      (SOUTH TO RESERVOIR
       IF LOW-TIDE ELSE "Vous vous noieriez.")
      (ACTION RESERVOIR-NORTH-FCN)
      (FLAGS RLANDBIT)
      (GLOBAL GLOBAL-WATER STAIRS)
      (PSEUDO "LAKE" LAKE-PSEUDO)>

<ROOM STREAM-VIEW
      (IN ROOMS)
      (LDESC
"Vous vous tenez sur un sentier qui longe un ruisseau paisible. Le chemin suit le cours d'eau, qui s'écoule d'ouest en est.")
      (DESC "Vue sur le ruisseau")
      (EAST TO RESERVOIR-SOUTH)
      (WEST "Le ruisseau émerge d'un endroit trop petit pour que vous puissiez y entrer.")
      (FLAGS RLANDBIT)
      (GLOBAL GLOBAL-WATER)
      (PSEUDO "STREAM" STREAM-PSEUDO)>

<ROOM IN-STREAM
      (IN ROOMS)
      (LDESC
"Vous naviguez sur un ruisseau au courant paisible. En amont, le passage est trop étroit ; en aval, les méandres des parois masquent la suite du cours d'eau. Une étroite plage permet d'accoster.")
      (DESC "Ruisseau")
      (UP "Le canal est trop étroit.")
      (WEST "Le canal est trop étroit.")
      (LAND TO STREAM-VIEW)
      (DOWN TO RESERVOIR)
      (EAST TO RESERVOIR)
      (FLAGS NONLANDBIT )
      (GLOBAL GLOBAL-WATER)
      (PSEUDO "STREAM" STREAM-PSEUDO)>

\

"SOUS-TITRE CHAMBRES MIROIR ET ENVIRONS"

<ROOM MIRROR-ROOM-1
      (IN ROOMS)
      (DESC "Salle aux miroirs")
      (NORTH TO COLD-PASSAGE)
      (WEST TO TWISTING-PASSAGE)
      (EAST TO SMALL-CAVE)
      (ACTION MIRROR-ROOM)
      (FLAGS RLANDBIT)>

<ROOM MIRROR-ROOM-2
      (IN ROOMS)
      (DESC "Salle aux miroirs")
      (WEST TO WINDING-PASSAGE)
      (NORTH TO NARROW-PASSAGE)
      (EAST TO TINY-CAVE)
      (ACTION MIRROR-ROOM)
      (FLAGS RLANDBIT ONBIT)>

<ROOM SMALL-CAVE
      (IN ROOMS)
      (LDESC
"C'est une petite grotte avec des entrées ouest et nord, et un escalier menant vers le bas.")
      (DESC "Grotte")
      (NORTH TO MIRROR-ROOM-1)
      (DOWN TO ATLANTIS-ROOM)
      (SOUTH TO ATLANTIS-ROOM)
      (WEST TO TWISTING-PASSAGE)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)>

<ROOM TINY-CAVE
      (IN ROOMS)
      (LDESC
"C'est une petite grotte avec des entrées ouest et nord, et un escalier sombre, interdisant de descendre.")
      (DESC "Grotte")
      (NORTH TO MIRROR-ROOM-2)
      (WEST TO WINDING-PASSAGE)
      (DOWN TO ENTRANCE-TO-HADES)
      (ACTION CAVE2-ROOM)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)>

<ROOM COLD-PASSAGE
      (IN ROOMS)
      (LDESC
"C'est un couloir froid et humide où un long passage est-ouest se transforme en un sentier sud.")
      (DESC "Passage froid")
      (SOUTH TO MIRROR-ROOM-1)
      (WEST TO SLIDE-ROOM)
      (FLAGS RLANDBIT)>

<ROOM NARROW-PASSAGE
      (IN ROOMS)
      (LDESC
"Ce long couloir étroit constitue le bref étranglement d'un passage orienté nord-sud.")
      (DESC "Passage étroit")
      (NORTH TO ROUND-ROOM)
      (SOUTH TO MIRROR-ROOM-2)
      (FLAGS RLANDBIT)>

<ROOM WINDING-PASSAGE
      (IN ROOMS)
      (LDESC
"Il semble qu'il n'y ait que des sorties à l'est et au nord.")
      (DESC "Passage tortueux")
      (NORTH TO MIRROR-ROOM-2)
      (EAST TO TINY-CAVE)
      (FLAGS RLANDBIT)>

<ROOM TWISTING-PASSAGE
      (IN ROOMS)
      (LDESC
"Il semble qu'il n'y ait que des sorties à l'est et au nord.")
      (DESC "Passage sinueux")
      (NORTH TO MIRROR-ROOM-1)
      (EAST TO SMALL-CAVE)
      (FLAGS RLANDBIT)>

<ROOM ATLANTIS-ROOM
      (IN ROOMS)
      (LDESC
"Cette salle antique est restée longtemps engloutie. Une sortie mène au sud et un escalier permet de monter.")
      (DESC "Salle d'Atlantide")
      (UP TO SMALL-CAVE)
      (SOUTH TO RESERVOIR-NORTH)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)>

\

"SOUS-TITRE CHAMBRE RONDE ET ENVIRONS"

<ROOM EW-PASSAGE
      (IN ROOMS)
      (LDESC
"C'est un étroit passage orienté d'est en ouest. À son extrémité nord, un escalier resserré descend dans les profondeurs.")
      (DESC "Passage est-ouest")
      (EAST TO ROUND-ROOM)
      (WEST TO TROLL-ROOM)
      (DOWN TO CHASM-ROOM)
      (NORTH TO CHASM-ROOM)
      (FLAGS RLANDBIT)
      (VALUE 5)
      (GLOBAL STAIRS)>

<ROOM ROUND-ROOM
      (IN ROOMS)
      (LDESC
"C'est une salle circulaire en pierre, percée de passages dans toutes les directions. Plusieurs sont malheureusement obstrués par des éboulements.")
      (DESC "Salle ronde")
      (EAST TO LOUD-ROOM)
      (WEST TO EW-PASSAGE)
      (NORTH TO NS-PASSAGE)
      (SOUTH TO NARROW-PASSAGE)
      (SE TO ENGRAVINGS-CAVE)
      (FLAGS RLANDBIT)>

<ROOM DEEP-CANYON
      (IN ROOMS)
      (DESC "Canyon profond")
      (NW TO RESERVOIR-SOUTH) ;COFFIN-CURE
      (EAST TO DAM-ROOM)
      (SW TO NS-PASSAGE)
      (DOWN TO LOUD-ROOM)
      (FLAGS RLANDBIT)
      (ACTION DEEP-CANYON-F)
      (GLOBAL STAIRS)>

<ROOM DAMP-CAVE
      (IN ROOMS)
      (LDESC
"Cette grotte possède des sorties à l'ouest et à l'est ; vers le sud, elle se resserre jusqu'à ne plus former qu'une fissure. La terre y est particulièrement humide.")
      (DESC "Grotte humide")
      (WEST TO LOUD-ROOM)
      (EAST TO WHITE-CLIFFS-NORTH)
      (SOUTH "Elle est trop étroite pour la plupart des insectes.")
      (FLAGS RLANDBIT)
      (GLOBAL CRACK)>

<ROOM LOUD-ROOM
      (IN ROOMS)
      (DESC "Salle assourdissante")
      (EAST TO DAMP-CAVE)
      (WEST TO ROUND-ROOM)
      (UP TO DEEP-CANYON)
      (ACTION LOUD-ROOM-FCN)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)>

<ROOM NS-PASSAGE
      (IN ROOMS)
      (LDESC
"Il s'agit d'un passage nord-sud élevé, qui bifurque vers le nord-est.")
      (DESC "Passage nord-sud")
      (NORTH TO CHASM-ROOM)
      (NE TO DEEP-CANYON)
      (SOUTH TO ROUND-ROOM)
      (FLAGS RLANDBIT)>

<ROOM CHASM-ROOM
      (IN ROOMS)
      (LDESC
"Un gouffre s'étend du sud-ouest au nord-est, longé par le sentier. Vous vous trouvez sur sa rive sud, où une fissure s'élargit en passage.")
      (DESC "Gouffre")
      (NE TO RESERVOIR-SOUTH)
      (SW TO EW-PASSAGE)
      (UP TO EW-PASSAGE)
      (SOUTH TO NS-PASSAGE)
      (DOWN "Avez-vous perdu la tête ?")
      (FLAGS RLANDBIT)
      (GLOBAL CRACK STAIRS)
      (PSEUDO "CHASM" CHASM-PSEUDO)>

\

"SOUS-TITRE HADES ET AL"

<ROOM ENTRANCE-TO-HADES
      (IN ROOMS)
      (DESC "Entrée des Enfers")
      (UP TO TINY-CAVE)
      (IN TO LAND-OF-LIVING-DEAD IF LLD-FLAG
       ELSE "Une force invisible vous empêche de passer par le porte.")
      (SOUTH TO LAND-OF-LIVING-DEAD IF LLD-FLAG
       ELSE "Une force invisible vous empêche de passer par le porte.")
      (ACTION LLD-ROOM)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL BODIES)
      (PSEUDO "GATE" GATE-PSEUDO "GATES" GATE-PSEUDO)>

<ROOM LAND-OF-LIVING-DEAD
      (IN ROOMS)
      (LDESC
"Vous avez pénétré dans le Royaume des Morts-Vivants. Des milliers d'âmes perdues pleurent et gémissent dans l'obscurité. Dans un coin sont entassés les restes de dizaines d'aventuriers qui eurent moins de chance que vous. Un passage mène au nord.")
      (DESC "Royaume des Morts")
      (OUT TO ENTRANCE-TO-HADES)
      (NORTH TO ENTRANCE-TO-HADES)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL BODIES)>

\

"SOUS-TITRE DÔME, TEMPLE, ÉGYPTE"

<ROOM ENGRAVINGS-CAVE	;"was CAVE4"
      (IN ROOMS)
      (LDESC
"Vous êtes entré dans une grotte basse, d'où partent des passages vers le nord-ouest et l'est.")
      (DESC "Grotte aux gravures")
      (NW TO ROUND-ROOM)
      (EAST TO DOME-ROOM)
      (FLAGS RLANDBIT)>

<ROOM EGYPT-ROOM	;"was EGYPT"
      (IN ROOMS)
      (LDESC
"C'est une pièce qui ressemble à une tombe égyptienne. Il y a un escalier ascendant à l'ouest.")
      (DESC "Salle égyptienne")
      (WEST TO NORTH-TEMPLE)
      (UP TO NORTH-TEMPLE)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)>

<ROOM DOME-ROOM	;"was DOME"
      (IN ROOMS)
      (DESC "Salle du dôme")
      (WEST TO ENGRAVINGS-CAVE)
      (DOWN TO TORCH-ROOM
       IF DOME-FLAG ELSE "Vous ne pourriez descendre sans vous briser quantité d'os.")
      (ACTION DOME-ROOM-FCN)
      (FLAGS RLANDBIT)
      (PSEUDO "DOME" DOME-PSEUDO)>

<ROOM TORCH-ROOM
      (IN ROOMS)
      (DESC "Salle de la torche")
      (UP "Vous ne pouvez pas atteindre la corde.")
      (SOUTH TO NORTH-TEMPLE)
      (DOWN TO NORTH-TEMPLE)
      (ACTION TORCH-ROOM-FCN)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)
      (PSEUDO "DOME" DOME-PSEUDO)>

<ROOM NORTH-TEMPLE	;"was TEMP1"
      (IN ROOMS)
      (LDESC
"Vous êtes à l'extrémité nord d'un vaste temple. Sur le mur oriental se trouve une inscription ancienne, sans doute une prière rédigée dans une langue oubliée depuis longtemps. Un escalier descend sous la prière. Le mur occidental est en granit massif. Au nord, la sortie passe entre d'immenses colonnes de marbre.")
      (DESC "Temple")
      (DOWN TO EGYPT-ROOM)
      (EAST TO EGYPT-ROOM)
      (NORTH TO TORCH-ROOM)
      (OUT TO TORCH-ROOM)
      (UP TO TORCH-ROOM)
      (SOUTH TO SOUTH-TEMPLE)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL STAIRS)>

<ROOM SOUTH-TEMPLE	;"was TEMP2"
      (IN ROOMS)
      (LDESC

"Vous êtes à l'extrémité sud d'un vaste temple. Devant vous se dresse ce qui paraît être un autel. Dans un coin, une petite ouverture ménagée dans le sol plonge dans les ténèbres. Vous ne pourriez probablement pas remonter par là.")
      (DESC "Autel")
      (NORTH TO NORTH-TEMPLE)
      (DOWN TO TINY-CAVE
       IF COFFIN-CURE
       ELSE "Vous n'avez aucune chance de faire descendre le cercueil par là.")
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (ACTION SOUTH-TEMPLE-FCN)>

\

"SOUS-TITRE BARRAGE CONTRÔLANT LES INONDATIONS #3"

<ROOM DAM-ROOM	;"was DAM"
      (IN ROOMS)
      (DESC "Barrage")
      (SOUTH TO DEEP-CANYON)
      (DOWN TO DAM-BASE)
      (EAST TO DAM-BASE)
      (NORTH TO DAM-LOBBY)
      (WEST TO RESERVOIR-SOUTH)
      (ACTION DAM-ROOM-FCN)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL GLOBAL-WATER)>

<ROOM DAM-LOBBY	;"was LOBBY"
      (IN ROOMS)
      (LDESC
"Cette salle semble avoir servi de salle d'attente aux groupes visitant le barrage. Des portes ouvertes au nord et à l'est portent la mention \"Privé\" ; un chemin part vers le sud en passant sur le sommet du barrage.")
      (DESC "Hall du barrage")
      (SOUTH TO DAM-ROOM)
      (NORTH TO MAINTENANCE-ROOM)
      (EAST TO MAINTENANCE-ROOM)
      (FLAGS RLANDBIT ONBIT)>

<ROOM MAINTENANCE-ROOM	;"was MAINT"
      (IN ROOMS)
      (LDESC
"Cette pièce semble avoir servi à l'entretien du Barrage de régulation des crues no 3. Elle a visiblement été pillée récemment : presque tout le matériel de valeur a disparu. Sur le mur devant vous sont disposés quatre boutons, bleu, jaune, brun et rouge. Des portes mènent à l'ouest et au sud.")
      (DESC "Salle de maintenance")
      (SOUTH TO DAM-LOBBY)
      (WEST TO DAM-LOBBY)
      (FLAGS RLANDBIT)>

\

"ZONE DE LA RIVIÈRE SOUS-TITRE"

<ROOM DAM-BASE	;"was DOCK"
      (IN ROOMS)
      (LDESC
"Vous êtes au pied du Barrage de régulation des crues no 3, dont la masse imposante se dresse au-dessus de vous, vers le nord. La Rivière Glaciale coule à proximité. Sur ses rives, les Falaises Blanches forment d'immenses murailles qui s'étendent du nord au sud en suivant les méandres du fleuve.")
      (DESC "Pied du barrage")
      (NORTH TO DAM-ROOM)
      (UP TO DAM-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM RIVER-1	;"was RIVR1"
      (IN ROOMS)
      (LDESC
"Vous naviguez sur la Rivière Glaciale, à proximité du barrage. Le courant est calme ici. Un débarcadère se trouve sur la rive ouest.")
      (DESC "Rivière Glaciale")
      (UP "La violence du courant vous empêche de remonter la rivière.")
      (WEST TO DAM-BASE)
      (LAND TO DAM-BASE)
      (DOWN TO RIVER-2)
      (EAST "Les Falaises Blanches vous empêchent d'accoster ici.")
      (FLAGS NONLANDBIT SACREDBIT ONBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM RIVER-2	;"was RIVR2"
      (IN ROOMS)
      (LDESC
"La rivière décrit ici un coude qui masque le barrage. Les Falaises Blanches dominent la rive est, tandis que de gros rochers empêchent d'accoster à l'ouest.")
      (DESC "Rivière Glaciale")
      (UP "La violence du courant vous empêche de remonter la rivière.")
      (DOWN TO RIVER-3)
      (LAND "Il n'y a pas de point d'atterrissage sûr ici.")
      (EAST "Les Falaises Blanches vous empêchent d'accoster ici.")
      (WEST "Juste à temps, vous vous éloignez des rochers.")
      (FLAGS NONLANDBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM RIVER-3	;"was RIVR3"
      (IN ROOMS)
      (LDESC
"La rivière descend ici dans une vallée. Une étroite plage s'étend sur la rive ouest, au pied des falaises. Au loin, on perçoit un faible grondement.")
      (DESC "Rivière Glaciale")
      (UP "La violence du courant vous empêche de remonter la rivière.")
      (DOWN TO RIVER-4)
      (LAND TO WHITE-CLIFFS-NORTH)
      (WEST TO WHITE-CLIFFS-NORTH)
      (FLAGS NONLANDBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM WHITE-CLIFFS-NORTH	;"was WCLF1"
      (IN ROOMS)
      (LDESC
"Vous êtes sur une étroite bande de plage au pied des Falaises Blanches. Un sentier resserré longe les falaises vers le sud ; un passage exigu s'enfonce vers l'ouest dans la roche.")
      (DESC "Plage des Falaises Blanches")
      (SOUTH TO WHITE-CLIFFS-SOUTH IF DEFLATE ELSE "Le chemin est trop étroit.")
      (WEST TO DAMP-CAVE IF DEFLATE ELSE "Le chemin est trop étroit.")
      (ACTION WHITE-CLIFFS-FUNCTION)
      (FLAGS RLANDBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER WHITE-CLIFF RIVER)>

<ROOM WHITE-CLIFFS-SOUTH	;"was WCLF2"
      (IN ROOMS)
      (LDESC
"Vous êtes sur une étroite plage rocheuse, au pied des falaises. Un sentier suit la rive vers le nord.")
      (DESC "Plage des Falaises Blanches")
      (NORTH TO WHITE-CLIFFS-NORTH
       IF DEFLATE ELSE "Le chemin est trop étroit.")
      (ACTION WHITE-CLIFFS-FUNCTION)
      (FLAGS RLANDBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER WHITE-CLIFF RIVER)>

<ROOM RIVER-4	;"was RIVR4"
      (IN ROOMS)
      (LDESC
"Le courant s'accélère et, devant vous, le fracas de l'eau se fait entendre. Une plage de sable borde la rive est. On distingue également une petite grève sous les falaises de la rive ouest.")
      (DESC "Rivière Glaciale")
      (UP "La violence du courant vous empêche de remonter la rivière.")
      (DOWN TO RIVER-5)
      (LAND "Vous pouvez atterrir soit à l'est, soit à l'ouest.")
      (WEST TO WHITE-CLIFFS-SOUTH)
      (EAST TO SANDY-BEACH)
      (ACTION RIVR4-ROOM)
      (FLAGS NONLANDBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM RIVER-5	;"was RIVR5"
      (IN ROOMS)
      (LDESC
"Le fracas de l'eau est presque insupportable. Une vaste zone d'accostage s'étend sur la rive est.")
      (DESC "Rivière Glaciale")
      (UP "La violence du courant vous empêche de remonter la rivière.")
      (EAST TO SHORE)
      (LAND TO SHORE)
      (FLAGS NONLANDBIT SACREDBIT ONBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM SHORE	;"was FANTE"
      (IN ROOMS)
      (LDESC
"Vous êtes sur la rive est de la rivière. L'eau paraît traîtresse à cet endroit. Un sentier suit un axe nord-sud ; vers le sud, il disparaît rapidement derrière un virage serré.")
      (DESC "Rive")
      (NORTH TO SANDY-BEACH)
      (SOUTH TO ARAGAIN-FALLS)
      (FLAGS RLANDBIT SACREDBIT ONBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM SANDY-BEACH	;"was BEACH"
      (IN ROOMS)
      (LDESC

"Vous êtes sur une vaste plage de sable, sur la rive est d'une rivière au courant rapide. Un sentier longe l'eau vers le sud et, au nord-est, un passage est en partie enseveli sous le sable.")
      (DESC "Plage de sable")
      (NE TO SANDY-CAVE)
      (SOUTH TO SHORE)
      (FLAGS RLANDBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM SANDY-CAVE	;"was TCAVE"
      (IN ROOMS)
      (LDESC
"Il s'agit d'une grotte remplie de sable dont la sortie est au sud-ouest.")
      (DESC "Grotte sablonneuse")
      (SW TO SANDY-BEACH)
      (FLAGS RLANDBIT)>

<ROOM ARAGAIN-FALLS	;"was FALLS"
      (IN ROOMS)
      (DESC "Chutes d'Aragain")
      (WEST TO ON-RAINBOW IF RAINBOW-FLAG)
      (DOWN "La chute serait longue...")
      (NORTH TO SHORE)
      (UP TO ON-RAINBOW IF RAINBOW-FLAG)
      (ACTION FALLS-ROOM)
      (FLAGS RLANDBIT SACREDBIT ONBIT)
      (GLOBAL GLOBAL-WATER RIVER RAINBOW)>

<ROOM ON-RAINBOW	;"was RAINB"
      (IN ROOMS)
      (LDESC
"Vous marchez au sommet d'un arc-en-ciel -- avouez que vous ne vous y attendiez pas -- et profitez d'une vue magnifique sur les chutes. L'arc-en-ciel s'étend ici d'est en ouest.")
      (DESC "Sur l'arc-en-ciel")
      (WEST TO END-OF-RAINBOW)
      (EAST TO ARAGAIN-FALLS)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL RAINBOW)>

<ROOM END-OF-RAINBOW	;"was POG"
      (IN ROOMS)
      (LDESC
"Vous êtes sur une petite plage rocheuse, au bord de la Rivière Glaciale en aval des chutes. Les Falaises Blanches ne lui laissent qu'une étroite bande de terrain. Le canyon s'ouvre ici et la lumière du jour descend d'en haut. À l'est, un arc-en-ciel enjambe les chutes ; un sentier étroit se poursuit vers le sud-ouest.")
      (DESC "Pied de l'arc-en-ciel")
      (UP TO ON-RAINBOW IF RAINBOW-FLAG)
      (NE TO ON-RAINBOW IF RAINBOW-FLAG)
      (EAST TO ON-RAINBOW IF RAINBOW-FLAG)
      (SW TO CANYON-BOTTOM)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL GLOBAL-WATER RAINBOW RIVER)>

<ROOM CANYON-BOTTOM	;"was CLBOT"
      (IN ROOMS)
      (LDESC
"Vous êtes au pied des parois du canyon, qui semblent pouvoir être escaladées ici. En contrebas coule le bras secondaire des Chutes d'Aragain. Un sentier étroit mène au nord.")
      (DESC "Fond du canyon")
      (UP TO CLIFF-MIDDLE)
      (NORTH TO END-OF-RAINBOW)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER CLIMBABLE-CLIFF RIVER)>

<ROOM CLIFF-MIDDLE	;"was CLMID"
      (IN ROOMS)
      (LDESC
"Vous êtes sur une corniche, à mi-hauteur de la paroi du canyon. D'ici, vous voyez le cours principal des Chutes d'Aragain s'engouffrer dans un passage inaccessible. Le fond du canyon est en dessous de vous ; au-dessus, la falaise paraît encore praticable.")
      (DESC "Corniche rocheuse")
      (UP TO CANYON-VIEW)
      (DOWN TO CANYON-BOTTOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL CLIMBABLE-CLIFF RIVER)>

<ROOM CANYON-VIEW	;"was CLTOP"
      (IN ROOMS)
      (LDESC
"Vous êtes au sommet de la paroi ouest du Grand Canyon. La vue embrasse le canyon et une partie de la Rivière Glaciale en amont. En face, les Falaises Blanches rejoignent à l'est les puissants remparts des montagnes Tête-Plate. Vers le nord, en remontant le canyon, on aperçoit les Chutes d'Aragain et leur arc-en-ciel. La puissante Rivière Glaciale jaillit d'une immense caverne obscure. À l'ouest et au sud s'étend à perte de vue une forêt gigantesque. Un sentier part au nord-ouest. Il est possible de descendre dans le canyon depuis cet endroit.")
      (DESC "Belvédère du canyon")
      (EAST TO CLIFF-MIDDLE)
      (DOWN TO CLIFF-MIDDLE)
      (NW TO CLEARING)
      (WEST TO FOREST-3)
      (SOUTH "Des arbres secoués par la tempête bloquent votre chemin.")
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL CLIMBABLE-CLIFF RIVER RAINBOW)
      (ACTION CANYON-VIEW-F)>

<ROUTINE CANYON-VIEW-F (RARG)
	 <COND (<AND <==? .RARG ,M-BEG>
		     <VERB? LEAP>
		     <NOT ,PRSO>>
		<JIGS-UP "Jolie vue, mais très mauvais endroit pour sauter.">
		<RTRUE>)>>
	       

\

"SOUS-TITRE MINE DE CHARBON ZONE"

<ROOM MINE-ENTRANCE	;"was ENTRA"
      (IN ROOMS)
      (LDESC

"Vous vous tenez à l'entrée de ce qui fut peut-être une mine de charbon. Le puits s'enfonce dans le mur ouest ; une autre sortie se trouve au sud.")
      (DESC "Entrée de la mine")
      (SOUTH TO SLIDE-ROOM)
      (IN TO SQUEEKY-ROOM)
      (WEST TO SQUEEKY-ROOM)
      (FLAGS RLANDBIT)>

<ROOM SQUEEKY-ROOM	;"was SQUEE"
      (IN ROOMS)
      (LDESC
"Vous êtes dans une petite salle. D'étranges grincements proviennent du passage au nord. Vous pouvez également sortir par l'est.")
      (DESC "Salle grinçante")
      (NORTH TO BAT-ROOM)
      (EAST TO MINE-ENTRANCE)
      (FLAGS RLANDBIT)>

<ROOM BAT-ROOM	;"was BATS"
      (IN ROOMS)
      (DESC "Salle des chauves-souris")
      (SOUTH TO SQUEEKY-ROOM)
      (EAST TO SHAFT-ROOM)
      (ACTION BATS-ROOM)
      (FLAGS RLANDBIT SACREDBIT)>

<ROOM SHAFT-ROOM	;"was TSHAF"
      (IN ROOMS)
      (LDESC
"C'est une vaste salle. En son centre, un puits étroit s'enfonce à travers le sol dans les ténèbres. Des sorties mènent à l'ouest et au nord. Au-dessus du puits se dresse une armature métallique à laquelle est fixée une lourde chaîne de fer.")
      (DESC "Salle du puits")
      (DOWN "Vous ne pourriez pas y passer ; même si vous le pouviez, vous mourriez.")
      (WEST TO BAT-ROOM)
      (NORTH TO SMELLY-ROOM)
      (FLAGS RLANDBIT)
      (PSEUDO "CHAIN" CHAIN-PSEUDO)>

<ROOM SMELLY-ROOM	;"was SMELL"
      (IN ROOMS)
      (LDESC
"C'est une petite pièce quelconque. Une odeur pestilentielle monte toutefois d'un petit escalier descendant. Un étroit tunnel mène au sud.")
      (DESC "Salle malodorante")
      (DOWN TO GAS-ROOM)
      (SOUTH TO SHAFT-ROOM)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)
      (PSEUDO "ODOR" GAS-PSEUDO "GAS" GAS-PSEUDO)>

<ROOM GAS-ROOM	;"was BOOM"
      (IN ROOMS)
      (LDESC
"Cette petite salle empeste le grisou. Quelques marches permettent de monter ; un étroit tunnel mène à l'est.")
      (DESC "Salle du gaz")
      (UP TO SMELLY-ROOM)
      (EAST TO MINE-1)
      (ACTION BOOM-ROOM)
      (FLAGS RLANDBIT SACREDBIT)
      (GLOBAL STAIRS)
      (PSEUDO "GAS" GAS-PSEUDO "ODOR" GAS-PSEUDO)>

<ROOM LADDER-TOP	;"was TLADD"
      (IN ROOMS)
      (LDESC
"C'est une minuscule pièce. Dans un coin, une échelle de bois branlante descend vers le niveau inférieur. Elle devrait pouvoir supporter votre poids. Un escalier monte également d'ici.")
      (DESC "Haut de l'échelle")
      (DOWN TO LADDER-BOTTOM)
      (UP TO MINE-4)
      (FLAGS RLANDBIT)
      (GLOBAL LADDER STAIRS)>

<ROOM LADDER-BOTTOM	;"was BLADD"
      (IN ROOMS)
      (LDESC
"C'est une salle assez large. D'un côté se trouve le pied d'une étroite échelle en bois. Des passages quittent la pièce vers l'ouest et le sud.")
      (DESC "Bas de l'échelle")
      (SOUTH TO DEAD-END-5)
      (WEST TO TIMBER-ROOM)
      (UP TO LADDER-TOP)
      (FLAGS RLANDBIT)
      (GLOBAL LADDER)>

<ROOM DEAD-END-5	;"was DEAD7"
      (IN ROOMS)
      (DESC "Impasse")
      (LDESC "Vous êtes arrivé dans une impasse dans la mine.")
      (NORTH TO LADDER-BOTTOM)
      (FLAGS RLANDBIT)>

<ROOM TIMBER-ROOM	;"was TIMBE"
      (IN ROOMS)
      (LDESC
"Ce long passage étroit est encombré de poutres brisées. Un large couloir arrive de l'est puis, à l'extrémité ouest, tourne pour se rétrécir fortement. Un puissant courant d'air vient de l'ouest.")
      (DESC "Salle des poutres")
      (EAST TO LADDER-BOTTOM)
      (WEST TO LOWER-SHAFT
       IF EMPTY-HANDED
       ELSE "Vous ne pouvez pas passer par ce passage avec cette charge.")
      (ACTION NO-OBJS)
      (FLAGS RLANDBIT SACREDBIT)>

<ROOM LOWER-SHAFT	;"was BSHAF"
      (IN ROOMS)
      (LDESC
"C'est une petite salle balayée par les courants d'air, au fond d'un long puits. Un passage mène au sud et un autre, très étroit, à l'est. Une lourde chaîne de fer est visible dans le puits.")
      (DESC "Salle des courants d'air")
      (SOUTH TO MACHINE-ROOM)
      (OUT TO TIMBER-ROOM
       IF EMPTY-HANDED
       ELSE "Vous ne pouvez pas passer par ce passage avec cette charge.")
      (EAST TO TIMBER-ROOM
       IF EMPTY-HANDED
       ELSE "Vous ne pouvez pas passer par ce passage avec cette charge.")
      (ACTION NO-OBJS)
      (FLAGS RLANDBIT SACREDBIT)
      (PSEUDO "CHAIN" CHAIN-PSEUDO)>

<ROOM MACHINE-ROOM	;"was MACHI"
      (IN ROOMS)
      (DESC "Salle des machines")
      (NORTH TO LOWER-SHAFT)
      (ACTION MACHINE-ROOM-FCN)
      (FLAGS RLANDBIT)>

\

"SOUS-TITRE CHARBON MINE"

<ROOM MINE-1	;"was MINE1"
      (IN ROOMS)
      (LDESC "Vous êtes dans une partie sans caractère particulier d'une mine de charbon.")
      (DESC "Mine de charbon")
      (NORTH TO GAS-ROOM)
      (EAST TO MINE-1)
      (NE TO MINE-2)
      (FLAGS RLANDBIT)>

<ROOM MINE-2	;"was MINE2"
      (IN ROOMS)
      (LDESC "Vous êtes dans une partie sans caractère particulier d'une mine de charbon.")
      (DESC "Mine de charbon")
      (NORTH TO MINE-2)
      (SOUTH TO MINE-1)
      (SE TO MINE-3)
      (FLAGS RLANDBIT)>

<ROOM MINE-3	;"was MINE3"
      (IN ROOMS)
      (LDESC "Vous êtes dans une partie sans caractère particulier d'une mine de charbon.")
      (DESC "Mine de charbon")
      (SOUTH TO MINE-3)
      (SW TO MINE-4)
      (EAST TO MINE-2)
      (FLAGS RLANDBIT)>

<ROOM MINE-4	;"was MINE4"
      (IN ROOMS)
      (LDESC "Vous êtes dans une partie sans caractère particulier d'une mine de charbon.")
      (DESC "Mine de charbon")
      (NORTH TO MINE-3)
      (WEST TO MINE-4)
      (DOWN TO LADDER-TOP)
      (FLAGS RLANDBIT)>

<ROOM SLIDE-ROOM	;"was SLIDE"
      (IN ROOMS)
      (LDESC
"Cette petite chambre semble avoir fait partie d'une mine de charbon. Sur son mur sud, les mots « Mur de granit » sont gravés dans la roche. Un long passage mène à l'est ; une glissière métallique très inclinée s'enroule vers le bas. Une petite ouverture se trouve au nord.")
      (DESC "Salle de la glissière")
      (EAST TO COLD-PASSAGE)
      (NORTH TO MINE-ENTRANCE)
      (DOWN TO CELLAR)
      (FLAGS RLANDBIT)
      (GLOBAL SLIDE)>

\

;"RANDOM TABLES FOR WALK-AROUND"

<GLOBAL HOUSE-AROUND
  <LTABLE (PURE) WEST-OF-HOUSE NORTH-OF-HOUSE EAST-OF-HOUSE SOUTH-OF-HOUSE
	  WEST-OF-HOUSE>>

<GLOBAL FOREST-AROUND
  <LTABLE (PURE) FOREST-1 FOREST-2 FOREST-3 PATH CLEARING FOREST-1>>

<GLOBAL IN-HOUSE-AROUND
  <LTABLE (PURE) LIVING-ROOM KITCHEN ATTIC KITCHEN>>

<GLOBAL ABOVE-GROUND
  <LTABLE (PURE) WEST-OF-HOUSE NORTH-OF-HOUSE EAST-OF-HOUSE SOUTH-OF-HOUSE
	  FOREST-1 FOREST-2 FOREST-3 PATH CLEARING GRATING-CLEARING
	  CANYON-VIEW>>

;"The GO routine must live here."

<ROUTINE GO ()
	<ENABLE <QUEUE I-FIGHT -1>>
	<QUEUE I-SWORD -1>
	<ENABLE <QUEUE I-THIEF -1>>
	<QUEUE I-CANDLES 40>
	<QUEUE I-LANTERN 200>
	<PUTP ,INFLATED-BOAT ,P?VTYPE ,NONLANDBIT>
	<PUT ,DEF1-RES 1 <REST ,DEF1 2>>
	<PUT ,DEF1-RES 2 <REST ,DEF1 4>>
	<PUT ,DEF2-RES 2 <REST ,DEF2B 2>>
	<PUT ,DEF2-RES 3 <REST ,DEF2B 4>>
	<PUT ,DEF3-RES 1 <REST ,DEF3A 2>>
	<PUT ,DEF3-RES 3 <REST ,DEF3B 2>>
	<SETG HERE ,WEST-OF-HOUSE>
	<THIS-IS-IT ,MAILBOX>
	<COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
	       <V-VERSION>
	       <CRLF>)>
	<SETG LIT T>
	<SETG WINNER ,ADVENTURER>
	<SETG PLAYER ,WINNER>
	<MOVE ,WINNER ,HERE>
	<V-LOOK>
	<MAIN-LOOP>
	<AGAIN>>