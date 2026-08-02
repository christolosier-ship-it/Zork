"2DUNGEON pour Zork II: Le Magicien de Frobozz (c) Copyright 1981, 1983 Infocom, Inc. Tous droits réservés."

<DIRECTIONS NORTH EAST WEST SOUTH NE NW SE SW UP DOWN IN OUT LAND CROSS>

<ROUTINE GO () 
	 <PUTB ,P-LEXV 0 59>
;"put interrupts on clock chain"
	 <ENABLE <QUEUE I-WIZARD 4>>
	 <QUEUE I-LANTERN 200>
;"clean up junk compiler can't do"
	 <PUTP ,BALLOON ,P?VTYPE ,NONLANDBIT>
	 <PUTP ,BUCKET ,P?VTYPE ,NONLANDBIT>
	 <PUTP ,SEWL ,P?SIZE ,P?EAST>
	 <PUTP ,SWWL ,P?SIZE ,P?WEST>
	 <PUTP ,SSWL ,P?SIZE ,P?SOUTH>
	 <PUTP ,SNWL ,P?SIZE ,P?NORTH>
;"set up and go"
	 <SETG LIT T>
	 <SETG WINNER ,ADVENTURER>
	 <SETG PLAYER ,ADVENTURER>
	 <SETG HERE ,INSIDE-BARROW>
	 <SETG P-IT-OBJECT <>>
	 <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		<V-VERSION>
		<CRLF>)>
	 <MOVE ,WINNER ,HERE>
	 <V-LOOK>
	 <MAIN-LOOP>
	 <AGAIN>>

"SORTIES CONDITIONNELLES DE SOUS-TITRE"

<GLOBAL SECRET-DOOR <>>
<GLOBAL GNOME-DOOR-FLAG <>>

"SOUS-TITRE GLOBAL OBJECTS"

<OBJECT STREAM
	(IN LOCAL-GLOBALS)
	(SYNONYM STREAM)
	(ADJECTIVE FLOWING SMALL)
	(DESC "courant")
	(ACTION STREAM-FCN)
	(FLAGS NDESCBIT)>

<OBJECT CHASM
	(IN LOCAL-GLOBALS)
	(SYNONYM CHASM RAVINE)
	(ADJECTIVE DEEP)
	(DESC "gouffre")
	(ACTION CHASM-FCN)
	(FLAGS NDESCBIT)>

<OBJECT MOSS
	(IN LOCAL-GLOBALS)
	(SYNONYM MOSS MOSSES)
	(ADJECTIVE GLOWING PHOSPHORESCENT)
	(DESC "mousses")
	(ACTION MOSS-FCN)
	(FLAGS NDESCBIT TRYTAKEBIT)>

<OBJECT ROSE-BUSH
	(IN LOCAL-GLOBALS)
	(SYNONYM ROSES BUSH ARBOR)
	(ADJECTIVE ROSE)
	(DESC "roses")
	(ACTION ROSE-BUSH-FCN)
	(FLAGS NDESCBIT TRYTAKEBIT)>

<OBJECT BRIDGE
	(IN LOCAL-GLOBALS)
	(SYNONYM BRIDGE)
	(ADJECTIVE STONE WOODEN RICKETY)
	(DESC "pont")
	(ACTION BRIDGE-FCN)
	(FLAGS NDESCBIT)>

<OBJECT TUNNEL
	(IN GLOBAL-OBJECTS)
	(SYNONYM PASSAGE TUNNEL CRAWLWAY)
        (ADJECTIVE DARK SMOKY)
	(DESC "tunnel")
	(FLAGS NDESCBIT)
	(ACTION TUNNEL-OBJECT)>

<OBJECT EAST-WALL
	(IN GLOBAL-OBJECTS)
	(SYNONYM WALL)
	(ADJECTIVE EAST EASTERN)
	(DESC "mur est")
	(FLAGS NDESCBIT)>

<OBJECT SOUTH-WALL
	(IN GLOBAL-OBJECTS)
	(SYNONYM WALL)
	(ADJECTIVE SOUTH SOUTHE) ;"only 6 chars count and southeast exists"
	(DESC "mur sud")
	(FLAGS NDESCBIT)>

<OBJECT WEST-WALL
	(IN GLOBAL-OBJECTS)
	(SYNONYM WALL)
	(ADJECTIVE WEST WESTERN)
	(DESC "ouest mur")
	(FLAGS NDESCBIT)>

<OBJECT NORTH-WALL
	(IN GLOBAL-OBJECTS)
	(SYNONYM WALL)
	(ADJECTIVE NORTH NORTHE)	;"only six chars used..."
	(DESC "mur nord")
	(FLAGS NDESCBIT)>

<OBJECT GLOBAL-WATER
	(IN LOCAL-GLOBALS)
	(SYNONYM WATER QUANTITY)
	(DESC "eau")
	(FLAGS DRINKBIT)
	(ACTION WATER-FCN)>

<OBJECT WISH
	(IN GLOBAL-OBJECTS)
	(SYNONYM WISH BLESS)
	(DESC "souhait")
	(FLAGS NDESCBIT)
	(ACTION WISH-FCN)>

<OBJECT WELL
        (IN LOCAL-GLOBALS)
	(SYNONYM WELL)
	(ADJECTIVE MAGIC)
	(DESC "bien")
	(FLAGS NDESCBIT)
	(ACTION WELL-FCN)>

<OBJECT SEWL		
        (IN LOCAL-GLOBALS)
	(SYNONYM WALL)
	(ADJECTIVE EAST EASTERN)
	(DESC "mur est")
	(FLAGS NDESCBIT)
	(SIZE 0) ;",P?EAST"
	(ACTION SCOLWALL)>

<OBJECT SWWL
        (IN LOCAL-GLOBALS)
	(SYNONYM WALL)
	(ADJECTIVE WEST WESTERN)
	(DESC "ouest mur")
	(FLAGS NDESCBIT)
	(SIZE 0) ;"P?WEST"
	(ACTION SCOLWALL)>

<OBJECT SSWL
        (IN LOCAL-GLOBALS)
	(SYNONYM WALL)
	(ADJECTIVE SOUTH SOUTHE)
	(DESC "mur sud")
	(FLAGS NDESCBIT)
	(SIZE 0) ;"P?SOUTH"
	(ACTION SCOLWALL)>

<OBJECT SNWL
        (IN LOCAL-GLOBALS)
	(SYNONYM WALL)
	(ADJECTIVE NORTH NORTHE)
	(DESC "mur nord")
	(FLAGS NDESCBIT)
	(SIZE 0) ;"P?NORTH"
	(ACTION SCOLWALL)>

\

"SOUS-TITRE CHAMBRES"

<ROOM INSIDE-BARROW
      (IN ROOMS)
      (LDESC
"Vous êtes dans un ancien tumulus, dissimulé au plus profond d'une forêt sombre. À son extrémité sud, il s'ouvre sur un étroit tunnel. Une faible lueur brille tout au fond.")
      (DESC "À l'intérieur du tumulus")
      (FLAGS RLANDBIT ONBIT)
      (SOUTH TO NARROW-TUNNEL)
      (OUT
"Vous ne vous souvenez peut-être pas, mais quand vous êtes entré, la porte du terrier s'est fermée derrière vous.")>

<ROOM NARROW-TUNNEL
      (IN ROOMS)
      (LDESC
"Vous vous tenez à l'extrémité sud d'un étroit tunnel, à l'endroit où celui-ci débouche dans une vaste caverne. Des mousses phosphorescentes accrochées au plafond élevé diffusent une faible lumière. Un profond ravin serpente à travers la caverne ; un petit ruisseau coule au fond. Ses parois sont abruptes et friables. Une passerelle franchit le ravin vers le sud.")
      (DESC "Tunnel étroit")
      (FLAGS RLANDBIT ONBIT)
      (NORTH TO INSIDE-BARROW)
      (SOUTH TO FOOT-BRIDGE)
      (CROSS TO FOOT-BRIDGE)
      (DOWN "Lorsque vous commencez à descendre, vous glissez sur les rochers qui s'effondrent et reculez, évitant de façon étroite une chute fatale.")
      (GLOBAL BRIDGE CHASM STREAM MOSS)>

<ROOM FOOT-BRIDGE
      (IN ROOMS)
      (LDESC
"Vous êtes debout sur un pont de pied en bois brut mais robuste traversant un ravin profond. Le chemin court au nord et au sud d'ici.")
      (DESC "Pont piétonnier")
      (FLAGS RLANDBIT ONBIT)
      (NORTH TO NARROW-TUNNEL)
      (SOUTH TO GREAT-CAVERN)
      (DOWN "La chute serait fatale.")
      (CROSS "Vous devrez spécifier un direction.")
      (GLOBAL BRIDGE CHASM)>

<ROOM GREAT-CAVERN
      (IN ROOMS)
      (LDESC
"C'est le centre de la grande caverne, taillée dans le calcaire. Les stalagmites et les stalagmites de nombreuses tailles sont partout. La chambre brille avec une faible lumière fournie par la mousse phosphorescente, et les ombres bizarres se déplacent tout autour de vous.")
      (DESC "Excellent Caverne")
      (FLAGS RLANDBIT ONBIT)
      (NE TO FOOT-BRIDGE)
      (SW TO SHALLOW-FORD)
      (GLOBAL MOSS)
      (PSEUDO "STALAGMITE" STALA-PSEUDO "STALACTITE" STALA-PSEUDO)>

<ROOM SHALLOW-FORD
      (IN ROOMS)
      (LDESC
"Vous êtes à la limite sud d'une grande caverne. Au sud à travers un gué peu profond est un tunnel sombre qui semble avoir été une fois agrandi et lissé. Au nord un sentier étroit souffle parmi les stalagmites.")
      (DESC "Gué peu profond")
      (FLAGS RLANDBIT ONBIT)
      (NORTH TO GREAT-CAVERN)
      (SOUTH TO DARK-TUNNEL)
      (CROSS TO DARK-TUNNEL)
      (GLOBAL GLOBAL-WATER)>

<ROOM DARK-TUNNEL
      (IN ROOMS)
      (LDESC
"Il s'agit d'un tunnel sombre avec une faible lumière au nord-est. Le tunnel est lisse mais poussiéreux et rempli de brindilles et de feuilles, débris qui devient plus profond que les branches du tunnel dans un large couloir menant au sud-ouest et un plus étroit menant au sud-est.")
      (DESC "Tunnel sombre")
      (FLAGS RLANDBIT)
      (NE TO SHALLOW-FORD)
      (SE TO GARDEN-NORTH)
      (SW TO STREAM-PATH)>

"JARDIN SOUS-TITRE ZONE"

<OBJECT GLOBAL-UNICORN
	(IN LOCAL-GLOBALS)
	(SYNONYM UNICORN)
	(DESC "licorne")
	(ADJECTIVE BEAUTIFUL WHITE)
	(FLAGS ACTORBIT)
	(ACTION GLOBAL-UNICORN-FCN)>

<OBJECT UNICORN
	(SYNONYM UNICORN ANIMAL)
	(ADJECTIVE BEAUTIFUL WHITE)
	(DESC "licorne")
	(LDESC "Il y a une belle licorne ici qui coupe de l'herbe.")
	(FLAGS ACTORBIT TRYTAKEBIT OPENBIT CONTBIT)
	(ACTION UNICORN-FCN)>

<ROOM GARDEN-NORTH
      (IN ROOMS)
      (LDESC
"C'est l'extrémité nord d'un jardin formel. Les haies cachent les murs des cavernes, et si vous ne regardez pas vers le haut, l'illusion est d'une journée nuageuse dehors. La lumière vient d'une grande croissance de mousses brillantes sur le toit de la grotte. Une rupture dans la haie est presque envahie au nord. Un sentier soigneusement manucuré mène au sud. Au centre d'un lit de rose est une petite structure ouverte, peinte en blanc. Il semble être un gazebo.")
      (DESC "Extrémité nord du jardin")
      (FLAGS RLANDBIT ONBIT)
      (IN TO GAZEBO-ROOM)
      (NORTH TO DARK-TUNNEL)
      (SOUTH TO FORMAL-GARDEN)
      (ACTION GARDEN-ROOM-FCN)
      (GLOBAL GLOBAL-UNICORN GAZEBO MOSS ROSE-BUSH)>

<ROOM GAZEBO-ROOM
      (IN ROOMS)
      (LDESC
"C'est un gazebo au milieu d'un jardin formel. Il est frais et reposant ici. Une table de thé orne le centre du gazebo.")
      (DESC "Gazebo")
      (FLAGS RLANDBIT ONBIT)
      (OUT TO GARDEN-NORTH)
      (GLOBAL GLOBAL-UNICORN GAZEBO)>

<ROOM FORMAL-GARDEN
      (IN ROOMS)
      (LDESC
"C'est la partie centrale d'un jardin formel. Les haies cachent les murs de cavernes et un éclairage faible vient de mousses loin au-dessus. Le sentier est de petites pierres blanches écrasées. Il souffle entre les buissons et les lits de fleurs du sud au nord. Au nord une petite structure peut être vue. Au sud sont des buissons particulièrement façonnés. Il y a un petit trou dans les haies à l'ouest.")
      (DESC "Jardin à la française")
      (FLAGS RLANDBIT ONBIT)
      (WEST TO STREAM-PATH)
      (NORTH TO GARDEN-NORTH)
      (SOUTH TO TOPIARY-ROOM)
      (ACTION GARDEN-ROOM-FCN)
      (GLOBAL GLOBAL-UNICORN MOSS)>

<ROOM TOPIARY-ROOM
      (IN ROOMS)
      (LDESC
"C'est l'extrémité sud d'un jardin formel. Les haies cachent les murs de cavernes et les mousses fournissent une faible illumination. Les haies et les buissons de forme fantastique sont garnis de précision géométrique. Ils n'ont pas été récemment coupés, mais vous pouvez discerner les créatures dans les formes des buissons: Il y a un dragon, une licorne, un grand serpent, un énorme chien mishapen, et plusieurs figures humaines.")
      (DESC "Topiaire")
      (FLAGS RLANDBIT ONBIT)
      (WEST TO CAROUSEL-ROOM)
      (NORTH TO FORMAL-GARDEN)
      (ACTION GARDEN-ROOM-FCN)
      (GLOBAL GLOBAL-UNICORN MOSS ROSE-BUSH)>

<OBJECT HEDGES
	(IN TOPIARY-ROOM)
	(DESC "haie")
	(SYNONYM HEDGE HEDGES)
	(FLAGS NDESCBIT)
	(ACTION HEDGES-F)>

<ROUTINE HEDGES-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"Les haies sont en forme de différents animaux : chiens, serpents, dragons, etc., et elles sont vaguement troublantes à regarder." CR>)>>

<ROOM STREAM-PATH
      (IN ROOMS)
      (LDESC
"Le sentier suit le bord sud d'un ravin profond et se dirige vers le nord-est. Un tunnel se dirige vers le sud-ouest, se rétrécissant à une rampe assez serrée. Un faible bruit tourbillonnant peut être entendu dans cette direction.")
	(DESC "Chemin près du ruisseau")
	(FLAGS RLANDBIT)
	(EAST TO FORMAL-GARDEN)
	(NE TO DARK-TUNNEL)
	(SW TO CAROUSEL-ROOM)
	(WEST TO MARBLE-HALL IF SECRET-DOOR)
	(DOWN "Le ravin est extrêmement profond. Vous n'y parviendrez jamais.")
	(GLOBAL BRIDGE CHASM STREAM)>

<ROOM MARBLE-HALL
      (IN ROOMS)
      (LDESC
"C'est une salle arquée de marbre fin. La salle s'arrête brusquement au nord à un gué en travers d'un ruisseau, où le marbre est fendue et cassé. Peut-être une inondation ou l'effondrement de la grotte était responsable. Au sud, la salle s'ouvre dans une grande pièce. Il y a un bruit assez ennuyeux venant de cette pièce.")
      (DESC "Salle de marbre")
      (FLAGS RLANDBIT)
      (EAST TO STREAM-PATH IF SECRET-DOOR ELSE "C'est un mur là-bas.")
      (NORTH TO DEEP-FORD)
      (SOUTH TO CAROUSEL-ROOM)
      (GLOBAL STREAM)>

<ROOM DEEP-FORD
      (IN ROOMS)
      (LDESC
"Vous enfoncez le ruisseau à un endroit profond mais pas impossible. L'eau est très froide. Les murs du ravin s'élèvent à l'est et à l'ouest. Il y a un petit rebord le long du mur nord du ravin. Au sud se trouve l'entrée d'un hall bien construit mais quelque peu ruiné.")
      (DESC "Gué profond")
      (FLAGS RLANDBIT)
      (NORTH TO RAVINE-LEDGE)
      (UP TO RAVINE-LEDGE)
      (SOUTH TO MARBLE-HALL)
      (EAST
"Le ruisseau s'approfondit rapidement et vous revenez sagement avant noyade.")
      (WEST
"Vous remarquez que le rebord au-dessus serait une route plus sèche vers l'ouest.")
      (GLOBAL GLOBAL-WATER CHASM STREAM)>

<ROOM RAVINE-LEDGE
      (IN ROOMS)
      (LDESC
"Vous êtes sur un corniche étroit près du fond d'un ravin profond. Le corniche continue à l'ouest. Une montée précaire jusqu'à un autre corniche minuscule est possible.")
      (DESC "Rebord dans le ravin")
      (FLAGS RLANDBIT)
      (UP TO TINY-ROOM)
      (SOUTH TO DEEP-FORD)
      (WEST TO LEDGE-TUNNEL)
      (DOWN TO DEEP-FORD)
      (GLOBAL CHASM)>

<ROOM LEDGE-TUNNEL
      (IN ROOMS)
      (LDESC
"Un rebord de l'est se termine ici, et un tunnel mène vers le nord dans le mur. Il y a une odeur de fumée assez étrange dans l'air chaud du tunnel.")
      (DESC "Fin du rebord")
      (FLAGS RLANDBIT)
      (EAST TO RAVINE-LEDGE)
      (IN TO DRAGON-ROOM)
      (NORTH TO DRAGON-ROOM)
      (DOWN "Il y a beaucoup de rochers pointus en bas. là.")>

<ROOM DRAGON-ROOM
      (IN ROOMS)
      (LDESC
"La chambre est une grande caverne pleine de pierre cassée. Les murs sont brûlés et il ya des rayures profondes sur le sol. Une odeur sèche suie est très forte ici. Un chemin pavé souffle d'un grand passage à l'ouest, à travers la chambre, et à travers un énorme pont de pierre au sud. À l'est une petite fissure est visible. Un tunnel sombre et fumant mène au nord.")
      (DESC "Salle du dragon")
      (FLAGS RLANDBIT)
      (EAST TO LEDGE-TUNNEL)
      (NORTH TO DRAGON-LAIR
	IF ICE-MELTED ELSE "Le dragon vous siffle et vous bloque le chemin.")
      (IN TO DRAGON-LAIR
        IF ICE-MELTED ELSE "Le dragon vous siffle et vous bloque le chemin.")
      (WEST TO FRESCO-ROOM)
      (SOUTH TO STONE-BRIDGE)
      (CROSS TO STONE-BRIDGE)
      (GLOBAL BRIDGE)>

<ROOM DRAGON-LAIR
      (IN ROOMS)
      (LDESC
"Vous êtes dans le repaire du dragon, où les parois rocheuses sont marquées par la flamme. Une porte noircie mène au sud.")
      (DESC "Antre du dragon")
      (FLAGS RLANDBIT)
      (SOUTH TO DRAGON-ROOM)
      (OUT TO DRAGON-ROOM)>

<OBJECT CHEST
	(IN DRAGON-LAIR)
	(SYNONYM CHEST TRUNK)
	(ADJECTIVE WOODEN OLD ROTTEN)
	(DESC "coffre en bois pourri")
	(FDESC
"Un vieux coffre en bois pourri se trouve dans un coin. parmi les débris.")
	(FLAGS CONTBIT TAKEBIT)
	(ACTION CHEST-FCN)
	(CAPACITY 40)
	(SIZE 40)>

<OBJECT STATUETTE
	(IN CHEST)
	(SYNONYM TREASURE STATUETTE DRAGON)
	(ADJECTIVE GOLD)
	(DESC "statuette de dragon doré")
	(FDESC
"Nichée dans le coffre se trouve une statuette de dragon en or forgé.")
	(FLAGS STAGGERED TAKEBIT)
	(VALUE 20)>

<OBJECT DRAGON
	(IN DRAGON-ROOM)
	(SYNONYM DRAGON SMAUG WORM)
	(ADJECTIVE RED HUGE)
	(DESC "énorme dragon rouge")
	(LDESC
"Un énorme dragon rouge est allongé ici sur les rochers, observant.")
	(FDESC
"Un énorme dragon rouge est allongé ici, bloquant l'entrée d'un tunnel qui mène au nord.")
	(FLAGS ACTORBIT)
	(ACTION DRAGON-FCN)>

<OBJECT DEAD-DRAGON
	(SYNONYM DRAGON SMAUG WORM)
	(ADJECTIVE RED HUGE DEAD)
	(DESC "énorme dragon mort")
	(LDESC
"Un énorme dragon mort gît à moitié bloquant le ruisseau.")
	(SIZE 400)>

<OBJECT GLOBAL-PRINCESS
	(IN GLOBAL-OBJECTS)
	(SYNONYM PRINCESS WOMAN LADY)
	(ADJECTIVE BEAUTIFUL YOUNG)
	(DESC "magnifique princesse")
	(FLAGS ACTORBIT)
	(ACTION PRINCESS-FCN)>

<OBJECT PRINCESS
	(IN DRAGON-LAIR)
	(SYNONYM PRINCESS WOMAN LADY)
	(ADJECTIVE BEAUTIFUL YOUNG)
	(DESC "magnifique princesse")
	(LDESC
"Une belle jeune femme, vêtue d'une robe sale et draguée, est assise sur un rocher dans le coin. Ses cheveux ne sont pas kidnappés et elle est ignorante de votre présence, presque en transe.")
	(FLAGS ACTORBIT)
	(ACTION PRINCESS-FCN)>

<ROOM FRESCO-ROOM
      (IN ROOMS)
      (LDESC
"Un sentier mène à l'est-ouest à travers une pièce décorée de belles fresques de quelqu'un luttant contre les dragons et le sauvetage de belles filles. Il est difficile de dire qui fait cela comme ces parties des fresques ont été noircies et fissurées par la chaleur intense.")
      (DESC "Salle des fresques")
      (FLAGS RLANDBIT)
      (EAST TO DRAGON-ROOM)
      (WEST TO BANK-ENTRANCE)>

<ROOM STONE-BRIDGE
      (IN ROOMS)
      (LDESC
"C'est le milieu d'un pont de pierre en ruine mais encore impressionnant enjambant un profond fossé. L'eau coule loin en dessous. Un sentier pavé mène au nord dans un grand espace ouvert. Au sud, le sentier mène dans un tunnel brumeux.")
      (DESC "Pont de pierre")
      (FLAGS RLANDBIT)
      (NORTH TO DRAGON-ROOM)
      (SOUTH TO COOL-ROOM)
      (DOWN "C'est un long chemin vers le bas.")
      (CROSS "Vous devrez spécifier un direction.")
      (GLOBAL BRIDGE CHASM)>

<ROOM COOL-ROOM
      (IN ROOMS)
      (LDESC
"La pièce est fraîche et humide. L'air est brumeux. Un sentier tordu du sud-est se sépare ici vers un large pont en pierre du nord, et un tunnel étroit à l'ouest. C'est de ce dernier que la brume et le froid semblent provenir.")
      (DESC "Pièce fraîche")
      (FLAGS RLANDBIT)
      (SE TO CAROUSEL-ROOM)
      (NORTH TO STONE-BRIDGE)
      (WEST TO GLACIER-ROOM)
      (CROSS TO STONE-BRIDGE)
      (GLOBAL BRIDGE)>

<ROOM GLACIER-ROOM
      (IN ROOMS)
      (LDESC " ")
      (DESC "Salle de glace")
      (FLAGS RLANDBIT)
      (EAST TO COOL-ROOM)
      (WEST TO LAVA-ROOM
       IF ICE-MELTED ELSE "Vous n'avez même pas de pic à glace.")
      (UP TO LAVA-TUBE)
      (ACTION GLACIER-ROOM-FCN)>

<ROOM LAVA-TUBE
      (IN ROOMS)
      (LDESC
"Vous êtes dans une cheminée serrée de lave solidifiée. Elle s'étend sur au moins une centaine de pieds et descend jusqu'à une grande pièce bien en dessous. Une grande fissure s'ouvre au sud, probablement le résultat d'un déplacement dans les strates rocheuses.")
      (DESC "Tube de lave")
      (FLAGS RLANDBIT)
      (DOWN TO GLACIER-ROOM)
      (UP TO VOLCANO-VIEW)
      (SOUTH TO COBWEBBY-CORRIDOR)
      (PSEUDO "FISSURE" LT-CRACK-PSEUDO)>

<ROUTINE LT-CRACK-PSEUDO ()
	 <COND (<VERB? BOARD THROUGH>
		<DO-WALK ,P?SOUTH>
		<RTRUE>)
	       (T <CC-CRACK-PSEUDO>)>>

<ROOM COBWEBBY-CORRIDOR
      (IN ROOMS)
      (LDESC
"Un couloir sinueux est rempli de toiles d'eau. Certains sont brisés et la poussière sur le sol est perturbée. La tendance des torsions et des virages est du nord-est au sud-ouest.")
      (DESC "Couloir aux toiles d'araignée")
      (FLAGS RLANDBIT)
      (IN TO LAVA-TUBE)
      (UP TO LAVA-TUBE)
      (NORTH TO LAVA-TUBE)
      (NE TO CAROUSEL-ROOM)
      (SW TO GUARDIAN-ROOM)
      (DOWN TO GUARDIAN-ROOM)
      (PSEUDO "FISSURE" CC-CRACK-PSEUDO)>

<ROUTINE CC-CRACK-PSEUDO ()
	 <COND (<VERB? THROUGH BOARD>
		<DO-WALK ,P?NORTH>
		<RTRUE>)
	       (T
		<TELL
"La fissure est assez large. Vous devriez pouvoir y accéder." CR>)>>

<OBJECT WIZ-DOOR
	(IN LOCAL-GLOBALS)
	(SYNONYM DOOR)
	(ADJECTIVE COBWEBBED WOODEN OAK)
	(DESC "porte partiellement recouverte de toiles d'araignées")
	(FLAGS DOORBIT CONTBIT)
	(ACTION WIZ-DOOR-FCN)>

<ROOM ROOM-8
      (IN ROOMS)
      (LDESC
"C'est une petite chambre taillée dans la roche à la fin d'une courte rampe. Sur le mur est grossièrement ciselé le nombre \"8\".")
      (DESC "Salle 8")
      (FLAGS RLANDBIT)
      (EAST TO CAROUSEL-ROOM)>

<ROOM MENHIR-ROOM
      (IN ROOMS)
      (DESC "Salle des Menhirs")
      (LDESC " ")
      (FLAGS RLANDBIT)
      (NORTH TO CAROUSEL-ROOM)
      (SW TO KENNEL
       IF MENHIR-POSITION
        ELSE "Vous essayez de traverser un énorme rocher.")
      (SOUTH TO STAIRWAY-TOP)
      (ACTION MENHIR-ROOM-FCN)
      (GLOBAL MENHIR)>

<OBJECT GLOBAL-MENHIR
	(IN LOCAL-GLOBALS)
	(SYNONYM MENHIR ROCK STONE)
	(ADJECTIVE HUGE HEAVY ENORMOUS)
	(FLAGS NDESCBIT READBIT)
	(ACTION GLOBAL-MENHIR-F)
	(DESC "énorme menhir")>

<ROUTINE GLOBAL-MENHIR-F ()
	 <TELL "Ce n'est pas ici." CR>>

<OBJECT MENHIR
	(IN LOCAL-GLOBALS)
	(SYNONYM MENHIR ROCK STONE F)
	(ADJECTIVE HUGE HEAVY ENORMOUS)
	(FLAGS NDESCBIT READBIT TURNBIT)
	(DESC "énorme menhir")
	(ACTION MENHIR-FCN)>

<ROOM KENNEL
      (IN ROOMS)
      (LDESC
"Cette pièce a l'air d'être autrefois un chenil pour un très grand chien (certains os correspondraient à un dinosaure). Elle n'a apparemment pas été utilisée depuis longtemps, car la poussière est assez épaisse partout.")
      (DESC "Chenil")
      (FLAGS RLANDBIT)
      (NE TO MENHIR-ROOM
       IF MENHIR-POSITION
        ELSE "Vous essayez de traverser un énorme rocher.")
      (OUT TO MENHIR-ROOM
       IF MENHIR-POSITION
        ELSE "Vous essayez de traverser un énorme rocher.")
      (GLOBAL MENHIR)>

<OBJECT COLLAR
	(IN KENNEL)
	(SYNONYM COLLAR TREASURE)
	(ADJECTIVE HUGE GIANT DOG)
	(FDESC
"Un col de chien gigantesque, assez grand pour trois chiens de taille rhinocéros, se trouve au milieu des débris.")
	(DESC "collier de chien gigantesque")
	(FLAGS STAGGERED TAKEBIT)
	(ACTION COLLAR-FCN)
	(VALUE 15)>

\

"SUBTITLE DIAMOND MAZE"

<OBJECT BAT
	(SYNONYM CLUB BAT)
	(ADJECTIVE WOODEN BASEBALL)
	(FDESC
"Un long club en bois se trouve sur le sol près de la fenêtre en forme de diamant. Le club est curieusement brûlé à l'extrémité épaisse.")
	(DESC "club en bois")
	(FLAGS INVISIBLE TAKEBIT WEAPONBIT READBIT BURNBIT)
	(TEXT
"Les mots \"Babe Tête-Plate\" sont gravés dans le bois.")>

<ROOM STAIRWAY-TOP
      (IN ROOMS)
      (LDESC
"Un escalier en marbre descend dans l'obscurité et un passage mène au nord.")
      (DESC "Escalier")
      (FLAGS RLANDBIT)
      (DOWN TO DIAMOND-5)
      (NORTH TO MENHIR-ROOM)
      (GLOBAL STAIRS)>

<ROOM DIAMOND-1
      (IN ROOMS)
      (DESC
"Angle bizarre Pièce")
      (LDESC
"Une petite pièce avec des murs aux angles étranges et des passages dans toutes les directions.")
      (FLAGS RLANDBIT)
      (SE TO DIAMOND-5)
      (ACTION DIAMOND-MOTION)
      (GLOBAL DWINDOW)>

<ROOM DIAMOND-2
      (IN ROOMS)
      (DESC
"Angle bizarre Pièce")
      (LDESC
"Une petite pièce avec des murs aux angles étranges et des passages dans toutes les directions.")
      (FLAGS RLANDBIT)
      (SOUTH TO DIAMOND-5)
      (SE TO DIAMOND-6)
      (SW TO DIAMOND-4)
      (ACTION DIAMOND-MOTION)
      (GLOBAL DWINDOW)>

<ROOM DIAMOND-3
      (IN ROOMS)
      (DESC
"Angle bizarre Pièce")
      (LDESC
"Une petite pièce avec des murs aux angles étranges et des passages dans toutes les directions.")
      (FLAGS RLANDBIT)
      (SW TO DIAMOND-5)
      (ACTION DIAMOND-MOTION)
      (GLOBAL DWINDOW)>

<ROOM DIAMOND-4
      (IN ROOMS)
      (DESC
"Angle bizarre Pièce")
      (LDESC
"Une petite pièce avec des murs aux angles étranges et des passages dans toutes les directions.")
      (FLAGS RLANDBIT)
      (NE TO DIAMOND-2)
      (SE TO DIAMOND-8)
      (EAST TO DIAMOND-5)
      (ACTION DIAMOND-MOTION)
      (GLOBAL DWINDOW)>

<ROOM DIAMOND-5
      (IN ROOMS)
      (DESC
"Angle bizarre Pièce")
      (LDESC
"Une petite pièce avec des murs aux angles étranges et des passages dans toutes les directions.")
      (FLAGS RLANDBIT)
      (NW TO DIAMOND-1)
      (NORTH TO DIAMOND-2)
      (NE TO DIAMOND-3)
      (WEST TO DIAMOND-4)
      (EAST TO DIAMOND-6)
      (SW TO DIAMOND-7)
      (SOUTH TO DIAMOND-8)
      (SE TO DIAMOND-9)
      (DOWN TO CERBERUS-ROOM)
      (UP TO STAIRWAY-TOP)
      (ACTION DIAMOND-MOTION)
      (GLOBAL STAIRS DWINDOW)>

<ROOM DIAMOND-6
      (IN ROOMS)
      (DESC
"Angle bizarre Pièce")
      (LDESC
"Une petite pièce avec des murs aux angles étranges et des passages dans toutes les directions.")
      (FLAGS RLANDBIT)
      (WEST TO DIAMOND-5)
      (NW TO DIAMOND-2)
      (SW TO DIAMOND-8)
      (ACTION DIAMOND-MOTION)
      (GLOBAL DWINDOW)>

<ROOM DIAMOND-7
      (IN ROOMS)
      (DESC
"Angle bizarre Pièce")
      (LDESC
"Une petite pièce avec des murs aux angles étranges et des passages dans toutes les directions.")
      (FLAGS RLANDBIT)
      (NE TO DIAMOND-5)
      (ACTION DIAMOND-MOTION)
      (GLOBAL DWINDOW)>

<ROOM DIAMOND-8
      (IN ROOMS)
      (DESC
"Angle bizarre Pièce")
      (LDESC
"Une petite pièce avec des murs aux angles étranges et des passages dans toutes les directions.")
      (FLAGS RLANDBIT)
      (NORTH TO DIAMOND-5)
      (NW TO DIAMOND-4)
      (NE TO DIAMOND-6)
      (ACTION DIAMOND-MOTION)
      (GLOBAL DWINDOW)>

<ROOM DIAMOND-9
      (IN ROOMS)
      (DESC
"Angle bizarre Pièce")
      (LDESC
"Une petite pièce avec des murs aux angles étranges et des passages dans toutes les directions.")
      (FLAGS RLANDBIT)
      (NW TO DIAMOND-5)
      (ACTION DIAMOND-MOTION)
      (GLOBAL DWINDOW)>

<OBJECT DWINDOW
	(IN LOCAL-GLOBALS)
	(SYNONYM WINDOW)
	(ADJECTIVE GLOWING DIAMOND)
	(DESC "fenêtre en forme de losange")
	(ACTION DWINDOW-FCN)
	(FLAGS NDESCBIT TRYTAKEBIT)>

<ROOM CERBERUS-ROOM
      (IN ROOMS)
      (LDESC
"C'est l'entrée d'une énorme crypte ou tombe. Un escalier en marbre mène d'un arc de porte.")
      (DESC "Salle Cerbère")
      (FLAGS RLANDBIT)
      (EAST TO CRYPT-ANTEROOM
       IF CERBERUS-LEASHED ELSE "L'énorme chien s'en prend méchamment à vous.")
      (IN TO CRYPT-ANTEROOM
       IF CERBERUS-LEASHED ELSE "L'énorme chien s'en prend méchamment à vous.")
      (UP TO DIAMOND-5)
      (VALUE 10)
      (GLOBAL STAIRS)
      (PSEUDO "TOMBE" TOMB-PSEUDO "CRYPTE" TOMB-PSEUDO)>

<OBJECT GLOBAL-CERBERUS
	(IN LOCAL-GLOBALS)
	(SYNONYM CERBERUS DOG HOUND MONSTER)
	(ADJECTIVE HUGE GIANT THREE HEADED)
	(ACTION GLOBAL-CERBERUS-F)
	(DESC "trois têtes chien")>

<ROUTINE GLOBAL-CERBERUS-F ()
	 <TELL "Il n'est pas là." CR>>

<OBJECT CERBERUS
	(IN CERBERUS-ROOM)
	(SYNONYM CERBERUS DOG HOUND MONSTER)
	(ADJECTIVE HUGE GIANT THREE HEADED)
	(DESC "trois têtes chien")
	(LDESC
"C'est plus ou moins votre chien habituel, sauf qu'il a trois têtes et est la taille d'un éléphant.")
	(FLAGS ACTORBIT OPENBIT CONTBIT)
	(ACTION CERBERUS-FCN)>

<ROOM CRYPT-ANTEROOM
      (IN ROOMS)
      (LDESC " ")
      (DESC "Antichambre de la crypte")
      (FLAGS RLANDBIT)
      (IN TO CRYPT-ROOM IF CRYPT-DOOR IS OPEN)
      (SOUTH TO CRYPT-ROOM IF CRYPT-DOOR IS OPEN)
      (WEST TO CERBERUS-ROOM)
      (ACTION CRYPT-ANTEROOM-FCN)
      (GLOBAL CRYPT-DOOR)
      (VALUE 3)>

<ROOM CRYPT-ROOM
      (IN ROOMS)
      (LDESC " ")
      (DESC "Crypte")
      (FLAGS RLANDBIT)
      (NORTH TO CRYPT-ANTEROOM IF CRYPT-DOOR IS OPEN)
      (SOUTH TO ZORK3 IF DIM-DOOR-FLAG)
      (GLOBAL CRYPT-DOOR DIM-DOOR)
      (ACTION CRYPT-ROOM-FCN)
      (VALUE 2)>

<OBJECT HEADS
	(IN CRYPT-ROOM)
	(SYNONYM HEADS HEAD POLE POLES)
        (DESC "ensemble de poteaux têtes")
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION HEAD-FCN)>

<OBJECT CRYPT
	(IN CRYPT-ROOM)
	(SYNONYM TOMB CRYPT GRAVE)
	(ADJECTIVE MARBLE)
	(DESC "crypte en marbre")
	(FLAGS NDESCBIT READBIT)
	(ACTION CRYPT-OBJECT)
	(TEXT
"\"Voici les Tête-Plates, dont les têtes ont été placées sur des poteaux par le Gardien du Donjon pour une incroyable ingéniosité.\"")>

<OBJECT CRYPT-DOOR
	(IN LOCAL-GLOBALS)
	(SYNONYM DOOR)
	(ADJECTIVE CRYPT NORTH)
	(DESC "porte de la crypte")
	(FLAGS DOORBIT CONTBIT)
	(ACTION CRYPT-DOOR-FCN)>

<OBJECT DIM-DOOR
	(IN LOCAL-GLOBALS)
	(SYNONYM DOOR LETTER)
	(ADJECTIVE F DIMLY SOUTH SECRET)
	(DESC "porte secrète")
	(FLAGS DOORBIT CONTBIT INVISIBLE)
	(ACTION DIM-DOOR-FCN)>

<ROOM ZORK3
      (IN ROOMS)
      (LDESC " ")
      (DESC "Palier")
      (FLAGS RLANDBIT ONBIT)
      (ACTION ZORK3-FCN)>

\

"ATELIER DE L'ASSISTANT DE SOUS-TITRE"

<ROOM GUARDIAN-ROOM
      (IN ROOMS)
      (LDESC " ")
      (DESC "Gardé Chambre")
      (FLAGS RLANDBIT)
      (NORTH TO COBWEBBY-CORRIDOR)
      (SOUTH TO WIZARDS-WORKSHOP
       IF WIZ-DOOR IS OPEN)
      (IN TO WIZARDS-WORKSHOP
       IF WIZ-DOOR IS OPEN)
      (ACTION GUARDIAN-ROOM-FCN)
      (GLOBAL WIZ-DOOR)>

<OBJECT DOOR-KEEPER
	(IN GUARDIAN-ROOM)
	(SYNONYM KEEPER GUARDIAN LIZARD HEAD)
	(ADJECTIVE NASTY)
	(DESC "lézard")
	(FLAGS NDESCBIT)
	(ACTION DOOR-KEEPER-FCN)>

<ROOM WIZARDS-WORKSHOP
      (IN ROOMS)
      (LDESC
"C'est l'atelier du Magicien de Frobozz.")
      (DESC "Assistant Atelier")
      (FLAGS RLANDBIT)
      (NORTH TO GUARDIAN-ROOM IF WIZ-DOOR IS OPEN)
      (OUT TO GUARDIAN-ROOM IF WIZ-DOOR IS OPEN)
      (WEST TO WORKBENCH-ROOM)
      (SOUTH TO TROPHY-ROOM)
      (ACTION WORKSHOP-FCN)
      (VALUE 10)
      (GLOBAL WIZ-DOOR)>

<ROOM WORKBENCH-ROOM
      (IN ROOMS)
      (LDESC
"Cette pièce est la salle de travail du Wizard. Une salle continue à l'est et à l'ouest, et une salle plus grande se trouve au sud. Il y a beaucoup d'étagères et de crémaillères sur les murs, mais l'atelier du Wizard domine la pièce. Il est fait de bois sombre et lourd lié au fer. L'atelier est teinté de nombreuses années d'utilisation, et est profondément bouché comme si un énorme animal griffé y était emprisonné. Il y a des marques de brûlures et même des notes écrites dans une main de crabe.")
      (DESC "Atelier du sorcier")
      (FLAGS RLANDBIT ONBIT)
      (EAST TO WIZARDS-WORKSHOP)
      (SOUTH TO PENTAGRAM-ROOM)
      (WEST TO AQUARIUM-ROOM)
      (PSEUDO "MORTIER" ARCANA-PSEUDO "PILON" ARCANA-PSEUDO)>

<OBJECT ARCANA
	(IN WORKBENCH-ROOM)
	(SYNONYM ALEMBIC VELLUM CANDLES KNIVES)
        (ADJECTIVE WAX SMALL)
	(DESC "objet arcanique")
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION ARCANA-PSEUDO)>

<OBJECT WORKBENCH
	(IN WORKBENCH-ROOM)
	(SYNONYM WORKBENCH BENCH TABLE)
	(ADJECTIVE WORK HEAVY WOODEN WIZARD)
	(DESC "Établi du sorcier")
	(CAPACITY 200)
	(FLAGS NDESCBIT SURFACEBIT CONTBIT OPENBIT)>

<OBJECT STAND-1
	(IN WORKBENCH)
	(SYNONYM STAND STANDS)
	(ADJECTIVE CRYSTAL RUBY)
	(DESC "rubis support")
	(FLAGS NDESCBIT SURFACEBIT CONTBIT OPENBIT)
	(CAPACITY 10)
	(ACTION STAND-FCN)>

<OBJECT STAND-2
	(IN WORKBENCH)
	(SYNONYM STAND STANDS)
	(ADJECTIVE CRYSTAL SAPPHIRE)
	(DESC "support en saphir")
	(FLAGS NDESCBIT SURFACEBIT OPENBIT CONTBIT)
	(CAPACITY 10)
	(ACTION STAND-FCN)>

<OBJECT STAND-3
	(IN WORKBENCH)
	(SYNONYM STAND STANDS)
	(ADJECTIVE DIAMOND CRYSTAL)
	(DESC "support en diamant")
	(FLAGS NDESCBIT SURFACEBIT OPENBIT CONTBIT)
	(CAPACITY 10)
	(ACTION STAND-FCN)>

<OBJECT STAND-4
	(SYNONYM STAND STANDS)
	(ADJECTIVE OBSIDIAN BLACK CRYSTAL STRANGE)
	(DESC "obsidienne noire stand")
	(FLAGS SURFACEBIT CONTBIT OPENBIT)
	(SIZE 5)
	(CAPACITY 10)
	(ACTION STAND-FCN)>

<OBJECT PALANTIR-4
	(IN STAND-4)
	(SYNONYM SPHERE BALL PALANTIR)
	(ADJECTIVE CRYSTAL STRANGE BLACK)
	(DESC "sphère de cristal noir")
	(FLAGS STAGGERED TAKEBIT TRANSBIT)
	(ACTION PALANTIR)
	(LDESC "Il y a une étrange sphère noire ici.")
	(VALUE 30)
	(SIZE 10)>

<ROOM TROPHY-ROOM
      (IN ROOMS)
      (LDESC
"C'est la salle des trophées du Wizard, remplie de souvenirs de différentes sortes. Sur un mur est le degré D.T. du Wizard (Docteur de Thaumaturgy) de GUE Tech. Plusieurs vieilles baguettes magiques sont montées sur un support de baguette. Une collection d'épées ternes et incrustées témoignent du sort de nombreux aventuriers téméraires.")
      (DESC "Trophée Chambre")
      (FLAGS RLANDBIT)
      (NORTH TO WIZARDS-WORKSHOP)
      (PSEUDO
       "OWL" TROPHY-PSEUDO
       "HOMUN CULI" TROPHY-PSEUDO)>

<OBJECT DEGREE
	(IN TROPHY-ROOM)
	(SYNONYM DEGREE DIPLOMA)
	(DESC "degré")
	(FLAGS NDESCBIT TRYTAKEBIT READBIT)
	(ACTION TROPHY-PSEUDO)
	(TEXT
"Le texte est dans une langue obscure. Tout ce qui peut être fait est une référence à «l'envoi dans une couverture de livre de correspondance».")>

<OBJECT WANDS
	(IN TROPHY-ROOM)
	(SYNONYM WANDS WAND RACK SET)
        (ADJECTIVE WORN USED)
	(DESC "jeu de baguettes usagées")
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION TROPHY-PSEUDO)>

<OBJECT TROPHY-SWORD
	(IN TROPHY-ROOM)
	(SYNONYM SWORD SWORDS)
        (ADJECTIVE DULL NICKED)
	(DESC "épées entaillées")
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION TROPHY-PSEUDO)>

<OBJECT TROPHY-BOTTLES
	(IN TROPHY-ROOM)
	(SYNONYM BOTTLE)
        (ADJECTIVE SMALL)
	(DESC "petites bouteilles")
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION TROPHY-PSEUDO)>

<OBJECT WARNING-LABEL
	(IN TROPHY-ROOM)
	(SYNONYM LABEL)
	(ADJECTIVE WARNING)
	(DESC "étiquette d'avertissement")
	(LDESC "Une étiquette manuscrite est apposée sur le mur.")
	(FLAGS READBIT)
	(TEXT
"Attention !| | Les expositions dans cette salle sont la propriété du puissant Magicien de Frobozz (moi), et sont les fruits d'un travail diligent et d'études sur de nombreuses années. Celui qui touche n'importe quoi le regrettera.| | (signé)| Frobozz|")>

<OBJECT GLOBAL-WIZARD-CASE
	(IN LOCAL-GLOBALS)
	(SYNONYM CASE CABINET)
	(ADJECTIVE TROPHY WIZARD)
	(DESC "Armoire à trophées du sorcier")
	(ACTION WIZARD-CASE-FCN)>

<OBJECT WIZARD-CASE
	(IN TROPHY-ROOM)
	(SYNONYM CASE CABINET)
	(ADJECTIVE TROPHY WIZARD)
	(DESC "Armoire à trophées du sorcier")
	(FLAGS CONTBIT TRANSBIT)
	(LDESC "Un trophée orné est incrusté dans le mur ")
	(ACTION WIZARD-CASE-FCN)
	(CAPACITY 1000)>

<OBJECT BROKEN-CASE
	(SYNONYM CASE CABINET)
	(ADJECTIVE BROKEN TROPHY WIZARD)
	(DESC "armoire à trophées brisée")
	(FLAGS CONTBIT OPENBIT)
	(LDESC "Des éclats d'une boîte à trophées brisée jonchent la pièce.")>

<ROOM PENTAGRAM-ROOM
      (IN ROOMS)
      (LDESC
"Dans cette pièce, inscrite sur le sol, est un grand pentagramme dessiné avec de la craie noire. Dans son centre est un cercle noir.")
      (DESC "Salle du Pentagramme")
      (FLAGS RLANDBIT ONBIT)
      (NORTH TO WORKBENCH-ROOM)
      (GLOBAL GLOBAL-MENHIR GLOBAL-CERBERUS GLOBAL-WIZARD-CASE)>

<OBJECT PENTAGRAM
	(IN PENTAGRAM-ROOM)
	(SYNONYM PENTAGRAM STAR CIRCLE)
	(ADJECTIVE GREAT CHALK BLACK)
	(DESC "pentagramme")
	(FLAGS NDESCBIT SURFACEBIT CONTBIT OPENBIT)
	(CAPACITY 200)
	(ACTION PENTAGRAM-FCN)>

<ROOM AQUARIUM-ROOM
      (IN ROOMS)
      (LDESC
"Ici, un couloir sombre tourne un coin. Au sud est une pièce sombre, à l'est est la lumière appropriée.")
      (DESC "Salle d'aquarium")
      (FLAGS RLANDBIT ONBIT)
      (EAST TO WORKBENCH-ROOM)
      (IN TO IN-AQUARIUM)
      (SOUTH TO WIZARDS-QUARTERS)>

<OBJECT AQUARIUM
	(IN AQUARIUM-ROOM)
	(SYNONYM AQUARIUM GLASS)
	(ADJECTIVE HUGE)
	(DESC "aquarium")
	(LDESC "Remplir la moitié nord de la pièce est un immense aquarium.")
	(FLAGS OPENBIT CONTBIT)
	(CAPACITY 200)
	(ACTION AQUARIUM-FCN)>

<OBJECT PALANTIR-3
	(IN IN-AQUARIUM)
	(SYNONYM PALANTIR SPHERE)
	(ADJECTIVE CRYSTAL WHITE CLEAR)
	(DESC "sphère de cristal clair")
	(LDESC "Il y a une sphère de cristal clair posée dans le sable.")
	(FLAGS STAGGERED TAKEBIT NDESCBIT TRANSBIT)
	(ACTION PALANTIR)
	(VALUE 20)>

<OBJECT SERPENT
	(IN AQUARIUM)
	(SYNONYM SERPENT SNAKE)
	(ADJECTIVE BABY SEA)
	(DESC "bébé mer serpent")
	(LDESC "Il y a un bébé serpent de mer qui nage dans l'aquarium.")
	(FLAGS ACTORBIT)
	(ACTION SERPENT-FCN)>

<OBJECT DEAD-SERPENT
	(SYNONYM SERPENT SNAKE)
	(ADJECTIVE DEAD BABY SEA)
	(DESC "serpent de mer mort")
	(LDESC "Il y a un serpent de mer mort dans un tas ici.")
	(FLAGS TAKEBIT)
	(ACTION DEAD-SERPENT-FCN)
	(SIZE 400)>

<ROOM IN-AQUARIUM
      (IN ROOMS)
      (LDESC
"Le sol ici semble être fait de sable, mais il est difficile de voir autre chose.")
      (DESC "Chambre sombre")
      (FLAGS RLANDBIT ONBIT)
      (OUT TO AQUARIUM-ROOM)
      (ACTION IN-AQUARIUM-FCN)>

<ROOM WIZARDS-QUARTERS
      (IN ROOMS)
      (LDESC " ")
      (DESC "Quartiers du sorcier")
      (FLAGS RLANDBIT)
      (NORTH TO AQUARIUM-ROOM)
      (ACTION WIZARD-QUARTERS-FCN)>

<ROOM CAROUSEL-ROOM
      (IN ROOMS)
      (LDESC " ")
      (DESC "Carrousel Chambre")
      (FLAGS RLANDBIT)
      (NORTH TO MARBLE-HALL)
      (NE TO STREAM-PATH)
      (EAST TO TOPIARY-ROOM)
      (SE TO RIDDLE-ROOM)
      (SOUTH TO MENHIR-ROOM)
      (SW TO COBWEBBY-CORRIDOR)
      (WEST TO ROOM-8)
      (NW TO COOL-ROOM)
      (ACTION CAROUSEL-ROOM-FCN)>

; "SUBTITLE ROOMS FROM OLD ZORK"

<ROOM RIDDLE-ROOM
       (IN ROOMS)
       (LDESC " ")
       (DESC "Salle Riddle")
       (DOWN TO CAROUSEL-ROOM)
       (NW TO CAROUSEL-ROOM)
       (EAST TO PEARL-ROOM IF RIDDLE-DOOR IS OPEN)
       (FLAGS RLANDBIT)
       (ACTION RIDDLE-ROOM-FCN)
       (PSEUDO "RIDDLE" RIDDLE-PSEUDO)>

<OBJECT RIDDLE-DOOR
	(IN RIDDLE-ROOM)
	(DESC "pierre porte")
	(SYNONYM DOOR)
	(ADJECTIVE GREAT STONE)
	(FLAGS DOORBIT CONTBIT NDESCBIT)
	(ACTION RIDDLE-DOOR-FCN)>

<ROOM PEARL-ROOM
        (IN ROOMS)
	(LDESC
"Il s'agit d'un ancien placard à balais. Les sorties sont à l'est et à l'ouest.")
        (DESC "Salle des Perles")
       	(EAST TO WELL-BOTTOM)
	(WEST TO RIDDLE-ROOM)
	(FLAGS RLANDBIT)>

\

;"SUBTITLE VOLCANO AREA"

<ROOM VOLCANO-BOTTOM
        (IN ROOMS)
       (LDESC
"Vous êtes au fond d'un grand volcan dormant. Au-dessus de vous la lumière entre du cône du volcan. La seule sortie est au nord.")
       (DESC "Bas du volcan")
       (NORTH TO LAVA-ROOM)
       (FLAGS RLANDBIT NONLANDBIT)>

<ROOM VAIR-1
        (IN ROOMS)
       (LDESC
"Vous êtes à une centaine de pieds au-dessus du fond du volcan. Le sommet du volcan est clairement visible ici.")
       (DESC "Noyau du volcan")
       (FLAGS NONLANDBIT NWALLBIT )>

<ROOM VAIR-2
        (IN ROOMS)
       (LDESC
"Vous êtes à environ deux cents pieds au-dessus du sol du volcan. La bordure du volcan est en pente.")
       (DESC "Volcan près d'un petit rebord")
       (WEST TO LEDGE-1)
       (LAND TO LEDGE-1)
       (FLAGS NONLANDBIT NWALLBIT )>

<ROOM VAIR-3
        (IN ROOMS)
       (LDESC
"Vous êtes haut au-dessus du sol du volcan. Le bord du volcan semble très étroit et vous êtes très près de lui. À l'est est ce qui semble être un rebord d'observation, trop mince pour atterrir.")
       (DESC "Volcan près du rebord d'observation")
       (FLAGS NONLANDBIT NWALLBIT )>

<ROOM VAIR-4
       (IN ROOMS)
       (LDESC
"Vous êtes près du bord du volcan. Au-dessus de vous il est ouvert au ciel. À l'ouest, il y a un endroit pour atterrir sur un large rebord.")
       (DESC "Volcan près de Wide Ledge")
       (LAND TO LEDGE-2)
       (WEST TO LEDGE-2)
       (FLAGS NONLANDBIT NWALLBIT )>

<ROOM LEDGE-1
       (IN ROOMS)
       (LDESC
"Vous êtes sur un rebord étroit à l'intérieur d'un vieux volcan dormant. Ce rebord est à mi-chemin entre le plancher et la jante au-dessus. Il y a une sortie au sud.")
       (DESC "Corniche étroite")
       (DOWN "Je ne sauterais pas d'ici.")
       (WEST TO VOLCANO-BOTTOM IF GNOME-DOOR-FLAG)
       (SOUTH TO LIBRARY)
       (FLAGS RLANDBIT NONLANDBIT)>

<ROOM LIBRARY
       (IN ROOMS)
       (LDESC
"Ce devait être une grande bibliothèque, probablement pour la famille royale. Toutes les étagères ont été rongées en morceaux par des gnomes hostiles. Au nord est une sortie.")
       (DESC "Bibliothèque")
       (NORTH TO LEDGE-1)
       (OUT TO LEDGE-1)
       (FLAGS RLANDBIT)>

<ROOM VOLCANO-VIEW
       (IN ROOMS)
       (LDESC
"Vous êtes sur un rebord au milieu d'un grand volcan. Au-dessous de vous le fond du volcan peut être vu et au-dessus est le bord du volcan. Un couple de rebords peut être vu de l'autre côté du volcan; il semble que ce rebord est intermédiaire en altitude entre ceux de l'autre côté. La sortie de cette pièce est à l'est.")
       (DESC "Vue sur le volcan")
       (DOWN "Je n'essaierais pas ça.")
       (CROSS "Il est impossible de traverser cette pièce. distance.")
       (EAST TO LAVA-TUBE)
       (FLAGS RLANDBIT)>

<ROOM LEDGE-2
       (IN ROOMS)
       (LDESC " ")
       (DESC "Large rebord")
       (DOWN "C'est un long chemin vers le bas.")
       (WEST TO VOLCANO-BOTTOM IF GNOME-DOOR-FLAG)
       (SOUTH TO SAFE-ROOM)
       (ACTION LEDGE-FCN)
       (FLAGS RLANDBIT NONLANDBIT)>

<ROOM SAFE-ROOM
       (IN ROOMS)
       (LDESC " ")
       (DESC "Pièce poussiéreuse")
       (NORTH TO LEDGE-2)
       (ACTION SAFE-ROOM-FCN)
       (FLAGS RLANDBIT ONBIT)>

<ROOM LAVA-ROOM
       (IN ROOMS)
       (LDESC
"C'est une petite pièce, dont les murs sont formés par un vieux courant de lave. Il y a des sorties ici à l'est et au sud.")
       (DESC "Salle de lave")
       (SOUTH TO VOLCANO-BOTTOM)
       (EAST TO GLACIER-ROOM)
       (FLAGS RLANDBIT)>

<GLOBAL BLOC VOLCANO-BOTTOM>

\

"SOUS-TITRE ALICE AU PAYS DES MERVEILLES"

<ROOM MAGNET-ROOM
       (IN ROOMS)
       (LDESC " ")
       (DESC "Faible Salle")
       (NORTH PER MAGNET-ROOM-EXIT)
       (SOUTH PER MAGNET-ROOM-EXIT)
       (WEST PER MAGNET-ROOM-EXIT)
       (NE PER MAGNET-ROOM-EXIT)
       (NW PER MAGNET-ROOM-EXIT)
       (SW PER MAGNET-ROOM-EXIT)
       (SE PER MAGNET-ROOM-EXIT)
       (EAST PER MAGNET-ROOM-EXIT)
       (OUT PER MAGNET-ROOM-EXIT)
       (ACTION MAGNET-ROOM-FCN)
       (FLAGS RLANDBIT ONBIT)>

<ROOM MACHINE-ROOM
       (IN ROOMS)
       (LDESC
"Il s'agit d'une grande pièce pleine de machines lourdes assorties, tourbillonnant bruyamment. La pièce sent les résistances brûlées. Le long d'un mur sont trois boutons qui sont, respectivement, rond, triangulaire, et carré. Naturellement, au-dessus de ces boutons sont des instructions écrites en EBCDIC. Un grand panneau en anglais surtout les boutons dit| \"DANGER -- HIGH VOLTAGE\"| Il y a des sorties vers l'ouest et le sud.")
       (DESC "Salle des machines")
       (WEST TO MAGNET-ROOM)
       (SOUTH TO CAGE-ROOM)
       (FLAGS RLANDBIT ONBIT)>

<ROOM CAGE-ROOM
       (IN ROOMS)
       (LDESC
"Ce débarras sordide jouxte une pièce plus grande au nord. Ces mots sont gravés dans un mur :|
|
     Protégé par la|
       Société d'alarmes|
     magiques FROBOZZ|
  (Bonjour, voleur !)||
Pourtant, aucun voleur ne semble se trouver ici.")
       (DESC "Débarras sordide")
       (OUT TO MACHINE-ROOM)
       (NORTH TO MACHINE-ROOM)
       (FLAGS ONBIT RLANDBIT)>

<ROOM IN-CAGE
       (IN ROOMS)
       (LDESC "Vous êtes coincé à l'intérieur d'un solide acier. cage.")
       (DESC "Cage")
       (ACTION IN-CAGE-FCN)
       (FLAGS RLANDBIT NWALLBIT ONBIT)>

<ROOM WELL-TOP
       (IN ROOMS)
       (LDESC
"Vous êtes au sommet du puits. Bien fait. Il y a des gravures sur le côté du puits. Il y a une petite fissure à travers le sol à l'entrée d'une pièce à l'est, mais il peut être croisé facilement.")
       (DESC "Haut du puits")
       (EAST TO TEA-ROOM)
       (DOWN "C'est une longue descente !")
       (FLAGS RLANDBIT NONLANDBIT)
       (VALUE 10)
       (GLOBAL WELL)
       (PSEUDO "FISSURE" CRACK-PSEUDO)>

<ROUTINE CRACK-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL
"C'est une petite crack (comme annoncé) sans valeur de rachat." CR>)>>

<ROOM WELL-BOTTOM
       (IN ROOMS)
       (LDESC
"C'est une pièce circulaire humide, dont les murs sont en brique et mortier. Le toit de cette pièce n'est pas visible, mais il semble y avoir des gravures sur les murs. Il y a un passage à l'ouest.")
       (DESC "Salle circulaire")
       (WEST TO PEARL-ROOM)
       (UP "Les murs ne peuvent pas être escaladés.")
       (FLAGS RLANDBIT NONLANDBIT)
       (GLOBAL WELL)>

<ROOM TEA-ROOM
       (IN ROOMS)
       (LDESC
"C'est une petite salle contenant une grande table oblonge, sans doute pour le thé de l'après-midi. Il est clair des objets sur la table que les utilisateurs étaient en effet fou. Dans le coin est de la salle est un petit trou (pas plus de quatre pouces de haut). Il ya des passages menant loin vers l'ouest et le nord-ouest.")
       (DESC "Salon de thé")
       (EAST "Seule une souris pouvait entrer là.")
       (WEST TO WELL-TOP)
       (NW TO MAGNET-ROOM)
       (FLAGS RLANDBIT ONBIT)
       (PSEUDO "TROU" ALICE-HOLE)>

<ROUTINE ALICE-HOLE ()
	 <COND (<VERB? EXAMINE>
		<TELL "Le trou est très petit. Vous ne pourrez jamais y entrer." CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL "Vous ne pouvez pas voir ce qu'il y a au-delà du trou d'ici." CR>)
	       (<AND <VERB? PUT> <EQUAL? ,PRSI ,PSEUDO-OBJECT>>
		<TELL "Il ne passe pas à travers le trou." CR>)>>

<ROOM POSTS-ROOM
       (IN ROOMS)
       (LDESC
"Il s'agit d'une salle énorme, au centre de laquelle se trouvent quatre poteaux en bois délimitant une zone rectangulaire, au-dessus de laquelle apparaît un toit en bois. En fait, tous les objets de cette salle semblent anormalement grands. À l'est se trouve un passage. Il y a de grands chasmes à l'ouest et au nord-ouest.")
       (DESC "Salle des messages")
       (NW "Un grand gouffre bloque votre chemin.")
       (EAST TO POOL-ROOM)
       (WEST "Un grand gouffre bloque votre chemin.")
       (DOWN "Un grand gouffre bloque votre chemin.")
       (FLAGS RLANDBIT ONBIT)
       (ACTION POSTS-ROOM-FCN)
       (GLOBAL CHASM)>

<ROOM POOL-ROOM
       (IN ROOMS)
       (LDESC
"C'est une grande pièce, dont la moitié est déprimée. L'eau salée coule d'une grande fuite dans le plafond. La seule sortie est à l'ouest.")
       (DESC "Salle de billard")
       (OUT TO POSTS-ROOM)
       (WEST TO POSTS-ROOM)
       (FLAGS RLANDBIT)>

\

; "SUBTITLE BANK OF ZORK"

<ROOM BANK-ENTRANCE
      (IN ROOMS)
      (LDESC
"Vous êtes dans le hall de la Banque de Zork, le plus grand établissement financier du Grand Empire Souterrain. On trouve un résumé de son histoire dans \"La Vie des douze Tête-Plate\", au chapitre consacré à J. Pierpont Tête-Plate. Une version plus détaillée, quoique moins objective, figure dans l'autobiographie extravagante de Tête-Plate : \"Je suis riche et vous ne l'êtes pas - et puis voilà !\". La plupart des meubles ont été saccagés par des pillards de passage. Il ne reste que deux panneaux, dans les angles nord-ouest et nord-est :|
|
    <--  SALLES DE CONSULTATION  -->|
|
La sortie, ornée avec goût, se trouve à l'est.")
      (DESC "Entrée de la banque")
      (NW TO TELLER-WEST)
      (NE TO TELLER-EAST)
      (EAST TO FRESCO-ROOM)
      (FLAGS RLANDBIT)>

<ROOM TELLER-WEST
      (IN ROOMS)
      (LDESC " ")
      (DESC "Salle du guichet ouest")
      (NORTH TO VIEWING-WEST)
      (SOUTH TO BANK-ENTRANCE)
      (WEST TO DEPOSITORY)
      (ACTION TELLER-ROOM)
      (FLAGS RLANDBIT)>

<ROOM TELLER-EAST
      (IN ROOMS)
      (LDESC " ")
      (DESC "Salle du guichet est Salle")
      (NORTH TO VIEWING-EAST)
      (SOUTH TO BANK-ENTRANCE)
      (EAST TO DEPOSITORY)
      (ACTION TELLER-ROOM)
      (FLAGS RLANDBIT)>

<ROOM VIEWING-WEST
      (IN ROOMS)
      (LDESC
"Cette pièce a été utilisée par les détenteurs de coffres de sécurité pour voir leur contenu. Du côté nord de la pièce est un panneau qui dit:| | \"Restez ici pendant que le caissier récupère votre coffre de sécurité.Lorsque vous avez terminé, laissez la boîte, et sortez vers le sud. Les coffres de sécurité ne peuvent pas être retirés de cette pièce!| | Merci pour la banque au Zork!\"")
      (DESC "Salle d'observation ouest")
      (SOUTH TO BANK-ENTRANCE)
      (FLAGS RLANDBIT)
      (GLOBAL SEWL SWWL SNWL SSWL)>

<ROOM VIEWING-EAST
      (IN ROOMS)
      (LDESC
"Cette pièce a été utilisée par les détenteurs de coffres-forts pour voir leur contenu. Du côté nord de la pièce est un panneau qui dit| | \"Restez ici pendant que le caissier récupère votre coffre-fort. Lorsque vous avez terminé, laissez la boîte, et sortez vers le sud. Les coffres-forts ne peuvent pas être retirés de cette pièce!| | Merci pour la banque au Zork!\"")
      (DESC "Salle d'observation Est")
      (SOUTH TO BANK-ENTRANCE)
      (FLAGS RLANDBIT)
      (GLOBAL SEWL SWWL SNWL SSWL)>

<ROOM SMALL-ROOM
       (IN ROOMS)
      (LDESC
"Il s'agit d'une petite pièce nue sans traits distinctifs. Il n'y a pas de sorties de cette pièce.")
      (DESC "Petite pièce")
      (FLAGS RLANDBIT )
      (GLOBAL SEWL SWWL SNWL SSWL)>

<ROOM VAULT
       (IN ROOMS)
      (LDESC
"C'est le coffre-fort de la banque de Zork, dans lequel il n'y a aucun portes.")
      (DESC "Coffre")
      (FLAGS  RLANDBIT)
      (GLOBAL SEWL SWWL SNWL SSWL)>

<ROOM DEPOSITORY
       (IN ROOMS)
      (LDESC
"C'est une grande pièce rectangulaire. Les murs est et ouest ont été utilisés pour stocker des coffres de sécurité, mais tous ont été soigneusement enlevés par les personnes maléfiques. À l'est, à l'ouest et au sud de la pièce sont de grandes portes. Le \"mur\" nord de la pièce est un rideau de lumière chatoyante. Au centre de la pièce est un grand cube de pierre, environ 10 pieds sur un côté. Gravé sur le côté du cube est un peu de lettrage.")
      (DESC "Salle des coffres")
      (NORTH "Il y a là un rideau de lumière.")
      (WEST PER BKLEAVEW)
      (EAST PER BKLEAVEE)
      (SOUTH TO OFFICE)
      (ACTION DEPOSITORY-FCN)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL SNWL)>

<ROOM OFFICE
       (IN ROOMS)
      (LDESC
"Cette chambre était le bureau du président de la Banque de Zork. Comme les autres chambres ici, elle a été largement vandalisée. La sortie solitaire est au nord.")
      (DESC "Bureau du président")
      (NORTH TO DEPOSITORY)
      (FLAGS RLANDBIT)>

<OBJECT MATCH
	(IN GAZEBO-TABLE)
	(SYNONYM MATCH MATCHES MATCHBOOK)
	(ADJECTIVE ZORK)
	(DESC "boîte d'allumettes")
	(FLAGS READBIT TAKEBIT)
	(ACTION MATCH-FCN)
	(LDESC
"Il y a une boîte d'allumettes disant \"Visitez ZORK I\" ici.")
	(TEXT
"\">> Visitez l'exotique ZORK I <<|
|
Consultez l'Agence de voyages magiques Frobozz ou votre revendeur informatique pour en savoir plus.\"")
	(SIZE 2)>


\

"SOUS-TITRE CHAMBRES PALANTIR"

<ROOM DREARY-ROOM
      (IN ROOMS)
      (LDESC " ")
      (DESC "Chambre morne")
      (SOUTH TO TINY-ROOM IF PDOOR IS OPEN)
      (OUT TO TINY-ROOM IF PDOOR IS OPEN)
      (ACTION DREARY-ROOM-FCN)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL PDOOR PWINDOW)>

<ROOM TINY-ROOM
      (IN ROOMS)
      (LDESC " ")
      (DESC "Petite chambre")
      (NORTH TO DREARY-ROOM IF PDOOR IS OPEN)
      (IN TO DREARY-ROOM IF PDOOR IS OPEN)
      (DOWN TO RAVINE-LEDGE)
      (FLAGS RLANDBIT)
      (ACTION TINY-ROOM-FCN)
      (GLOBAL PDOOR PWINDOW CHASM)>
	
\

; "SUBTITLE OBJECTS"

<OBJECT GNOME
	(SYNONYM GNOME)
	(ADJECTIVE VOLCANO)
	(DESC "Gnome du volcan")
	(FLAGS ACTORBIT)
	(ACTION GNOME-FCN)
	(LDESC "Il y a un gnome du volcan nerveux ici.")>

<OBJECT BALLOON
	(IN VOLCANO-BOTTOM)
	(SYNONYM BALLOON BASKET)
	(ADJECTIVE WICKER)
	(DESC "panier")
	(FLAGS VEHBIT OPENBIT)
	(ACTION BALLOON-FCN)
	(DESCFCN BALLOON-FCN)
	(CAPACITY 100)
	(SIZE 70)
	(VTYPE 0)>

<OBJECT BALLOON-LABEL
	(SYNONYM LABEL)
	(ADJECTIVE BLUE)
	(DESC "étiquette bleue")
	(FLAGS READBIT TAKEBIT BURNBIT)
	(LDESC "Il y a une étiquette bleue ici.")
	(SIZE 1)
	(TEXT
" !! COMPAGNIE DES BALLONS MAGIQUES FROBOZZ !!|
|
Bonjour, aéronaute !|
|
Pour poser votre ballon, tapez ATTERRIR.|
Pour le reste, débrouillez-vous !|
|
Aucune garantie, expresse ou implicite.")>

<OBJECT SAFE
	(IN SAFE-ROOM)
	(SYNONYM SAFE BOX)
	(ADJECTIVE STEEL RUSTY)
	(DESC "boîte")
	(FLAGS CONTBIT NDESCBIT)
	(ACTION SAFE-FCN)
	(CAPACITY 15)>

<OBJECT BRAIDED-WIRE
	(FLAGS NDESCBIT)
	(IN BALLOON)
	(SYNONYM ROPE WIRE)
	(ADJECTIVE BRAIDED)
	(DESC "tressé fil")
	(ACTION WIRE-FCN)>

<OBJECT BRICK
	(IN MARBLE-HALL)
	(SYNONYM BRICK)
	(ADJECTIVE SQUARE CLAY)
	(DESC "brique")
	(FLAGS TAKEBIT BURNBIT OPENBIT SEARCHBIT)
	(ACTION BRICK-FCN)
	(LDESC "Il y a ici une brique carrée qui ressemble à de l'argile.")
	(CAPACITY 2)
	(SIZE 9)>

<OBJECT EXPLOSION
	(SYNONYM KREBF)
	(DESC "débris d'un explosion")
	(LDESC
"La pièce est encombrée de débris d'une explosion.")
	(FLAGS )>

<OBJECT DEAD-BALLOON
	(SYNONYM BALLOON BASKET)
	(ADJECTIVE BROKEN)
	(DESC "ballon cassé")
	(LDESC "Il y a ici un ballon brisé en morceaux.")
	(SIZE 40)>

<OBJECT ROUND-BUTTON
	(IN MACHINE-ROOM)
	(SYNONYM BUTTON)
	(ADJECTIVE ROUND)
	(DESC "rond bouton")
	(FLAGS NDESCBIT)
	(ACTION BUTTONS)>

<OBJECT SQUARE-BUTTON
	(IN MACHINE-ROOM)
	(SYNONYM BUTTON)
	(ADJECTIVE SQUARE)
	(DESC "bouton carré")
	(FLAGS NDESCBIT)
	(ACTION BUTTONS)>

<OBJECT TRIANGULAR-BUTTON
	(IN MACHINE-ROOM)
	(SYNONYM BUTTON)
	(ADJECTIVE TRIANGULAR)
	(DESC "bouton triangulaire")
	(FLAGS NDESCBIT)
	(ACTION BUTTONS)>

<OBJECT CARD
	(IN SAFE)
	(SYNONYM CARD NOTE)
	(DESC "carte")
	(FLAGS READBIT TAKEBIT BURNBIT)
	(LDESC "Il y a une carte avec une écriture dessus ici.")
	(SIZE 1)
	(TEXT
"
Avertissement :|
    Cette pièce a été construite au-dessus de couches rocheuses très fragiles. Il est formellement interdit d'y faire exploser des charges !|
         Compagnie des cavernes magiques Frobozz|
         M. Agrippa, contremaître|
") >

<OBJECT CLOTH-BAG
	(IN BALLOON)
	(SYNONYM BAG)
	(ADJECTIVE CLOTH)
	(FLAGS NDESCBIT)
	(DESC "sac en tissu")
	(ACTION BCONTENTS)>

<OBJECT CROWN
	(IN SAFE)
	(SYNONYM CROWN TREASURE)
	(ADJECTIVE GAUDY)
	(DESC "couronne voyante")
	(FLAGS STAGGERED TAKEBIT WEARBIT)
	(FDESC
"La couronne trop voyante du Seigneur Nigaud Tête-Plate se trouve dans le en sécurité.")
	(LDESC "La couronne de Lord Dimwit est ici.")
	(SIZE 10)
	(VALUE 20)>

<OBJECT PALANTIR-1	;"was SPHER"
	(IN CAGE-ROOM)
	(SYNONYM SPHERE BALL PALANTIR)
	(ADJECTIVE CRYSTAL RED)
	(DESC "sphère de cristal rouge")
	(FLAGS STAGGERED TAKEBIT TRANSBIT TRYTAKEBIT)
	(ACTION SPHERE-FCN)
	(LDESC "Il y a une belle sphère de cristal rouge ici.")
	(SIZE 10)
	(VALUE 20)>

<OBJECT VIOLIN
	(IN IRON-BOX)
	(SYNONYM STRADIVARIUS VIOLIN TREASURE)
	(ADJECTIVE FANCY)
	(DESC "violon fantaisie")
	(FLAGS STAGGERED TAKEBIT)
	(LDESC "Il y a un Stradivarius ici.")
	(SIZE 10)
	(VALUE 20)
	(ACTION VIOLIN-FCN)>

<OBJECT ICE
	(IN GLACIER-ROOM)
	(SYNONYM ICE MASS GLACIER)
	(ADJECTIVE COLD ICY)
	(DESC "glacier")
	(ACTION GLACIER-FCN)
	(LDESC "Une masse de glace remplit la moitié ouest de la pièce.")>

<OBJECT FLASK
	(IN POOL-ROOM)
	(SYNONYM FLASK)
	(ADJECTIVE GLASS)
	(DESC "flacon en verre bouché rempli de liquide")
	(FLAGS TAKEBIT TRANSBIT READBIT)
	(ACTION FLASK-FCN)
	(LDESC
"Une fiole en verre avec un marquage du crâne et des crosses est là. La fiole est remplie d'un liquide clair.")
	(CAPACITY 5)
	(TEXT "Il y a une tête de mort gravée sur le verre.")
	(SIZE 10)>

<OBJECT ROBOT-LABEL
	(IN MAGNET-ROOM)
	(SYNONYM PAPER PIECE INSTRUCTIONS)
	(ADJECTIVE GREEN)
	(DESC "morceau de verre vert papier")
	(FLAGS READBIT TAKEBIT BURNBIT)
	(LDESC "Il y a un morceau de papier vert ici.")
	(SIZE 3)
	(TEXT
" !!  SOCIÉTÉ DE ROBOT MAGIQUE FROBOZZ !!||

Bonjour Maître !|
|
   Je suis un robot récent, formé à GUE Tech pour réaliser diverses
fonctions domestiques simples.|
|
   Pour m'activer, dites ce qui suit : |
|
        >ROBOT, <choses à faire>|
|
A votre service !") >

<OBJECT SLOT
	(IN SAFE-ROOM)
	(SYNONYM SLOT HOLE)
	(DESC "trou")
	(FLAGS OPENBIT NDESCBIT)
	(CAPACITY 10)
	(ACTION SLOT-F)>

<ROUTINE SLOT-F ()
	 <COND (<AND <VERB? LOOK-INSIDE> <NOT <FIRST? ,SLOT>>>
		<TELL "Il n'y a rien dans le trou." CR>)
	       (<VERB? EXAMINE>
		<TELL
"Le trou oblong a été arraché de la boîte, probablement par quelqu'un voulant ce qui est dans la boîte. La tentative était un échec pathétique, cependant." CR>)>>

<OBJECT HOOK-2
	(IN LEDGE-2)
	(SYNONYM HOOK)
	(ADJECTIVE SMALL)
	(DESC "crochet")
	(LDESC "Il y a un petit crochet attaché au rocher ici.")>

<OBJECT HOOK-1
	(IN LEDGE-1)
	(SYNONYM HOOK)
	(ADJECTIVE SMALL)
	(DESC "crochet")
	(LDESC "Il y a un petit crochet attaché au rocher ici.")>

<OBJECT LAMP
	(IN INSIDE-BARROW)
	(SYNONYM LAMP LANTERN LIGHT)
	(ADJECTIVE BRASS)
	(DESC "lampe")
	(FLAGS TAKEBIT LIGHTBIT)
	(FDESC "Une lanterne en laiton étrangement familière repose sur le sol.")
	(ACTION LANTERN)
	(SIZE 15)>

<OBJECT BROKEN-LAMP	;"was BLAMP"
	(SYNONYM LAMP LANTERN LIGHT)
	(ADJECTIVE BROKEN BRASS)
	(DESC "laiton cassé lanterne")
	(FLAGS TAKEBIT)
	(SIZE 15)>

<OBJECT ALICE-TABLE
	(IN TEA-ROOM)
	(SYNONYM TABLE)
	(ADJECTIVE LARGE OBLONG)
	(FLAGS CONTBIT SURFACEBIT OPENBIT)
	(DESC "grande table oblongue")
	(CAPACITY 50)>

<OBJECT MANGLED-CAGE
	(SYNONYM CAGE)
	(ADJECTIVE MANGLED STEEL)
	(DESC "cage mutilée")
	(FLAGS TAKEBIT)
	(LDESC "Il y a une cage en acier mutilée ici.")
	(SIZE 60)>

<OBJECT PEARL
	(IN PEARL-ROOM)
	(SYNONYM NECKLACE PEARLS TREASURE)
	(ADJECTIVE PEARL)
	(DESC "collier de perles")
	(FLAGS STAGGERED TAKEBIT)
	(LDESC "Il y a ici un collier de perles avec des centaines de grosses perles.")
	(SIZE 10)
	(VALUE 15)>

<OBJECT EAT-ME-CAKE
	(IN ALICE-TABLE)
	(SYNONYM CAKE ICING CAKES LETTER)
	(ADJECTIVE GREEN FROSTED)
	(DESC "gâteau glacé portant des lettres vertes")
	(FLAGS READBIT TAKEBIT FOODBIT)
	(ACTION EATME-FCN)
	(TEXT "Le glaçage indique \"Mange-moi\".")
	(SIZE 4)>

<OBJECT BLUE-ICING
	(IN ALICE-TABLE)
	(SYNONYM CAKE ICING CAKES LETTER)
	(ADJECTIVE BLUE FROSTED)
	(DESC "gâteau glacé avec des lettres bleues")
	(FLAGS READBIT TAKEBIT FOODBIT)
	(ACTION CAKE-FCN)
	(SIZE 4)>

<OBJECT ORANGE-ICING
	(IN ALICE-TABLE)
	(SYNONYM CAKE CAKES ICING LETTER)
	(ADJECTIVE ORANGE FROSTED)
	(DESC "gâteau givré avec lettres orange")
	(FLAGS READBIT TAKEBIT FOODBIT)
	(ACTION CAKE-FCN)
	(SIZE 4)>

<OBJECT RED-ICING
	(IN ALICE-TABLE)
	(SYNONYM CAKE CAKES ICING LETTER)
	(ADJECTIVE RED FROSTED)
	(DESC "gâteau givré avec lettres rouges")
	(FLAGS READBIT TAKEBIT FOODBIT)
	(ACTION CAKE-FCN)
	(SIZE 4)>

<OBJECT LEAK
	(IN POOL-ROOM)
	(SYNONYM LEAK)
	(ADJECTIVE LARGE)
	(DESC "fuite")
	(FLAGS NDESCBIT)
	(ACTION PLEAK)>

<OBJECT POOL
	(IN POOL-ROOM)
	(SYNONYM POOL TEARS)
	(ADJECTIVE LARGE)
	(DESC "pool de larmes")
	(LDESC
"La fuite a submergé la zone dépressive dans une piscine de larmes. Il y a un bazar dans la partie la plus profonde de la piscine.")
	(ACTION POOL-FCN)>

<OBJECT COIN
	(IN LEDGE-1)
	(SYNONYM COIN ZORKMID GOLD TREASURE)
	(ADJECTIVE GOLD PRICELESS)
	(DESC "zorkmid inestimable")
	(FLAGS STAGGERED READBIT TAKEBIT)
	(FDESC
"Sur le sol se trouve un zorkmid en or inestimable (une précieuse pièce de collection ")
	(LDESC "Il y a un zorkmid gravé ici.")
	(SIZE 10)
	(VALUE 20)
	(TEXT
"Cette magnifique pièce octogonale porte les inscriptions \"Dix mille zorkmids\" et \"Nous croyons en Frobs\".")>

;"      -------------------------|
      /      Gold Zorkmid        \\|
     /  T e n   T h o u s a n d   \\|
    /        Z O R K M I D S       \\|
   /                                \\|
  /        !!!!!!!!!!!!!!!!!!        \\|
 /        !!!!!          !!!!!        \\|
!           !!!  ^^  ^^  !!!           !|
!           !!!  OO  OO  !!!           !|
! In Frobs  !!!    <<    !!!  We Trust !|
!            !! (______) !!            !|
!             !          !             !|
!             !__________!             !|
 \\                                    /|
  \\     -- Lord Dimwit Flathead --   /|
   \\     -- Beloved of Zorkers --   /|
    \\                              /|
     \\       * 722 G.U.E. *       /|
      \\                          /|
       --------------------------|
"

<OBJECT STAMP
	(IN PURPLE-BOOK)
	(SYNONYM STAMP TREASURE)
	(ADJECTIVE FLATHEAD)
	(DESC "Tampon Tête-Plate")
	(FLAGS STAGGERED READBIT TAKEBIT BURNBIT)
	(LDESC "Il y a un tampon Tête-Plate ici.")
	(SIZE 1)
	(VALUE 10)
	(TEXT "Ce timbre zorkmid porte un portrait de Seigneur Nigaud Tête-Plate, \"Notre Leader excessif\".")>

;"|
---v----v----v----v----v---|
!   !!!!!!!!!!     LORD   !|
> !!!!!       !   DIMWIT  <|
!  !!!!    ---!  FLATHEAD !|
!  !!!C    CC \\           !|
>   !!        _\\          <|
!    !!! (____!           !|
!     !!      !    Our    !|
>      !______! Excessive <|
!        /   \\   Leader   !|
!                         !|
>    G.U.E.       Three   <|
!   POSTAGE      Zorkmids !|
---^----^----^----^----^---|
"

<OBJECT GREEN-BOOK
	(IN LIBRARY)
	(SYNONYM BOOK COVER BOOKS)
	(ADJECTIVE HANDSOME GREEN LEATHER)
	(DESC "livre vert")
	(FLAGS READBIT TAKEBIT CONTBIT BURNBIT)
	(FDESC
"Un beau livre, relié en cuir vert, se trouve au centre du salle.")
	(CAPACITY 2)
	(SIZE 10)
	(TEXT "Ce livre est écrit dans une langue que je ne connais pas.")
	(ACTION RANDOM-BOOK)>

<OBJECT BLUE-BOOK
	(IN LIBRARY)
	(SYNONYM BOOK COVER BOOKS)
	(ADJECTIVE BLUE)
	(DESC "livre bleu")
	(FLAGS READBIT TAKEBIT CONTBIT BURNBIT)
	(FDESC "Porté et battu dans un coin de la pièce. un livre bleu.")
	(CAPACITY 2)
	(SIZE 10)
	(TEXT "Ce livre est écrit dans une langue que je ne connais pas.")
	(ACTION RANDOM-BOOK)>

<OBJECT WHITE-BOOK
	(IN LIBRARY)
	(SYNONYM BOOK COVER BOOKS)
	(ADJECTIVE WHITE GLOSSY)
	(DESC "livre blanc")
	(FLAGS READBIT TAKEBIT CONTBIT BURNBIT)
	(FDESC
"Juste à côté du livre violet se trouve un livre blanc.")
	(CAPACITY 2)
	(SIZE 5)
	(TEXT
"Il est écrit dans une langue inconnue et détaille l'utilisation de divers objets magiques, principalement la soi-disant « baguette magique ». Apparemment, ces dispositifs fonctionnent en les pointant sur l'objet à ensorceller, puis en chantant les mots magiques appropriés. (C'est vraiment incroyable combien ces anciens étaient crédules, n'est-ce pas?)")
	(ACTION RANDOM-BOOK)>

<OBJECT PURPLE-BOOK
	(IN LIBRARY)
	(SYNONYM BOOK BOOKS)
	(ADJECTIVE PURPLE)
	(DESC "livre violet")
	(FLAGS READBIT TAKEBIT CONTBIT SEARCHBIT BURNBIT)
	(LDESC
"Gît dans la poussière et recouvert de moisissure se trouve un violet livre.")
	(CAPACITY 2)
	(SIZE 10)
	(ACTION PURPLE-BOOK-FCN)
	(TEXT
"Ce livre est écrit dans une langue que je ne connais pas. En supposant que l'on puisse effectivement dire un livre par sa couverture, il est probablement rempli de prose pourpre, dont on voit rarement en dehors du Grand Empire Souterrain.")>

<OBJECT RECEPTACLE
	(IN BALLOON)
	(SYNONYM RECEPTACLE)
	(ADJECTIVE METAL)
	(DESC "réceptacle")
	(FLAGS CONTBIT SEARCHBIT NDESCBIT)
	(ACTION BCONTENTS)
	(CAPACITY 6)>

<OBJECT ROBOT
	(IN MAGNET-ROOM)
	(SYNONYM ROBOT R2D2 C3PO ROBBY)
	(DESC "robot")
	(FLAGS ACTORBIT CONTBIT OPENBIT)
	(ACTION ROBOT-FCN)
	(LDESC "Il y a un robot ici.")>

<OBJECT RUBY
	(IN LAVA-ROOM)
	(SYNONYM RUBY TREASURE)
	(ADJECTIVE MOBY)
	(DESC "rubis")
	(FLAGS STAGGERED TAKEBIT)
	(FDESC "Sur le sol se trouve un rubis moby.")
	(LDESC "Il y a un rubis moby couché ici.")
	(VALUE 15)>

<OBJECT IRON-BOX
	(IN CAROUSEL-ROOM)
	(SYNONYM BOX)
	(ADJECTIVE STEEL DENTED)
	(DESC "boîte en acier")
	(FLAGS CONTBIT TAKEBIT INVISIBLE)
	(LDESC "Il y a une boîte en acier bosselée ici.")
	(CAPACITY 20)
	(SIZE 40)>

<OBJECT CAGE
	(IN CAGE-ROOM)
	(FLAGS INVISIBLE)
	(SYNONYM CAGE)
	(ADJECTIVE STEEL SOLID)
	(DESC "acier massif cage")
	(LDESC "Il y a une cage en acier solide au milieu de la pièce.")>

<OBJECT CANDY
	(IN POOL-ROOM)
	(SYNONYM PACKAGE CANDY TREASURE GRASSHOPPERS)
	(ADJECTIVE CANDIED RARE)
	(DESC "paquet de bonbons")
	(FLAGS STAGGERED FOODBIT TAKEBIT INVISIBLE READBIT)
	(LDESC "Il y a un paquet de friandises confites ici.")
	(ACTION CANDY-FCN)
	(SIZE 8)
	(VALUE 15)>

<OBJECT TOP-ETCHINGS
	(IN WELL-TOP)
	(SYNONYM ETCHINGS WALL)
	(DESC "mur couvert de gravures")
	(FLAGS READBIT NDESCBIT)
	(ACTION TOP-ETCHINGS-F)>

<OBJECT BOTTOM-ETCHINGS
	(IN WELL-BOTTOM)
	(SYNONYM ETCHINGS WALL)
	(DESC "mur couvert de gravures")
	(FLAGS READBIT NDESCBIT)
	(ACTION BOTTOM-ETCHINGS-F)>

<OBJECT FUSE
	(IN COBWEBBY-CORRIDOR)
	(SYNONYM FUSE STRING COIL)
	(ADJECTIVE BLACK THIN)
	(DESC "ficelle noire")
	(FLAGS TAKEBIT BURNBIT)
	(ACTION FUSE-FCN)
	(LDESC "Il y a une bobine de ficelle tressée noire ici.")
	(SIZE 1)>

<OBJECT BUCKET
	(IN WELL-BOTTOM)
	(SYNONYM BUCKET)
	(ADJECTIVE WOODEN)
	(DESC "seau en bois")
	(FLAGS VEHBIT OPENBIT CONTBIT)
	(ACTION BUCKET-FCN)
	(CONTFCN BUCKET-CONT)
	(LDESC
"Il y a ici un seau en bois, de 3 pieds de diamètre et 3 pieds de haut.")
	(CAPACITY 100)
	(SIZE 100)
	(VTYPE 0)>

<OBJECT POSTS
	(IN POSTS-ROOM)
	(SYNONYM POSTS POST)
	(ADJECTIVE WOODEN)
	(FLAGS NDESCBIT)
	(DESC "groupe de bois posts")>

"SOUS-TITRE OBJETS BANCAIRES"

<OBJECT BILLS
	(IN VAULT)
	(SYNONYM BILLS STACK MONEY TREASURE)
	(ADJECTIVE NEAT MANY ZORKMID)
	(DESC "pile de billets de zorkmid")
	(FLAGS STAGGERED READBIT TAKEBIT BURNBIT)
	(ACTION BILLS-OBJECT)
	(LDESC
	 "200 zorkmid soigneusement empilés les billets sont ici.")
	(FDESC
	 "Sur le sol se trouvent 200 billets de zorkmid soigneusement empilés.")
	(SIZE 10)
	(VALUE 25)
	(TEXT "Chaque billet vaut 100 zorkmids et porte l'inscription \"Nous croyons en Frobs\".")>

;"
______________________________________________________________
+ 1  0   0          GREAT UNDERGROUND EMPIRE         1  0   0 +|
+ 1 0 0 0 0					     1 0 0 0 0+|
+ 1 0 0 0 0					     1 0 0 0 0+|
+ 1  0   0		    DIMWIT		     1  0   0 +|
+	               ++++++++++++++++	  		      +|
+		       ++   __  __   ++		   B30332744D +|
+		       ++  -OO  OO-  ++	  		      +|
+	IN  FROBS      \\++    >>    ++/	    WE  TRUST         +|
+		        ++  ______  ++	       		      +|
+ B30332744D	         +  ------  +	       		      +|
+                        \\\\________//	       		      +|
+ 1  0   0    Series	   FLATHEAD	LD Flathead  1  0   0 +|
+ 1 0 0 0 0   719GUE	   		 Treasurer   1 0 0 0 0+|
+ 1 0 0 0 0 					     1 0 0 0 0+|
+ 1  0   0	  One Hundred Royal Zorkmids	     1  0   0 +|
+_____________________________________________________________+|

"
	
<OBJECT PORTRAIT
	(IN OFFICE)
	(SYNONYM PORTRAIT PAINTING ART TREASURE)
	(ADJECTIVE FLATHEAD)
	(DESC "portrait de J. Pierpont Tête-Plate")
	(FLAGS STAGGERED TAKEBIT BURNBIT)	
	(LDESC
	 "Le portrait de J. Pierpont Tête-Plate est ici.")
	(FDESC
	 "Un portrait de J. Pierpont Tête-Plate est accroché au mur.")
	(SIZE 25)
	(VALUE 20)>

;"|
        !!!!!!!!!!!!!!|
       !!   __  __   !!|
       !!   $$  $$   !!|
       \\!!    >>    !!/|
        !!  ______  !!|
         !  -//--   !|
         \\\\_//_____//|
        ___//!  !|
        \\_// !  !|
  __________//  \\\\__________|
 / $ /       *ZZ*       \\ $ \\|
|
     J.  PIERPONT  FLATHEAD|
          CHAIRMAN|
"

<OBJECT BANK-BROCHURE
	(IN DEPOSITORY)
	(SYNONYM BROCHURE PAPER PIECE)
	(ADJECTIVE BANK SMALL WORN)
	(DESC "brochure bancaire")
	(FDESC "Sur le fond est un petit morceau de papier usé.")
	(FLAGS READBIT TAKEBIT BURNBIT)
	(SIZE 2)
	(TEXT
"Le papier est à peine lisible. Vous pouvez seulement distinguer \"... les objets de valeur sont complètement sûrs ... technologie magique avancée ... impossible à prendre les objets de valeur du dépositaire ... soit caissier ... Beaucoup de clients évanouis ... caissier pops in ... semble marcher à travers ... murs ...\"")>

<OBJECT CUBE
	(IN DEPOSITORY)
	(SYNONYM VAULT CUBE LETTER)
	(ADJECTIVE STONE LARGE)
	(DESC "grand cube de pierre")
	(FLAGS READBIT NDESCBIT)
	(ACTION CUBE-F)>

<OBJECT CURTAIN
	(IN DEPOSITORY)
	(SYNONYM CURTAIN LIGHT)
	(ADJECTIVE SHIMMERING)
	(DESC "rideau de lumière scintillant")
	(FLAGS NDESCBIT)
	(ACTION SCOL-OBJECT)>

<OBJECT GNOME-OF-ZURICH
	(SYNONYM GNOME ZURICH)
	(ADJECTIVE ZURICH)
	(DESC "Gnome de Zurich")
	(FLAGS ACTORBIT CONTBIT OPENBIT)
	(ACTION ZGNOME-FCN)
	(LDESC "Il y a ici un Gnome de Zurich.")>

<OBJECT DEPOSIT-BOX
	(IN GNOME-OF-ZURICH)
	(SYNONYM BOX)
	(ADJECTIVE DEPOSIT SAFETY)
	(DESC "coffre-fort")
	(FLAGS NDESCBIT TAKEBIT TRYTAKEBIT)
	(ACTION BOX-F)>

;"PALANTIR SECTION"

<OBJECT PDOOR
	(IN LOCAL-GLOBALS)
	(SYNONYM DOOR)
	(ADJECTIVE WOODEN OAK)
	(DESC "porte en chêne")
	(FLAGS DOORBIT CONTBIT)
	(ACTION PDOOR-FCN)>

<OBJECT PWINDOW
	(IN LOCAL-GLOBALS)
	(SYNONYM WINDOW)
	(ADJECTIVE BARRED)
	(DESC "fenêtre à barreaux")
	(FLAGS DOORBIT)
	(ACTION PWINDOW-FCN)>

<OBJECT LID-1
	(IN TINY-ROOM)
	(SYNONYM LID)
	(ADJECTIVE METAL)
	(DESC "couvercle en métal")
	(FLAGS NDESCBIT CONTBIT)
	(ACTION PLID-FCN)>

<OBJECT LID-2
	(IN DREARY-ROOM)
	(SYNONYM LID)
	(ADJECTIVE METAL)
	(DESC "couvercle en métal")
	(FLAGS NDESCBIT CONTBIT OPENBIT)
	(ACTION PLID-FCN)>

<OBJECT PTABLE
	(IN DREARY-ROOM)
	(SYNONYM TABLE)
	(ADJECTIVE DUSTY WOODEN)
	(DESC "table")
	(FLAGS NDESCBIT CONTBIT SURFACEBIT OPENBIT)
	(CAPACITY 40)>

<OBJECT PCRACK
	(IN DREARY-ROOM)
	(SYNONYM CRACK)
	(ADJECTIVE NARROW)
	(DESC "étroit fissure")
	(FLAGS NDESCBIT)>

<OBJECT KEYHOLE-1
	(IN TINY-ROOM)
	(SYNONYM KEYHOLE HOLE)
	(DESC "trou de serrure")
	(FLAGS NDESCBIT OPENBIT SEARCHBIT)
	(ACTION PKH-FCN)
	(CAPACITY 2)>

<OBJECT KEYHOLE-2
	(IN DREARY-ROOM)
	(SYNONYM KEYHOLE HOLE)
	(DESC "trou de serrure")
	(FLAGS NDESCBIT OPENBIT SEARCHBIT)
	(ACTION PKH-FCN)
	(CAPACITY 2)>

<OBJECT LETTER-OPENER
	(IN GAZEBO-TABLE)
	(SYNONYM OPENER)
	(ADJECTIVE LETTER)
	(DESC "ouvre-lettre")
	(SIZE 2)
	(FLAGS TAKEBIT TOOLBIT)>

<OBJECT KEY
	(IN KEYHOLE-2)
	(SYNONYM KEY)
	(ADJECTIVE IRON RUSTY)
	(DESC "fer rouillé clé")
	(FLAGS TAKEBIT NDESCBIT TURNBIT TOOLBIT)
	(ACTION PKEY-FCN)
	(SIZE 2)>

<OBJECT PALANTIR-2
	(IN DREARY-ROOM)
	(SYNONYM PALANTIR SPHERE)
	(ADJECTIVE CRYSTAL BLUE)
	(DESC "sphère de cristal bleu")
	(FLAGS STAGGERED TAKEBIT TRANSBIT)
	(ACTION PALANTIR)
	(VALUE 20)
	(FDESC "Au centre de la table se trouve un cristal bleu sphère.")>

<OBJECT GAZEBO
	(IN LOCAL-GLOBALS)
	(SYNONYM GAZEBO STRUCTURE)
	(ADJECTIVE WOODEN)
	(DESC "belvédère")
	(FLAGS NDESCBIT)
	(ACTION GAZEBO-FCN)>

<OBJECT GAZEBO-TABLE
	(IN GAZEBO-ROOM)
	(SYNONYM TABLE)
	(ADJECTIVE TEA)
	(DESC "table")
	(FLAGS NDESCBIT SURFACEBIT CONTBIT OPENBIT)
	(CAPACITY 100)>

<OBJECT NEWSPAPER
	(IN GAZEBO-TABLE)
	(SYNONYM PAPER NEWSPAPER)
	(ADJECTIVE NEWS NEWSPAPER)
	(DESC "journal")
	(FLAGS TAKEBIT BURNBIT READBIT)
	(TEXT
"** Gazette des États-Unis et des Donjons **|
|
UN CÉLÈBRE AVENTURIER PART À LA DÉCOUVERTE DU GRAND EMPIRE SOUTERRAIN|
|
Nos correspondants signalent qu'un aventurier mondialement connu et aguerri a été aperçu aux abords du Grand Empire Souterrain. Les grues locales auraient commencé à aiguiser leurs crocs dégoulinants...|
|
\"Zork II : Le Magicien de Frobozz\" a été écrit par Dave Lebling et Marc Blank. Copyright (c) 1981, 1982, 1983 Infocom, Inc.")>

<OBJECT PLACE-MAT
	(IN GAZEBO-TABLE)
	(SYNONYM MAT PLACEM)
	(ADJECTIVE PLACE)
	(DESC "set de table")
	(FLAGS TAKEBIT SURFACEBIT CONTBIT OPENBIT)
	(ACTION PLACE-MAT-FCN)
	(SIZE 12)
	(CAPACITY 20)>

<OBJECT TEAPOT
	(IN GAZEBO-TABLE)
	(SYNONYM TEAPOT POT)
	(ADJECTIVE CHINA TEA)
	(DESC "chine théière")
	(FLAGS TAKEBIT TRANSBIT CONTBIT OPENBIT)
	(CAPACITY 4)
	(ACTION TEAPOT-F)>

<ROUTINE TEAPOT-F ()
	 <COND (<VERB? CLOSE>
		<TELL "La théière n'a pas de couvercle." CR>)>>

<OBJECT WATER
	(SYNONYM WATER QUANTITY LIQUID H2O)
	(DESC "quantité d'eau")
	(FLAGS TAKEBIT DRINKBIT)
	(ACTION WATER-FCN)
	(LDESC "Il y a de l'eau ici.")
	(SIZE 4)>

<OBJECT SALTY-WATER
	(SYNONYM WATER QUANTITY LIQUID H2O)
	(DESC "quantité de sel eau")
	(FLAGS TAKEBIT DRINKBIT)
	(ACTION WATER-FCN)
	(LDESC "Il y a de l'eau ici.")
	(SIZE 4)>

<OBJECT GOLD-KEY
	(IN UNICORN)
	(SYNONYM KEY TREASURE)
	(ADJECTIVE DELICATE GOLD)
	(DESC "clé en or délicate")
	(FLAGS STAGGERED NDESCBIT TAKEBIT TRYTAKEBIT)
	(ACTION UNICORN-FCN)
	(VALUE 15)
	(SIZE 3)>

<OBJECT RIBBON
	(IN UNICORN)
	(SYNONYM RIBBON)
	(ADJECTIVE VELVET SATIN)
	(DESC "ruban")
	(ACTION UNICORN-FCN)
	(FLAGS NDESCBIT)>

<OBJECT ROSE
	(SYNONYM ROSE)
	(ADJECTIVE BEAUTIFUL RED PERFECT)
	(DESC "rose parfaite")
	(FLAGS TAKEBIT)
	(SIZE 1)
	(ACTION ROSE-F)>

<ROUTINE ROSE-F ()
	 <COND (<VERB? SMELL>
		<TELL
"Contrairement à vos efforts ici, elle sent la rose."CR>)
	       (<VERB? EXAMINE>
		<TELL "Une rose est une rose est une rose...." CR>)>>

<OBJECT GENIE
	(SYNONYM DEVIL DEMON GENIE DJINN)
	(DESC "démon")
	(FLAGS ACTORBIT INVISIBLE)
	(ACTION GENIE-FCN)
	(LDESC "Il y a un démon flottant dans les airs ici.")>

<OBJECT WIZARD
	(SYNONYM WIZARD MAGICIAN SORCEROR MAN)
	(ADJECTIVE STRANGE LITTLE FROBOZZ OLD)
	(DESC "Magicien de Frobozz")
	(LDESC
"Le Magicien de Frobozz se trouve ici et vous examine d'un air méfiant.")
	(FLAGS ACTORBIT CONTBIT OPENBIT)
	(ACTION WIZARD-FCN)>

<OBJECT WAND
	(IN WIZARD)
	(SYNONYM WAND)
	(ADJECTIVE MAGIC)
	(DESC "Baguette magique du sorcier")
	(FLAGS STAGGERED NDESCBIT TAKEBIT TRYTAKEBIT)
	(ACTION WAND-FCN)
	(VALUE 30)>

<OBJECT SWORD
	(IN INSIDE-BARROW)
	(SYNONYM SWORD ORCRIST GLAMDRING BLADE)
	(ADJECTIVE ELVISH OLD ANTIQUE)
	(DESC "épée elfique")
	(FLAGS TAKEBIT WEAPONBIT TRYTAKEBIT)
	(ACTION SWORD-FCN)
	(LDESC "Une épée elfique d'une grande antiquité est ici.")
	(FDESC "Une épée de fabrication elfique est sur le sol.")
	(SIZE 30)>

<OBJECT REPELLENT
	(IN ROOM-8)
	(SYNONYM REPELLENT CAN)
	(ADJECTIVE GRUE MAGIC)
	(DESC "Répulsif magique Frobozz contre les grues")
	(FLAGS TAKEBIT READBIT)
	(ACTION REPELLENT-FCN)
	(FDESC
"Une bombe aérosol se trouve dans un coin. Elle porte en gros caractères l'inscription \"Répulsif magique Frobozz contre les grues\".")
	(TEXT
"!!! RÉPULSIF MAGIQUE FROBOZZ CONTRE LES GRUES !!!|
|
Mode d'emploi : appliquez généreusement sur la créature à protéger. La durée de l'effet est imprévisible. À n'utiliser qu'en cas de danger mortel !|
|
(Aucune garantie, expresse ou implicite)")>

<ROOM DEAD-PALANTIR-1
	(IN ROOMS)
	(LDESC " ")
	(DESC "Chambre de brume rouge")
	(WEST TO DEAD-PALANTIR-2)
	(FLAGS RLANDBIT ONBIT)
	(ACTION DEAD-PALANTIR)
	(GLOBAL GLOBAL-PALANTIR)>

<ROOM DEAD-PALANTIR-2
	(IN ROOMS)
	(LDESC " ")
	(DESC "Chambre de brume bleue")
	(WEST TO DEAD-PALANTIR-3)
	(FLAGS RLANDBIT ONBIT)
	(ACTION DEAD-PALANTIR)
	(GLOBAL GLOBAL-PALANTIR)>

<ROOM DEAD-PALANTIR-3
	(IN ROOMS)
	(LDESC " ")
	(DESC "Chambre de blanc Brume")
	(WEST TO DEAD-PALANTIR-4)
	(FLAGS RLANDBIT ONBIT)
	(ACTION DEAD-PALANTIR)
	(GLOBAL GLOBAL-PALANTIR)>

<ROOM DEAD-PALANTIR-4
	(LDESC " ")
	(IN ROOMS)
	(DESC "Chambre du noir Brume")
	(FLAGS RLANDBIT ONBIT)
	(ACTION DEAD-PALANTIR)>

<OBJECT GLOBAL-PALANTIR
	(IN LOCAL-GLOBALS)
	(SYNONYM SPHERE)
	(ADJECTIVE RED BLUE WHITE CRYSTAL)
	(DESC "sphère")
	(FLAGS NDESCBIT)
	(ACTION GLOBAL-PALANTIRS)>

<OBJECT FOOTPAD
	(IN GLOBAL-OBJECTS)
	(SYNONYM FOOTPAD)
	(DESC "repose-pieds")
	(ACTION FOOTPAD-F)>

<ROUTINE FOOTPAD-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "Un repose-pieds est un voleur." CR>)>>

<OBJECT COMPASS
	(IN GLOBAL-OBJECTS)
	(DESC "boussole")
	(SYNONYM COMPASS)
	(ACTION COMPASS-F)>

<ROUTINE COMPASS-F ()
	 <COND (<VERB? FIND>
		<TELL
"C'est sur votre personne et chanceux pour vous, ou vous deviendrez désespérément perdu." CR>)
	       (<VERB? DROP THROW OVERBOARD>
		<TELL
"Vous ne pouvez pas vous en débarrasser. C'est une extension de vous-même." CR>)
	       (<VERB? EXAMINE>
		<TELL
"C'est un de ces gizmos avec une aiguille et une carte avec les huit directions de la boussole principale. Simple, mais efficace." CR>)
	       (<VERB? READ>
		<TELL
"Cela ne permet pas une lecture très intéressante - juste les directions de la boussole." CR>)
	       (T
		<TELL
"Vous ne pouvez pas faire ça. Et ne vous embêtez pas à demander pourquoi." CR>)>>

