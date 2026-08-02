"1DUNGEON pour Zork I: Le Grand Empire Souterrain (c) Copyright 1983 Infocom, Inc. Tous droits réservés."

<DIRECTIONS NORTH EAST WEST SOUTH NE NW SE SW UP DOWN IN OUT LAND>

<GLOBAL SCORE-MAX 350>

<GLOBAL FALSE-FLAG <>>

"OBJETS DE SOUS-TITRE"

<OBJECT BOARD
	(IN LOCAL-GLOBALS)
	(SYNONYM BOARDS BOARD)
	(DESC "carte")
	(FLAGS NDESCBIT)
	(ACTION BOARD-F)>

<OBJECT TEETH
	(IN GLOBAL-OBJECTS)
	(SYNONYM OVERBOARD TEETH)
	(DESC "jeu de dents")
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
	(DESC "granit mural")
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
	(DESC "blanc maison")
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
	(DESC "montagne plage")
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
	(DESC "quantité d'eau")
	(FLAGS TRYTAKEBIT TAKEBIT DRINKBIT)
	(ACTION WATER-F)
	(SIZE 4)>

<OBJECT	KITCHEN-WINDOW
	(IN LOCAL-GLOBALS)
	(SYNONYM WINDOW)
	(ADJECTIVE KITCHEN SMALL)
	(DESC "cuisine fenêtre")
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
	(DESC "nombre de fantômes")
	(FLAGS ACTORBIT NDESCBIT)
	(ACTION GHOSTS-F)>

<OBJECT SKULL
	(IN LAND-OF-LIVING-DEAD)
	(SYNONYM SKULL HEAD TREASURE)
	(ADJECTIVE CRYSTAL)
	(DESC "cristal crâne")
	(FDESC
"Allonger dans un coin de la pièce est un crâne de cristal magnifiquement sculpté. Il semble être sourire à vous plutôt nastily.")
	(FLAGS TAKEBIT)
	(VALUE 10)
	(TVALUE 10)>

<OBJECT LOWERED-BASKET
	(IN LOWER-SHAFT)
	(SYNONYM CAGE DUMBWAITER BASKET)
	(ADJECTIVE LOWERED)
	(LDESC "A la chaîne est suspendu un panier.")
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
	(DESC "laiton chaud rouge cloche")
	(FLAGS TRYTAKEBIT)
	(ACTION HOT-BELL-F)
	(LDESC "Au sol se trouve une cloche rougeoyante.")>

<OBJECT AXE
	(IN TROLL)
	(SYNONYM AXE AX)
	(ADJECTIVE BLOODY)
	(DESC "hache sanglante")
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
"Commandement #12592| | Oh, vous qui allez dire à chacun: \"Salut marin\":| Connaissez-vous l'ampleur de votre péché devant les dieux?| Oui, en vérité, vous serez terre entre deux pierres.| Les dieux en colère jetteront-ils votre corps dans le tourbillon?| Certainement, votre œil sera mis dehors avec un bâton tranchant!| Jusqu'aux extrémités de la terre vous errerez et| Vous serez enfin envoyés au pays des morts.| Vous vous repentirez certainement de votre ruse." )>

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
"Un sceptre, peut-être celui de l'Égypte antique elle-même, se trouve dans le cercueil. Le sceptre est orné d'émail coloré, et touche à un point aigu.")
	(SIZE 3)
	(VALUE 4)
	(TVALUE 6)>

<OBJECT TIMBERS
	(IN TIMBER-ROOM)
	(SYNONYM TIMBERS PILE)
	(ADJECTIVE WOODEN BROKEN)
	(DESC "bois brisé")
	(FLAGS TAKEBIT)
	(SIZE 50)>

<OBJECT	SLIDE
	(IN LOCAL-GLOBALS)
	(SYNONYM CHUTE RAMP SLIDE)
	(ADJECTIVE STEEP METAL TWISTING)
	(DESC "goulotte")
	(FLAGS CLIMBBIT)
	(ACTION SLIDE-FUNCTION)>

<OBJECT KITCHEN-TABLE
	(IN KITCHEN)
	(SYNONYM TABLE)
	(ADJECTIVE KITCHEN)
	(DESC "cuisine table")
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
	(DESC "sac marron")
	(FLAGS TAKEBIT CONTBIT BURNBIT)
	(FDESC
"Sur la table se trouve un sac marron allongé, sentant le chaud poivrons.")
	(CAPACITY 9)
	(SIZE 9)
	(ACTION SANDWICH-BAG-FCN)>

<OBJECT TOOL-CHEST
	(IN MAINTENANCE-ROOM)
	(SYNONYM CHEST CHESTS GROUP TOOLCHESTS)
	(ADJECTIVE TOOL)
	(DESC "groupe de coffres à outils")
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
	(DESC "marron bouton")
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
	(DESC "trophée étui")
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
	(DESC "piège porte")
	(FLAGS DOORBIT NDESCBIT INVISIBLE)
	(ACTION TRAP-DOOR-FCN)>

<OBJECT BOARDED-WINDOW
	(IN LOCAL-GLOBALS)
        (SYNONYM WINDOW)
	(ADJECTIVE BOARDED)
	(DESC "fenêtre à panneaux")
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
	(DESC "pierre porte")
	(FLAGS DOORBIT NDESCBIT OPENBIT)
	(ACTION BARROW-DOOR-FCN)>

<OBJECT BARROW
	(IN STONE-BARROW)
	(SYNONYM BARROW TOMB)
	(ADJECTIVE MASSIVE STONE)
	(DESC "brouette en pierre")
	(FLAGS NDESCBIT)
	(ACTION BARROW-FCN)>

<OBJECT BOTTLE
	(IN KITCHEN-TABLE)
	(SYNONYM BOTTLE CONTAINER)
	(ADJECTIVE CLEAR GLASS)
	(DESC "bouteille en verre")
	(FLAGS TAKEBIT TRANSBIT CONTBIT)
	(ACTION BOTTLE-FUNCTION)
	(FDESC "Une bouteille est posée sur le table.")
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
	(DESC "cercueil en or")
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
	(DESC "un méchant couteau")
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
	(DESC "lanterne grillée")
	(FLAGS TAKEBIT)
	(FDESC "La lanterne inutile de l'aventurier décédé est ici.")
	(SIZE 20)>

<OBJECT BAG-OF-COINS
	(IN MAZE-5)
	(SYNONYM BAG COINS TREASURE)
	(ADJECTIVE OLD LEATHER)
	(DESC "sac en cuir contenant des pièces de monnaie")
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
	(DESC "laiton lanterne")
	(FLAGS TAKEBIT LIGHTBIT)
	(ACTION LANTERN)
	(FDESC "Une lanterne en laiton alimentée par batterie se trouve sur la vitrine du trophée.")
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
"\"WELCOME TO ZORK!| | ZORK est un jeu d'aventure, de danger, et de basse ruse. En elle vous explorerez certains des territoires les plus étonnants jamais vus par les mortels. Aucun ordinateur ne devrait être sans un!\"")
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
	(DESC "boîte d'allumettes")
	(FLAGS READBIT TAKEBIT)
	(ACTION MATCH-FUNCTION)
	(LDESC
"Il y a une boîte d'allumettes dont la couverture dit \"Visit Beautiful FCD#3\" ici.")
	(SIZE 2)
	(TEXT
"|
(Fermer le couvercle avant de frapper)|
|
VOUS aussi pouvez gagner BEAUCOUP D'ARGENT dans le domaine passionnant du PAPER SHUFFLING !|
|
M. Anderson de Muddle, Massachusetts dit : « Avant de suivre ce cours, je
C'était un humble petit fouineur. Maintenant avec ce que j'ai appris à GUE Tech
Je me sens vraiment important et je peux obscurcir et confondre avec les meilleurs. \"|
|
Le Dr Blank a déclaré ceci : « Il y a dix jours à peine, tout ce que je pouvais regarder
j'attendais avec impatience un travail sans issue en tant que médecin. Maintenant j'ai une promesse
l'avenir et faire de très gros zorkmids.\"|
|
GUE Tech ne peut pas promettre ces résultats fantastiques à tout le monde. Mais quand
vous obtenez votre diplôme de GUE Tech, votre avenir sera meilleur." )>

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
	(DESC "peinture")
	(FLAGS TAKEBIT BURNBIT)
	(ACTION PAINTING-FCN)
	(FDESC
"Heureusement, il y a encore une chance pour vous d'être un vandal, car sur le mur lointain est une peinture d'une beauté inégalée.")
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
	(DESC "petit morceau de scories vitreuses")
	(FLAGS TAKEBIT TRYTAKEBIT)
	(ACTION GUNK-FUNCTION)
	(SIZE 10)>

<OBJECT BODIES
	(IN LOCAL-GLOBALS)
	(SYNONYM BODIES BODY REMAINS PILE)
	(ADJECTIVE MANGLED)
	(DESC "tas de cadavres")
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
	(DESC "tas de feuilles plastique")
	(FLAGS TAKEBIT BURNBIT)
	(ACTION IBOAT-FUNCTION)
	(LDESC
"Il y a ici une pile de plastique pliée qui a une petite valve attachée.")
	(SIZE 20)>

<OBJECT BAR
	(IN LOUD-ROOM)
	(SYNONYM BAR PLATINUM TREASURE)
	(ADJECTIVE PLATINUM LARGE)
	(DESC "barre de platine")
	(FLAGS TAKEBIT SACREDBIT)
	(LDESC "Au sol se trouve une grande barre de platine.")
	(SIZE 20)
	(VALUE 10)
	(TVALUE 5)>

<OBJECT POT-OF-GOLD
	(IN END-OF-RAINBOW)
	(SYNONYM POT GOLD TREASURE)
	(ADJECTIVE GOLD)
	(DESC "pot de or")
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
"La prière est inscrite dans un ancien script, rarement utilisé aujourd'hui. Il semble être un philippe contre les petits insectes, l'absence d'esprit, et la cueillette et la chute de petits objets. Le verset final consigne des intrus sur la terre des morts." )>

<OBJECT RAILING
	(IN DOME-ROOM)
	(SYNONYM RAILING RAIL)
	(ADJECTIVE WOODEN)
	(DESC "en bois garde-corps")
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
	(DESC "rouge bouée")
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
	(DESC "saphir incrusté bracelet")
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
	(DESC "squelette clé")
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
	(DESC "en bois échelle")
	(FLAGS NDESCBIT CLIMBBIT)>

<OBJECT SCARAB
	(IN SANDY-CAVE)
	(SYNONYM SCARAB BUG BEETLE TREASURE)
	(ADJECTIVE BEAUTI CARVED JEWELED)
	(DESC "magnifique scarabée bijou")
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
	(DESC "en bois porte")
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
"Au-dessus de la boîte à trophées est suspendue une épée elfique de grande antiquité.")
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
"La carte montre une forêt avec trois clairières. La plus grande clairière contient une maison. Trois chemins quittent la grande clairière. L'un de ces chemins, menant au sud-ouest, est marqué « To Stone Barrow ».")>

<OBJECT BOAT-LABEL
	(IN INFLATED-BOAT)
	(SYNONYM LABEL FINEPRINT PRINT)
	(ADJECTIVE TAN FINE)
	(DESC "étiquette beige")
	(FLAGS READBIT TAKEBIT BURNBIT)
	(SIZE 2)
	(TEXT
"!!!!FROBAZZ MAGIC BOAT COMPANY!!!!| | Bonjour, Sailor!| | Instructions pour l'utilisation:| | Pour entrer dans un plan d'eau, dites \"Launch\".| Pour accéder au rivage, dites \"Land\" ou dans la direction dans laquelle vous voulez manœuvrer le bateau.| | Garantie:| | Ce bateau est garanti contre tous les défauts pour une période de 76 millisecondes à partir de la date d'achat ou jusqu'à la première utilisation, selon le cas.| | Avertissement:| Ce bateau est en plastique fin.| Bonne chance!" )>

<OBJECT THIEF
	(IN ROUND-ROOM)
	(SYNONYM THIEF ROBBER MAN PERSON)
	(ADJECTIVE SHADY SUSPICIOUS SEEDY)
	(DESC "voleur")
	(FLAGS ACTORBIT INVISIBLE CONTBIT OPENBIT TRYTAKEBIT)
	(ACTION ROBBER-FUNCTION)
	(LDESC
"Il y a une personne suspecte, tenant un grand sac, penché contre un mur. Il est armé d'un stiletto mortel.")
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
"\" Barrage de contrôle des inondations #3|
|
Le FCD#3 a été construit en l'an 783 du Grand Empire Souterrain pour
exploitez la puissante rivière Frigid. Ce travail a été soutenu par une subvention de
37 millions de zorkmids de votre tyran local tout-puissant Lord Dimwit
Tête-Plate l'Excessif. Cette structure impressionnante est composée de
370 000 pieds cubes de béton, mesure 256 pieds de hauteur au centre et 193
pieds larges en haut. Le lac créé derrière le barrage a un volume
de 1,7 milliard de pieds cubes, une superficie de 12 millions de pieds carrés et un
ligne côtière de 36 mille pieds.|
|
La construction du FCD#3 a duré 112 jours, depuis le début des travaux jusqu'à
la dédicace. Cela nécessitait une main d'œuvre de 384 esclaves, 34 esclaves
des chauffeurs, 12 ingénieurs, 2 tourterelles et une perdrix dans une poire
arbre. Les travaux ont été dirigés par une équipe de commandement composée de 2345
bureaucrates, 2347 secrétaires (dont au moins deux savaient taper à la machine),
12 256 mélangeurs de papier, 52 469 tampons en caoutchouc, 245 193 formalités administratives
transformateurs et près d'un million d'arbres morts.|
|
Nous allons maintenant souligner quelques-unes des fonctionnalités les plus intéressantes
du FCD#3 pendant que nous vous emmenons faire une visite guidée des installations :|
|
        1) Vous commencez votre visite ici, dans le hall du barrage. Vous remarquerez
sur votre droite que...." )>

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
	(DESC "coffre à bijoux")
	(FLAGS TAKEBIT INVISIBLE)
	(FDESC
"À moitié enfoui dans la boue se trouve un vieux coffre bombé de bijoux.")
	(LDESC "Là Il y a ici une vieille malle remplie de bijoux assortis.")
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
"---> Frobozz Magic Gunk Company <----| Gunk tout-terrain")>

<OBJECT PUTTY
	(IN TUBE)
	(SYNONYM MATERIAL GUNK)
	(ADJECTIVE VISCOUS)
	(DESC "matériau visqueux")
	(FLAGS TAKEBIT TOOLBIT)
	(SIZE 6)
	(ACTION PUTTY-FCN)>

<OBJECT ENGRAVINGS
	(IN ENGRAVINGS-CAVE)
	(SYNONYM WALL ENGRAVINGS INSCRIPTION)
	(ADJECTIVE OLD ANCIENT)
	(DESC "mur avec gravures")
	(FLAGS READBIT SACREDBIT)
	(LDESC "Il y a de vieilles gravures sur les murs ici.")
	(TEXT
"Les gravures ont été incisée dans le rocher vivant du mur de la grotte par une main inconnue. Elles dépeignent, sous forme symbolique, les croyances des anciens Zorkers. habilement entrelacés avec les bas reliefs sont des extraits illustrant les principaux principes religieux de cette époque. Malheureusement, un âge plus tard semble les avoir considérés blasphématoires et tout aussi habilement excisés.")>

<OBJECT OWNERS-MANUAL
	(IN STUDIO)
	(SYNONYM MANUAL PIECE PAPER)
	(ADJECTIVE ZORK OWNERS SMALL)
	(DESC "Manuel du propriétaire ZORK")
	(FLAGS READBIT TAKEBIT)
	(FDESC "Un petit morceau de papier est vaguement fixé à un mur.")
	(TEXT
"Félicitations!| | Vous êtes le propriétaire privilégié de ZORK I: Le Grand Empire Souterrain, un univers autonome et autonome. Si utilisé et entretenu conformément aux pratiques d'exploitation normales pour les petits univers, ZORK fournira de nombreux mois de fonctionnement sans problème.")>

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
	(DESC "blanc falaises")
	(FLAGS NDESCBIT CLIMBBIT)
	(ACTION WCLIF-OBJECT)>

<OBJECT WRENCH
	(IN MAINTENANCE-ROOM)
	(SYNONYM WRENCH TOOL TOOLS)
	(DESC "clé")
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
	(DESC "oiseau nid")
	(FLAGS TAKEBIT BURNBIT CONTBIT OPENBIT SEARCHBIT)
	(FDESC "À côté de vous, sur la branche, se trouve un petit nid d'oiseau.")
	(CAPACITY 20)>

<OBJECT EGG
	(IN NEST)
	(SYNONYM EGG TREASURE)
	(ADJECTIVE BIRDS ENCRUSTED JEWELED)
	(DESC "œuf incrusté de bijoux")
	(FLAGS TAKEBIT CONTBIT SEARCHBIT)
	(ACTION EGG-OBJECT)
	(VALUE 5)
	(TVALUE 5)
	(CAPACITY 6)
	(FDESC
"Dans le nid de l'oiseau est un grand œuf incrusté de bijoux précieux, apparemment récupéré par un oiseau chanteur sans enfant. L'oeuf est couvert d'or fin incrusté, et orné de lapis lazuli et de nacre. Contrairement à la plupart des œufs, celui-ci est articulé et fermé avec un fermoir délicat. L'oeuf semble extrêmement fragile.")>

<OBJECT BROKEN-EGG
	(SYNONYM EGG TREASURE)
	(ADJECTIVE BROKEN BIRDS ENCRUSTED JEWEL)
	(DESC "œuf cassé incrusté de bijoux")
	(FLAGS TAKEBIT CONTBIT OPENBIT)
	(CAPACITY 6)
	(TVALUE 2)
	(LDESC "Il y a ici un œuf quelque peu en ruine.")>

<OBJECT BAUBLE
	(SYNONYM BAUBLE TREASURE)
	(ADJECTIVE BRASS BEAUTI)
	(DESC "magnifique laiton boule")
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
"Il y a un canari d'horloge doré niché dans l'œuf. Il a des yeux rubis et un bec d'argent. Par une fenêtre en cristal au-dessous de son aile gauche, vous pouvez voir des machines complexes à l'intérieur.")>

<OBJECT BROKEN-CANARY
	(IN BROKEN-EGG)
	(SYNONYM CANARY TREASURE)
	(ADJECTIVE BROKEN CLOCKWORK GOLD GOLDEN)
	(DESC "canari mécanique cassé")
	(FLAGS TAKEBIT)
	(ACTION CANARY-OBJECT)
	(TVALUE 1)
	(FDESC
"Il y a un canari d'horloge doré niché dans l'œuf. Il semble avoir eu récemment une mauvaise expérience. Les fixations pour ses yeux comme des bijoux sont vides, et son bec d'argent est fracassé. Par une fenêtre en cristal fissuré sous son aile gauche, vous pouvez voir les restes de machines complexes. Il n'est pas clair quel résultat l'enrouler, comme le ressort principal semble jaillir.")>

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
      (EAST "La porte est barricadée et vous ne pouvez pas l'enlever les planches.")
      (SW TO STONE-BARROW IF WON-FLAG)
      (IN TO STONE-BARROW IF WON-FLAG)
      (ACTION WEST-HOUSE)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL WHITE-HOUSE BOARD FOREST)>

<ROOM STONE-BARROW
      (IN ROOMS)
      (LDESC
"Vous êtes debout devant un front massif de pierre. Dans la face est est est une énorme porte de pierre qui est ouverte. Vous ne pouvez pas voir dans l'obscurité du tombeau.")
      (DESC "Barrow de pierre")
      (NE TO WEST-OF-HOUSE)
      (ACTION STONE-BARROW-FCN)
      (FLAGS RLANDBIT ONBIT SACREDBIT)>

<ROOM NORTH-OF-HOUSE
      (IN ROOMS)
      (LDESC
"Vous êtes face au côté nord d'une maison blanche. Il n'y a pas de porte ici, et toutes les fenêtres sont montées.")
      (DESC "Au nord de la maison")
      (SW TO WEST-OF-HOUSE)
      (SE TO EAST-OF-HOUSE)
      (WEST TO WEST-OF-HOUSE)
      (EAST TO EAST-OF-HOUSE)
      (NORTH TO PATH)
      (SOUTH "Les fenêtres sont toutes barricadées.")
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL BOARDED-WINDOW BOARD WHITE-HOUSE FOREST)>

<ROOM SOUTH-OF-HOUSE
      (IN ROOMS)
      (LDESC
"Vous êtes face au côté sud d'une maison blanche. Il n'y a pas de porte ici, et toutes les fenêtres sont à bord.")
      (DESC "Sud de la maison")
      (WEST TO WEST-OF-HOUSE)
      (EAST TO EAST-OF-HOUSE)
      (NE TO EAST-OF-HOUSE)
      (NW TO WEST-OF-HOUSE)
      (SOUTH TO FOREST-3)
      (NORTH "Les fenêtres sont toutes barricadées.")
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
      (EAST "Les sous-bois raides empêchent de se diriger vers l'est. mouvement.")
      (SOUTH "Des arbres secoués par la tempête bloquent votre chemin.")
      (WEST TO FOREST-1)
      (NW TO SOUTH-OF-HOUSE)
      (ACTION FOREST-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE SONGBIRD WHITE-HOUSE FOREST)>

<ROOM PATH
      (IN ROOMS)
      (LDESC
"Il s'agit d'un sentier qui serpente à travers une forêt faiblement éclairée. Le sentier se dirige vers le nord-sud ici. Un arbre particulièrement grand avec quelques branches basses se dresse au bord du sentier.")
      (DESC "Chemin forestier")
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
      (DESC "Sur un arbre")
      (DOWN TO PATH)
      (UP "Vous ne pouvez escalader aucun plus haut.")
      (ACTION TREE-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE FOREST SONGBIRD WHITE-HOUSE)>

<ROOM GRATING-CLEARING
      (IN ROOMS)
      (DESC "Dégagement")
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
	       (T <TELL "Vous ne pouvez pas aller jusque là. chemin." CR> <RFALSE>)>>

<ROOM CLEARING
      (IN ROOMS)
      (LDESC
"Vous êtes dans une petite clairière dans un sentier forestier bien marqué qui s'étend à l'est et à l'ouest.")
      (DESC "Dégagement")
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
	 "Seul le Père Noël descend cheminées.")
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
      (WEST TO STRANGE-PASSAGE IF MAGIC-FLAG ELSE "La porte est clouée fermé.")
      (DOWN PER TRAP-DOOR-EXIT)
      (ACTION LIVING-ROOM-FCN)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL STAIRS)
      (PSEUDO "CLOUS" NAILS-PSEUDO "CLOUS" NAILS-PSEUDO)>

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
"Il s'agit d'une petite pièce avec des passages à l'est et au sud et un trou d'interdiction menant à l'ouest.")
      (DESC "La salle des trolls")
      (SOUTH TO CELLAR)
      (EAST TO EW-PASSAGE
       IF TROLL-FLAG ELSE "Le troll vous repousse avec un geste.")
      (WEST TO MAZE-1
       IF TROLL-FLAG ELSE "Le troll vous repousse avec un geste.")
      (FLAGS RLANDBIT)
      (ACTION TROLL-ROOM-F)>

<ROOM EAST-OF-CHASM
      (IN ROOMS)
      (LDESC
"Nous sommes sur le bord est d' un chasme, dont le bas ne peut pas être vu. Un passage étroit va au nord, et le chemin que nous sommes continue à l' est.")
      (DESC "Est du gouffre")
      (NORTH TO CELLAR)
      (EAST TO GALLERY)
      (DOWN "Le gouffre mène probablement tout droit à l'enfer régions.")
      (FLAGS RLANDBIT)
      (PSEUDO "CHASM" CHASM-PSEUDO)>

<ROOM GALLERY
      (IN ROOMS)
      (LDESC
"C'est une galerie d'art. La plupart des peintures ont été volées par des vandales avec un goût exceptionnel.")
      (DESC "Galerie")
      (WEST TO EAST-OF-CHASM)
      (NORTH TO STUDIO)
      (FLAGS RLANDBIT ONBIT)>

<ROOM STUDIO
      (IN ROOMS)
      (LDESC
"Cela semble avoir été un studio d'artiste. Les murs et les planchers sont éclaboussés de peintures de 69 couleurs différentes. Étrangement, rien de précieux ne s'accroche ici. A l'extrémité sud de la pièce est une porte ouverte (également couverte de peinture). Une cheminée sombre et étroite conduit d'une cheminée; bien que vous pourriez être en mesure de la monter, il semble peu probable que vous puissiez descendre.")
      (DESC "Studio")
      (SOUTH TO GALLERY)
      (UP PER UP-CHIMNEY-FUNCTION)
      (FLAGS RLANDBIT)
      (GLOBAL CHIMNEY)
      (PSEUDO "DOO R" DOOR-PSEUDO "PEINTURE" PAINT-PSEUDO)>

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
      (DESC "Mort Fin")
      (LDESC "Vous êtes dans une impasse dans le labyrinthe.")
      (SOUTH TO MAZE-4)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-5
      (IN ROOMS)
      (LDESC "Ceci fait partie d'un labyrinthe de petits passages tordus, tout comme. Un squelette, probablement les restes d'un aventurier sans chance, se trouve ici.")
      (DESC "Labyrinthe")
      (EAST TO DEAD-END-2)
      (NORTH TO MAZE-3)
      (SW TO MAZE-6)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM DEAD-END-2
      (IN ROOMS)
      (DESC "Mort Fin")
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
      (DESC "Mort Fin")
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
      (DESC "Mort Fin")
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
      (DESC "Salle du Cyclope")
      (NW TO MAZE-15)
      (EAST TO STRANGE-PASSAGE
       IF MAGIC-FLAG ELSE "Le mur est est en roche solide.")
      (UP TO TREASURE-ROOM IF CYCLOPS-FLAG
        ELSE "Le cyclope ne ressemble pas à il vous laissera passer.")
      (ACTION CYCLOPS-ROOM-FCN)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)>

<ROOM STRANGE-PASSAGE
      (IN ROOMS)
      (LDESC
"C'est un long passage. A l'ouest est une entrée. À l'est il y a une vieille porte en bois, avec une grande ouverture en elle (environ cyclopes de taille).")
      (DESC "Passage étrange")
      (WEST TO CYCLOPS-ROOM)
      (IN TO CYCLOPS-ROOM)
      (EAST TO LIVING-ROOM)
      (FLAGS RLANDBIT)>

<ROOM TREASURE-ROOM
      (IN ROOMS)
      (LDESC
"Il s'agit d'une grande pièce, dont le mur est en granit massif. Un certain nombre de sacs jetés, qui s'écroulent à votre toucher, sont dispersés autour du sol. Il y a une sortie en bas d'un escalier.")
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
      (DESC "Réservoir Sud")
      (SE TO DEEP-CANYON)
      (SW TO CHASM-ROOM)
      (EAST TO DAM-ROOM)
      (WEST TO STREAM-VIEW)
      (NORTH TO RESERVOIR
       IF LOW-TIDE ELSE "Vous auriez se noyer.")
      (ACTION RESERVOIR-SOUTH-FCN)
      (FLAGS RLANDBIT)
      (GLOBAL GLOBAL-WATER)
      (PSEUDO "LAC" LAKE-PSEUDO "CHASM" CHASM-PSEUDO)>

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
      (PSEUDO "RUISSEAU" STREAM-PSEUDO)
      (GLOBAL GLOBAL-WATER)>

<ROOM RESERVOIR-NORTH
      (IN ROOMS)
      (DESC "Réservoir Nord")
      (NORTH TO ATLANTIS-ROOM)
      (SOUTH TO RESERVOIR
       IF LOW-TIDE ELSE "Vous auriez se noyer.")
      (ACTION RESERVOIR-NORTH-FCN)
      (FLAGS RLANDBIT)
      (GLOBAL GLOBAL-WATER STAIRS)
      (PSEUDO "LAC" LAKE-PSEUDO)>

<ROOM STREAM-VIEW
      (IN ROOMS)
      (LDESC
"Vous êtes debout sur un sentier à côté d'un ruisseau qui coule doucement. Le sentier suit le ruisseau, qui coule d'ouest en est.")
      (DESC "Vue du ruisseau")
      (EAST TO RESERVOIR-SOUTH)
      (WEST "Le ruisseau émerge d'un endroit trop petit pour que vous puissiez y entrer.")
      (FLAGS RLANDBIT)
      (GLOBAL GLOBAL-WATER)
      (PSEUDO "RUISSEAU" STREAM-PSEUDO)>

<ROOM IN-STREAM
      (IN ROOMS)
      (LDESC
"Vous êtes sur le ruisseau qui coule doucement. La route en amont est trop étroite pour naviguer, et la route en aval est invisible en raison de murs tordus. Il ya une plage étroite pour atterrir sur.")
      (DESC "Ruisseau")
      (UP "Le canal est trop étroit.")
      (WEST "Le canal est trop étroit.")
      (LAND TO STREAM-VIEW)
      (DOWN TO RESERVOIR)
      (EAST TO RESERVOIR)
      (FLAGS NONLANDBIT )
      (GLOBAL GLOBAL-WATER)
      (PSEUDO "RUISSEAU" STREAM-PSEUDO)>

\

"SOUS-TITRE CHAMBRES MIROIR ET ENVIRONS"

<ROOM MIRROR-ROOM-1
      (IN ROOMS)
      (DESC "Salle miroir")
      (NORTH TO COLD-PASSAGE)
      (WEST TO TWISTING-PASSAGE)
      (EAST TO SMALL-CAVE)
      (ACTION MIRROR-ROOM)
      (FLAGS RLANDBIT)>

<ROOM MIRROR-ROOM-2
      (IN ROOMS)
      (DESC "Salle miroir")
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
"C'est un long et étroit couloir où un long passage nord-sud rétrécit brièvement encore plus.")
      (DESC "Passage étroit")
      (NORTH TO ROUND-ROOM)
      (SOUTH TO MIRROR-ROOM-2)
      (FLAGS RLANDBIT)>

<ROOM WINDING-PASSAGE
      (IN ROOMS)
      (LDESC
"Il semble qu'il n'y ait que des sorties à l'est et au nord.")
      (DESC "Passage sinueux")
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
"Il s'agit d'une pièce ancienne, longue sous l'eau. Il y a une sortie vers le sud et un escalier menant vers le haut.")
      (DESC "Salle Atlantis")
      (UP TO SMALL-CAVE)
      (SOUTH TO RESERVOIR-NORTH)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)>

\

"SOUS-TITRE CHAMBRE RONDE ET ENVIRONS"

<ROOM EW-PASSAGE
      (IN ROOMS)
      (LDESC
"Il s'agit d'un étroit passage est-ouest. Il y a un étroit escalier qui descend à l'extrémité nord de la pièce.")
      (DESC "Passage Est-Ouest")
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
"Il s'agit d'une salle circulaire en pierre avec des passages dans toutes les directions. Plusieurs d'entre eux ont malheureusement été bloqués par des grottes.")
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
"Cette grotte a des sorties à l'ouest et à l'est, et se rétrécit à une fissure vers le sud. La terre est particulièrement humide ici.")
      (DESC "Grotte humide")
      (WEST TO LOUD-ROOM)
      (EAST TO WHITE-CLIFFS-NORTH)
      (SOUTH "Elle est trop étroite pour la plupart des insectes.")
      (FLAGS RLANDBIT)
      (GLOBAL CRACK)>

<ROOM LOUD-ROOM
      (IN ROOMS)
      (DESC "Fort Salle")
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
"Un chasme court du sud-ouest au nord-est et le sentier le suit. Nous sommes du côté sud du chasme, où une fissure s'ouvre dans un passage.")
      (DESC "Gouffre")
      (NE TO RESERVOIR-SOUTH)
      (SW TO EW-PASSAGE)
      (UP TO EW-PASSAGE)
      (SOUTH TO NS-PASSAGE)
      (DOWN "Êtes-vous hors de votre esprit ?")
      (FLAGS RLANDBIT)
      (GLOBAL CRACK STAIRS)
      (PSEUDO "CHASM" CHASM-PSEUDO)>

\

"SOUS-TITRE HADES ET AL"

<ROOM ENTRANCE-TO-HADES
      (IN ROOMS)
      (DESC "Entrée d'Hadès")
      (UP TO TINY-CAVE)
      (IN TO LAND-OF-LIVING-DEAD IF LLD-FLAG
       ELSE "Une force invisible vous empêche de passer par le porte.")
      (SOUTH TO LAND-OF-LIVING-DEAD IF LLD-FLAG
       ELSE "Une force invisible vous empêche de passer par le porte.")
      (ACTION LLD-ROOM)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL BODIES)
      (PSEUDO "PORTE" GATE-PSEUDO "PORTES" GATE-PSEUDO)>

<ROOM LAND-OF-LIVING-DEAD
      (IN ROOMS)
      (LDESC
"Vous êtes entrés dans la Terre des morts vivants. Des milliers d'âmes perdues peuvent être entendues pleurer et gémir. Dans le coin sont empilés les restes de dizaines d'aventuriers précédents moins chanceux que vous. Un passage sort au nord.")
      (DESC "Terre des Morts")
      (OUT TO ENTRANCE-TO-HADES)
      (NORTH TO ENTRANCE-TO-HADES)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL BODIES)>

\

"SOUS-TITRE DÔME, TEMPLE, ÉGYPTE"

<ROOM ENGRAVINGS-CAVE	;"was CAVE4"
      (IN ROOMS)
      (LDESC
"Vous êtes entré une grotte basse avec des passages menant au nord-ouest et à l'est.")
      (DESC "Grotte des gravures")
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
      (DESC "Salle du Dôme")
      (WEST TO ENGRAVINGS-CAVE)
      (DOWN TO TORCH-ROOM
       IF DOME-FLAG ELSE "Vous ne pouvez pas descendre sans en fracturer plusieurs os.")
      (ACTION DOME-ROOM-FCN)
      (FLAGS RLANDBIT)
      (PSEUDO "DÔME" DOME-PSEUDO)>

<ROOM TORCH-ROOM
      (IN ROOMS)
      (DESC "Salle de la Torche")
      (UP "Vous ne pouvez pas atteindre le corde.")
      (SOUTH TO NORTH-TEMPLE)
      (DOWN TO NORTH-TEMPLE)
      (ACTION TORCH-ROOM-FCN)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)
      (PSEUDO "DÔME" DOME-PSEUDO)>

<ROOM NORTH-TEMPLE	;"was TEMP1"
      (IN ROOMS)
      (LDESC
"C'est l'extrémité nord d'un grand temple. Sur le mur est est une inscription ancienne, probablement une prière dans une langue longtemps oubliée. Au-dessous de la prière est un escalier menant vers le bas. Le mur ouest est en granit solide. La sortie à l'extrémité nord de la pièce est par d'énormes piliers en marbre.")
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

"C'est l'extrémité sud d'un grand temple. Devant vous se trouve ce qui semble être un autel. Dans un coin se trouve un petit trou dans le sol qui mène à l'obscurité.")
      (DESC "Autel")
      (NORTH TO NORTH-TEMPLE)
      (DOWN TO TINY-CAVE
       IF COFFIN-CURE
       ELSE "Vous n'avez pas une prière pour y amener le cercueil.")
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
"Cette salle semble avoir été la salle d'attente pour les groupes qui visitent le barrage. Il y a des portes ouvertes ici au nord et à l'est marqués \"Privé\", et il y a un sentier menant au sud au-dessus du sommet du barrage.")
      (DESC "Hall du barrage")
      (SOUTH TO DAM-ROOM)
      (NORTH TO MAINTENANCE-ROOM)
      (EAST TO MAINTENANCE-ROOM)
      (FLAGS RLANDBIT ONBIT)>

<ROOM MAINTENANCE-ROOM	;"was MAINT"
      (IN ROOMS)
      (LDESC
"C'est ce qui semble avoir été la salle d'entretien du barrage de contrôle des inondations #3. Apparemment, cette salle a été saccagé récemment, car la plupart de l'équipement précieux est parti. Sur le mur en face de vous est un groupe de boutons colorés bleu, jaune, brun, et rouge. Il ya des portes à l'ouest et au sud.")
      (DESC "Salle de maintenance")
      (SOUTH TO DAM-LOBBY)
      (WEST TO DAM-LOBBY)
      (FLAGS RLANDBIT)>

\

"ZONE DE LA RIVIÈRE SOUS-TITRE"

<ROOM DAM-BASE	;"was DOCK"
      (IN ROOMS)
      (LDESC
"Vous êtes à la base du barrage de contrôle des inondations #3, qui se profile au-dessus de vous et au nord. La rivière Frigid coule ici. Le long de la rivière sont les falaises blanches qui semblent former des murs géants s'étendant du nord au sud le long des rives de la rivière pendant qu'il serpente son chemin en aval.")
      (DESC "Base du barrage")
      (NORTH TO DAM-ROOM)
      (UP TO DAM-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM RIVER-1	;"was RIVR1"
      (IN ROOMS)
      (LDESC
"Vous êtes sur la rivière Frigid à proximité du barrage. La rivière coule tranquillement ici. Il y a un débarquement sur la rive ouest.")
      (DESC "Rivière glaciale")
      (UP "Vous ne pouvez pas remonter en amont en raison de forts courants.")
      (WEST TO DAM-BASE)
      (LAND TO DAM-BASE)
      (DOWN TO RIVER-2)
      (EAST "Les falaises blanches empêchent votre débarquement. ici.")
      (FLAGS NONLANDBIT SACREDBIT ONBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM RIVER-2	;"was RIVR2"
      (IN ROOMS)
      (LDESC
"La rivière tourne un coin ici ce qui rend impossible de voir le barrage. Les falaises blanches sur la rive est et de grands rochers empêchent l'atterrissage sur l'ouest.")
      (DESC "Rivière glaciale")
      (UP "Vous ne pouvez pas remonter en amont en raison de forts courants.")
      (DOWN TO RIVER-3)
      (LAND "Il n'y a pas de point d'atterrissage sûr ici.")
      (EAST "Les falaises blanches empêchent votre débarquement. ici.")
      (WEST "Juste à temps, vous vous éloignez des rochers.")
      (FLAGS NONLANDBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM RIVER-3	;"was RIVR3"
      (IN ROOMS)
      (LDESC
"La rivière descend ici dans une vallée. Il y a une plage étroite sur la rive ouest sous les falaises. Au loin un léger grondement peut être entendu.")
      (DESC "Rivière glaciale")
      (UP "Vous ne pouvez pas remonter en amont en raison de forts courants.")
      (DOWN TO RIVER-4)
      (LAND TO WHITE-CLIFFS-NORTH)
      (WEST TO WHITE-CLIFFS-NORTH)
      (FLAGS NONLANDBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM WHITE-CLIFFS-NORTH	;"was WCLF1"
      (IN ROOMS)
      (LDESC
"Vous êtes sur une bande étroite de plage qui longe la base des falaises blanches. Il y a un sentier étroit se dirigeant vers le sud le long des falaises et un passage étroit menant à l'ouest dans les falaises elles-mêmes.")
      (DESC "Plage de White Cliffs")
      (SOUTH TO WHITE-CLIFFS-SOUTH IF DEFLATE ELSE "Le chemin est trop étroit.")
      (WEST TO DAMP-CAVE IF DEFLATE ELSE "Le chemin est trop étroit.")
      (ACTION WHITE-CLIFFS-FUNCTION)
      (FLAGS RLANDBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER WHITE-CLIFF RIVER)>

<ROOM WHITE-CLIFFS-SOUTH	;"was WCLF2"
      (IN ROOMS)
      (LDESC
"Vous êtes sur une plage rocheuse et étroite à côté des Cliffs. Un sentier étroit mène au nord le long du rivage.")
      (DESC "Plage de White Cliffs")
      (NORTH TO WHITE-CLIFFS-NORTH
       IF DEFLATE ELSE "Le chemin est trop étroit.")
      (ACTION WHITE-CLIFFS-FUNCTION)
      (FLAGS RLANDBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER WHITE-CLIFF RIVER)>

<ROOM RIVER-4	;"was RIVR4"
      (IN ROOMS)
      (LDESC
"Sur la rive est est est une plage de sable. Une petite zone de plage peut également être vue sous les falaises sur la rive ouest.")
      (DESC "Rivière glaciale")
      (UP "Vous ne pouvez pas remonter en amont en raison de forts courants.")
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
"Sur la rive est est est une grande zone d'atterrissage.")
      (DESC "Rivière glaciale")
      (UP "Vous ne pouvez pas remonter en amont en raison de forts courants.")
      (EAST TO SHORE)
      (LAND TO SHORE)
      (FLAGS NONLANDBIT SACREDBIT ONBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM SHORE	;"was FANTE"
      (IN ROOMS)
      (LDESC
"Vous êtes sur la rive est de la rivière. L'eau ici semble un peu perfide. Un sentier se déplace du nord au sud ici, l'extrémité sud tourne rapidement autour d'un angle tranchant.")
      (DESC "Rive")
      (NORTH TO SANDY-BEACH)
      (SOUTH TO ARAGAIN-FALLS)
      (FLAGS RLANDBIT SACREDBIT ONBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM SANDY-BEACH	;"was BEACH"
      (IN ROOMS)
      (LDESC

"Vous êtes sur une grande plage de sable sur la rive est de la rivière, qui coule rapidement. Un sentier longe la rivière au sud ici, et un passage est partiellement enterré dans le sable au nord-est.")
      (DESC "Plage de sable")
      (NE TO SANDY-CAVE)
      (SOUTH TO SHORE)
      (FLAGS RLANDBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM SANDY-CAVE	;"was TCAVE"
      (IN ROOMS)
      (LDESC
"Il s'agit d'une grotte remplie de sable dont la sortie est au sud-ouest.")
      (DESC "Sandy Grotte")
      (SW TO SANDY-BEACH)
      (FLAGS RLANDBIT)>

<ROOM ARAGAIN-FALLS	;"was FALLS"
      (IN ROOMS)
      (DESC "Aragain Chutes")
      (WEST TO ON-RAINBOW IF RAINBOW-FLAG)
      (DOWN "C'est un long chemin...")
      (NORTH TO SHORE)
      (UP TO ON-RAINBOW IF RAINBOW-FLAG)
      (ACTION FALLS-ROOM)
      (FLAGS RLANDBIT SACREDBIT ONBIT)
      (GLOBAL GLOBAL-WATER RIVER RAINBOW)>

<ROOM ON-RAINBOW	;"was RAINB"
      (IN ROOMS)
      (LDESC
"Vous êtes au sommet d'un arc-en-ciel (je parie que vous ne pensiez jamais marcher sur un arc-en-ciel), avec une vue magnifique sur les chutes.")
      (DESC "Sur l'Arc-en-ciel")
      (WEST TO END-OF-RAINBOW)
      (EAST TO ARAGAIN-FALLS)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL RAINBOW)>

<ROOM END-OF-RAINBOW	;"was POG"
      (IN ROOMS)
      (LDESC
"Vous êtes sur une petite plage rocheuse sur la suite de la rivière Frigid après les chutes. La plage est étroite en raison de la présence des falaises blanches. Le canyon de la rivière s'ouvre ici et le soleil brille en haut. Un arc-en-ciel traverse les chutes à l'est et un sentier étroit continue au sud-ouest.")
      (DESC "Fin de Rainbow")
      (UP TO ON-RAINBOW IF RAINBOW-FLAG)
      (NE TO ON-RAINBOW IF RAINBOW-FLAG)
      (EAST TO ON-RAINBOW IF RAINBOW-FLAG)
      (SW TO CANYON-BOTTOM)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL GLOBAL-WATER RAINBOW RIVER)>

<ROOM CANYON-BOTTOM	;"was CLBOT"
      (IN ROOMS)
      (LDESC
"Vous êtes sous les murs du canyon de la rivière qui peut être grimpable ici. La partie inférieure du ruissellement de Aragain Falls coule en dessous. Au nord est un sentier étroit.")
      (DESC "Fond du canyon")
      (UP TO CLIFF-MIDDLE)
      (NORTH TO END-OF-RAINBOW)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER CLIMBABLE-CLIFF RIVER)>

<ROOM CLIFF-MIDDLE	;"was CLMID"
      (IN ROOMS)
      (LDESC
"Vous êtes sur un rebord environ à mi-haut du mur du canyon de rivière. Vous pouvez voir d'ici que le courant principal de Aragain Falls tourne le long d'un passage qu'il est impossible pour vous d'entrer.")
      (DESC "Corniche rocheuse")
      (UP TO CANYON-VIEW)
      (DOWN TO CANYON-BOTTOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL CLIMBABLE-CLIFF RIVER)>

<ROOM CANYON-VIEW	;"was CLTOP"
      (IN ROOMS)
      (LDESC
"Vous êtes au sommet du Grand Canyon sur son mur ouest. De là, il y a une vue magnifique du canyon et des parties de la rivière Frigid en amont. De l'autre côté du canyon, les murs des Cliffs blancs rejoignent les puissants remparts des monts Tête-Plate à l'est. Après le canyon en amont au nord, les chutes Aragain peuvent être vues, avec arc-en-ciel. La rivière Frigid s'écoule d'une grande caverne sombre.")
      (DESC "Vue du canyon")
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
		<JIGS-UP "Belle vue, endroit moche pour sauter.">
		<RTRUE>)>>
	       

\

"SOUS-TITRE MINE DE CHARBON ZONE"

<ROOM MINE-ENTRANCE	;"was ENTRA"
      (IN ROOMS)
      (LDESC

"Vous êtes debout à l'entrée de ce qui aurait pu être une mine de charbon. Le puits entre dans le mur ouest, et il y a une autre sortie au sud de la pièce.")
      (DESC "Entrée de la mine")
      (SOUTH TO SLIDE-ROOM)
      (IN TO SQUEEKY-ROOM)
      (WEST TO SQUEEKY-ROOM)
      (FLAGS RLANDBIT)>

<ROOM SQUEEKY-ROOM	;"was SQUEE"
      (IN ROOMS)
      (LDESC
"Vous êtes dans une petite pièce. D'étranges bruits de coulis peuvent être entendus venant du passage à l'extrémité nord.")
      (DESC "Salle qui grince")
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
"Il s'agit d'une grande pièce, au milieu de laquelle se trouve un petit arbre descendant à travers le sol dans l'obscurité en dessous. A l'ouest et au nord sont des sorties de cette pièce. Construit au-dessus du sommet de l'arbre est un cadre métallique auquel est attachée une chaîne de fer lourde.")
      (DESC "Salle de l'arbre")
      (DOWN "Vous ne rentreriez pas et mourriez si vous pourrait.")
      (WEST TO BAT-ROOM)
      (NORTH TO SMELLY-ROOM)
      (FLAGS RLANDBIT)
      (PSEUDO "CHAIN" CHAIN-PSEUDO)>

<ROOM SMELLY-ROOM	;"was SMELL"
      (IN ROOMS)
      (LDESC
"Il s'agit d'une petite pièce non-descriptible. Cependant, depuis la direction d'un petit escalier descendant, on peut détecter une odeur obscène.")
      (DESC "Smelly Pièce")
      (DOWN TO GAS-ROOM)
      (SOUTH TO SHAFT-ROOM)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)
      (PSEUDO "ODEUR" GAS-PSEUDO "GAZ" GAS-PSEUDO)>

<ROOM GAS-ROOM	;"was BOOM"
      (IN ROOMS)
      (LDESC
"Il s'agit d'une petite pièce qui sent fortement le gaz de charbon. Il y a une petite montée sur quelques escaliers et un tunnel étroit menant à l'est.")
      (DESC "Salle à gaz")
      (UP TO SMELLY-ROOM)
      (EAST TO MINE-1)
      (ACTION BOOM-ROOM)
      (FLAGS RLANDBIT SACREDBIT)
      (GLOBAL STAIRS)
      (PSEUDO "GAZ" GAS-PSEUDO "ODEUR" GAS-PSEUDO)>

<ROOM LADDER-TOP	;"was TLADD"
      (IN ROOMS)
      (LDESC
"C'est une très petite pièce. Dans le coin est une échelle en bois ricket, menant vers le bas. Il pourrait être sûr de descendre. Il y a aussi un escalier menant vers le haut.")
      (DESC "Haut de l'échelle")
      (DOWN TO LADDER-BOTTOM)
      (UP TO MINE-4)
      (FLAGS RLANDBIT)
      (GLOBAL LADDER STAIRS)>

<ROOM LADDER-BOTTOM	;"was BLADD"
      (IN ROOMS)
      (LDESC
"C'est une pièce assez large. D'un côté est le fond d'une étroite échelle en bois. À l'ouest et au sud sont des passages qui quittent la pièce.")
      (DESC "Bas de l'échelle")
      (SOUTH TO DEAD-END-5)
      (WEST TO TIMBER-ROOM)
      (UP TO LADDER-TOP)
      (FLAGS RLANDBIT)
      (GLOBAL LADDER)>

<ROOM DEAD-END-5	;"was DEAD7"
      (IN ROOMS)
      (DESC "Mort Fin")
      (LDESC "Vous êtes arrivé dans une impasse dans la mine.")
      (NORTH TO LADDER-BOTTOM)
      (FLAGS RLANDBIT)>

<ROOM TIMBER-ROOM	;"was TIMBE"
      (IN ROOMS)
      (LDESC
"C'est un long et étroit passage, qui est encombré de bois cassés. Un large passage vient de l'est et se transforme à l'extrémité ouest de la pièce en un passage très étroit. De l'ouest vient un fort tirant d'eau.")
      (DESC "Chambre à bois")
      (EAST TO LADDER-BOTTOM)
      (WEST TO LOWER-SHAFT
       IF EMPTY-HANDED
       ELSE "Vous ne pouvez pas passer par ce passage avec cette charge.")
      (ACTION NO-OBJS)
      (FLAGS RLANDBIT SACREDBIT)>

<ROOM LOWER-SHAFT	;"was BSHAF"
      (IN ROOMS)
      (LDESC
"Il s'agit d'une petite salle de tirant d'eau dans laquelle se trouve le fond d'un long puits. Au sud se trouve un passage et à l'est un passage très étroit.")
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
      (LDESC "Il s'agit d'une partie quelconque d'une mine de charbon.")
      (DESC "Mine de charbon")
      (NORTH TO GAS-ROOM)
      (EAST TO MINE-1)
      (NE TO MINE-2)
      (FLAGS RLANDBIT)>

<ROOM MINE-2	;"was MINE2"
      (IN ROOMS)
      (LDESC "Il s'agit d'une partie quelconque d'une mine de charbon.")
      (DESC "Mine de charbon")
      (NORTH TO MINE-2)
      (SOUTH TO MINE-1)
      (SE TO MINE-3)
      (FLAGS RLANDBIT)>

<ROOM MINE-3	;"was MINE3"
      (IN ROOMS)
      (LDESC "Il s'agit d'une partie quelconque d'une mine de charbon.")
      (DESC "Mine de charbon")
      (SOUTH TO MINE-3)
      (SW TO MINE-4)
      (EAST TO MINE-2)
      (FLAGS RLANDBIT)>

<ROOM MINE-4	;"was MINE4"
      (IN ROOMS)
      (LDESC "Il s'agit d'une partie quelconque d'une mine de charbon.")
      (DESC "Mine de charbon")
      (NORTH TO MINE-3)
      (WEST TO MINE-4)
      (DOWN TO LADDER-TOP)
      (FLAGS RLANDBIT)>

<ROOM SLIDE-ROOM	;"was SLIDE"
      (IN ROOMS)
      (LDESC
"Il s'agit d'une petite chambre, qui semble avoir fait partie d'une mine de charbon. Sur le mur sud de la chambre, les lettres \"Granite Wall\" sont gravées dans la roche. À l'est est un long passage, et il y a un glissement en métal raide vers le bas. Au nord est une petite ouverture.")
      (DESC "Salle des diapositives")
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