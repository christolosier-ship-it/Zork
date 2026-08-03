"2DUNGEON pour Zork II : Le Magicien de Frobozz
(c) Copyright 1981, 1983 Infocom, Inc. Tous droits réservés."

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

"SOUS-TITRE : SORTIES CONDITIONNELLES"

<GLOBAL SECRET-DOOR <>>
<GLOBAL GNOME-DOOR-FLAG <>>

"SOUS-TITRE GLOBAL OBJECTS"

<OBJECT STREAM
	(IN LOCAL-GLOBALS)
	(SYNONYM STREAM)
	(ADJECTIVE FLOWING SMALL)
	(DESC "ruisseau")
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
	(DESC "mur ouest")
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
	(DESC "voeu")
	(FLAGS NDESCBIT)
	(ACTION WISH-FCN)>

<OBJECT WELL
        (IN LOCAL-GLOBALS)
	(SYNONYM WELL)
	(ADJECTIVE MAGIC)
	(DESC "puits")
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
	(DESC "mur ouest")
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
"Vous êtes dans un antique tumulus, dissimulé au plus profond d'une forêt obscure. À son extrémité sud, le tombeau s'ouvre sur un étroit tunnel dont le fond laisse filtrer une faible lueur.")
      (DESC "À l'intérieur du tumulus")
      (FLAGS RLANDBIT ONBIT)
      (SOUTH TO NARROW-TUNNEL)
      (OUT
"Vous ne vous en souvenez peut-être pas, mais la porte du tumulus s'est refermée derrière vous à votre arrivée. Il n'existe aucune issue.")>

<ROOM NARROW-TUNNEL
      (IN ROOMS)
      (LDESC
"Vous vous tenez à l'extrémité sud d'un étroit tunnel, là où il débouche dans une vaste caverne. Des mousses phosphorescentes accrochées à la haute voûte y diffusent une faible lumière. Un profond ravin serpente à travers la caverne ; un petit ruisseau en occupe le fond. Les parois du ravin sont abruptes et friables. Au sud, une passerelle le franchit.")
      (DESC "Tunnel étroit")
      (FLAGS RLANDBIT ONBIT)
      (NORTH TO INSIDE-BARROW)
      (SOUTH TO FOOT-BRIDGE)
      (CROSS TO FOOT-BRIDGE)
      (DOWN "En commençant à descendre, vous glissez sur les roches friables et vous rejetez en arrière, évitant de justesse une chute mortelle.")
      (GLOBAL BRIDGE CHASM STREAM MOSS)>

<ROOM FOOT-BRIDGE
      (IN ROOMS)
      (LDESC
"Vous vous tenez sur une passerelle de bois rudimentaire mais solide, jetée au-dessus d'un profond ravin. Le sentier se poursuit vers le nord et le sud.")
      (DESC "Passerelle")
      (FLAGS RLANDBIT ONBIT)
      (NORTH TO NARROW-TUNNEL)
      (SOUTH TO GREAT-CAVERN)
      (DOWN "La chute serait fatale.")
      (CROSS "Vous devrez indiquer une direction.")
      (GLOBAL BRIDGE CHASM)>

<ROOM GREAT-CAVERN
      (IN ROOMS)
      (LDESC
"Vous êtes au centre de la grande caverne, creusée dans le calcaire. Stalactites et stalagmites de toutes tailles foisonnent alentour. La lueur diffuse des mousses phosphorescentes anime d'étranges ombres autour de vous. Un étroit sentier serpente vers le sud-ouest entre les stalagmites ; un autre mène au nord-est.")
      (DESC "Grande caverne")
      (FLAGS RLANDBIT ONBIT)
      (NE TO FOOT-BRIDGE)
      (SW TO SHALLOW-FORD)
      (GLOBAL MOSS)
      (PSEUDO "STALAGMITE" STALA-PSEUDO "STALACTITE" STALA-PSEUDO)>

<ROOM SHALLOW-FORD
      (IN ROOMS)
      (LDESC
"Vous êtes à l'extrémité sud d'une grande caverne. Au-delà d'un gué peu profond, vers le sud, s'ouvre un tunnel obscur qui semble avoir jadis été élargi et lissé. Au nord, un étroit sentier serpente entre les stalagmites. Une faible lumière baigne la caverne.")
      (DESC "Gué peu profond")
      (FLAGS RLANDBIT ONBIT)
      (NORTH TO GREAT-CAVERN)
      (SOUTH TO DARK-TUNNEL)
      (CROSS TO DARK-TUNNEL)
      (GLOBAL GLOBAL-WATER)>

<ROOM DARK-TUNNEL
      (IN ROOMS)
      (LDESC
"C'est un tunnel obscur, au fond duquel luit une faible clarté vers le nord-est. Ses parois sont lisses, mais le sol poussiéreux est jonché de brindilles et de feuilles. Ces débris s'accumulent à mesure que le tunnel se divise entre un large couloir au sud-ouest et un passage plus étroit au sud-est.")
      (DESC "Tunnel obscur")
      (FLAGS RLANDBIT)
      (NE TO SHALLOW-FORD)
      (SE TO GARDEN-NORTH)
      (SW TO STREAM-PATH)>

"SOUS-TITRE : JARDIN"

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
	(LDESC "Une magnifique licorne broute paisiblement l'herbe.")
	(FLAGS ACTORBIT TRYTAKEBIT OPENBIT CONTBIT)
	(ACTION UNICORN-FCN)>

<ROOM GARDEN-NORTH
      (IN ROOMS)
      (LDESC
"Vous êtes à l'extrémité nord d'un jardin à la française. Les haies dissimulent les parois de la caverne et, si vous ne levez pas les yeux, vous pourriez vous croire dehors par une journée nuageuse. La lumière émane d'une vaste nappe de mousses luminescentes qui tapisse la voûte. Au nord, une trouée dans la haie est presque entièrement envahie par la végétation. Un sentier soigneusement entretenu mène au sud. Au milieu d'un parterre de roses se dresse un petit pavillon ouvert, peint en blanc.")
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
"Vous êtes sous un pavillon au coeur du jardin à la française. L'endroit est frais et reposant. Une table à thé en occupe le centre.")
      (DESC "Pavillon")
      (FLAGS RLANDBIT ONBIT)
      (OUT TO GARDEN-NORTH)
      (GLOBAL GLOBAL-UNICORN GAZEBO)>

<ROOM FORMAL-GARDEN
      (IN ROOMS)
      (LDESC
"Vous êtes au milieu d'un jardin à la française. Les haies masquent les parois de la caverne, tandis que des mousses très haut placées répandent une clarté diffuse. Un sentier de gravier blanc serpente du sud au nord entre les buissons et les parterres. On aperçoit une petite construction au nord et d'étranges topiaires au sud. Une étroite trouée s'ouvre dans les haies à l'ouest.")
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
"Vous êtes à l'extrémité sud d'un jardin à la française. Les haies cachent les parois de la caverne et les mousses dispensent une faible lumière. Buissons et topiaires aux formes fantastiques sont disposés avec une précision géométrique. Faute de taille récente, leurs contours se sont brouillés, mais on reconnaît encore un dragon, une licorne, un grand serpent, un chien énorme et difforme, ainsi que plusieurs silhouettes humaines. À l'ouest, le sentier traverse une tonnelle de roses avant de s'enfoncer dans un tunnel.")
      (DESC "Jardin des topiaires")
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
"Les haies ont la forme de divers animaux -- chiens, serpents, dragons et autres créatures -- dont la vue inspire un vague malaise." CR>)>>

<ROOM STREAM-PATH
      (IN ROOMS)
      (LDESC
"Le sentier longe la rive sud d'un profond ravin avant de partir au nord-est. Vers le sud-ouest, un tunnel se resserre jusqu'à devenir un boyau difficilement praticable ; un faible bourdonnement en provient. À l'est se dresse une arche en ruine, étouffée par la végétation.")
	(DESC "Sentier près du ruisseau")
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
"Cette galerie voûtée est revêtue d'un marbre raffiné. Au nord, elle s'interrompt brusquement devant un gué, là où le marbre s'est fissuré et brisé -- peut-être sous l'effet d'une crue ou d'un effondrement. Au sud, la galerie débouche dans une vaste salle d'où monte un bourdonnement passablement agaçant.")
      (DESC "Galerie de marbre")
      (FLAGS RLANDBIT)
      (EAST TO STREAM-PATH IF SECRET-DOOR ELSE "C'est bien un mur.")
      (NORTH TO DEEP-FORD)
      (SOUTH TO CAROUSEL-ROOM)
      (GLOBAL STREAM)>

<ROOM DEEP-FORD
      (IN ROOMS)
      (LDESC
"Vous traversez le ruisseau à gué en un point profond, mais encore praticable. L'eau est glaciale. Les parois du ravin se dressent à l'est et à l'ouest. Une étroite corniche longe sa face nord. Au sud s'ouvre une galerie bien construite, quoique partiellement ruinée.")
      (DESC "Gué profond")
      (FLAGS RLANDBIT)
      (NORTH TO RAVINE-LEDGE)
      (UP TO RAVINE-LEDGE)
      (SOUTH TO MARBLE-HALL)
      (EAST
"Le ruisseau devient rapidement plus profond ; vous avez la sagesse de rebrousser chemin avant de vous noyer.")
      (WEST
"Vous remarquez que la corniche supérieure offrirait un chemin plus sec vers l'ouest.")
      (GLOBAL GLOBAL-WATER CHASM STREAM)>

<ROOM RAVINE-LEDGE
      (IN ROOMS)
      (LDESC
"Vous êtes sur une étroite corniche, près du fond d'un profond ravin. Elle se poursuit vers l'ouest. Une escalade périlleuse permettrait d'atteindre une corniche minuscule plus haut ; quelques pas d'escalade vers le bas conduisent au ruisseau.")
      (DESC "Corniche du ravin")
      (FLAGS RLANDBIT)
      (UP TO TINY-ROOM)
      (SOUTH TO DEEP-FORD)
      (WEST TO LEDGE-TUNNEL)
      (DOWN TO DEEP-FORD)
      (GLOBAL CHASM)>

<ROOM LEDGE-TUNNEL
      (IN ROOMS)
      (LDESC
"La corniche venue de l'est s'achève ici. Un tunnel s'enfonce dans la paroi vers le nord ; son air tiède charrie une singulière odeur de fumée.")
      (DESC "Bout de la corniche")
      (FLAGS RLANDBIT)
      (EAST TO RAVINE-LEDGE)
      (IN TO DRAGON-ROOM)
      (NORTH TO DRAGON-ROOM)
      (DOWN "De nombreux rochers acérés vous attendent en contrebas.")>

<ROOM DRAGON-ROOM
      (IN ROOMS)
      (LDESC
"Cette vaste caverne est encombrée de blocs fracassés. Les parois sont calcinées et le sol porte de profondes griffures. Une forte odeur de suie sèche imprègne les lieux. Un chemin pavé part d'un large passage à l'ouest, traverse la salle et gagne au sud un immense pont de pierre. Une petite fissure est visible à l'est, tandis qu'un tunnel obscur et enfumé mène au nord.")
      (DESC "Salle du dragon")
      (FLAGS RLANDBIT)
      (EAST TO LEDGE-TUNNEL)
      (NORTH TO DRAGON-LAIR
	IF ICE-MELTED ELSE "Le dragon siffle dans votre direction et vous barre le passage.")
      (IN TO DRAGON-LAIR
        IF ICE-MELTED ELSE "Le dragon siffle dans votre direction et vous barre le passage.")
      (WEST TO FRESCO-ROOM)
      (SOUTH TO STONE-BRIDGE)
      (CROSS TO STONE-BRIDGE)
      (GLOBAL BRIDGE)>

<ROOM DRAGON-LAIR
      (IN ROOMS)
      (LDESC
"Vous êtes dans l'antre du dragon, dont les flammes ont marqué les parois rocheuses. Une ouverture noircie mène au sud.")
      (DESC "Antre du dragon")
      (FLAGS RLANDBIT)
      (SOUTH TO DRAGON-ROOM)
      (OUT TO DRAGON-ROOM)>

<OBJECT CHEST
	(IN DRAGON-LAIR)
	(SYNONYM CHEST TRUNK)
	(ADJECTIVE WOODEN OLD ROTTEN)
	(DESC "coffre de bois vermoulu")
	(FDESC
"Un vieux coffre de bois vermoulu repose dans un coin, parmi les débris.")
	(FLAGS CONTBIT TAKEBIT)
	(ACTION CHEST-FCN)
	(CAPACITY 40)
	(SIZE 40)>

<OBJECT STATUETTE
	(IN CHEST)
	(SYNONYM TREASURE STATUETTE DRAGON)
	(ADJECTIVE GOLD)
	(DESC "statuette de dragon en or")
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
"Un énorme dragon rouge repose sur les rochers et vous observe.")
	(FDESC
"Un énorme dragon rouge est étendu ici et bloque l'entrée d'un tunnel menant au nord. Des volutes de fumée s'échappent de ses narines et filtrent entre ses dents.")
	(FLAGS ACTORBIT)
	(ACTION DRAGON-FCN)>

<OBJECT DEAD-DRAGON
	(SYNONYM DRAGON SMAUG WORM)
	(ADJECTIVE RED HUGE DEAD)
	(DESC "cadavre de l'énorme dragon")
	(LDESC
"Le cadavre d'un énorme dragon obstrue à moitié le ruisseau.")
	(SIZE 400)>

<OBJECT GLOBAL-PRINCESS
	(IN GLOBAL-OBJECTS)
	(SYNONYM PRINCESS WOMAN LADY)
	(ADJECTIVE BEAUTIFUL YOUNG)
	(DESC "belle princesse")
	(FLAGS ACTORBIT)
	(ACTION PRINCESS-FCN)>

<OBJECT PRINCESS
	(IN DRAGON-LAIR)
	(SYNONYM PRINCESS WOMAN LADY)
	(ADJECTIVE BEAUTIFUL YOUNG)
	(DESC "belle princesse")
	(LDESC
"Une belle jeune femme, vêtue d'une robe sale et en lambeaux, est assise sur un rocher dans un coin. Ses cheveux sont en bataille et, presque en transe, elle ne paraît pas remarquer votre présence.")
	(FLAGS ACTORBIT)
	(ACTION PRINCESS-FCN)>

<ROOM FRESCO-ROOM
      (IN ROOMS)
      (LDESC
"Un sentier traverse d'est en ouest une salle ornée de magnifiques fresques représentant un héros aux prises avec des dragons et délivrant de nobles demoiselles. Impossible de savoir de qui il s'agit : les parties concernées ont été noircies et fendillées par une chaleur intense.")
      (DESC "Salle des fresques")
      (FLAGS RLANDBIT)
      (EAST TO DRAGON-ROOM)
      (WEST TO BANK-ENTRANCE)>

<ROOM STONE-BRIDGE
      (IN ROOMS)
      (LDESC
"Vous êtes au milieu d'un pont de pierre en ruine, mais encore imposant, qui enjambe un profond gouffre. L'eau coule très loin en contrebas. Un chemin pavé mène au nord vers un vaste espace découvert et, au sud, vers un tunnel noyé de brume.")
      (DESC "Pont de pierre")
      (FLAGS RLANDBIT)
      (NORTH TO DRAGON-ROOM)
      (SOUTH TO COOL-ROOM)
      (DOWN "Le fond est très loin.")
      (CROSS "Vous devrez indiquer une direction.")
      (GLOBAL BRIDGE CHASM)>

<ROOM COOL-ROOM
      (IN ROOMS)
      (LDESC
"Cette salle est fraîche et humide ; une brume flotte dans l'air. Un sentier tortueux venu du sud-est se divise ici : une branche gagne au nord un large pont de pierre, l'autre s'enfonce à l'ouest dans un tunnel étroit. C'est de ce dernier que semblent provenir le froid et la brume.")
      (DESC "Salle fraîche")
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
"Vous êtes dans une étroite cheminée de lave solidifiée. Elle se prolonge encore sur une bonne centaine de pieds vers le haut et plonge vers une vaste salle très loin en contrebas. Au sud s'ouvre une large fissure, probablement due au déplacement des strates rocheuses.")
      (DESC "Tunnel de lave")
      (FLAGS RLANDBIT)
      (DOWN TO GLACIER-ROOM)
      (UP TO VOLCANO-VIEW)
      (SOUTH TO COBWEBBY-CORRIDOR)
      (PSEUDO "CRACK" LT-CRACK-PSEUDO)>

<ROUTINE LT-CRACK-PSEUDO ()
	 <COND (<VERB? BOARD THROUGH>
		<DO-WALK ,P?SOUTH>
		<RTRUE>)
	       (T <CC-CRACK-PSEUDO>)>>

<ROOM COBWEBBY-CORRIDOR
      (IN ROOMS)
      (LDESC
"Un couloir sinueux est envahi de toiles d'araignée. Certaines sont déchirées et la poussière du sol a été remuée. Malgré ses nombreux détours, le passage suit globalement un axe nord-est--sud-ouest. Dans l'un des coudes, une étroite fissure s'ouvre en hauteur sur la paroi nord.")
      (DESC "Couloir aux toiles d'araignée")
      (FLAGS RLANDBIT)
      (IN TO LAVA-TUBE)
      (UP TO LAVA-TUBE)
      (NORTH TO LAVA-TUBE)
      (NE TO CAROUSEL-ROOM)
      (SW TO GUARDIAN-ROOM)
      (DOWN TO GUARDIAN-ROOM)
      (PSEUDO "CRACK" CC-CRACK-PSEUDO)>

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
	(DESC "porte partiellement couverte de toiles d'araignée")
	(FLAGS DOORBIT CONTBIT)
	(ACTION WIZ-DOOR-FCN)>

<ROOM ROOM-8
      (IN ROOMS)
      (LDESC
"Cette petite chambre a été creusée dans la roche au bout d'un court boyau. Le chiffre « 8 » est grossièrement gravé sur la paroi.")
      (DESC "Salle 8")
      (FLAGS RLANDBIT)
      (EAST TO CAROUSEL-ROOM)>

<ROOM MENHIR-ROOM
      (IN ROOMS)
      (DESC "Salle du menhir")
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
"Cette pièce semble avoir servi de chenil à un chien gigantesque -- certains os conviendraient à un dinosaure. L'épaisse couche de poussière indique qu'elle est abandonnée depuis fort longtemps. L'unique sortie mène au nord-est.")
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
"Un collier gigantesque, assez grand pour trois chiens de la taille d'un rhinocéros, gît parmi les débris.")
	(DESC "gigantesque collier de chien")
	(FLAGS STAGGERED TAKEBIT)
	(ACTION COLLAR-FCN)
	(VALUE 15)>

\

"SOUS-TITRE : LABYRINTHE DE DIAMANT"

<OBJECT BAT
	(SYNONYM CLUB BAT)
	(ADJECTIVE WOODEN BASEBALL)
	(FDESC
"Une longue massue de bois repose près de la fenêtre en losange. Son extrémité la plus épaisse est curieusement brûlée.")
	(DESC "massue en bois")
	(FLAGS INVISIBLE TAKEBIT WEAPONBIT READBIT BURNBIT)
	(TEXT
"Les mots « Babe Tête-Plate » ont été marqués au fer dans le bois.")>

<ROOM STAIRWAY-TOP
      (IN ROOMS)
      (LDESC
"Un escalier de marbre descend dans les ténèbres, tandis qu'un passage mène au nord.")
      (DESC "Escalier")
      (FLAGS RLANDBIT)
      (DOWN TO DIAMOND-5)
      (NORTH TO MENHIR-ROOM)
      (GLOBAL STAIRS)>

<ROOM DIAMOND-1
      (IN ROOMS)
      (DESC
"Salle aux angles étranges")
      (LDESC
"C'est une petite salle aux murs bizarrement inclinés, percée de passages dans toutes les directions.")
      (FLAGS RLANDBIT)
      (SE TO DIAMOND-5)
      (ACTION DIAMOND-MOTION)
      (GLOBAL DWINDOW)>

<ROOM DIAMOND-2
      (IN ROOMS)
      (DESC
"Salle aux angles étranges")
      (LDESC
"C'est une petite salle aux murs bizarrement inclinés, percée de passages dans toutes les directions.")
      (FLAGS RLANDBIT)
      (SOUTH TO DIAMOND-5)
      (SE TO DIAMOND-6)
      (SW TO DIAMOND-4)
      (ACTION DIAMOND-MOTION)
      (GLOBAL DWINDOW)>

<ROOM DIAMOND-3
      (IN ROOMS)
      (DESC
"Salle aux angles étranges")
      (LDESC
"C'est une petite salle aux murs bizarrement inclinés, percée de passages dans toutes les directions.")
      (FLAGS RLANDBIT)
      (SW TO DIAMOND-5)
      (ACTION DIAMOND-MOTION)
      (GLOBAL DWINDOW)>

<ROOM DIAMOND-4
      (IN ROOMS)
      (DESC
"Salle aux angles étranges")
      (LDESC
"C'est une petite salle aux murs bizarrement inclinés, percée de passages dans toutes les directions.")
      (FLAGS RLANDBIT)
      (NE TO DIAMOND-2)
      (SE TO DIAMOND-8)
      (EAST TO DIAMOND-5)
      (ACTION DIAMOND-MOTION)
      (GLOBAL DWINDOW)>

<ROOM DIAMOND-5
      (IN ROOMS)
      (DESC
"Salle aux angles étranges")
      (LDESC
"C'est une petite salle aux murs bizarrement inclinés, percée de passages dans toutes les directions.")
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
"Salle aux angles étranges")
      (LDESC
"C'est une petite salle aux murs bizarrement inclinés, percée de passages dans toutes les directions.")
      (FLAGS RLANDBIT)
      (WEST TO DIAMOND-5)
      (NW TO DIAMOND-2)
      (SW TO DIAMOND-8)
      (ACTION DIAMOND-MOTION)
      (GLOBAL DWINDOW)>

<ROOM DIAMOND-7
      (IN ROOMS)
      (DESC
"Salle aux angles étranges")
      (LDESC
"C'est une petite salle aux murs bizarrement inclinés, percée de passages dans toutes les directions.")
      (FLAGS RLANDBIT)
      (NE TO DIAMOND-5)
      (ACTION DIAMOND-MOTION)
      (GLOBAL DWINDOW)>

<ROOM DIAMOND-8
      (IN ROOMS)
      (DESC
"Salle aux angles étranges")
      (LDESC
"C'est une petite salle aux murs bizarrement inclinés, percée de passages dans toutes les directions.")
      (FLAGS RLANDBIT)
      (NORTH TO DIAMOND-5)
      (NW TO DIAMOND-4)
      (NE TO DIAMOND-6)
      (ACTION DIAMOND-MOTION)
      (GLOBAL DWINDOW)>

<ROOM DIAMOND-9
      (IN ROOMS)
      (DESC
"Salle aux angles étranges")
      (LDESC
"C'est une petite salle aux murs bizarrement inclinés, percée de passages dans toutes les directions.")
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
"Vous êtes à l'entrée d'une immense crypte, ou peut-être d'un tombeau. Un escalier de marbre remonte sous une arche monumentale.")
      (DESC "Salle de Cerbère")
      (FLAGS RLANDBIT)
      (EAST TO CRYPT-ANTEROOM
       IF CERBERUS-LEASHED ELSE "L'énorme chien claque méchamment des mâchoires dans votre direction.")
      (IN TO CRYPT-ANTEROOM
       IF CERBERUS-LEASHED ELSE "L'énorme chien claque méchamment des mâchoires dans votre direction.")
      (UP TO DIAMOND-5)
      (VALUE 10)
      (GLOBAL STAIRS)
      (PSEUDO "TOMB" TOMB-PSEUDO "CRYPT" TOMB-PSEUDO)>

<OBJECT GLOBAL-CERBERUS
	(IN LOCAL-GLOBALS)
	(SYNONYM CERBERUS DOG HOUND MONSTER)
	(ADJECTIVE HUGE GIANT THREE HEADED)
	(ACTION GLOBAL-CERBERUS-F)
	(DESC "chien à trois têtes")>

<ROUTINE GLOBAL-CERBERUS-F ()
	 <TELL "Il n'est pas là." CR>>

<OBJECT CERBERUS
	(IN CERBERUS-ROOM)
	(SYNONYM CERBERUS DOG HOUND MONSTER)
	(ADJECTIVE HUGE GIANT THREE HEADED)
	(DESC "chien à trois têtes")
	(LDESC
"Un chien à l'air féroce garde l'entrée. Il ressemble à un chien ordinaire, à ceci près qu'il possède trois têtes et la taille d'un éléphant.")
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
        (DESC "rangée de têtes fichées sur des piques")
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION HEAD-FCN)>

<OBJECT CRYPT
	(IN CRYPT-ROOM)
	(SYNONYM TOMB CRYPT GRAVE)
	(ADJECTIVE MARBLE)
	(DESC "crypte de marbre")
	(FLAGS NDESCBIT READBIT)
	(ACTION CRYPT-OBJECT)
	(TEXT
"« Ci-gisent les Tête-Plate, dont les têtes furent plantées sur des piques par le Gardien du Donjon pour cause de mauvais goût prodigieux. »")>

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

"SOUS-TITRE : ATELIER DU MAGICIEN"

<ROOM GUARDIAN-ROOM
      (IN ROOMS)
      (LDESC " ")
      (DESC "Salle gardée")
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
"Vous êtes dans l'atelier du Magicien de Frobozz.")
      (DESC "Atelier du Magicien")
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
"Vous êtes dans le laboratoire du Magicien. Une galerie se poursuit à l'est et à l'ouest, tandis qu'une salle plus vaste s'ouvre au sud. Les murs sont couverts d'étagères et de râteliers, mais l'imposant établi du Magicien domine la pièce. Fabriqué dans un bois sombre et massif cerclé de fer, il porte les taches de longues années de travail ainsi que de profondes entailles, comme si un énorme animal griffu y avait été entravé. On y distingue des brûlures et des notes tracées d'une écriture serrée. Alambics, mortier et pilon, petits couteaux de toutes tailles, fragments de vélin, bougies de cire et quantité d'autres objets ésotériques encombrent l'établi. Au centre d'une zone relativement dégagée, trois socles -- de rubis, de saphir et de diamant -- forment un triangle.")
      (DESC "Laboratoire du Magicien")
      (FLAGS RLANDBIT ONBIT)
      (EAST TO WIZARDS-WORKSHOP)
      (SOUTH TO PENTAGRAM-ROOM)
      (WEST TO AQUARIUM-ROOM)
      (PSEUDO "MORTAR" ARCANA-PSEUDO "PESTLE" ARCANA-PSEUDO)>

<OBJECT ARCANA
	(IN WORKBENCH-ROOM)
	(SYNONYM ALEMBIC VELLUM CANDLES KNIVES)
        (ADJECTIVE WAX SMALL)
	(DESC "objet ésotérique")
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION ARCANA-PSEUDO)>

<OBJECT WORKBENCH
	(IN WORKBENCH-ROOM)
	(SYNONYM WORKBENCH BENCH TABLE)
	(ADJECTIVE WORK HEAVY WOODEN WIZARD)
	(DESC "établi du Magicien")
	(CAPACITY 200)
	(FLAGS NDESCBIT SURFACEBIT CONTBIT OPENBIT)>

<OBJECT STAND-1
	(IN WORKBENCH)
	(SYNONYM STAND STANDS)
	(ADJECTIVE CRYSTAL RUBY)
	(DESC "socle de rubis")
	(FLAGS NDESCBIT SURFACEBIT CONTBIT OPENBIT)
	(CAPACITY 10)
	(ACTION STAND-FCN)>

<OBJECT STAND-2
	(IN WORKBENCH)
	(SYNONYM STAND STANDS)
	(ADJECTIVE CRYSTAL SAPPHIRE)
	(DESC "socle de saphir")
	(FLAGS NDESCBIT SURFACEBIT OPENBIT CONTBIT)
	(CAPACITY 10)
	(ACTION STAND-FCN)>

<OBJECT STAND-3
	(IN WORKBENCH)
	(SYNONYM STAND STANDS)
	(ADJECTIVE DIAMOND CRYSTAL)
	(DESC "socle de diamant")
	(FLAGS NDESCBIT SURFACEBIT OPENBIT CONTBIT)
	(CAPACITY 10)
	(ACTION STAND-FCN)>

<OBJECT STAND-4
	(SYNONYM STAND STANDS)
	(ADJECTIVE OBSIDIAN BLACK CRYSTAL STRANGE)
	(DESC "socle d'obsidienne noire")
	(FLAGS SURFACEBIT CONTBIT OPENBIT)
	(SIZE 5)
	(CAPACITY 10)
	(ACTION STAND-FCN)>

<OBJECT PALANTIR-4
	(IN STAND-4)
	(SYNONYM SPHERE BALL PALANTIR)
	(ADJECTIVE CRYSTAL STRANGE BLACK)
	(DESC "sphère de cristal noire")
	(FLAGS STAGGERED TAKEBIT TRANSBIT)
	(ACTION PALANTIR)
	(LDESC "Une étrange sphère noire repose ici.")
	(VALUE 30)
	(SIZE 10)>

<ROOM TROPHY-ROOM
      (IN ROOMS)
      (LDESC
"Vous êtes dans la salle des trophées du Magicien, remplie de souvenirs hétéroclites. Sur un mur est accroché son diplôme de D. T. -- docteur en thaumaturgie -- délivré par l'Institut technologique du GES. Plusieurs vieilles baguettes magiques sont alignées sur un râtelier. Une collection d'épées ternies et ébréchées témoigne du sort de nombreux aventuriers téméraires. De petites fioles renferment des homoncules réformés, dont quelques-uns conservés dans l'alcool. Un hibou empaillé trône sur un perchoir.")
      (DESC "Salle des trophées")
      (FLAGS RLANDBIT)
      (NORTH TO WIZARDS-WORKSHOP)
      (PSEUDO
       "OWL" TROPHY-PSEUDO
       "HOMUNCULI" TROPHY-PSEUDO)>

<OBJECT DEGREE
	(IN TROPHY-ROOM)
	(SYNONYM DEGREE DIPLOMA)
	(DESC "diplôme")
	(FLAGS NDESCBIT TRYTAKEBIT READBIT)
	(ACTION TROPHY-PSEUDO)
	(TEXT
"Le texte est rédigé dans une langue obscure. Vous ne parvenez à déchiffrer qu'une allusion à « l'envoi d'une couverture de carnet d'allumettes ».")>

<OBJECT WANDS
	(IN TROPHY-ROOM)
	(SYNONYM WANDS WAND RACK SET)
        (ADJECTIVE WORN USED)
	(DESC "lot de baguettes usagées")
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION TROPHY-PSEUDO)>

<OBJECT TROPHY-SWORD
	(IN TROPHY-ROOM)
	(SYNONYM SWORD SWORDS)
        (ADJECTIVE DULL NICKED)
	(DESC "épées ébréchées")
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION TROPHY-PSEUDO)>

<OBJECT TROPHY-BOTTLES
	(IN TROPHY-ROOM)
	(SYNONYM BOTTLE)
        (ADJECTIVE SMALL)
	(DESC "petites fioles")
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION TROPHY-PSEUDO)>

<OBJECT WARNING-LABEL
	(IN TROPHY-ROOM)
	(SYNONYM LABEL)
	(ADJECTIVE WARNING)
	(DESC "étiquette d'avertissement")
	(LDESC "Une étiquette manuscrite est fixée au mur.")
	(FLAGS READBIT)
	(TEXT
"Attention !| |Les pièces exposées ici sont la propriété du puissant Magicien de Frobozz -- moi-même -- et le fruit de longues années de travail assidu et d'études. Quiconque y touchera le regrettera.| |(signé)|Frobozz|")>

<OBJECT GLOBAL-WIZARD-CASE
	(IN LOCAL-GLOBALS)
	(SYNONYM CASE CABINET)
	(ADJECTIVE TROPHY WIZARD)
	(DESC "vitrine à trophées du Magicien")
	(ACTION WIZARD-CASE-FCN)>

<OBJECT WIZARD-CASE
	(IN TROPHY-ROOM)
	(SYNONYM CASE CABINET)
	(ADJECTIVE TROPHY WIZARD)
	(DESC "vitrine à trophées du Magicien")
	(FLAGS CONTBIT TRANSBIT)
	(LDESC "Une vitrine à trophées richement ouvragée est encastrée dans le mur.")
	(ACTION WIZARD-CASE-FCN)
	(CAPACITY 1000)>

<OBJECT BROKEN-CASE
	(SYNONYM CASE CABINET)
	(ADJECTIVE BROKEN TROPHY WIZARD)
	(DESC "vitrine à trophées fracassée")
	(FLAGS CONTBIT OPENBIT)
	(LDESC "Les débris d'une vitrine à trophées fracassée jonchent la pièce.")>

<ROOM PENTAGRAM-ROOM
      (IN ROOMS)
      (LDESC
"Un immense pentagramme tracé à la craie noire couvre le sol de cette pièce. En son centre se trouve un cercle noir.")
      (DESC "Salle du pentagramme")
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
"Un couloir obscur forme ici un coude. Une salle ténébreuse s'ouvre au sud ; à l'est vacille une lumière irrégulière.")
      (DESC "Salle de l'aquarium")
      (FLAGS RLANDBIT ONBIT)
      (EAST TO WORKBENCH-ROOM)
      (IN TO IN-AQUARIUM)
      (SOUTH TO WIZARDS-QUARTERS)>

<OBJECT AQUARIUM
	(IN AQUARIUM-ROOM)
	(SYNONYM AQUARIUM GLASS)
	(ADJECTIVE HUGE)
	(DESC "aquarium")
	(LDESC "Un immense aquarium occupe toute la moitié nord de la salle.")
	(FLAGS OPENBIT CONTBIT)
	(CAPACITY 200)
	(ACTION AQUARIUM-FCN)>

<OBJECT PALANTIR-3
	(IN IN-AQUARIUM)
	(SYNONYM PALANTIR SPHERE)
	(ADJECTIVE CRYSTAL WHITE CLEAR)
	(DESC "sphère de cristal transparente")
	(LDESC "Une sphère de cristal transparente repose dans le sable.")
	(FLAGS STAGGERED TAKEBIT NDESCBIT TRANSBIT)
	(ACTION PALANTIR)
	(VALUE 20)>

<OBJECT SERPENT
	(IN AQUARIUM)
	(SYNONYM SERPENT SNAKE)
	(ADJECTIVE BABY SEA)
	(DESC "bébé serpent de mer")
	(LDESC "Un bébé serpent de mer nage dans l'aquarium.")
	(FLAGS ACTORBIT)
	(ACTION SERPENT-FCN)>

<OBJECT DEAD-SERPENT
	(SYNONYM SERPENT SNAKE)
	(ADJECTIVE DEAD BABY SEA)
	(DESC "serpent de mer mort")
	(LDESC "Le corps d'un serpent de mer gît ici en tas.")
	(FLAGS TAKEBIT)
	(ACTION DEAD-SERPENT-FCN)
	(SIZE 400)>

<ROOM IN-AQUARIUM
      (IN ROOMS)
      (LDESC
"Le sol semble couvert de sable, mais il est difficile de distinguer quoi que ce soit d'autre.")
      (DESC "Salle trouble")
      (FLAGS RLANDBIT ONBIT)
      (OUT TO AQUARIUM-ROOM)
      (ACTION IN-AQUARIUM-FCN)>

<ROOM WIZARDS-QUARTERS
      (IN ROOMS)
      (LDESC " ")
      (DESC "Appartements du Magicien")
      (FLAGS RLANDBIT)
      (NORTH TO AQUARIUM-ROOM)
      (ACTION WIZARD-QUARTERS-FCN)>

<ROOM CAROUSEL-ROOM
      (IN ROOMS)
      (LDESC " ")
      (DESC "Salle du carrousel")
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
       (DESC "Salle de l'énigme")
       (DOWN TO CAROUSEL-ROOM)
       (NW TO CAROUSEL-ROOM)
       (EAST TO PEARL-ROOM IF RIDDLE-DOOR IS OPEN)
       (FLAGS RLANDBIT)
       (ACTION RIDDLE-ROOM-FCN)
       (PSEUDO "RIDDLE" RIDDLE-PSEUDO)>

<OBJECT RIDDLE-DOOR
	(IN RIDDLE-ROOM)
	(DESC "porte de pierre")
	(SYNONYM DOOR)
	(ADJECTIVE GREAT STONE)
	(FLAGS DOORBIT CONTBIT NDESCBIT)
	(ACTION RIDDLE-DOOR-FCN)>

<ROOM PEARL-ROOM
        (IN ROOMS)
	(LDESC
"Cet endroit était autrefois un placard à balais. Des sorties mènent à l'est et à l'ouest.")
        (DESC "Salle de la perle")
       	(EAST TO WELL-BOTTOM)
	(WEST TO RIDDLE-ROOM)
	(FLAGS RLANDBIT)>

\

;"SUBTITLE VOLCANO AREA"

<ROOM VOLCANO-BOTTOM
        (IN ROOMS)
       (LDESC
"Vous êtes au fond d'un vaste volcan endormi. Très haut au-dessus, la lumière pénètre par le cratère. L'unique sortie mène au nord.")
       (DESC "Fond du volcan")
       (NORTH TO LAVA-ROOM)
       (FLAGS RLANDBIT NONLANDBIT)>

<ROOM VAIR-1
        (IN ROOMS)
       (LDESC
"Vous vous trouvez à une centaine de pieds au-dessus du fond du volcan. D'ici, son sommet est nettement visible.")
       (DESC "Coeur du volcan")
       (FLAGS NONLANDBIT NWALLBIT )>

<ROOM VAIR-2
        (IN ROOMS)
       (LDESC
"Vous êtes à quelque deux cents pieds au-dessus du fond du volcan. Le rebord du cratère se dresse au-dessus de vous. Une petite corniche est visible sur la paroi ouest.")
       (DESC "Volcan près de la petite corniche")
       (WEST TO LEDGE-1)
       (LAND TO LEDGE-1)
       (FLAGS NONLANDBIT NWALLBIT )>

<ROOM VAIR-3
        (IN ROOMS)
       (LDESC
"Vous êtes très haut au-dessus du fond du volcan, tout près de l'étroit rebord du cratère. À l'est se trouve ce qui ressemble à un belvédère, mais sa corniche est trop mince pour y atterrir.")
       (DESC "Volcan près du belvédère")
       (FLAGS NONLANDBIT NWALLBIT )>

<ROOM VAIR-4
       (IN ROOMS)
       (LDESC
"Vous êtes près du rebord du volcan, sous le ciel ouvert. À l'ouest, une large corniche offre un emplacement où se poser.")
       (DESC "Volcan près de la large corniche")
       (LAND TO LEDGE-2)
       (WEST TO LEDGE-2)
       (FLAGS NONLANDBIT NWALLBIT )>

<ROOM LEDGE-1
       (IN ROOMS)
       (LDESC
"Vous êtes sur une étroite corniche à l'intérieur d'un vieux volcan endormi, à mi-hauteur entre le fond et le cratère. Une sortie mène au sud.")
       (DESC "Corniche étroite")
       (DOWN "Je ne sauterais pas d'ici.")
       (WEST TO VOLCANO-BOTTOM IF GNOME-DOOR-FLAG)
       (SOUTH TO LIBRARY)
       (FLAGS RLANDBIT NONLANDBIT)>

<ROOM LIBRARY
       (IN ROOMS)
       (LDESC
"Ce lieu devait être une vaste bibliothèque, probablement destinée à la famille royale. Des gnomes peu amènes ont rongé toutes les étagères jusqu'à les réduire en miettes. Une sortie mène au nord.")
       (DESC "Bibliothèque")
       (NORTH TO LEDGE-1)
       (OUT TO LEDGE-1)
       (FLAGS RLANDBIT)>

<ROOM VOLCANO-VIEW
       (IN ROOMS)
       (LDESC
"Vous êtes sur une corniche à mi-hauteur d'un vaste volcan. Le fond est visible en contrebas et le rebord du cratère se dessine au-dessus. Deux autres corniches apparaissent sur la paroi opposée : l'une plus haute, l'autre plus basse que la vôtre. La sortie mène à l'est.")
       (DESC "Belvédère du volcan")
       (DOWN "Je n'essaierais pas ça.")
       (CROSS "Cette distance est impossible à franchir.")
       (EAST TO LAVA-TUBE)
       (FLAGS RLANDBIT)>

<ROOM LEDGE-2
       (IN ROOMS)
       (LDESC " ")
       (DESC "Large corniche")
       (DOWN "Le fond est très loin.")
       (WEST TO VOLCANO-BOTTOM IF GNOME-DOOR-FLAG)
       (SOUTH TO SAFE-ROOM)
       (ACTION LEDGE-FCN)
       (FLAGS RLANDBIT NONLANDBIT)>

<ROOM SAFE-ROOM
       (IN ROOMS)
       (LDESC " ")
       (DESC "Salle poussiéreuse")
       (NORTH TO LEDGE-2)
       (ACTION SAFE-ROOM-FCN)
       (FLAGS RLANDBIT ONBIT)>

<ROOM LAVA-ROOM
       (IN ROOMS)
       (LDESC
"C'est une petite salle dont les parois ont été façonnées par une ancienne coulée de lave. Des sorties mènent à l'est et au sud.")
       (DESC "Salle de lave")
       (SOUTH TO VOLCANO-BOTTOM)
       (EAST TO GLACIER-ROOM)
       (FLAGS RLANDBIT)>

<GLOBAL BLOC VOLCANO-BOTTOM>

\

"SOUS-TITRE : ALICE AU PAYS DES MERVEILLES"

<ROOM MAGNET-ROOM
       (IN ROOMS)
       (LDESC " ")
       (DESC "Salle basse")
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
"Cette vaste salle est remplie de lourdes machines de toutes sortes qui vrombissent bruyamment. Une odeur de résistances brûlées flotte dans l'air. Trois boutons sont alignés sur un mur : l'un rond, l'autre triangulaire et le dernier carré. Les instructions placées au-dessus sont, comme il se doit, rédigées en EBCDIC. Un grand panneau, écrit dans une langue plus accessible, proclame :| |        « DANGER -- HAUTE TENSION »| |Des sorties mènent à l'ouest et au sud.")
       (DESC "Salle des machines")
       (WEST TO MAGNET-ROOM)
       (SOUTH TO CAGE-ROOM)
       (FLAGS RLANDBIT ONBIT)>

<ROOM CAGE-ROOM
       (IN ROOMS)
       (LDESC
"Ce débarras lugubre jouxte une salle plus vaste au nord. Une inscription a été gravée dans le mur :| |        Protégé par la|      Société d'alarmes|      magiques FROBOZZ|        (Bonjour, coupe-jarret !)| |Pourtant, aucun coupe-jarret ne semble se trouver ici.")
       (DESC "Débarras lugubre")
       (OUT TO MACHINE-ROOM)
       (NORTH TO MACHINE-ROOM)
       (FLAGS ONBIT RLANDBIT)>

<ROOM IN-CAGE
       (IN ROOMS)
       (LDESC "Vous êtes enfermé dans une cage en acier massif.")
       (DESC "Cage")
       (ACTION IN-CAGE-FCN)
       (FLAGS RLANDBIT NWALLBIT ONBIT)>

<ROOM WELL-TOP
       (IN ROOMS)
       (LDESC
"Vous êtes au sommet du puits. Bien joué. Des gravures couvrent sa paroi. Une petite fissure traverse le sol à l'entrée d'une salle située à l'est, mais elle se franchit aisément.")
       (DESC "Sommet du puits")
       (EAST TO TEA-ROOM)
       (DOWN "La chute serait vertigineuse !")
       (FLAGS RLANDBIT NONLANDBIT)
       (VALUE 10)
       (GLOBAL WELL)
       (PSEUDO "CRACK" CRACK-PSEUDO)>

<ROUTINE CRACK-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL
"C'est une petite fissure -- comme annoncé -- parfaitement dépourvue d'intérêt." CR>)>>

<ROOM WELL-BOTTOM
       (IN ROOMS)
       (LDESC
"C'est une salle circulaire et humide, aux murs de brique et de mortier. Son plafond demeure invisible, mais des gravures semblent courir sur les parois. Un passage mène à l'ouest.")
       (DESC "Salle circulaire")
       (WEST TO PEARL-ROOM)
       (UP "Les murs ne peuvent pas être escaladés.")
       (FLAGS RLANDBIT NONLANDBIT)
       (GLOBAL WELL)>

<ROOM TEA-ROOM
       (IN ROOMS)
       (LDESC
"Cette petite salle contient une grande table oblongue, sans doute dressée pour le thé. Les objets qui s'y trouvent ne laissent aucun doute sur la folie de ses convives. Dans l'angle est s'ouvre un trou minuscule, haut de quatre pouces tout au plus. Des passages partent vers l'ouest et le nord-ouest.")
       (DESC "Salon de thé")
       (EAST "Seule une souris pourrait entrer là-dedans.")
       (WEST TO WELL-TOP)
       (NW TO MAGNET-ROOM)
       (FLAGS RLANDBIT ONBIT)
       (PSEUDO "HOLE" ALICE-HOLE)>

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
"Cette salle est gigantesque. En son centre, quatre poteaux de bois délimitent un rectangle surmonté de ce qui paraît être un toit. À vrai dire, tous les objets présents ici semblent démesurés. Un passage mène à l'est ; d'immenses gouffres béent à l'ouest et au nord-ouest.")
       (DESC "Salle des poteaux")
       (NW "Un immense gouffre vous barre le passage.")
       (EAST TO POOL-ROOM)
       (WEST "Un immense gouffre vous barre le passage.")
       (DOWN "Un immense gouffre vous barre le passage.")
       (FLAGS RLANDBIT ONBIT)
       (ACTION POSTS-ROOM-FCN)
       (GLOBAL CHASM)>

<ROOM POOL-ROOM
       (IN ROOMS)
       (LDESC
"Cette vaste salle présente une moitié en contrebas. De l'eau salée s'écoule par une importante fuite au plafond. L'unique sortie mène à l'ouest.")
       (DESC "Salle du bassin")
       (OUT TO POSTS-ROOM)
       (WEST TO POSTS-ROOM)
       (FLAGS RLANDBIT)>

\

; "SUBTITLE BANK OF ZORK"

<ROOM BANK-ENTRANCE
      (IN ROOMS)
      (LDESC
"Vous êtes dans le hall de la Banque de Zork, le plus grand établissement financier du Grand Empire Souterrain. Un aperçu de son histoire figure dans « La Vie des douze Tête-Plate », au chapitre consacré à J. Pierpont Tête-Plate. Une version plus détaillée -- quoique moins objective -- se trouve dans son extravagante autobiographie, « Je suis riche et pas vous -- bien fait ! ».|La plupart des meubles ont été saccagés par des pillards de passage. Il ne reste que deux panneaux, dans les angles nord-ouest et nord-est :| |        ← SALLES DE CONSULTATION →| |La sortie, ornée mais de bon goût, se trouve à l'est.")
      (DESC "Entrée de la banque")
      (NW TO TELLER-WEST)
      (NE TO TELLER-EAST)
      (EAST TO FRESCO-ROOM)
      (FLAGS RLANDBIT)>

<ROOM TELLER-WEST
      (IN ROOMS)
      (LDESC " ")
      (DESC "Guichet ouest")
      (NORTH TO VIEWING-WEST)
      (SOUTH TO BANK-ENTRANCE)
      (WEST TO DEPOSITORY)
      (ACTION TELLER-ROOM)
      (FLAGS RLANDBIT)>

<ROOM TELLER-EAST
      (IN ROOMS)
      (LDESC " ")
      (DESC "Guichet est")
      (NORTH TO VIEWING-EAST)
      (SOUTH TO BANK-ENTRANCE)
      (EAST TO DEPOSITORY)
      (ACTION TELLER-ROOM)
      (FLAGS RLANDBIT)>

<ROOM VIEWING-WEST
      (IN ROOMS)
      (LDESC
"Cette salle permettait aux détenteurs de coffres de dépôt d'en consulter le contenu. Sur le mur nord, un panneau indique :| |« Veuillez patienter ici pendant que le guichetier récupère votre coffre. Une fois votre consultation terminée, laissez-le sur place et sortez par le sud. Les coffres de dépôt ne doivent pas quitter cette salle !| |Merci d'avoir choisi la Banque de Zork ! »|")
      (DESC "Salle d'observation ouest")
      (SOUTH TO BANK-ENTRANCE)
      (FLAGS RLANDBIT)
      (GLOBAL SEWL SWWL SNWL SSWL)>

<ROOM VIEWING-EAST
      (IN ROOMS)
      (LDESC
"Cette salle permettait aux détenteurs de coffres de dépôt d'en consulter le contenu. Sur le mur nord, un panneau indique :| |« Veuillez patienter ici pendant que le guichetier récupère votre coffre. Une fois votre consultation terminée, laissez-le sur place et sortez par le sud. Les coffres de dépôt ne doivent pas quitter cette salle !| |Merci d'avoir choisi la Banque de Zork ! »|")
      (DESC "Salle d'observation est")
      (SOUTH TO BANK-ENTRANCE)
      (FLAGS RLANDBIT)
      (GLOBAL SEWL SWWL SNWL SSWL)>

<ROOM SMALL-ROOM
       (IN ROOMS)
      (LDESC
"C'est une petite salle nue, dépourvue du moindre signe distinctif. Elle ne possède aucune sortie.")
      (DESC "Petite salle")
      (FLAGS RLANDBIT )
      (GLOBAL SEWL SWWL SNWL SSWL)>

<ROOM VAULT
       (IN ROOMS)
      (LDESC
"Vous êtes dans la chambre forte de la Banque de Zork, une pièce qui ne possède aucune porte.")
      (DESC "Chambre forte")
      (FLAGS  RLANDBIT)
      (GLOBAL SEWL SWWL SNWL SSWL)>

<ROOM DEPOSITORY
       (IN ROOMS)
      (LDESC
"Cette vaste salle rectangulaire servait autrefois à entreposer des coffres de dépôt le long des murs est et ouest, mais des individus mal intentionnés les ont tous soigneusement emportés. De larges ouvertures mènent à l'est, à l'ouest et au sud. Le « mur » nord est un rideau de lumière scintillante. Au centre se dresse un cube de pierre d'environ dix pieds de côté, portant une inscription gravée.")
      (DESC "Salle des coffres de dépôt")
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
"Cette salle était le bureau du président de la Banque de Zork. Comme le reste des lieux, elle a été abondamment vandalisée. L'unique sortie mène au nord.")
      (DESC "Bureau du président")
      (NORTH TO DEPOSITORY)
      (FLAGS RLANDBIT)>

<OBJECT MATCH
	(IN GAZEBO-TABLE)
	(SYNONYM MATCH MATCHES MATCHBOOK)
	(ADJECTIVE ZORK)
	(DESC "carnet d'allumettes")
	(FLAGS READBIT TAKEBIT)
	(ACTION MATCH-FCN)
	(LDESC
"Un carnet d'allumettes portant la mention « Visitez ZORK I » se trouve ici.")
	(TEXT
"« >> Visitez le fabuleux ZORK I <<|
|
Consultez l'Agence de voyages magiques Frobozz ou votre revendeur informatique pour en savoir plus. »")
	(SIZE 2)>


\

"SOUS-TITRE : SALLES DES PALANTIRS"

<ROOM DREARY-ROOM
      (IN ROOMS)
      (LDESC " ")
      (DESC "Salle morne")
      (SOUTH TO TINY-ROOM IF PDOOR IS OPEN)
      (OUT TO TINY-ROOM IF PDOOR IS OPEN)
      (ACTION DREARY-ROOM-FCN)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL PDOOR PWINDOW)>

<ROOM TINY-ROOM
      (IN ROOMS)
      (LDESC " ")
      (DESC "Minuscule salle")
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
	(LDESC "Un Gnome du volcan visiblement nerveux se tient ici.")>

<OBJECT BALLOON
	(IN VOLCANO-BOTTOM)
	(SYNONYM BALLOON BASKET)
	(ADJECTIVE WICKER)
	(DESC "nacelle")
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
	(LDESC "Une étiquette bleue se trouve ici.")
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
	(DESC "coffre")
	(FLAGS CONTBIT NDESCBIT)
	(ACTION SAFE-FCN)
	(CAPACITY 15)>

<OBJECT BRAIDED-WIRE
	(FLAGS NDESCBIT)
	(IN BALLOON)
	(SYNONYM ROPE WIRE)
	(ADJECTIVE BRAIDED)
	(DESC "fil métallique tressé")
	(ACTION WIRE-FCN)>

<OBJECT BRICK
	(IN MARBLE-HALL)
	(SYNONYM BRICK)
	(ADJECTIVE SQUARE CLAY)
	(DESC "brique")
	(FLAGS TAKEBIT BURNBIT OPENBIT SEARCHBIT)
	(ACTION BRICK-FCN)
	(LDESC "Une brique carrée, qui semble faite d'argile, se trouve ici.")
	(CAPACITY 2)
	(SIZE 9)>

<OBJECT EXPLOSION
	(SYNONYM KREBF)
	(DESC "débris de l'explosion")
	(LDESC
"La salle est encombrée de débris laissés par une explosion. Les murs paraissent sur le point de s'effondrer.")
	(FLAGS )>

<OBJECT DEAD-BALLOON
	(SYNONYM BALLOON BASKET)
	(ADJECTIVE BROKEN)
	(DESC "ballon déchiré")
	(LDESC "Les restes déchirés d'un ballon gisent ici.")
	(SIZE 40)>

<OBJECT ROUND-BUTTON
	(IN MACHINE-ROOM)
	(SYNONYM BUTTON)
	(ADJECTIVE ROUND)
	(DESC "bouton rond")
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
	(LDESC "Une carte portant une inscription se trouve ici.")
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
	(DESC "sac en toile")
	(ACTION BCONTENTS)>

<OBJECT CROWN
	(IN SAFE)
	(SYNONYM CROWN TREASURE)
	(ADJECTIVE GAUDY)
	(DESC "couronne voyante")
	(FLAGS STAGGERED TAKEBIT WEARBIT)
	(FDESC
"La couronne outrageusement voyante du seigneur Nigaud Tête-Plate repose dans le coffre-fort.")
	(LDESC "La couronne du seigneur Nigaud est posée ici.")
	(SIZE 10)
	(VALUE 20)>

<OBJECT PALANTIR-1	;"was SPHER"
	(IN CAGE-ROOM)
	(SYNONYM SPHERE BALL PALANTIR)
	(ADJECTIVE CRYSTAL RED)
	(DESC "sphère de cristal rouge")
	(FLAGS STAGGERED TAKEBIT TRANSBIT TRYTAKEBIT)
	(ACTION SPHERE-FCN)
	(LDESC "Une magnifique sphère de cristal rouge repose ici.")
	(SIZE 10)
	(VALUE 20)>

<OBJECT VIOLIN
	(IN IRON-BOX)
	(SYNONYM STRADIVARIUS VIOLIN TREASURE)
	(ADJECTIVE FANCY)
	(DESC "violon ouvragé")
	(FLAGS STAGGERED TAKEBIT)
	(LDESC "Un Stradivarius est posé ici.")
	(SIZE 10)
	(VALUE 20)
	(ACTION VIOLIN-FCN)>

<OBJECT ICE
	(IN GLACIER-ROOM)
	(SYNONYM ICE MASS GLACIER)
	(ADJECTIVE COLD ICY)
	(DESC "glacier")
	(ACTION GLACIER-FCN)
	(LDESC "Une imposante masse de glace occupe la moitié ouest de la salle.")>

<OBJECT FLASK
	(IN POOL-ROOM)
	(SYNONYM FLASK)
	(ADJECTIVE GLASS)
	(DESC "flacon de verre bouché rempli de liquide")
	(FLAGS TAKEBIT TRANSBIT READBIT)
	(ACTION FLASK-FCN)
	(LDESC
"Un flacon de verre bouché, marqué d'une tête de mort, se trouve ici. Il contient un liquide transparent.")
	(CAPACITY 5)
	(TEXT "Une tête de mort surmontant deux tibias croisés est gravée sur le verre.")
	(SIZE 10)>

<OBJECT ROBOT-LABEL
	(IN MAGNET-ROOM)
	(SYNONYM PAPER PIECE INSTRUCTIONS)
	(ADJECTIVE GREEN)
	(DESC "feuille de papier verte")
	(FLAGS READBIT TAKEBIT BURNBIT)
	(LDESC "Une feuille de papier verte se trouve ici.")
	(SIZE 3)
	(TEXT
"!! SOCIÉTÉ DES ROBOTS MAGIQUES FROBOZZ !!| |Bonjour, Maître !| |Je suis un robot de dernière génération, formé à l'Institut technologique du GES pour accomplir diverses tâches ménagères simples.| |Pour m'activer, donnez-moi vos ordres ainsi :| |        >ROBOT, <action à accomplir>| |À votre service !") >

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
"Quelqu'un a taillé ce trou oblong dans le coffre, sans doute pour s'emparer de son contenu. La tentative s'est toutefois soldée par un échec lamentable." CR>)>>

<OBJECT HOOK-2
	(IN LEDGE-2)
	(SYNONYM HOOK)
	(ADJECTIVE SMALL)
	(DESC "crochet")
	(LDESC "Un petit crochet est fixé à la roche.")>

<OBJECT HOOK-1
	(IN LEDGE-1)
	(SYNONYM HOOK)
	(ADJECTIVE SMALL)
	(DESC "crochet")
	(LDESC "Un petit crochet est fixé à la roche.")>

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
	(DESC "lanterne en laiton brisée")
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
	(DESC "cage disloquée")
	(FLAGS TAKEBIT)
	(LDESC "Une cage d'acier disloquée gît ici.")
	(SIZE 60)>

<OBJECT PEARL
	(IN PEARL-ROOM)
	(SYNONYM NECKLACE PEARLS TREASURE)
	(ADJECTIVE PEARL)
	(DESC "collier de perles")
	(FLAGS STAGGERED TAKEBIT)
	(LDESC "Un collier composé de centaines de grosses perles repose ici.")
	(SIZE 10)
	(VALUE 15)>

<OBJECT EAT-ME-CAKE
	(IN ALICE-TABLE)
	(SYNONYM CAKE ICING CAKES LETTER)
	(ADJECTIVE GREEN FROSTED)
	(DESC "gâteau glacé portant des lettres vertes")
	(FLAGS READBIT TAKEBIT FOODBIT)
	(ACTION EATME-FCN)
	(TEXT "Le glaçage forme les mots « Mangez-moi ».")
	(SIZE 4)>

<OBJECT BLUE-ICING
	(IN ALICE-TABLE)
	(SYNONYM CAKE ICING CAKES LETTER)
	(ADJECTIVE BLUE FROSTED)
	(DESC "gâteau glacé portant des lettres bleues")
	(FLAGS READBIT TAKEBIT FOODBIT)
	(ACTION CAKE-FCN)
	(SIZE 4)>

<OBJECT ORANGE-ICING
	(IN ALICE-TABLE)
	(SYNONYM CAKE CAKES ICING LETTER)
	(ADJECTIVE ORANGE FROSTED)
	(DESC "gâteau glacé portant des lettres orange")
	(FLAGS READBIT TAKEBIT FOODBIT)
	(ACTION CAKE-FCN)
	(SIZE 4)>

<OBJECT RED-ICING
	(IN ALICE-TABLE)
	(SYNONYM CAKE CAKES ICING LETTER)
	(ADJECTIVE RED FROSTED)
	(DESC "gâteau glacé portant des lettres rouges")
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
	(DESC "mare de larmes")
	(LDESC
"La fuite a transformé la partie basse en une mare de larmes. Quelque chose de flou apparaît au point le plus profond.")
	(ACTION POOL-FCN)>

<OBJECT COIN
	(IN LEDGE-1)
	(SYNONYM COIN ZORKMID GOLD TREASURE)
	(ADJECTIVE GOLD PRICELESS)
	(DESC "zorkmid inestimable")
	(FLAGS STAGGERED READBIT TAKEBIT)
	(FDESC
"Un zorkmid d'or inestimable -- une précieuse pièce de collection -- repose au sol.")
	(LDESC "Un zorkmid gravé se trouve ici.")
	(SIZE 10)
	(VALUE 20)
	(TEXT
"Cette magnifique pièce octogonale porte les inscriptions « Dix mille zorkmids » et « En Frobs nous avons foi ».")>

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
	(DESC "timbre Tête-Plate")
	(FLAGS STAGGERED READBIT TAKEBIT BURNBIT)
	(LDESC "Un timbre Tête-Plate se trouve ici.")
	(SIZE 1)
	(VALUE 10)
	(TEXT "Ce timbre de trois zorkmids porte le portrait du seigneur Nigaud Tête-Plate, « Notre Dirigeant excessif ».")>

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
"Un bel ouvrage relié de cuir vert repose au centre de la salle.")
	(CAPACITY 2)
	(SIZE 10)
	(TEXT "Ce livre est rédigé dans une langue qui m'est inconnue.")
	(ACTION RANDOM-BOOK)>

<OBJECT BLUE-BOOK
	(IN LIBRARY)
	(SYNONYM BOOK COVER BOOKS)
	(ADJECTIVE BLUE)
	(DESC "livre bleu")
	(FLAGS READBIT TAKEBIT CONTBIT BURNBIT)
	(FDESC "Un livre bleu, usé et malmené, gît dans un coin de la salle.")
	(CAPACITY 2)
	(SIZE 10)
	(TEXT "Ce livre est rédigé dans une langue qui m'est inconnue.")
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
"Le texte, rédigé dans une langue inconnue, détaille l'usage de divers objets magiques, principalement de la prétendue « baguette magique ». Ces instruments fonctionneraient en les pointant vers l'objet à ensorceler, puis en prononçant la formule appropriée. (Il est vraiment stupéfiant de constater à quel point les anciens étaient crédules, n'est-ce pas ?)")
	(ACTION RANDOM-BOOK)>

<OBJECT PURPLE-BOOK
	(IN LIBRARY)
	(SYNONYM BOOK BOOKS)
	(ADJECTIVE PURPLE)
	(DESC "livre violet")
	(FLAGS READBIT TAKEBIT CONTBIT SEARCHBIT BURNBIT)
	(LDESC
"Un livre violet, couvert de moisissure, gît dans la poussière.")
	(CAPACITY 2)
	(SIZE 10)
	(ACTION PURPLE-BOOK-FCN)
	(TEXT
"Ce livre est rédigé dans une langue qui m'est inconnue. S'il est vrai que l'on peut juger un ouvrage à sa couverture, il doit regorger de prose ampoulée comme on en rencontre rarement hors du Grand Empire Souterrain.")>

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
	(LDESC "Un robot se tient ici.")>

<OBJECT RUBY
	(IN LAVA-ROOM)
	(SYNONYM RUBY TREASURE)
	(ADJECTIVE MOBY)
	(DESC "rubis")
	(FLAGS STAGGERED TAKEBIT)
	(FDESC "Un rubis absolument gigantesque repose au sol.")
	(LDESC "Un rubis absolument gigantesque repose ici.")
	(VALUE 15)>

<OBJECT IRON-BOX
	(IN CAROUSEL-ROOM)
	(SYNONYM BOX)
	(ADJECTIVE STEEL DENTED)
	(DESC "coffre en acier")
	(FLAGS CONTBIT TAKEBIT INVISIBLE)
	(LDESC "Un coffre d'acier cabossé se trouve ici.")
	(CAPACITY 20)
	(SIZE 40)>

<OBJECT CAGE
	(IN CAGE-ROOM)
	(FLAGS INVISIBLE)
	(SYNONYM CAGE)
	(ADJECTIVE STEEL SOLID)
	(DESC "cage en acier massif")
	(LDESC "Une cage en acier massif occupe le centre de la salle.")>

<OBJECT CANDY
	(IN POOL-ROOM)
	(SYNONYM PACKAGE CANDY TREASURE GRASSHOPPERS)
	(ADJECTIVE CANDIED RARE)
	(DESC "paquet de friandises")
	(FLAGS STAGGERED FOODBIT TAKEBIT INVISIBLE READBIT)
	(LDESC "Un paquet de friandises confites se trouve ici.")
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
	(DESC "cordon noir")
	(FLAGS TAKEBIT BURNBIT)
	(ACTION FUSE-FCN)
	(LDESC "Un rouleau de cordon noir tressé repose ici.")
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
"Un seau de bois démesuré -- trois pieds de diamètre pour autant de haut -- se trouve ici.")
	(CAPACITY 100)
	(SIZE 100)
	(VTYPE 0)>

<OBJECT POSTS
	(IN POSTS-ROOM)
	(SYNONYM POSTS POST)
	(ADJECTIVE WOODEN)
	(FLAGS NDESCBIT)
	(DESC "rangée de poteaux en bois")>

"SOUS-TITRE : OBJETS DE LA BANQUE"

<OBJECT BILLS
	(IN VAULT)
	(SYNONYM BILLS STACK MONEY TREASURE)
	(ADJECTIVE NEAT MANY ZORKMID)
	(DESC "liasse de billets en zorkmids")
	(FLAGS STAGGERED READBIT TAKEBIT BURNBIT)
	(ACTION BILLS-OBJECT)
	(LDESC
	 "Deux cents billets en zorkmids sont soigneusement empilés ici.")
	(FDESC
	 "Deux cents billets en zorkmids sont soigneusement empilés au sol.")
	(SIZE 10)
	(VALUE 25)
	(TEXT "Chaque billet vaut cent zorkmids et porte la devise « En Frobs nous avons foi ».")>

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
	 "Le portrait de J. Pierpont Tête-Plate se trouve ici.")
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
	(DESC "brochure de la banque")
	(FDESC "Un petit morceau de papier usé repose au sol.")
	(FLAGS READBIT TAKEBIT BURNBIT)
	(SIZE 2)
	(TEXT
"Le papier est presque illisible. Vous ne parvenez à déchiffrer que quelques bribes : « ... objets de valeur parfaitement en sécurité... technologie magique de pointe... impossible de sortir les biens de la salle des coffres... l'un ou l'autre guichetier... nombreux clients s'évanouissent... le guichetier surgit... semble traverser... les murs... »")>

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
	(DESC "rideau de lumière scintillante")
	(FLAGS NDESCBIT)
	(ACTION SCOL-OBJECT)>

<OBJECT GNOME-OF-ZURICH
	(SYNONYM GNOME ZURICH)
	(ADJECTIVE ZURICH)
	(DESC "Gnome de Zurich")
	(FLAGS ACTORBIT CONTBIT OPENBIT)
	(ACTION ZGNOME-FCN)
	(LDESC "Un Gnome de Zurich se tient ici.")>

<OBJECT DEPOSIT-BOX
	(IN GNOME-OF-ZURICH)
	(SYNONYM BOX)
	(ADJECTIVE DEPOSIT SAFETY)
	(DESC "coffre de dépôt")
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
	(DESC "couvercle métallique")
	(FLAGS NDESCBIT CONTBIT)
	(ACTION PLID-FCN)>

<OBJECT LID-2
	(IN DREARY-ROOM)
	(SYNONYM LID)
	(ADJECTIVE METAL)
	(DESC "couvercle métallique")
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
	(DESC "fissure étroite")
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
	(DESC "coupe-papier")
	(SIZE 2)
	(FLAGS TAKEBIT TOOLBIT)>

<OBJECT KEY
	(IN KEYHOLE-2)
	(SYNONYM KEY)
	(ADJECTIVE IRON RUSTY)
	(DESC "clé de fer rouillée")
	(FLAGS TAKEBIT NDESCBIT TURNBIT TOOLBIT)
	(ACTION PKEY-FCN)
	(SIZE 2)>

<OBJECT PALANTIR-2
	(IN DREARY-ROOM)
	(SYNONYM PALANTIR SPHERE)
	(ADJECTIVE CRYSTAL BLUE)
	(DESC "sphère de cristal bleue")
	(FLAGS STAGGERED TAKEBIT TRANSBIT)
	(ACTION PALANTIR)
	(VALUE 20)
	(FDESC "Une sphère de cristal bleue repose au centre de la table.")>

<OBJECT GAZEBO
	(IN LOCAL-GLOBALS)
	(SYNONYM GAZEBO STRUCTURE)
	(ADJECTIVE WOODEN)
	(DESC "pavillon")
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
"** Gazette des États-Unis et des Donjons **| |UN CÉLÈBRE AVENTURIER PART EXPLORER LE GRAND EMPIRE SOUTERRAIN| |Nos correspondants signalent qu'un aventurier de renommée mondiale, rompu aux combats, a été aperçu aux abords du Grand Empire Souterrain. Les grues de la région auraient commencé à aiguiser leurs crocs dégoulinants...| |« Zork II : Le Magicien de Frobozz » a été écrit par Dave Lebling et Marc Blank. Copyright © 1981, 1982 et 1983 Infocom, Inc.")>

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
	(DESC "théière en porcelaine")
	(FLAGS TAKEBIT TRANSBIT CONTBIT OPENBIT)
	(CAPACITY 4)
	(ACTION TEAPOT-F)>

<ROUTINE TEAPOT-F ()
	 <COND (<VERB? CLOSE>
		<TELL "La théière n'a pas de couvercle." CR>)>>

<OBJECT WATER
	(SYNONYM WATER QUANTITY LIQUID H2O)
	(DESC "eau")
	(FLAGS TAKEBIT DRINKBIT)
	(ACTION WATER-FCN)
	(LDESC "De l'eau se trouve ici.")
	(SIZE 4)>

<OBJECT SALTY-WATER
	(SYNONYM WATER QUANTITY LIQUID H2O)
	(DESC "eau salée")
	(FLAGS TAKEBIT DRINKBIT)
	(ACTION WATER-FCN)
	(LDESC "De l'eau se trouve ici.")
	(SIZE 4)>

<OBJECT GOLD-KEY
	(IN UNICORN)
	(SYNONYM KEY TREASURE)
	(ADJECTIVE DELICATE GOLD)
	(DESC "délicate clé d'or")
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
		<TELL "Une rose est une rose est une rose..." CR>)>>

<OBJECT GENIE
	(SYNONYM DEVIL DEMON GENIE DJINN)
	(DESC "démon")
	(FLAGS ACTORBIT INVISIBLE)
	(ACTION GENIE-FCN)
	(LDESC "Un démon flotte ici dans les airs.")>

<OBJECT WIZARD
	(SYNONYM WIZARD MAGICIAN SORCEROR MAN)
	(ADJECTIVE STRANGE LITTLE FROBOZZ OLD)
	(DESC "Magicien de Frobozz")
	(LDESC
"Le Magicien de Frobozz se tient ici et vous surveille avec méfiance.")
	(FLAGS ACTORBIT CONTBIT OPENBIT)
	(ACTION WIZARD-FCN)>

<OBJECT WAND
	(IN WIZARD)
	(SYNONYM WAND)
	(ADJECTIVE MAGIC)
	(DESC "baguette magique du Magicien")
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
	(LDESC "Une très ancienne épée elfique se trouve ici.")
	(FDESC "Une épée de facture elfique repose au sol.")
	(SIZE 30)>

<OBJECT REPELLENT
	(IN ROOM-8)
	(SYNONYM REPELLENT CAN)
	(ADJECTIVE GRUE MAGIC)
	(DESC "répulsif magique Frobozz contre les grues")
	(FLAGS TAKEBIT READBIT)
	(ACTION REPELLENT-FCN)
	(FDESC
"Une bombe aérosol se trouve dans un coin. Elle porte en gros caractères l'inscription « Répulsif magique Frobozz contre les grues ».")
	(TEXT
"!!! RÉPULSIF MAGIQUE FROBOZZ CONTRE LES GRUES !!!|
|
Mode d'emploi : appliquez généreusement sur la créature à protéger. La durée de l'effet est imprévisible. À n'utiliser qu'en cas de danger mortel !|
|
(Aucune garantie, expresse ou implicite)")>

<ROOM DEAD-PALANTIR-1
	(IN ROOMS)
	(LDESC " ")
	(DESC "Salle de la brume rouge")
	(WEST TO DEAD-PALANTIR-2)
	(FLAGS RLANDBIT ONBIT)
	(ACTION DEAD-PALANTIR)
	(GLOBAL GLOBAL-PALANTIR)>

<ROOM DEAD-PALANTIR-2
	(IN ROOMS)
	(LDESC " ")
	(DESC "Salle de la brume bleue")
	(WEST TO DEAD-PALANTIR-3)
	(FLAGS RLANDBIT ONBIT)
	(ACTION DEAD-PALANTIR)
	(GLOBAL GLOBAL-PALANTIR)>

<ROOM DEAD-PALANTIR-3
	(IN ROOMS)
	(LDESC " ")
	(DESC "Salle de la brume blanche")
	(WEST TO DEAD-PALANTIR-4)
	(FLAGS RLANDBIT ONBIT)
	(ACTION DEAD-PALANTIR)
	(GLOBAL GLOBAL-PALANTIR)>

<ROOM DEAD-PALANTIR-4
	(LDESC " ")
	(IN ROOMS)
	(DESC "Salle de la brume noire")
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
	(DESC "coupe-jarret")
	(ACTION FOOTPAD-F)>

<ROUTINE FOOTPAD-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "Un coupe-jarret est un voleur." CR>)>>

<OBJECT COMPASS
	(IN GLOBAL-OBJECTS)
	(DESC "boussole")
	(SYNONYM COMPASS)
	(ACTION COMPASS-F)>

<ROUTINE COMPASS-F ()
	 <COND (<VERB? FIND>
		<TELL
"Vous le portez sur vous, fort heureusement : sans lui, vous seriez irrémédiablement perdu." CR>)
	       (<VERB? DROP THROW OVERBOARD>
		<TELL
"Vous ne pouvez pas vous en débarrasser. C'est une extension de vous-même." CR>)
	       (<VERB? EXAMINE>
		<TELL
"C'est l'un de ces instruments munis d'une aiguille et d'un cadran indiquant les huit directions principales. Simple, mais efficace." CR>)
	       (<VERB? READ>
		<TELL
"La lecture n'est guère passionnante : il ne s'agit que des points cardinaux." CR>)
	       (T
		<TELL
"Vous ne pouvez pas faire ça. Et ne vous embêtez pas à demander pourquoi." CR>)>>

