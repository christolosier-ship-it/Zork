"1ACTIONS pour Zork I: Le Grand Empire Souterrain (c) Copyright 1983 Infocom, Inc. Tous droits réservés."

"SOUS-TITRE LA MAISON BLANCHE"

<ROUTINE WEST-HOUSE (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Vous vous trouvez dans une clairière, à l'ouest d'une maison blanche dont la porte d'entrée est condamnée.">
		<COND (,WON-FLAG
		       <TELL
" Un chemin secret mène au sud-ouest dans la forêt.">)>
		<CRLF>)>>

<ROUTINE EAST-HOUSE (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Vous êtes derrière la maison blanche. Un sentier s'enfonce dans la forêt vers l'est. À l'un des angles de la maison se trouve une petite fenêtre qui est ">
		<COND (<FSET? ,KITCHEN-WINDOW ,OPENBIT>
		       <TELL "ouverte.">)
		      (T <TELL "légèrement entrouverte.">)>
		<CRLF>)>>

<ROUTINE OPEN-CLOSE (OBJ STROPN STRCLS)
	 <COND (<VERB? OPEN>
		<COND (<FSET? .OBJ ,OPENBIT>
		       <TELL <PICK-ONE ,DUMMY>>)
		      (T
		       <TELL .STROPN>
		       <FSET .OBJ ,OPENBIT>)>
		<CRLF>)
	       (<VERB? CLOSE>
		<COND (<FSET? .OBJ ,OPENBIT>
		       <TELL .STRCLS>
		       <FCLEAR .OBJ ,OPENBIT>
		       T)
		      (T <TELL <PICK-ONE ,DUMMY>>)>
		<CRLF>)>>

<ROUTINE BOARD-F ()
	 <COND (<VERB? TAKE EXAMINE>
		<TELL "Les planches sont solidement fixées." CR>)>>

<ROUTINE TEETH-F ()
	 <COND (<AND <VERB? BRUSH>
		     <EQUAL? ,PRSO ,TEETH>>
		<COND (<AND <EQUAL? ,PRSI ,PUTTY>
			    <IN? ,PRSI ,WINNER>>
		       <JIGS-UP
"Eh bien, on dirait que vous vous êtes brossé les dents avec une sorte de colle. Votre bouche se retrouve donc collée à votre nez, et vous mourez d'insuffisance respiratoire.">)
		      (<NOT ,PRSI>
		       <TELL
"L'hygiène dentaire est fortement recommandée, mais je ne sais pas avec quoi vous voulez les brosser." CR>)
		      (T
		       <TELL "Une belle idée, mais avec un " D ,PRSI "?" CR>)>)>>

<ROUTINE GRANITE-WALL-F ()
	 <COND (<EQUAL? ,HERE ,NORTH-TEMPLE>
		<COND (<VERB? FIND>
		       <TELL "Le mur ouest est ici en granit massif." CR>)
		      (<VERB? TAKE RAISE LOWER>
		       <TELL "C'est du solide granit." CR>)>)
	       (<EQUAL? ,HERE ,TREASURE-ROOM>
		<COND (<VERB? FIND>
		       <TELL "Le mur oriental est ici constitué de granit massif." CR>)
		      (<VERB? TAKE RAISE LOWER>
		       <TELL "C'est du solide granit." CR>)>)
	       (<EQUAL? ,HERE ,SLIDE-ROOM>
		<COND (<VERB? FIND READ>
		       <TELL "Il DIT seulement \"Mur de granit\"." CR>)
		      (T <TELL "Le mur ne l'est pas. granit." CR>)>)
	       (T
		<TELL "Il n'y a pas de mur de granit ici." CR>)>>

<ROUTINE SONGBIRD-F ()
	 <COND (<VERB? FIND TAKE>
		<TELL "L'oiseau chanteur n'est pas ici mais est probablement à proximité." CR>)
	       (<VERB? LISTEN>
		<TELL "Vous ne pouvez pas entendre l'oiseau chanteur maintenant." CR>)
	       (<VERB? FOLLOW>
		<TELL "C'est impossible suivi." CR>)
	       (T
		<TELL "Vous ne pouvez voir aucun oiseau chanteur ici." CR>)>>

<ROUTINE WHITE-HOUSE-F ()
    <COND (<EQUAL? ,HERE ,KITCHEN ,LIVING-ROOM ,ATTIC>
	   <COND (<VERB? FIND>
		  <TELL "Pourquoi ne pas trouver votre cerveau ?" CR>)
		 (<VERB? WALK-AROUND>
		  <GO-NEXT ,IN-HOUSE-AROUND>
		  T)>)
	  (<NOT <OR <EQUAL? ,HERE ,EAST-OF-HOUSE ,WEST-OF-HOUSE>
		    <EQUAL? ,HERE ,NORTH-OF-HOUSE ,SOUTH-OF-HOUSE>>>
	   <COND (<VERB? FIND>
		  <COND (<EQUAL? ,HERE ,CLEARING>
			 <TELL "Cela semble venir de l'ouest." CR>)
			(T
			 <TELL "C'était ici il y a une minute à peine..." CR>)>)
		 (T <TELL "Vous n'êtes pas à la maison." CR>)>)
	  (<VERB? FIND>
	   <TELL
"C'est ici ! Êtes-vous aveugle ou quoi ?" CR>)
	  (<VERB? WALK-AROUND>
	   <GO-NEXT ,HOUSE-AROUND>
	   T)
	  (<VERB? EXAMINE>
	   <TELL
"C'est une belle demeure de style colonial, peinte en blanc. Ses propriétaires devaient manifestement être extrêmement riches." CR>)
	  (<VERB? THROUGH OPEN>
	   <COND (<EQUAL? ,HERE ,EAST-OF-HOUSE>
		  <COND (<FSET? ,KITCHEN-WINDOW ,OPENBIT>
			 <GOTO ,KITCHEN>)
			(T
			 <TELL "La fenêtre est fermée." CR>
			 <THIS-IS-IT ,KITCHEN-WINDOW>)>)
		 (T
		  <TELL "Je ne vois pas comment entrer depuis ici." CR>)>)
	  (<VERB? BURN>
	   <TELL "Vous devez plaisanter." CR>)>>

;"0 -> no next, 1 -> success, 2 -> failed move"

<ROUTINE GO-NEXT (TBL "AUX" VAL)
	 <COND (<SET VAL <LKP ,HERE .TBL>>
		<COND (<NOT <GOTO .VAL>> 2)
		      (T 1)>)>>

<ROUTINE FOREST-F ()
	 <COND (<VERB? WALK-AROUND>
		<COND (<OR <EQUAL? ,HERE
			       ,WEST-OF-HOUSE ,NORTH-OF-HOUSE
			       ,SOUTH-OF-HOUSE>
			   <EQUAL? ,HERE ,EAST-OF-HOUSE>>
		       <TELL "Vous n'êtes même pas dans la forêt." CR>)>
		<GO-NEXT ,FOREST-AROUND>)
	       (<VERB? DISEMBARK>
		<TELL "Vous devrez indiquer une direction." CR>)
	       (<VERB? FIND>
		<TELL "Vous ne pouvez pas voir la forêt à cause des arbres." CR>)
	       (<VERB? LISTEN>
		<TELL "Les pins et les pruches semblent murmurer."
		      CR>)>>

<ROUTINE MOUNTAIN-RANGE-F ()
	 <COND (<VERB? CLIMB-UP CLIMB-DOWN CLIMB-FOO>
		<TELL "Vous n'y croyez pas. moi ? Les montagnes sont infranchissables !"
		      CR>)>>

<ROUTINE WATER-F ("AUX" AV W PI?)
	 <COND (<VERB? SGIVE> <RFALSE>)
	       (<VERB? THROUGH BOARD>
		<TELL <PICK-ONE ,SWIMYUKS> CR>
		<RTRUE>)
	       (<VERB? FILL>	;"fill bottle with water =>"
		<SET W ,PRSI>	   ;"put water in bottle"
		<SETG PRSA ,V?PUT>
		<SETG PRSI ,PRSO>
		<SETG PRSO .W>
		<SET PI? <>>)
	       (<OR <EQUAL? ,PRSO ,GLOBAL-WATER>
		    <EQUAL? ,PRSO ,WATER>>
		<SET W ,PRSO>
		<SET PI? <>>)
	       (ELSE
		<SET W ,PRSI>
		<COND (.W <SET PI? T>)>)>
	 <COND (<EQUAL? .W ,GLOBAL-WATER>
		<SET W ,WATER>
		<COND (<VERB? TAKE PUT> <REMOVE-CAREFULLY .W>)>)>
	 <COND (.PI? <SETG PRSI .W>)
	       (T <SETG PRSO .W>)>
	 <SET AV <LOC ,WINNER>>
	 <COND (<NOT <FSET? .AV ,VEHBIT>> <SET AV <>>)>
	 <COND (<AND <VERB? TAKE PUT> <NOT .PI?>>
		<COND (<AND .AV
			    <OR <EQUAL? .AV ,PRSI>
				<AND <NOT ,PRSI>
				     <NOT <IN? .W .AV>>>>>
		       <TELL "Il y a maintenant une flaque d'eau au fond du "
			     D .AV "." CR>
		       <REMOVE-CAREFULLY ,PRSO>
		       <MOVE ,PRSO .AV>)
		      (<AND ,PRSI <NOT <EQUAL? ,PRSI ,BOTTLE>>>
		       <TELL "L'eau s'échappe du " D ,PRSI
			     " et s'évapore. immédiatement." CR>
		       <REMOVE-CAREFULLY .W>)
		      (<IN? ,BOTTLE ,WINNER>
		       <COND (<NOT <FSET? ,BOTTLE ,OPENBIT>>
			      <TELL "La bouteille est fermée." CR>
			      <THIS-IS-IT ,BOTTLE>)
			     (<NOT <FIRST? ,BOTTLE>>
			      <MOVE ,WATER ,BOTTLE>
			      <TELL "La bouteille est maintenant pleine d'eau." CR>)
			     (T
			      <TELL "L'eau vous glisse entre les doigts." CR>
			      <RTRUE>)>)
		      (<AND <IN? ,PRSO ,BOTTLE>
			    <VERB? TAKE>
			    <NOT ,PRSI>>
		       <TELL
"C'est dans la bouteille. Peut-être devriez-vous plutôt prendre cela." CR>)
		      (T
		       <TELL "L'eau vous glisse entre les doigts." CR>)>)
	       (.PI?
		<COND (<AND <VERB? PUT>
			    <GLOBAL-IN? ,RIVER ,HERE>>
		       <PERFORM ,V?PUT ,PRSO ,RIVER>)
		      (ELSE
		       <TELL "Bien essayé." CR>)>
		<RTRUE>)
	       (<VERB? DROP GIVE>
		<COND (<AND <VERB? DROP>
			    <IN? ,WATER ,BOTTLE>
			    <NOT <FSET? ,BOTTLE ,OPENBIT>>>
		       <TELL "La bouteille est fermée." CR>
		       <RTRUE>)>
		<REMOVE-CAREFULLY ,WATER>
		<COND (.AV
		       <TELL "Il y a maintenant une flaque d'eau au fond du "
			     D .AV "." CR>
		       <MOVE ,WATER .AV>)
		      (T
		       <TELL
"L'eau se répand sur le sol et s'évapore immédiatement." CR>
		       <REMOVE-CAREFULLY ,WATER>)>)
	       (<VERB? THROW>
		<TELL
"L'eau éclabousse les murs et s'évapore. immédiatement." CR>
		<REMOVE-CAREFULLY ,WATER>)>>

<GLOBAL KITCHEN-WINDOW-FLAG <>>

<ROUTINE KITCHEN-WINDOW-F ()
	 <COND (<VERB? OPEN CLOSE>
		<SETG KITCHEN-WINDOW-FLAG T>
		<OPEN-CLOSE ,KITCHEN-WINDOW
"Avec beaucoup d'effort, vous ouvrez la fenêtre suffisamment loin pour permettre l'entrée."
"La fenêtre se ferme (plus facilement qu'elle ne s'est ouverte).">)
	       (<AND <VERB? EXAMINE>
		     <NOT ,KITCHEN-WINDOW-FLAG>>
		<TELL
"La fenêtre est légèrement entrouverte, mais pas suffisamment pour permettre l'entrée." CR>)
	       (<VERB? WALK BOARD THROUGH>
		<COND (<EQUAL? ,HERE ,KITCHEN>
		       <DO-WALK ,P?EAST>)
		      (T
		       <DO-WALK ,P?WEST>)>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE>
		<TELL "Vous pouvez voir ">
		<COND (<EQUAL? ,HERE ,KITCHEN>
		       <TELL "une zone dégagée menant vers une forêt." CR>)
		      (T
		       <TELL "ce qui paraît être une cuisine." CR>)>)>>

<ROUTINE GHOSTS-F ()
	 <COND (<VERB? TELL>
		<TELL "Les esprits se moquent bruyamment et vous ignorent." CR>
		<SETG P-CONT <>>)
	       (<VERB? EXORCISE>
		<TELL "Seule la cérémonie elle-même a un effet." CR>)
	       (<AND <VERB? ATTACK MUNG> <EQUAL? ,PRSO ,GHOSTS>>
		<TELL "Comment pouvez-vous attaquer un esprit avec du matériel objets ?" CR>)
	       (T
		<TELL "Vous semblez incapable d'interagir avec ces esprits." CR>)>>

<GLOBAL CAGE-TOP T>

<ROUTINE BASKET-F ()
	 <COND (<VERB? RAISE>
		<COND (,CAGE-TOP
		       <TELL <PICK-ONE ,DUMMY> CR>)
		      (T
		       <MOVE ,RAISED-BASKET ,SHAFT-ROOM>
		       <MOVE ,LOWERED-BASKET ,LOWER-SHAFT>
		       <SETG CAGE-TOP T>
		       <THIS-IS-IT ,RAISED-BASKET>
		       <TELL
"Le panier est élevé jusqu'au sommet de la tige." CR>)>)
	       (<VERB? LOWER>
		<COND (<NOT ,CAGE-TOP>
		       <TELL <PICK-ONE ,DUMMY> CR>)
		      (T
		       <MOVE ,RAISED-BASKET ,LOWER-SHAFT>
		       <MOVE ,LOWERED-BASKET ,SHAFT-ROOM>
		       <THIS-IS-IT ,LOWERED-BASKET>
		       <TELL
"Le panier est abaissé vers le bas. de l'arbre." CR>
		       <SETG CAGE-TOP <>>
		       <COND (<AND ,LIT <NOT <SETG LIT <LIT? ,HERE>>>>
			      <TELL "Il fait maintenant nuit noire." CR>)>
		       T)>)
	       (<OR <EQUAL? ,PRSO ,LOWERED-BASKET>
		    <EQUAL? ,PRSI ,LOWERED-BASKET>>
		<TELL "Le panier est à l'autre extrémité de la chaîne." CR>)
	       (<AND <VERB? TAKE>
		     <EQUAL? ,PRSO ,RAISED-BASKET ,LOWERED-BASKET>>
		<TELL "La cage est solidement fixée à la chaîne en fer." CR>)>>

<ROUTINE BAT-F ()
	 <COND (<VERB? TELL>
		<FWEEP 6>
		<SETG P-CONT <>>)
	       (<VERB? TAKE ATTACK MUNG>
		<COND (<EQUAL? <LOC ,GARLIC> ,WINNER ,HERE>
		       <TELL "Vous ne pouvez pas l'atteindre ; il est au plafond." CR>)
		      (T <FLY-ME>)>)>>

<ROUTINE FLY-ME ()
	 <FWEEP 4>
	 <TELL
"La chauve-souris vous saisit par la peau du cou et vous emporte..." CR CR>
	 <GOTO <PICK-ONE ,BAT-DROPS> <>>
	 <COND (<NOT <EQUAL? ,HERE ,ENTRANCE-TO-HADES>>
		<V-FIRST-LOOK>)>
	 T>

<ROUTINE FWEEP (N)
	 <REPEAT ()
		 <COND (<L? <SET N <- .N 1>> 1> <RETURN>)
		       (T <TELL " Fweep !" CR>)>>
	 <CRLF>>

<GLOBAL BAT-DROPS
      <LTABLE 0
	      MINE-1
	      MINE-2
	      MINE-3
	      MINE-4
	      LADDER-TOP
	      LADDER-BOTTOM
	      SQUEEKY-ROOM
	      MINE-ENTRANCE>>

<ROUTINE BELL-F ()
	 <COND (<VERB? RING>
		<COND (<AND <EQUAL? ,HERE ,LLD-ROOM>
			    <NOT ,LLD-FLAG>>
		       <RFALSE>)
		      (T
		       <TELL "Ding, dong." CR>)>)>>

<ROUTINE HOT-BELL-F ()
	 <COND (<VERB? TAKE>
		<TELL "La cloche est très chaude et ne peut pas être prise." CR>)
	       (<OR <VERB? RUB> <AND <VERB? RING> ,PRSI>>
		<COND (<FSET? ,PRSI ,BURNBIT>
		       <TELL "Le " D ,PRSI " brûle et est consommée." CR>
		       <REMOVE-CAREFULLY ,PRSI>)
		      (<EQUAL? ,PRSI ,HANDS>
		       <TELL "La cloche est trop chaude pour être touchée." CR>)
		      (T
		       <TELL "La chaleur de la cloche est trop intense." CR>)>)
	       (<VERB? POUR-ON>
		<REMOVE-CAREFULLY ,PRSO>
		<TELL "L'eau refroidit la cloche et s'évapore." CR>
		<QUEUE I-XBH 0>
		<I-XBH>)
	       (<VERB? RING>
		<TELL "La cloche est trop chaude pour être atteinte." CR>)>>

<ROUTINE BOARDED-WINDOW-FCN ()
	 <COND (<VERB? OPEN>
		<TELL "Les fenêtres sont barricadées et ne peuvent pas être ouvertes." CR>)
	       (<VERB? MUNG>
		<TELL "Vous ne pouvez pas briser les fenêtres pour les ouvrir." CR>)>>

<ROUTINE NAILS-PSEUDO ()
	 <COND (<VERB? TAKE>
		<TELL
"Les clous, profondément enfoncés dans la porte, ne peuvent pas être retirés." CR>)>>

<ROUTINE CRACK-FCN ()
	 <COND (<VERB? THROUGH>
		<TELL "Vous ne pouvez pas passer à travers la fissure." CR>)>>

<ROUTINE KITCHEN-FCN (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	       <TELL
"Vous êtes dans la cuisine de la maison blanche. La table semble avoir servi récemment à préparer un repas. Un passage mène à l'ouest et un escalier obscur monte vers l'étage. Une cheminée sombre descend, tandis qu'à l'est se trouve une petite fenêtre qui est ">
	       <COND (<FSET? ,KITCHEN-WINDOW ,OPENBIT>
		      <TELL "ouverte." CR>)
		     (T
		      <TELL "légèrement entrouverte." CR>)>)
	      (<==? .RARG ,M-BEG>
	       <COND (<AND <VERB? CLIMB-UP> <EQUAL? ,PRSO ,STAIRS>>
		      <DO-WALK ,P?UP>)
		     (<AND <VERB? CLIMB-UP> <EQUAL? ,PRSO ,STAIRS>>
		      <TELL "Il n'y a aucun escalier menant vers le bas." CR>)>)>>

<ROUTINE STONE-BARROW-FCN (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-BEG>
		     <OR <VERB? ENTER>
			 <AND <VERB? WALK>
			      <EQUAL? ,PRSO ,P?WEST ,P?IN>>
			 <AND <VERB? THROUGH>
			      <EQUAL? ,PRSO ,BARROW>>>>
		<TELL
"À l'intérieur du tumulus|En entrant dans le tumulus, vous entendez la porte se refermer inexorablement derrière vous. Tout autour règnent les ténèbres, mais devant vous s'ouvre une immense caverne vivement éclairée. Un large ruisseau la traverse en son milieu. Une petite passerelle de bois l'enjambe et, au-delà, un sentier conduit à un tunnel obscur. Au-dessus du pont, un grand panneau flotte dans les airs. On peut y lire :| |Vous tous qui vous tenez devant ce pont avez achevé une grande et périlleuse aventure qui a mis à l'épreuve votre intelligence et votre courage. Vous avez triomphé de">
		<COND (<EQUAL? <BAND <GETB 0 1> 8> 0>
		       <TELL " la première partie de la trilogie ZORK. Quiconque franchit ce pont doit être prêt à entreprendre une aventure plus grande encore, qui soumettra son habileté et sa bravoure à rude épreuve !| |La trilogie ZORK se poursuit dans « ZORK II : Le Magicien de Frobozz » et s'achève dans « ZORK III : Le Maître du Donjon »." CR>)
		      (T
		       <TELL "ZORK: Le Grand Empire Souterrain.|" CR>)>
		<FINISH>)>>

<ROUTINE BARROW-DOOR-FCN ()
	 <COND (<VERB? OPEN CLOSE>
		<TELL "La porte est trop lourde." CR>)>>

<ROUTINE BARROW-FCN ()
	 <COND (<VERB? THROUGH>
		<DO-WALK ,P?WEST>)>>

\

<ROUTINE TROPHY-CASE-FCN ()
    <COND (<AND <VERB? TAKE> <EQUAL? ,PRSO ,TROPHY-CASE>>
	   <TELL
"La boîte à trophées est solidement fixée au mur." CR>)>>
	
<GLOBAL RUG-MOVED <>>

<ROUTINE LIVING-ROOM-FCN (RARG "AUX" RUG? TC)
	<COND (<EQUAL? .RARG ,M-LOOK>
	       <TELL
"Vous êtes dans le salon. Une ouverture mène à l'est">
	       <COND (,MAGIC-FLAG
		      <TELL
". À l'ouest, une vieille porte en bois est percée d'une ouverture en forme de cyclope et surmontée d'étranges lettres gothiques. Vous voyez également ">)
		     (T
		      <TELL
", tandis qu'à l'ouest une porte en bois ornée d'étranges lettres gothiques semble condamnée par des clous. Vous voyez également ">)>
	       <TELL "une vitrine à trophées, ">
	       <SET RUG? ,RUG-MOVED>
	       <COND (<AND .RUG? <FSET? ,TRAP-DOOR ,OPENBIT>>
		      <TELL
		       "et un tapis posé à côté d'une trappe ouverte.">)
		     (.RUG?
		      <TELL "et une trappe fermée à vos pieds.">)
		     (<FSET? ,TRAP-DOOR ,OPENBIT>
		      <TELL "et une trappe ouverte à vos pieds.">)
		     (T
		      <TELL
		       "et un grand tapis oriental au centre de la pièce.">)>
	       <CRLF>
	       T)
	      (<EQUAL? .RARG ,M-END>
	       <COND (<OR <VERB? TAKE>
			  <AND <VERB? PUT>
			       <EQUAL? ,PRSI ,TROPHY-CASE>>>
		      <COND (<IN? ,PRSO ,TROPHY-CASE>
			     <TOUCH-ALL ,PRSO>)>
		      <SETG SCORE <+ ,BASE-SCORE <OTVAL-FROB>>>
		      <SCORE-UPD 0>
		      <RFALSE>)>)>>

<ROUTINE TOUCH-ALL (OBJ "AUX" F)
	 <SET F <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN>)
		       (T
			<FSET .F ,TOUCHBIT>
			<COND (<FIRST? .F> <TOUCH-ALL .F>)>)>
		 <SET F <NEXT? .F>>>>

<ROUTINE OTVAL-FROB ("OPTIONAL" (O ,TROPHY-CASE) "AUX" F (SCORE 0))
	 <SET F <FIRST? .O>>
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN .SCORE>)>
		 <SET SCORE <+ .SCORE <GETP .F ,P?TVALUE>>>
		 <COND (<FIRST? .F> <OTVAL-FROB .F>)>
		 <SET F <NEXT? .F>>>>

<ROUTINE TRAP-DOOR-FCN ()
    <COND (<VERB? RAISE>
	   <PERFORM ,V?OPEN ,TRAP-DOOR>
	   <RTRUE>)
	  (<AND <VERB? OPEN CLOSE>
		<EQUAL? ,HERE ,LIVING-ROOM>>
	   <OPEN-CLOSE ,PRSO
"La porte s'ouvre à contrecoeur, révélant un escalier branlant qui descend dans les ténèbres."
"La porte s'ouvre et se ferme.">)
	  (<AND <VERB? LOOK-UNDER> <EQUAL? ,HERE LIVING-ROOM>>
	   <COND (<FSET? ,TRAP-DOOR ,OPENBIT>
		  <TELL
"Vous voyez un escalier branlant descendre dans l'obscurité." CR>)
		 (T <TELL "C'est fermée." CR>)>)
	  (<EQUAL? ,HERE ,CELLAR>
	   <COND (<AND <VERB? OPEN UNLOCK>
		       <NOT <FSET? ,TRAP-DOOR ,OPENBIT>>>
		  <TELL
"La porte est verrouillée par le haut." CR>)
		 (<AND <VERB? CLOSE> <NOT <FSET? ,TRAP-DOOR ,OPENBIT>>>
		  <FCLEAR ,TRAP-DOOR ,TOUCHBIT>
		  <FCLEAR ,TRAP-DOOR ,OPENBIT>
		  <TELL "La porte se ferme et se verrouille." CR>)
		 (<VERB? OPEN CLOSE>
		  <TELL <PICK-ONE ,DUMMY> CR>)>)>>

<ROUTINE CELLAR-FCN (RARG)
  <COND (<EQUAL? .RARG ,M-LOOK>
	 <TELL
"Vous êtes dans une cave sombre et humide. Un passage étroit mène au nord et un boyau au sud. À l'ouest se trouve le pied d'une rampe métallique si raide qu'elle est impossible à gravir." CR>)
	(<EQUAL? .RARG ,M-ENTER>
	 <COND (<AND <FSET? ,TRAP-DOOR ,OPENBIT>
		     <NOT <FSET? ,TRAP-DOOR ,TOUCHBIT>>>
		<FCLEAR ,TRAP-DOOR ,OPENBIT>
		<FSET ,TRAP-DOOR ,TOUCHBIT>
		<TELL
"La trappe se ferme brusquement et vous entendez quelqu'un la barrer." CR CR>)>)>>

<ROUTINE CHIMNEY-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "La cheminée mène ">
		<COND (<==? ,HERE ,KITCHEN>
		       <TELL "vers le bas">)
		      (T <TELL "vers le haut">)>
		<TELL ", et paraît praticable." CR>)>>

<ROUTINE UP-CHIMNEY-FUNCTION ("AUX" F)
  <COND (<NOT <SET F <FIRST? ,WINNER>>>
	 <TELL "Monter les mains vides est une mauvaise idée." CR>
	 <RFALSE>)
	(<AND <OR <NOT <SET F <NEXT? .F>>>
		  <NOT <NEXT? .F>>>
	      <IN? ,LAMP ,WINNER>>
	 <COND (<NOT <FSET? ,TRAP-DOOR ,OPENBIT>>
		<FCLEAR ,TRAP-DOOR ,TOUCHBIT>)>
	 <RETURN ,KITCHEN>)
	(T
	 <TELL "Vous ne pouvez pas monter là-haut avec ce que vous transportez." CR>
	 <RFALSE>)>>

<ROUTINE TRAP-DOOR-EXIT ()
	 <COND (,RUG-MOVED
		<COND (<FSET? ,TRAP-DOOR ,OPENBIT>
		       <RETURN ,CELLAR>)
		      (T
		       <TELL "La trappe est fermée." CR>
		       <THIS-IS-IT ,TRAP-DOOR>
		       <RFALSE>)>)
	       (T
		<TELL "Vous ne pouvez pas aller par là." CR>
		<RFALSE>)>>

<ROUTINE RUG-FCN ()
   <COND (<VERB? RAISE>
	  <TELL "Le tapis est trop lourd à soulever">
	  <COND (,RUG-MOVED
		 <TELL "." CR>)
		(T
		 <TELL
"Mais en essayant de le prendre, vous avez remarqué une irrégularité en dessous." CR>)>)
	 (<VERB? MOVE PUSH>
	  <COND (,RUG-MOVED
		 <TELL
"Après avoir déplacé le tapis auparavant, vous trouvez impossible de le déplacer à nouveau." CR>)
		(T
		 <TELL
"Au prix d'un grand effort, vous poussez le tapis sur le côté, révélant le battant poussiéreux d'une trappe fermée." CR>
		 <FCLEAR ,TRAP-DOOR ,INVISIBLE>
		 <THIS-IS-IT ,TRAP-DOOR>
		 <SETG RUG-MOVED T>)>)
	 (<VERB? TAKE>
	  <TELL
"Le tapis est extrêmement lourd et ne peut pas être transporté." CR>)
	 (<AND <VERB? LOOK-UNDER>
	       <NOT ,RUG-MOVED>
	       <NOT <FSET? ,TRAP-DOOR ,OPENBIT>>>
	  <TELL
"Sous le tapis se trouve une trappe fermée. Lorsque vous relâchez le coin du tapis, celui-ci retombe et dissimule de nouveau la trappe." CR>)
	 (<VERB? CLIMB-ON>
	  <COND (<AND <NOT ,RUG-MOVED>
		      <NOT <FSET? ,TRAP-DOOR ,OPENBIT>>>
		 <TELL
"En vous asseyant, vous sentez une bosse sous le tapis. Plutôt que de rester dans cette position inconfortable, vous vous relevez." CR>)
		(ELSE
		 <TELL "Je suppose que vous pensez que c'est un tapis magique ?" CR>)>)>>

\

"SUBTITLE TROLL"

<ROUTINE AXE-F ()
	 <COND (,TROLL-FLAG <>)
	       (T <WEAPON-FUNCTION ,AXE ,TROLL>)>>

<ROUTINE STILETTO-FUNCTION ()
	 <WEAPON-FUNCTION ,STILETTO ,THIEF>>

<ROUTINE WEAPON-FUNCTION (W V)
	<COND (<NOT <IN? .V ,HERE>> <RFALSE>)
	      (<VERB? TAKE>
	       <COND (<IN? .W .V>
		      <TELL
"Le " D .V " le fait sortir de votre portée." CR>)
		     (T
		      <TELL
"Le " D .W " semble brûlant. Vous ne pouvez pas le retenir." CR>)>
	       T)>>

<ROUTINE TROLL-FCN ("OPTIONAL" (MODE <>))
	 <COND (<VERB? TELL>
		<SETG P-CONT <>>
		<TELL "Le troll n'est pas vraiment un causeur." CR>)
	       (<EQUAL? .MODE ,F-BUSY?>
		<COND (<IN? ,AXE ,TROLL> <>)
		      (<AND <IN? ,AXE ,HERE> <PROB 75 90>>
		       <FSET ,AXE ,NDESCBIT>
		       <FCLEAR ,AXE ,WEAPONBIT>
		       <MOVE ,AXE ,TROLL>
		       <PUTP ,TROLL ,P?LDESC
"Un sale troll, brandissant une hache, bloque tous les passages de la pièce.">
		       <AND <IN? ,TROLL ,HERE>
			    <TELL
"Furieux et humilié, le troll récupère son arme. Manifestement, il a désormais une dent contre vous -- et une hache à la main." CR>>
		      T)
		     (<IN? ,TROLL ,HERE>
		      <PUTP ,TROLL ,P?LDESC
"Un troll pathétiquement bavard est là.">
		      <TELL
"Le troll, désarmé, cowers dans la terreur, plaidant pour sa vie dans la langue guttural des trolls." CR>
		      T)>)
	      (<EQUAL? .MODE ,F-DEAD>
	       <COND (<IN? ,AXE ,TROLL>
		      <MOVE ,AXE ,HERE>
		      <FCLEAR ,AXE ,NDESCBIT>
		      <FSET ,AXE ,WEAPONBIT>)>
	       <SETG TROLL-FLAG T>)
	      (<EQUAL? .MODE ,F-UNCONSCIOUS>
	       <FCLEAR ,TROLL ,FIGHTBIT>
	       <COND (<IN? ,AXE ,TROLL>
		      <MOVE ,AXE ,HERE>
		      <FCLEAR ,AXE ,NDESCBIT>
		      <FSET ,AXE ,WEAPONBIT>)>
	       <PUTP ,TROLL ,P?LDESC
"Un troll inconscient est étendu sur le sol. Tous les passages de la pièce sont ouverts.">
	       <SETG TROLL-FLAG T>)
	      (<EQUAL? .MODE ,F-CONSCIOUS>
	       <COND (<IN? ,TROLL ,HERE>
		      <FSET ,TROLL ,FIGHTBIT>
		      <TELL
"Le troll remue, reprenant rapidement une position de combat." CR>)>
	       <COND (<IN? ,AXE ,TROLL>
		      <PUTP ,TROLL ,P?LDESC
"Un sale troll, brandissant une hache, bloque tous les passages de la pièce.">)
		     (<IN? ,AXE ,TROLL-ROOM>
		      <FSET ,AXE ,NDESCBIT>
		      <FCLEAR ,AXE ,WEAPONBIT>
		      <MOVE ,AXE ,TROLL>
		      <PUTP ,TROLL ,P?LDESC
"Un sale troll, brandissant une hache, bloque tous les passages de la pièce.">)
		     (T
		      <PUTP ,TROLL ,P?LDESC
"Un troll est là.">)>
	       <SETG TROLL-FLAG <>>)
	      (<EQUAL? .MODE ,F-FIRST?>
	       <COND (<PROB 33>
		      <FSET ,TROLL ,FIGHTBIT>
		      <SETG P-CONT <>>
		      T)>)
	      (<NOT .MODE>
	       <COND (<VERB? EXAMINE>
		      <TELL <GETP ,TROLL ,P?LDESC> CR>)
		     (<OR <AND <VERB? THROW GIVE>
			       ,PRSO
			       <EQUAL? ,PRSI ,TROLL>>
			  <VERB? TAKE MOVE MUNG>>
		      <AWAKEN ,TROLL>
		      <COND (<VERB? THROW GIVE>
			     <COND (<AND <EQUAL? ,PRSO ,AXE>
					 <IN? ,AXE ,WINNER>>
				    <TELL
"Le troll se gratte la tête avec confusion, puis prend la hache." CR>
				    <FSET ,TROLL ,FIGHTBIT>
				    <MOVE ,AXE ,TROLL>
				    <RTRUE>)
				   (<EQUAL? ,PRSO ,TROLL ,AXE>
				    <TELL
"Vous devrez d'abord obtenir le " D ,PRSO ", et cela semble peu probable." CR>
				    <RTRUE>)>
			     <COND (<VERB? THROW>
				    <TELL
"Le troll, qui est remarquablement coordonné, attrape le " D ,PRSO>)
				   (T
				    <TELL
"Le troll, qui n'est pas trop fier, accepte gracieusement le cadeau">)>
			     <COND (<AND <PROB 20>
					 <EQUAL? ,PRSO ,KNIFE ,SWORD ,AXE>>
				    <REMOVE-CAREFULLY ,PRSO>
				    <TELL
" et le dévore avec avidité. Pauvre troll : victime d'une hémorragie interne, il s'effondre. Une sinistre brume noire enveloppe sa dépouille, qui disparaît." CR>
				    <REMOVE-CAREFULLY ,TROLL>
				    <APPLY <GETP ,TROLL ,P?ACTION> ,F-DEAD>
				    <SETG TROLL-FLAG T>)
				   (<EQUAL? ,PRSO ,KNIFE ,SWORD ,AXE>
				    <MOVE ,PRSO ,HERE>
				    <TELL
"Heureusement, le troll a un mauvais contrôle, et le" D ,PRSO "Il n'a pas l'air content." CR>
				    <FSET ,TROLL ,FIGHTBIT>)
				   (T
				    <TELL
" et n'ayant pas les goûts les plus exigeants, il le mange allègrement." CR>
				    <REMOVE-CAREFULLY ,PRSO>)>)
			    (<VERB? TAKE MOVE>
			     <TELL
"Le troll vous crache au visage et grogne, avec un accent particulièrement barbare : « Vous aurez peut-être plus de chance la prochaine fois. »" CR>)
			    (<VERB? MUNG>
			     <TELL
"Le troll se moque de votre geste chétif." CR>)>)
		     (<VERB? LISTEN>
		      <TELL
"Chaque fois, le troll dit quelque chose, probablement peu compliqué, dans sa langue gutturale." CR>)
		     (<AND ,TROLL-FLAG <VERB? HELLO>>
		      <TELL "Malheureusement, le troll ne vous entend pas." CR>)>)>>

\

"SOUS-TITRE GRILLE/LABYRINTHE"

;<GLOBAL LEAVES-GONE <>> ;"no longer used?"
<GLOBAL GRATE-REVEALED <>>
<GLOBAL GRUNLOCK <>>

<ROUTINE LEAVES-APPEAR ()
	<COND (<AND <NOT <FSET? ,GRATE ,OPENBIT>>
	            <NOT ,GRATE-REVEALED>>
	       <COND (<VERB? MOVE TAKE>
		      <TELL
"En dérangeant le tas de feuilles, une grille se révèle." CR>)
		     (T <TELL
"Une fois les feuilles écartées, une grille apparaît." CR>)>
	       <FCLEAR ,GRATE ,INVISIBLE>
	       <SETG GRATE-REVEALED T>)>
	<>>

<ROUTINE LEAF-PILE ()
	<COND (<VERB? COUNT>
	       <TELL "Il y a 69 105 feuilles ici." CR>)
	      (<VERB? BURN>
	       <LEAVES-APPEAR>
	       <REMOVE-CAREFULLY ,PRSO>
	       <COND (<IN? ,PRSO ,HERE>
		      <TELL
"Les feuilles brûlent." CR>)
		     (T
		      <JIGS-UP
"Les feuilles brûlent, tout comme vous.">)>)
	      (<VERB? CUT>
	       <TELL "Vous bruissez les feuilles, créant tout un désordre." CR>
	       <LEAVES-APPEAR>
	       <RTRUE>)
	      (<VERB? MOVE TAKE>
	       <COND (<VERB? MOVE>
		      <TELL "Terminé." CR>)>
	       <COND (,GRATE-REVEALED <RFALSE>)>
	       <LEAVES-APPEAR>
	       <COND (<VERB? TAKE> <RFALSE>)
		     (T <RTRUE>)>)
	      (<AND <VERB? LOOK-UNDER>
		    <NOT ,GRATE-REVEALED>>
	       <TELL
"Sous le tas de feuilles se trouve une grille. Lorsque vous relâchez les feuilles, elles retombent et la dissimulent de nouveau." CR>)>>
 
<ROUTINE CLEARING-FCN (RARG)
  	 <COND (<EQUAL? .RARG ,M-ENTER>
		<COND (<NOT ,GRATE-REVEALED>
		       <FSET ,GRATE ,INVISIBLE>)>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Vous êtes dans une clairière, avec une forêt qui vous entoure de tous côtés.">
		<COND (<FSET? ,GRATE ,OPENBIT>
		       <CRLF>
		       <TELL
"Il y a une grille ouverte qui descend dans l'obscurité.">)
		      (,GRATE-REVEALED
		       <CRLF>
		       <TELL
"Il y a une grille solidement fixée dans le sol.">)>
		<CRLF>)>>

<ROUTINE MAZE-11-FCN (RARG)
  	 <COND (<EQUAL? .RARG ,M-ENTER>
		<FCLEAR ,GRATE ,INVISIBLE>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Vous êtes dans une petite pièce près du labyrinthe. Il y a des passages tordus dans les environs immédiats." CR>
		<COND (<FSET? ,GRATE ,OPENBIT>
		       <TELL
 "Au-dessus de vous se trouve une grille ouverte avec la lumière du soleil qui entre.">)
		      (,GRUNLOCK
		       <TELL "Une grille se trouve au-dessus de vous.">)
		      (T
		       <TELL
 "Au-dessus de vous se trouve une grille verrouillée avec une serrure à tête de mort.">)>
		<CRLF>)>>

<ROUTINE GRATE-FUNCTION ()
    	 <COND (<AND <VERB? OPEN> <EQUAL? ,PRSI ,KEYS>>
		<PERFORM ,V?UNLOCK ,GRATE ,KEYS>
		<RTRUE>)
	       (<VERB? LOCK>
		<COND (<EQUAL? ,HERE ,GRATING-ROOM>
		       <SETG GRUNLOCK <>>
		       <TELL "La grille est verrouillée." CR>)
	              (<EQUAL? ,HERE ,GRATING-CLEARING>
		       <TELL "Vous Impossible de le verrouiller de ce côté." CR>)>)
	       (<AND <VERB? UNLOCK> <EQUAL? ,PRSO ,GRATE>>
		<COND (<AND <EQUAL? ,HERE ,GRATING-ROOM> <EQUAL? ,PRSI ,KEYS>>
		       <SETG GRUNLOCK T>
		       <TELL "La grille est déverrouillée." CR>)
		      (<AND <EQUAL? ,HERE ,GRATING-CLEARING>
			    <EQUAL? ,PRSI ,KEYS>>
		       <TELL "Vous ne pouvez pas atteindre la serrure d'ici." CR>)
		      (T
		       <TELL
"Pouvez-vous déverrouiller une grille avec un " D ,PRSI "?" CR>)>)
               (<VERB? PICK>
		<TELL "Vous ne pouvez pas crocheter la serrure." CR>)
               (<VERB? OPEN CLOSE>
		<COND (,GRUNLOCK
		       <OPEN-CLOSE ,GRATE
				   <COND (<EQUAL? ,HERE ,CLEARING>
					  "La grille s'ouvre.")
					 (T
"La grille s'ouvre, révélant des arbres au-dessus de vous.")>
				   "La grille est fermée.">
		       <COND (<FSET? ,GRATE ,OPENBIT>
			      <COND (<AND <NOT <EQUAL? ,HERE ,CLEARING>>
					  <NOT ,GRATE-REVEALED>>
				     <TELL
"Un tas de feuilles vous tombe sur la tête et au sol." CR>
				     <SETG GRATE-REVEALED T>
				     <MOVE ,LEAVES ,HERE>)>
			      <FSET ,GRATING-ROOM ,ONBIT>)
			     (T <FCLEAR ,GRATING-ROOM ,ONBIT>)>)
		      (T <TELL "La grille est verrouillée." CR>)>)
	       (<AND <VERB? PUT> <EQUAL? ,PRSI ,GRATE>>
		<COND (<G? <GETP ,PRSO ,P?SIZE> 20>
		       <TELL "Elle ne passe pas à travers le grille." CR>)
		      (T
		       <MOVE ,PRSO ,GRATING-ROOM>
		       <TELL
"Le " D ,PRSO " traverse la grille dans l'obscurité en dessous." CR>)>)>>

<ROUTINE MAZE-DIODES ()
	 <TELL
"Tu ne pourras pas remonter jusqu'au tunnel que tu traverses quand il arrivera à la pièce voisine." CR CR>
	 <COND (<EQUAL? ,HERE ,MAZE-2> ,MAZE-4)
	       (<EQUAL? ,HERE ,MAZE-7> ,DEAD-END-1)
	       (<EQUAL? ,HERE ,MAZE-9> ,MAZE-11)
	       (<EQUAL? ,HERE ,MAZE-12> ,MAZE-5)>>

<ROUTINE RUSTY-KNIFE-FCN ()
	<COND (<VERB? TAKE>
	       <AND <IN? ,SWORD ,WINNER>
		    <TELL
"Lorsque vous touchez le couteau rouillé, votre épée donne un seul pouls de lumière bleue aveuglante." CR>>
	       <>)
	      (<OR <AND <EQUAL? ,PRSI ,RUSTY-KNIFE>
			<VERB? ATTACK>>
		   <AND <VERB? SWING>
			<EQUAL? ,PRSO ,RUSTY-KNIFE>
			,PRSI>>
	       <REMOVE-CAREFULLY ,RUSTY-KNIFE>
	       <JIGS-UP
"Alors que le couteau approche de sa victime, une volonté irrésistible submerge votre esprit. Lentement, votre main pivote jusqu'à ce que la lame rouillée ne soit plus qu'à quelques centimètres de votre cou. Le couteau semble chanter lorsqu'il vous tranche sauvagement la gorge.">)>>

<ROUTINE KNIFE-F ()
	 <COND (<VERB? TAKE>
		<FCLEAR ,ATTIC-TABLE ,NDESCBIT>
		<RFALSE>)>>

<ROUTINE SKELETON ()
	 <COND (<VERB? TAKE RUB MOVE PUSH RAISE LOWER ATTACK KICK KISS>
		<TELL
"Un fantôme apparaît, horrifié par la profanation des restes d'un autre aventurier. Il maudit vos objets de valeur et les bannit au Royaume des Morts-Vivants, puis s'éloigne en marmonnant des obscénités." CR>
	 	<ROB ,HERE ,LAND-OF-LIVING-DEAD 100>
	 	<ROB ,ADVENTURER ,LAND-OF-LIVING-DEAD>
	 	T)>>

\

<ROUTINE TORCH-OBJECT ()
    <COND (<VERB? EXAMINE>
	   <TELL "La torche brûle." CR>)
	  (<AND <VERB? POUR-ON>
		<EQUAL? ,PRSI ,TORCH>>
	   <TELL "L'eau s'évapore avant de s'approcher." CR>)
	  (<AND <VERB? LAMP-OFF> <FSET? ,PRSO ,ONBIT>>
	   <TELL
"Vous vous brûlez presque la main essayant d'éteindre la flamme." CR>)>>

\

"SOUS-TITRE MIROIR, MIROIR, AU MUR"

<ROUTINE MIRROR-ROOM (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
	        <TELL
"Vous êtes dans une vaste salle carrée au plafond très élevé. Le mur sud est entièrement occupé par un immense miroir. Des sorties s'ouvrent sur les trois autres côtés." CR>
		<COND (,MIRROR-MUNG
		       <TELL
"Malheureusement, le miroir a été détruit par votre imprudence." CR>)>)>>

<GLOBAL MIRROR-MUNG <>>
<GLOBAL LUCKY T>

<ROUTINE MIRROR-MIRROR ("AUX" (RM2 ,MIRROR-ROOM-2) L1 L2 N)
	<COND (<AND <NOT ,MIRROR-MUNG> <VERB? RUB>>
	       <COND (<AND ,PRSI <NOT <EQUAL? ,PRSI ,HANDS>>>
		      <TELL
"Vous ressentez un léger picotement transmis à travers le " D ,PRSI "." CR>
		      <RTRUE>)>
	       <COND (<EQUAL? ,HERE .RM2>
		      <SET RM2 ,MIRROR-ROOM-1>)>
	       <SET L1 <FIRST? ,HERE>>
	       <SET L2 <FIRST? .RM2>>
	       <REPEAT ()
		       <COND (<NOT .L1> <RETURN>)>
		       <SET N <NEXT? .L1>>
		       <MOVE .L1 .RM2>
		       <SET L1 .N>>
	       <REPEAT ()
		       <COND (<NOT .L2> <RETURN>)>
		       <SET N <NEXT? .L2>>
		       <MOVE .L2 ,HERE>
		       <SET L2 .N>>
	       <GOTO .RM2 <>>
	       <TELL
"Il y a un grondement provenant des profondeurs de la terre et la pièce tremble." CR>)
	      (<VERB? LOOK-INSIDE EXAMINE>
	       <COND (,MIRROR-MUNG
		      <TELL "Le miroir est brisé en plusieurs morceaux.">)
		     (T
		      <TELL "Il y a une personne laide qui regarde en arrière. à vous.">)>
	       <CRLF>)
	      (<VERB? TAKE>
	       <TELL
"Le miroir est plusieurs fois votre taille. Abandonnez." CR>)
	      (<VERB? MUNG THROW ATTACK>
	       <COND (,MIRROR-MUNG
		      <TELL
"N'avez-vous pas déjà fait assez de dégâts ?" CR>)
		     (T
		      <SETG MIRROR-MUNG T>
		      <SETG LUCKY <>>
		      <TELL
"Vous avez cassé le miroir, j'espère que vous avez sept ans de chance à portée de main." CR>)>)>>

\

"SOUS-TITRE LE DÔME"

<ROUTINE TORCH-ROOM-FCN (RARG)
 	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"C'est une grande salle dont l'imposante porte donne sur un escalier descendant. Un vaste dôme s'élève au-dessus de vous. Tout autour de sa base, à six mètres de hauteur, court une balustrade en bois. Au centre de la pièce repose un piédestal de marbre blanc." CR>
		<COND (,DOME-FLAG
		       <TELL
"Un morceau de corde descend de la rampe au-dessus, se terminant à environ cinq pieds au-dessus de votre tête." CR>)>)>>

<ROUTINE DOME-ROOM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Vous vous trouvez au bord d'un grand dôme qui forme le plafond d'une autre salle, en contrebas. Une balustrade en bois entourant le dôme vous protège d'une chute vertigineuse." CR>
		<COND (,DOME-FLAG
		       <TELL
"Suspendre de la rampe est une corde qui se termine à environ dix pieds du plancher en dessous." CR>)>)
	       (<EQUAL? .RARG ,M-ENTER>
		<COND (,DEAD
		       <TELL
"En pénétrant sous le dôme, vous sentez une force puissante, semblable à un vent violent, vous attirer par-dessus la balustrade vers le vide." CR>
		       <MOVE ,WINNER ,TORCH-ROOM>
		       <SETG HERE ,TORCH-ROOM>
		       <RTRUE>)
		      (<VERB? LEAP>
		       <JIGS-UP
"Je crains que le saut que vous avez tenté ne vous ait fait échouer.">)>)>>

;<GLOBAL EGYPT-FLAG <>>	;"no longer used?"

\

"SOUS-TITRE TERRE DES MORTS"

<ROUTINE LLD-ROOM (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Vous vous tenez devant un grand portail sur lequel est inscrit :||   Vous qui entrez ici, abandonnez toute espérance !||Le portail est ouvert. Au-delà s'étend un paysage de désolation ; dans un coin gît un amas de corps mutilés. Des milliers de voix pleurent un destin effroyable." CR>
		<COND (<AND <NOT ,LLD-FLAG> <NOT ,DEAD>>
		       <TELL
"Le chemin à travers la porte est interdit par les mauvais esprits, qui se moquent de vos tentatives de passer." CR>)>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<VERB? EXORCISE>
		       <COND (<NOT ,LLD-FLAG>
			      <COND (<AND <IN? ,BELL ,WINNER>
					  <IN? ,BOOK ,WINNER>
					  <IN? ,CANDLES ,WINNER>>
				     <TELL
"Vous devez effectuer la cérémonie." CR>)
				    (T
				     <TELL
"Vous n'êtes pas équipé pour un exorcisme." CR>)>)>)
		      (<AND <NOT ,LLD-FLAG>
			    <VERB? RING>
			    <EQUAL? ,PRSO ,BELL>>
		       <SETG XB T>
		       <REMOVE-CAREFULLY ,BELL>
		       <THIS-IS-IT ,HOT-BELL>
		       <MOVE ,HOT-BELL ,HERE>
		       <TELL
"La cloche devient soudain rougeoyante et tombe au sol. Comme paralysés, les spectres cessent leurs railleries et se tournent lentement vers vous. Sur leurs visages cendreux se dessine une terreur oubliée depuis des siècles." CR>
		       <COND (<IN? ,CANDLES ,WINNER>
			      <TELL
"Dans votre confusion, les bougies tombent au sol (et elles s'éteignent)." CR>
			      <MOVE ,CANDLES ,HERE>
			      <FCLEAR ,CANDLES ,ONBIT>
			      <DISABLE <INT I-CANDLES>>)>
		       <ENABLE <QUEUE I-XB 6>>
		       <ENABLE <QUEUE I-XBH 20>>)
		      (<AND ,XC
			    <VERB? READ>
			    <EQUAL? ,PRSO ,BOOK>
			    <NOT ,LLD-FLAG>>
		       <TELL
"Chaque mot de la prière se répercute dans la salle en un vacarme assourdissant. Lorsque le dernier s'éteint, une voix puissante et impérieuse tonne : « Arrière, démons ! » Un hurlement à glacer le sang emplit la caverne ; sentant une puissance supérieure, les esprits s'enfuient à travers les murs." CR>
		       <REMOVE-CAREFULLY ,GHOSTS>
		       <SETG LLD-FLAG T>
		       <DISABLE <INT I-XC>>)>)
	       (<EQUAL? .RARG ,M-END>
		<COND (<AND ,XB
			    <IN? ,CANDLES ,WINNER>
			    <FSET? ,CANDLES ,ONBIT>
			    <NOT ,XC>>
		       <SETG XC T>
		       <TELL
"Les flammes vacillent follement et semblent danser. La terre tremble sous vos pieds et vos jambes manquent de se dérober. Les esprits se recroquevillent devant votre pouvoir surnaturel." CR>
		       <DISABLE <INT I-XB>>
		       <ENABLE <QUEUE I-XC 3>>)>)>>

<GLOBAL XB <>>

<GLOBAL XC <>>

<ROUTINE I-XB ()
	 <OR ,XC
	     <AND <EQUAL? ,HERE ,ENTRANCE-TO-HADES>
		  <TELL
"La tension de la cérémonie retombe. Amusés, mais tout de même ébranlés par votre maladresse, les spectres reprennent leurs ignobles railleries." CR>>>
	 <SETG XB <>>>

<ROUTINE I-XC ()
	 <SETG XC <>>
	 <I-XB>>

<ROUTINE I-XBH ()
	 <REMOVE-CAREFULLY ,HOT-BELL>
	 <MOVE ,BELL ,ENTRANCE-TO-HADES>
	 <COND (<EQUAL? ,HERE ,ENTRANCE-TO-HADES>
		<TELL "La cloche semble avoir refroidi." CR>)>>

\

"SOUS-TITRE BARRAGE CONTRÔLANT LES INONDATIONS #3"

<GLOBAL GATE-FLAG <>>
<GLOBAL GATES-OPEN <>>

<ROUTINE DAM-ROOM-FCN (RARG)
   	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Vous êtes au sommet du Barrage de régulation des crues no 3, qui fut jadis une attraction touristique très courue. Des chemins mènent au nord, au sud et à l'ouest ; il est également possible de descendre tant bien que mal." CR>
		<COND (<AND ,LOW-TIDE ,GATES-OPEN>
		       <TELL
"Le niveau de l'eau derrière le barrage est bas : les vannes ont été ouvertes. L'eau se précipite à travers le barrage et poursuit sa course en aval." CR>)
		      (,GATES-OPEN
		       <TELL
"Les vannes sont ouvertes et l'eau se rue à travers le barrage. Le niveau du réservoir demeure toutefois élevé." CR>)
		      (,LOW-TIDE
		       <TELL
"Les vannes sont fermées. Le niveau du réservoir est encore assez bas, mais il monte rapidement." CR>)
		      (T
		       <TELL
"Les vannes du barrage sont fermées. Derrière l'ouvrage s'étend un vaste réservoir, dont l'eau déborde par-dessus le sommet du barrage désormais abandonné." CR>)>
		<TELL
"Un panneau de commande se trouve ici. Un gros boulon métallique y est monté et, juste au-dessus, une petite bulle de plastique verte">
		<COND (,GATE-FLAG
		       <TELL "qui brille sereinement">)>
		<TELL "." CR>)>>

<ROUTINE BOLT-F ()
	<COND (<VERB? TURN>
	       <COND (<EQUAL? ,PRSI ,WRENCH>
		      <COND (,GATE-FLAG
			     <FCLEAR ,RESERVOIR-SOUTH ,TOUCHBIT>
			     <COND (,GATES-OPEN
				    <SETG GATES-OPEN <>>
				    <FCLEAR ,LOUD-ROOM ,TOUCHBIT>
				    <TELL
"Les vannes se ferment et l'eau commence à s'accumuler derrière le barrage." CR>
				    <ENABLE <QUEUE I-RFILL 8>>
				    <QUEUE I-REMPTY 0>
				    T)
				   (T
				    <SETG GATES-OPEN T>
				    <TELL
"Les vannes s'ouvrent et l'eau s'écoule à travers le barrage." CR>
				    <ENABLE <QUEUE I-REMPTY 8>>
				    <QUEUE I-RFILL 0>
				    T)>)
			    (T <TELL
"Le boulon ne tournera pas avec votre meilleur effort." CR>)>)
		     (ELSE
		      <TELL
"Le boulon ne tournera pas en utilisant le " D ,PRSI "." CR>)>)
	      (<VERB? TAKE>
	       <INTEGRAL-PART>)
	      (<VERB? OIL>
	       <TELL
"Il semble que le tube contenait de la colle, pas de l'huile." CR>)>>

<ROUTINE BUBBLE-F ()
	 <COND (<VERB? TAKE>
		<INTEGRAL-PART>)>>

<ROUTINE INTEGRAL-PART ()
	 <TELL "Il fait partie intégrante du panneau de commande." CR>>

<ROUTINE I-RFILL ()
	 <FSET ,RESERVOIR ,NONLANDBIT>
	 <FCLEAR ,RESERVOIR ,RLANDBIT>
	 <FCLEAR ,DEEP-CANYON ,TOUCHBIT>
	 <FCLEAR ,LOUD-ROOM ,TOUCHBIT>
	 <AND <IN? ,TRUNK ,RESERVOIR>
	      <FSET ,TRUNK ,INVISIBLE>>
	 <SETG LOW-TIDE <>>
	 <COND (<EQUAL? ,HERE ,RESERVOIR>
		<COND (<FSET? <LOC ,WINNER> ,VEHBIT>
		       <TELL
"Le bateau sort doucement de la boue et flotte maintenant sur le réservoir." CR>)
		      (T
		       <JIGS-UP
"La montée des eaux vous soulève ! Vous tentez de nager, mais le courant est trop puissant. Vous vous rapprochez encore et encore de l'impressionnante masse du Barrage de régulation des crues no 3. Le barrage semble vous appeler. Le rugissement de l'eau vous assourdit presque, mais vous restez conscient tandis que le flot vous emporte par-dessus l'ouvrage, vers une mort certaine sur les rochers en contrebas.">)>)
	       (<EQUAL? ,HERE ,DEEP-CANYON>
		<TELL
"Un bruit, comme celui de l'eau qui coule, commence à venir d'en bas." CR>)
	       (<EQUAL? ,HERE ,LOUD-ROOM>
		<TELL
"Soudain, un rugissement d'une puissance alarmante emplit la salle. Pris de panique, vous détalez." CR>
		<GOTO <PICK-ONE ,LOUD-RUNS>>)
	       (<EQUAL? ,HERE ,RESERVOIR-NORTH ,RESERVOIR-SOUTH>
		<TELL
"Vous remarquez que le niveau de l'eau a augmenté au point qu'il est impossible de traverser." CR>)>
	 T>

<GLOBAL LOUD-RUNS <LTABLE 0 DAMP-CAVE ROUND-ROOM DEEP-CANYON>>

<ROUTINE I-REMPTY ()
	 <FSET ,RESERVOIR ,RLANDBIT>
	 <FCLEAR ,RESERVOIR ,NONLANDBIT>
	 <FCLEAR ,DEEP-CANYON ,TOUCHBIT>
	 <FCLEAR ,LOUD-ROOM ,TOUCHBIT>
	 <FCLEAR ,TRUNK ,INVISIBLE>
	 <SETG LOW-TIDE T>
	 <COND (<AND <EQUAL? ,HERE ,RESERVOIR>
		     <FSET? <LOC ,WINNER> ,VEHBIT>>
		<TELL
"Le niveau d'eau est tombé au point où le bateau ne peut plus rester à flot. Il coule dans la boue." CR>)
	       (<EQUAL? ,HERE ,DEEP-CANYON>
		<TELL
"Le rugissement de l'eau qui coule est plus silencieux maintenant." CR>)
	       (<EQUAL? ,HERE ,RESERVOIR-NORTH ,RESERVOIR-SOUTH>
		<TELL
"Le niveau d'eau est maintenant assez bas ici et vous pourriez facilement traverser de l'autre côté." CR>)>
	 T>

<GLOBAL DROWNINGS
      <TABLE (PURE) "jusqu'à vos chevilles."
	"jusqu'à votre tibia."
	"jusqu'aux genoux."
	"jusqu'à vos hanches."
	"jusqu'à votre taille."
	"jusqu'à votre poitrine."
	"jusqu'à votre cou."
	"au-dessus de votre tête."
	"au plus profond de vos poumons.">>

<GLOBAL WATER-LEVEL 0>
<GDECL (WATER-LEVEL) FIX>

<ROUTINE BUTTON-F ()
	 <COND (<VERB? READ>
		<TELL "Ils sont grecs pour vous." CR>)
	       (<VERB? PUSH>
		<COND (<EQUAL? ,PRSO ,BLUE-BUTTON>
		       <COND (<0? ,WATER-LEVEL>
			      <FCLEAR ,LEAK ,INVISIBLE>
			      <TELL
"Un grondement retentit, puis un jet d'eau jaillit du mur est : une conduite vient apparemment de se rompre." CR>
			      <SETG WATER-LEVEL 1>
			      <ENABLE <QUEUE I-MAINT-ROOM -1>>
			      T)
			     (T
			      <TELL
			        "Le bouton bleu semble être bloqué." CR>)>)
		      (<EQUAL? ,PRSO ,RED-BUTTON>
		       <TELL "Les lumières de la pièce ">
		       <COND (<FSET? ,HERE ,ONBIT>
			      <FCLEAR ,HERE ,ONBIT>
			      <TELL "s'éteignent éteint." CR>)
			     (T
			      <FSET ,HERE ,ONBIT>
			      <TELL "allez." CR>)>)
		      (<EQUAL? ,PRSO ,BROWN-BUTTON>
		       <FCLEAR ,DAM-ROOM ,TOUCHBIT>
		       <SETG GATE-FLAG <>>
		       <TELL "Cliquez." CR>)
		      (<EQUAL? ,PRSO ,YELLOW-BUTTON>
		       <FCLEAR ,DAM-ROOM ,TOUCHBIT>
		       <SETG GATE-FLAG T>
		       <TELL "Cliquez." CR>)>)>>

<ROUTINE TOOL-CHEST-FCN ()
	 <COND (<VERB? EXAMINE>
		<TELL "Tous les coffres sont vides." CR>)
	       (<VERB? TAKE OPEN PUT>
		<REMOVE-CAREFULLY ,TOOL-CHEST>
<TELL
"Les coffres sont si rouillés et corrodés qu'ils tombent en poussière au moindre contact." CR>)
	       (<VERB? OPEN>
		<TELL "Les coffres sont déjà ouverts." CR>)>>

<ROUTINE I-MAINT-ROOM ("AUX" HERE?)
	 <SET HERE? <EQUAL? ,HERE ,MAINTENANCE-ROOM>>
	 <COND (.HERE? <TELL "Le niveau d'eau ici est maintenant "> <TELL <GET
		,DROWNINGS </ ,WATER-LEVEL 2>>> <CRLF>)>
	 <SETG WATER-LEVEL <+ 1 ,WATER-LEVEL>>
	 <COND (<NOT <L? ,WATER-LEVEL 14>>
		<MUNG-ROOM ,MAINTENANCE-ROOM
"La pièce est remplie d'eau et il est impossible d'y entrer.">
		<QUEUE I-MAINT-ROOM 0>
		<COND (.HERE?
		     <JIGS-UP
"J'ai bien peur que vous ne vous soyez noyé.">)>)
	       (<AND <IN? ,WINNER ,INFLATED-BOAT>
		     <EQUAL? ,HERE ,MAINTENANCE-ROOM ,DAM-ROOM ,DAM-LOBBY>>
		<JIGS-UP
"L'eau montante porte le bateau sur le barrage, le long de la rivière, et sur les chutes. Tsk, Tsk.">)>
	 <RTRUE>>

<ROUTINE LEAK-FUNCTION ()
	<COND (<G? ,WATER-LEVEL 0>
	       <COND (<AND <VERB? PUT PUT-ON>
			   <EQUAL? ,PRSO ,PUTTY>>
		      <FIX-MAINT-LEAK>)
		     (<VERB? PLUG>
		      <COND (<EQUAL? ,PRSI ,PUTTY>
			     <FIX-MAINT-LEAK>)
			    (T <WITH-TELL ,PRSI>)>)>)>>

<ROUTINE FIX-MAINT-LEAK ()
	 <SETG WATER-LEVEL -1>
	 <QUEUE I-MAINT-ROOM 0>
	 <TELL
"Par un miracle de la technologie Zorkian, vous avez réussi à arrêter la fuite dans le barrage." CR>>

<ROUTINE PUTTY-FCN ()
	 <COND (<OR <AND <VERB? OIL>
			 <EQUAL? ,PRSI ,PUTTY>>
		    <AND <VERB? PUT>
			 <EQUAL? ,PRSO ,PUTTY>>>
		<TELL "La crasse tout usage n'est pas un lubrifiant." CR>)>>

<ROUTINE TUBE-FUNCTION ()
	 <COND (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,TUBE>>
		<TELL "Le tube refuse d'accepter quoi que ce soit." CR>)
	       (<VERB? SQUEEZE>
		<COND (<AND <FSET? ,PRSO ,OPENBIT>
			    <IN? ,PUTTY ,PRSO>>
		       <MOVE ,PUTTY ,WINNER>
		       <TELL "Le matériau visqueux suinte dans votre main." CR>)
		      (<FSET? ,PRSO ,OPENBIT>
		       <TELL "Le tube est apparemment vide." CR>)
		      (T
		       <TELL "Le tube est fermé." CR>)>)>>

<ROUTINE DAM-FUNCTION ()
	 <COND (<VERB? OPEN CLOSE>
		<TELL "Cela semble raisonnable, mais ce n'est pas comme ça." CR>)
	       (<VERB? PLUG>
		<COND (<EQUAL? ,PRSI ,HANDS>
		       <TELL
"Es-tu donc le petit garçon hollandais ? Désolé, c'est un grand barrage." CR>)
		      (T
		       <TELL
"Avec un " D ,PRSI "Tu sais à quel point ce barrage est grand ?" CR>)>)>>

<ROUTINE WITH-TELL (OBJ)
	 <TELL "Avec un " D .OBJ "?" CR>>

<ROUTINE RESERVOIR-SOUTH-FCN (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	       <COND (<AND ,LOW-TIDE ,GATES-OPEN>
		      <TELL
"Vous êtes dans une longue salle. Au nord s'étendait autrefois un lac ; depuis la baisse du niveau, seul un large ruisseau en traverse encore le centre.">)
		     (,GATES-OPEN
		      <TELL
"Vous êtes dans une longue salle. Au nord s'étend un vaste lac, trop profond pour être traversé. Vous remarquez cependant que son niveau baisse rapidement. Il sera peut-être bientôt possible de gagner l'autre rive depuis cet endroit.">)
		     (,LOW-TIDE
		      <TELL
"Vous êtes dans une longue salle. Au nord, un vaste espace autrefois occupé par un réservoir n'est plus traversé que par un ruisseau. Son niveau monte cependant très vite ; il sera bientôt impossible de passer ici.">)
		     (T
		      <TELL
"Vous êtes dans une longue salle, sur la rive sud d'un lac bien trop profond et trop vaste pour être traversé.">)>
	       <CRLF>
	       <TELL
"Un sentier longe le ruisseau vers l'est et l'ouest. Un chemin escarpé grimpe au sud-ouest le long d'un gouffre, tandis qu'un autre pénètre dans un canyon au sud-est." CR>)>>

<ROUTINE RESERVOIR-FCN (RARG)
   	<COND (<AND <EQUAL? .RARG ,M-END>
		    <NOT <FSET? <LOC ,WINNER> ,VEHBIT>>
		    <NOT ,GATES-OPEN>
		    ,LOW-TIDE>
	       <TELL
"Vous remarquez que le niveau de l'eau monte rapidement et que le courant se renforce. Rester ici paraît extrêmement dangereux !" CR>)
	      (<EQUAL? .RARG ,M-LOOK>
	       <COND (,LOW-TIDE
		      <TELL
"Vous vous trouvez sur ce qui était autrefois un grand lac et n'est plus désormais qu'une immense étendue de boue. Des « rives » se trouvent au nord et au sud.">)
		     (T
		      <TELL
"Vous êtes sur le lac. Des plages sont visibles au nord et au sud. En amont, un petit ruisseau se jette dans le lac par une étroite fissure entre les rochers. Le barrage est visible en aval.">)>
	       <CRLF>)>>

<ROUTINE RESERVOIR-NORTH-FCN (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	       <COND (<AND ,LOW-TIDE ,GATES-OPEN>
		      <TELL
"Vous êtes dans une vaste salle caverneuse. Sa partie sud était autrefois occupée par un lac ; depuis la baisse du niveau, seul un large ruisseau y coule encore.">)
		     (,GATES-OPEN
		      <TELL
"Vous êtes dans une immense caverne. Au sud s'étend un vaste lac dont le niveau semble baisser rapidement.">)
		     (,LOW-TIDE
		      <TELL
"Vous êtes dans une immense caverne. Au sud coule un très large ruisseau dont le niveau monte rapidement ; il sera bientôt impossible d'atteindre l'autre rive.">)
		     (T
		      <TELL
"Vous êtes dans une grande pièce caverneuse, au nord d'un grand lac.">)>
	       <CRLF>
	       <TELL
"Il y a un escalier gluant qui mène à la pièce. au nord." CR>)>>

\

"SOUS-TITRE DE L'EAU, DE L'EAU PARTOUT..."

<ROUTINE BOTTLE-FUNCTION ("AUX" (E? <>))
  <COND (<AND <VERB? THROW> <==? ,PRSO ,BOTTLE>>
	 <REMOVE-CAREFULLY ,PRSO>
	 <SET E? T>
	 <TELL "La bouteille heurte le mur du fond et se brise." CR>)
	(<VERB? MUNG>
	 <SET E? T>
	 <REMOVE-CAREFULLY ,PRSO>
	 <TELL "Une manoeuvre brillante détruit la bouteille." CR>)
	(<VERB? SHAKE>
	 <COND (<AND <FSET? ,PRSO ,OPENBIT> <IN? ,WATER ,PRSO>>
		<SET E? T>)>)>
  <COND (<AND .E? <IN? ,WATER ,PRSO>>
	 <TELL "L'eau se répand sur le sol et s'évapore." CR>
	 <REMOVE-CAREFULLY ,WATER>
	 T)
	(.E? <RTRUE>)>>

\

"SOUS-TITRE CYCLOPS"

<GLOBAL CYCLOWRATH 0>

<ROUTINE CYCLOPS-FCN ("AUX" COUNT)
	<SET COUNT ,CYCLOWRATH>
	<COND (<EQUAL? ,WINNER ,CYCLOPS>
	       <COND (,CYCLOPS-FLAG
		      <TELL "Inutile de lui parler. Il dort profondément." CR>)
		     (<VERB? ODYSSEUS>
		      <SETG WINNER ,ADVENTURER>
		      <PERFORM ,V?ODYSSEUS>
		      <RTRUE>)
		     (ELSE
		      <TELL
"Le cyclope préfère manger plutôt que de faire la conversation." CR>)>)
	      (,CYCLOPS-FLAG
	       <COND (<VERB? EXAMINE>
		      <TELL
"Le cyclope dort comme un bébé, bien qu'il soit très laid. un." CR>)
		     (<VERB? ALARM KICK ATTACK BURN MUNG>
		      <TELL
"Le cyclope bâille et regarde fixement la chose qui l'a réveillé." CR>
		      <SETG CYCLOPS-FLAG <>>
		      <FSET ,CYCLOPS ,FIGHTBIT>
		      <COND (<L? .COUNT 0>
			     <SETG CYCLOWRATH <- .COUNT>>)
			    (T
			     <SETG CYCLOWRATH .COUNT>)>)>)
	      (<VERB? EXAMINE>
	       <TELL
"Un cyclope affamé se tient au pied de l'escalier." CR>)
	      (<AND <VERB? GIVE> <EQUAL? ,PRSI ,CYCLOPS>>
	       <COND (<EQUAL? ,PRSO ,LUNCH>
		      <COND (<NOT <L? .COUNT 0>>
			     <REMOVE-CAREFULLY ,LUNCH>
			     <TELL
"Le cyclope déclare : « Mmm, mmm... J'adore les piments ! Mais qu'est-ce que j'ai soif ! Je pourrais peut-être boire le sang de cette chose. » À la lueur de son oeil, vous devinez sans peine que « cette chose », c'est vous." CR>
			     <SETG CYCLOWRATH <MIN -1 <- .COUNT>>>)>
		      <ENABLE <QUEUE I-CYCLOPS -1>>)
		     (<OR <EQUAL? ,PRSO ,WATER>
			  <AND <EQUAL? ,PRSO ,BOTTLE>
			       <IN? ,WATER ,BOTTLE>>>
		      <COND (<L? .COUNT 0>
			     <REMOVE-CAREFULLY ,WATER>
			     <MOVE ,BOTTLE ,HERE>
			     <FSET ,BOTTLE ,OPENBIT>
			     <FCLEAR ,CYCLOPS ,FIGHTBIT>
			     <TELL
"Le cyclope prend la bouteille, vérifie qu'elle est ouverte et boit l'eau. Un instant plus tard, il bâille si fort qu'il manque de vous renverser, puis s'endort profondément. Qu'aviez-vous donc mis dans cette boisson ?" CR>
			     <SETG CYCLOPS-FLAG T>)
			    (T
			     <TELL
"Le cyclope n'a apparemment pas soif et refuse votre offre généreuse." CR>)>)
		     (<EQUAL? ,PRSO ,GARLIC>
		      <TELL
"Le cyclope a peut-être faim, mais il y a des limites." CR>)
		     (T
		      <TELL
"Le cyclope n'est pas assez stupide pour manger CELA !" CR>)>)
	      (<VERB? THROW ATTACK MUNG>
	       <ENABLE <QUEUE I-CYCLOPS -1>>
	       <COND (<VERB? MUNG>
		      <TELL
"\"Pensez-vous que je suis aussi stupide que mon père l'était ?\", dit-il, esquivant." CR>)
		     (T
		      <TELL
"Le cyclope hausse les épaules mais ignore par ailleurs votre pitoyable tentative." CR>
		      <COND (<VERB? THROW>
			     <MOVE ,PRSO ,HERE>)>
		      <RTRUE>)>)
	      (<VERB? TAKE>
	       <TELL
"Le cyclope n'apprécie pas d'être attrapé." CR>)
	      (<VERB? TIE>
	       <TELL
"Vous ne pouvez pas attacher le cyclope, bien qu'il soit apte à l'être." CR>)
	      (<VERB? LISTEN>
	       <TELL
"Vous pouvez entendre son estomac gronder." CR>)>>

<ROUTINE I-CYCLOPS ()
	 <COND (<OR ,CYCLOPS-FLAG ,DEAD> <RTRUE>)
	       (<NOT <EQUAL? ,HERE ,CYCLOPS-ROOM>>
		<DISABLE <INT I-CYCLOPS>>)
	       (T
		<COND (<G? <ABS ,CYCLOWRATH> 5>
		       <DISABLE <INT I-CYCLOPS>>
		       <JIGS-UP
"Le cyclope, lassé de vos jeux et de vos ruses, vous empoigne fermement. En se léchant les babines, il dit : « Mmm... Tout comme les préparait maman. » C'est toujours agréable d'être apprécié.">)
		      (T
		       <COND (<L? ,CYCLOWRATH 0>
			      <SETG CYCLOWRATH <- ,CYCLOWRATH 1>>)
			     (T
			      <SETG CYCLOWRATH <+ ,CYCLOWRATH 1>>)>
		       <COND (<NOT ,CYCLOPS-FLAG>
			      <TELL <NTH ,CYCLOMAD <- <ABS ,CYCLOWRATH> 1>>
				    CR>)>)>)>>

<ROUTINE CYCLOPS-ROOM-FCN (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	       <TELL
"Cette pièce a une sortie au nord-ouest et un escalier qui monte." CR>
	       <COND (<AND ,CYCLOPS-FLAG <NOT ,MAGIC-FLAG>>
		      <TELL
"Le cyclope dort paisiblement au pied de l'escalier." CR>)
		     (,MAGIC-FLAG
		      <TELL
"Le mur est, auparavant solide, comporte désormais une ouverture de la taille d'un cyclope." CR>)
		     (<0? ,CYCLOWRATH>
		      <TELL
"Un cyclope qui semble prêt à dévorer des chevaux -- et, à plus forte raison, de simples aventuriers -- bloque l'escalier. À voir son état et les taches de sang sur les murs, il n'a rien d'amical, même s'il apprécie manifestement les gens." CR>)
		     (<G? ,CYCLOWRATH 0>
		      <TELL
"Le cyclope se tient dans un coin et vous observe attentivement. Je ne crois pas que vous lui plaisiez beaucoup. Il paraît affamé, même pour un cyclope." CR>)
		     (<L? ,CYCLOWRATH 0>
		      <TELL
"Après avoir mangé les piments, le cyclope halète péniblement. Sa langue enflammée pend hors de sa bouche gigantesque." CR>)>)
	      (<EQUAL? .RARG ,M-ENTER>
	       <OR <0? ,CYCLOWRATH> <ENABLE <INT I-CYCLOPS>>>)>>

<GLOBAL CYCLOMAD
	<TABLE (PURE)
	  "Le cyclope semble quelque peu agité."
	  "Le cyclope semble devenir plus agité. agité."
	  "Le cyclope se déplace dans la pièce à la recherche de quelque chose."
	  "Le cyclope cherchait du sel et du poivre, sans doute pour assaisonner son prochain en-cas."
	  "Le cyclope se dirige vers vous de manière hostile."
	  "Vous avez deux choix : 1. Partir 2. Devenir dîner.">>

\

"SOUS-TITRE LOUD LOUD LOUD"

<GLOBAL LOUD-FLAG <>>

<ROUTINE LOUD-ROOM-FCN (RARG "AUX" WRD)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"C'est une vaste salle dont le plafond est invisible depuis le sol. Un passage étroit la traverse d'est en ouest et un escalier de pierre monte vers le niveau supérieur.">
		<COND (<OR ,LOUD-FLAG
			   <AND <NOT ,GATES-OPEN> ,LOW-TIDE>>
		       <TELL " La pièce est étrange par son calme.">)
		      (T
		       <TELL " La salle est emplie d'un grondement assourdissant d'origine indéterminée. Le bruit se répercute sur toutes les parois, au point qu'il devient difficile de penser.">)>
		<CRLF>)
	       (<AND <EQUAL? .RARG ,M-END> ,GATES-OPEN <NOT ,LOW-TIDE>>
		<TELL
"Le vacarme est insupportable : un rugissement à vous fendre les oreilles semble venir de partout. Votre crâne est martelé par une douleur incessante. Au prix d'un effort surhumain, vous parvenez à quitter la salle." CR CR>
		<GOTO <PICK-ONE ,LOUD-RUNS>>
		<RFALSE>)		
	       (<EQUAL? .RARG ,M-ENTER>
		<COND (<OR ,LOUD-FLAG
			   <AND <NOT ,GATES-OPEN> ,LOW-TIDE>>
		       <RFALSE>)
		      (<AND ,GATES-OPEN <NOT ,LOW-TIDE>>
		       <RFALSE>)
		      (T
		       <V-FIRST-LOOK>
		       <COND (,P-CONT
			      <TELL
"Le reste de vos commandes a été perdu dans le bruit." CR>
			      <SETG P-CONT <>>)>
		       <REPEAT ()
			       <COND (<NOT ,SUPER-BRIEF> <CRLF>)>
			       <TELL ">">
			       <READ ,P-INBUF ,P-LEXV>
			       <COND (<0? <GETB ,P-LEXV ,P-LEXWORDS>>
			              <TELL "Je vous demande pardon ?" CR>
				      <AGAIN>)>
			       <SET WRD <GET ,P-LEXV 1>>
			       <COND (<EQUAL? .WRD ,W?GO ,W?WALK ,W?RUN>
				      <SET WRD <GET ,P-LEXV 3>>)
				     (<EQUAL? .WRD ,W?SAY>
				      <SET WRD <GET ,P-LEXV 5>>)>
			       <COND (<EQUAL? .WRD ,W?SAVE>
				      <V-SAVE>)
				     (<EQUAL? .WRD ,W?RESTORE>
				      <V-RESTORE>)
				     (<EQUAL? .WRD ,W?Q ,W?QUIT>
				      <V-QUIT>)
				     (<EQUAL? .WRD ,W?W ,W?WEST>
				      <RETURN <GOTO ,ROUND-ROOM>>)
				     (<EQUAL? .WRD ,W?E ,W?EAST>
				      <RETURN <GOTO ,DAMP-CAVE>>)
				     (<EQUAL? .WRD ,W?U ,W?UP>
				      <RETURN <GOTO ,DEEP-CANYON>>)
				     (<EQUAL? .WRD ,W?BUG>
				      <TELL "Ce n'est que votre " CR>)
				     (<EQUAL? .WRD ,W?ECHO>
				      <SETG LOUD-FLAG T>
				      <FCLEAR ,BAR ,SACREDBIT>
				      <TELL
"L'acoustique de la pièce change subtilement." CR>
				      <COND (<NOT ,SUPER-BRIEF> <CRLF>)>
				      <RETURN>)
				     ;(,DEAD <CRLF>)
				     (T
				      <V-ECHO>)>>)>)>>

<ROUTINE DEEP-CANYON-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Vous êtes au bord sud d'un canyon profond. Les passages mènent à l'est, au nord-ouest et au sud-ouest.">
		<COND (<AND ,GATES-OPEN <NOT ,LOW-TIDE>>
		       <TELL
"Vous pouvez entendre un bruit rugissant, comme celui de l'eau rugissante, d'en bas.">)
		      (<AND <NOT ,GATES-OPEN> ,LOW-TIDE>
		       <CRLF>
		       <RTRUE>)
		      (T
		       <TELL
" Vous pouvez entendre le bruit de l'eau qui coule d'en bas.">)>
		<CRLF>)>>


<GLOBAL EGG-SOLVE <>>

\

"SOUS-TITRE UN ASPECT MALOUREUX GENTLEMAN..."

<GLOBAL THIEF-HERE <>>

;"I-THIEF moved to DEMONS"

\

"SOUS-TITRE CHOSES QUE LE VOLEUR POURRAIT FAIRE"

"INTERACTION AVEC L'AVENTURIER -- RETOURNE T SI VOLEUR FINI."

<ROUTINE THIEF-VS-ADVENTURER (HERE? "AUX" ROBBED? (WINNER-ROBBED? <>))
  <COND (<AND <NOT ,DEAD> <EQUAL? ,HERE ,TREASURE-ROOM>>)
        (<NOT ,THIEF-HERE>
         <COND (<AND <NOT ,DEAD> <NOT .HERE?> <PROB 30>>
	        <COND (<IN? ,STILETTO ,THIEF>
		       <FCLEAR ,THIEF ,INVISIBLE>
		       <TELL
"Un homme portant un grand sac est nonchalamment adossé à l'un des murs. Il ne dit rien, mais son attitude indique clairement qu'il faudra lui passer sur le corps pour s'emparer du sac." CR>
		       <SETG THIEF-HERE T>
		       <RTRUE>)
		      ;(<IN? ,STILETTO ,WINNER>
		       <MOVE ,STILETTO ,THIEF>
		       <FSET ,STILETTO ,NDESCBIT>
		       <FCLEAR ,THIEF ,INVISIBLE>
		       <TELL
"Vous sentez l'effleurement d'un doigt. En vous retournant, vous découvrez une silhouette souriante, un grand sac dans une main et un stylet dans l'autre.">
		       <SETG THIEF-HERE T>
		       <RTRUE>)>)
	       (<AND .HERE?
		     <FSET? ,THIEF ,FIGHTBIT>
		     <NOT <WINNING? ,THIEF>>>
		<TELL
"Votre adversaire, jugeant que la prudence est la meilleure part du courage, décide de mettre fin à ce petit contretemps. D'un signe de tête contrit, il recule dans l'ombre et disparaît." CR>
		<FSET ,THIEF ,INVISIBLE>
		<FCLEAR ,THIEF ,FIGHTBIT>
		<RECOVER-STILETTO>
		<RTRUE>)
	       (<AND .HERE? <FSET? ,THIEF ,FIGHTBIT> <PROB 90>>
		<RFALSE>)
	       (<AND .HERE? <PROB 30>>
	        <TELL
"Le porteur du grand sac vient de partir, l'air dégoûté. Heureusement, il n'a rien pris." CR>
		<FSET ,THIEF ,INVISIBLE>
		<RECOVER-STILETTO>
	        <RTRUE>)
	       (<PROB 70> <RFALSE>)
	       (<NOT ,DEAD>
		<COND (<ROB ,HERE ,THIEF 100>
		       <SET ROBBED? ,HERE>)
		      (<ROB ,WINNER ,THIEF>
		       <SET ROBBED? ,PLAYER>)>
		<SETG THIEF-HERE T>
	        <COND (<AND .ROBBED? <NOT .HERE?>>
		       <TELL
"Un individu qui a l'air souilleux avec un grand sac vient de s'aventurer dans la pièce.">
		       <COND (<EQUAL? .ROBBED? ,HERE>
			      <TELL "la pièce">)
			     (ELSE
			      <TELL "votre possession">)>
		       <TELL ", murmurant quelque chose à propos de \"faire aux autres avant...\"" CR>
		       <STOLE-LIGHT?>)
		      (.HERE?
		       <RECOVER-STILETTO>
		       <COND (.ROBBED?
			      <TELL
"Le voleur vient de partir, portant toujours son grand sac.">
			      <COND (<EQUAL? .ROBBED? ,PLAYER>
				     <TELL
"vous a d'abord volé à l'aveugle.">)
				    (T
				     <TELL
"s'est approprié les objets de valeur qui se trouvaient dans la pièce.">)>
			      <CRLF>
			      <STOLE-LIGHT?>)
			     (T
			      <TELL
"Le voleur, ne trouvant rien de valeur, est parti. dégoûté." CR>)>
		       <FSET ,THIEF ,INVISIBLE>
		       <SET HERE? <>>
		       <RTRUE>)
		      (T
		       <TELL
"Un individu \"maigre et affamé\" vient de passer, chargé d'un grand sac. N'ayant rien trouvé de valeur, il est reparti dépité." CR>
		       <RTRUE>)>)>)
	(T
	 <COND (.HERE?			;"Here, already announced."
		<COND (<PROB 30>
		       <COND (<ROB ,HERE ,THIEF 100>
			      <SET ROBBED? ,HERE>)
			     (<ROB ,WINNER ,THIEF>
			      <SET ROBBED? ,PLAYER>)>
		       <COND (.ROBBED?
			      <TELL
"Le voleur vient de partir, portant toujours son grand sac.">
			      <COND (<EQUAL? .ROBBED? ,PLAYER>
				     <TELL
"vous a d'abord volé à l'aveugle.">)
				    (T
				     <TELL
"s'est approprié les objets de valeur qui se trouvaient dans la pièce.">)>
			      <CRLF>
			      <STOLE-LIGHT?>)
			     (T
			      <TELL
"Le voleur, ne trouvant rien de valeur, est parti. dégoûté." CR>)>
		       <FSET ,THIEF ,INVISIBLE>
		       <SET HERE? <>>
		       <RECOVER-STILETTO>)>)>)>
       <RFALSE>>

<ROUTINE STOLE-LIGHT? ("AUX" OLD-LIT)
	 <SET OLD-LIT ,LIT>
	 <SETG LIT <LIT? ,HERE>>
	 <COND (<AND <NOT ,LIT> .OLD-LIT>
		<TELL "Le voleur semble vous avoir laissé dans le noir." CR>)>
	 <RTRUE>>

"SNARF STILETTO SI L'A LAISSÉ"

;"RECOVER-STILETTO moved to DEMONS"

"METTEZ SON BUTIN AU TRÉSOR CHAMBRE"

<ROUTINE HACK-TREASURES ("AUX" X)
	 <RECOVER-STILETTO>
	 <FSET ,THIEF ,INVISIBLE>
	 <SET X <FIRST? ,TREASURE-ROOM>>
	 <REPEAT ()
		 <COND (<NOT .X> <RETURN>)
		       (T <FCLEAR .X ,INVISIBLE>)>
		 <SET X <NEXT? .X>>>>

<ROUTINE DEPOSIT-BOOTY (RM "AUX" X N (FLG <>))
	 <SET X <FIRST? ,THIEF>>
	 <REPEAT ()
		 <COND (<NOT .X> <RETURN .FLG>)>
		 <SET N <NEXT? .X>>
		 <COND (<EQUAL? .X ,STILETTO ,LARGE-BAG>)
		       (<G? <GETP .X ,P?TVALUE> 0>
			<MOVE .X .RM>
			<SET FLG T>
			<COND (<EQUAL? .X ,EGG>
			       <SETG EGG-SOLVE T>
			       <FSET ,EGG ,OPENBIT>)>)>
		 <SET X .N>>>

"EMPORTEZ TOUS LES OBJETS DE VALEUR QUELQUE PART ET LES METTRE AILLEURS"

" DÉPLACÉS AUX DÉMONS"

"ROB MAZE"

<ROUTINE ROB-MAZE (RM "AUX" X N)
	 <SET X <FIRST? .RM>>
	 <REPEAT ()
		 <COND (<NOT .X> <RFALSE>)>
		 <SET N <NEXT? .X>>
		 <COND (<AND <FSET? .X ,TAKEBIT>
			     <NOT <FSET? .X ,INVISIBLE>>
			     <PROB 40>>
			<TELL
"Vous entendez, au loin, quelqu'un dire \"Mon, je me demande ce que ça va" D .X " fait ici.\"" CR>
			<COND (<PROB 60 80>
			       <MOVE .X ,THIEF>
			       <FSET .X ,TOUCHBIT>
			       <FSET .X ,INVISIBLE>)>
			<RETURN>)>
		 <SET X .N>>>

"Voler quelques déchets - déplacé vers DEMONS"

"LAISSEZ QUELQUES ORDRES - déplacé vers DÉMONS"



\

"FONCTION DE VOL -- occupations de voleurs plus prosaïques"

<GLOBAL THIEF-ENGROSSED <>>

<ROUTINE ROBBER-FUNCTION ("OPTIONAL" (MODE <>) "AUX" (FLG <>) X N)
	 <COND (<VERB? TELL>
		<TELL "Le voleur est un voleur fort et silencieux type." CR>
		<SETG P-CONT <>>)
	       (<NOT .MODE>
		<COND (<AND <VERB? HELLO>
			    <EQUAL? <GETP ,THIEF ,P?LDESC> ,ROBBER-U-DESC>>
		       <TELL
"Le voleur, momentanément hors d'état de réagir, ne peut répondre à votre salut avec sa courtoisie habituelle." CR>)
		      (<AND <EQUAL? ,PRSO ,KNIFE>
			    <VERB? THROW>
			    <NOT <FSET? ,THIEF ,FIGHTBIT>>>
		       <MOVE ,PRSO ,HERE>
		       <COND (<PROB 10 0>
			      <TELL
"Vous avez évidemment effrayé le voleur, mais vous ne l'avez pas frappé.">
			      <REMOVE ,LARGE-BAG>
			      <SET X <>>
			      <COND (<IN? ,STILETTO ,THIEF>
				     <REMOVE ,STILETTO>
				     <SET X T>)>
			      <COND (<FIRST? ,THIEF>
				     <MOVE-ALL ,THIEF ,HERE>
				     <TELL
", mais le contenu de son sac tombe par terre.">)
				    (T
				     <TELL ".">)>
			      <MOVE ,LARGE-BAG ,THIEF>
			      <COND (.X <MOVE ,STILETTO ,THIEF>)>
			      <CRLF>
			      <FSET ,THIEF ,INVISIBLE>)
			     (T
			      <TELL
"Le voleur ne tente pas de prendre le couteau, mais ce serait un bon ajout à la collection dans son sac." CR>
			      <FSET ,THIEF ,FIGHTBIT>)>)
		      (<AND <VERB? THROW GIVE>
			    ,PRSO
			    <NOT <EQUAL? ,PRSO ,THIEF>>
			    <EQUAL? ,PRSI ,THIEF>>
		       <COND (<L? <GETP ,THIEF ,P?STRENGTH> 0>
			      <PUTP ,THIEF
				    ,P?STRENGTH
				    <- <GETP ,THIEF ,P?STRENGTH>>>
			      <ENABLE <INT I-THIEF>>
			      <RECOVER-STILETTO>
			      <PUTP ,THIEF ,P?LDESC ,ROBBER-C-DESC>
			      <TELL
"Votre victime proposée reprend soudainement conscience." CR>)>
		       <MOVE ,PRSO ,THIEF>
		       <COND ;(<EQUAL? ,PRSO ,STILETTO>
			      <TELL
"Le voleur prend son stiletto et vous salue avec un petit clin d'oeil de sa tête." CR>)
			     (<G? <GETP ,PRSO ,P?TVALUE> 0>
			      <SETG THIEF-ENGROSSED T>
			      <TELL
"Le voleur est repris par votre générosité inattendue, mais accepte le" D ,PRSO " et s'arrête pour admirer sa beauté." CR>)
			     (T
			      <TELL
"Le voleur place le " D ,PRSO "dans son sac et merci poliment." CR>)>)
		      (<VERB? TAKE>
		       <TELL
"Une fois que vous l'aurez eu, que feriez-vous de lui ?" CR>)
		      (<VERB? EXAMINE LOOK-INSIDE>
		       <TELL
"Le voleur est un personnage fuyant, dont les petits yeux vifs vont sans cesse de droite à gauche. Avec une arrogance impossible à manquer, il porte un grand sac sur l'épaule et brandit un stylet redoutable, dont la lame est braquée sur vous. À votre place, je me méfierais." CR>)
		      (<VERB? LISTEN>
		       <TELL
"Le voleur ne dit rien, car vous n'avez pas été formellement présenté." CR>)>)
	       (<EQUAL? .MODE ,F-BUSY?>
		<COND (<IN? ,STILETTO ,THIEF> <>)
		      (<IN? ,STILETTO <LOC ,THIEF>>
		       <MOVE ,STILETTO ,THIEF>
		       <FSET ,STILETTO ,NDESCBIT>
		       <COND (<IN? ,THIEF ,HERE>
			      <TELL
"Quelque peu surpris par cette tournure des événements, le voleur récupère prestement son stylet." CR>)>
		       T)>)
	       (<EQUAL? .MODE ,F-DEAD>
		<MOVE ,STILETTO ,HERE>
		<FCLEAR ,STILETTO ,NDESCBIT>
		<SET X <DEPOSIT-BOOTY ,HERE>>
		<COND (<EQUAL? ,HERE ,TREASURE-ROOM>
		       <SET X <FIRST? ,HERE>>
		       <REPEAT ()
			       <COND
				(<NOT .X>
				 <TELL "Le calice peut désormais être pris en toute sécurité." CR>
				 <RETURN>)
				(<NOT <EQUAL? .X ,CHALICE ,THIEF ,ADVENTURER>>
				 <FCLEAR .X ,INVISIBLE>
				 <COND (<NOT .FLG>
					<SET FLG T>
					<TELL
"Comme le voleur meurt, la puissance de sa magie diminue, et ses trésors réapparaissent:" CR>)>
				 <TELL " A " D .X>
				 <COND (<AND <FIRST? .X>
					     <SEE-INSIDE? .X>>
					<TELL ", avec ">
					<PRINT-CONTENTS .X>)>
				 <CRLF>)>
			       <SET X <NEXT? .X>>>)
		      (.X
		       <TELL "Son butin reste." CR>)>
		<DISABLE <INT I-THIEF>>)
	       (<EQUAL? .MODE ,F-FIRST?>
		<COND (<AND ,THIEF-HERE
			    <NOT <FSET? ,THIEF ,INVISIBLE>>
			    <PROB 20>>
		       <FSET ,THIEF ,FIGHTBIT>
		       <SETG P-CONT <>>
		       T)>)
	       (<EQUAL? .MODE ,F-UNCONSCIOUS>
		<DISABLE <INT I-THIEF>>
		<FCLEAR ,THIEF ,FIGHTBIT>
		<MOVE ,STILETTO ,HERE>
		<FCLEAR ,STILETTO ,NDESCBIT>
		<PUTP ,THIEF ,P?LDESC ,ROBBER-U-DESC>)
	       (<EQUAL? .MODE ,F-CONSCIOUS>
		<COND (<EQUAL? <LOC ,THIEF> ,HERE>
		       <FSET ,THIEF ,FIGHTBIT>
		       <TELL
"Le voleur reprend connaissance, feint encore un instant l'inconscience puis, dès que l'occasion se présente, détale loin de vous." CR>)>
		<ENABLE <INT I-THIEF>>
		<PUTP ,THIEF ,P?LDESC ,ROBBER-C-DESC>
		<RECOVER-STILETTO>)>>

<GLOBAL ROBBER-C-DESC
"Un individu a l'air louche, un sac à la main, est adossé au mur. Il est armé d'un stylet à l'aspect redoutable.">

<GLOBAL ROBBER-U-DESC
"Il y a une personne suspecte qui est allongée inconsciente sur le sol.">

<ROUTINE LARGE-BAG-F ()
	 <COND (<VERB? TAKE>
		<COND (<EQUAL? <GETP ,THIEF ,P?LDESC> ,ROBBER-U-DESC>
		       <TELL
"Malheureusement pour toi, le voleur s'est effondré au-dessus du sac." CR>)
		      (T
		       <TELL
"Le sac sera récupéré sur son cadavre." CR>)>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,LARGE-BAG>>
		<TELL "Ce serait une bonne astuce." CR>)
	       (<VERB? OPEN CLOSE>
		<TELL
"Se rapprocher suffisamment serait un bon tour." CR>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
"Le sac est sous le voleur, donc on ne peut pas dire quoi, s'il y a quoi que ce soit, est à l'intérieur." CR>)>>

<ROUTINE MOVE-ALL (FROM TO "AUX" X N)
	 <COND (<SET X <FIRST? .FROM>>
		<REPEAT ()
			<COND (<NOT .X> <RETURN>)>
			<SET N <NEXT? .X>>
			<FCLEAR .X ,INVISIBLE>
			<MOVE .X .TO>
			<SET X .N>>)>>

<ROUTINE CHALICE-FCN ()
	 <COND (<VERB? TAKE>
		<COND (<AND <IN? ,PRSO ,TREASURE-ROOM>
			    <IN? ,THIEF ,TREASURE-ROOM>
			    <FSET? ,THIEF ,FIGHTBIT>
			    <NOT <FSET? ,THIEF ,INVISIBLE>>
			    <NOT <EQUAL? <GETP ,THIEF ,P?LDESC>
					 ,ROBBER-U-DESC>>>
		       <TELL
"Vous seriez d'abord poignardé dans le dos." CR>)>)
	       (<AND <VERB? PUT> <EQUAL? ,PRSI ,CHALICE>>
		<TELL
"Vous ne pouvez pas. Ce n'est pas un très bon calice, n'est-ce pas ?" CR>)
	       (T <DUMB-CONTAINER>)>>

<ROUTINE TREASURE-ROOM-FCN (RARG "AUX" TL)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <1? <GET <INT I-THIEF> ,C-ENABLED?>>
		     <NOT ,DEAD>>
		<COND (<NOT <IN? ,THIEF ,HERE>>
		       <TELL
"Un hurlement d'angoisse retentit lorsque vous pénétrez dans la cachette du voleur. Par des passages que vous ne connaissez pas, il accourt pour la défendre." CR>
		       <MOVE ,THIEF ,HERE>)>
		<FSET ,THIEF ,FIGHTBIT>
		<FCLEAR ,THIEF ,INVISIBLE>
		<THIEF-IN-TREASURE>)>>

<ROUTINE THIEF-IN-TREASURE ("AUX" F N)
	 <SET F <FIRST? ,HERE>>
	 <COND (<AND .F <NEXT? .F>>
		<TELL
"Le voleur fait des gestes mystérieux, et les trésors de la pièce disparaissent soudainement." CR CR>)>
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN>)
		       (<NOT <EQUAL? .F ,CHALICE ,THIEF>>
			<FSET .F ,INVISIBLE>)>
		 <SET F <NEXT? .F>>>>

<ROUTINE FRONT-DOOR-FCN ()
	 <COND (<VERB? OPEN>
		<TELL "La porte ne peut pas être ouverte." CR>)
	       (<VERB? BURN>
		<TELL
		 "Vous ne pouvez pas brûler cette porte." CR>)
	       (<VERB? MUNG>
		<TELL "Vous ne semblez pas endommager le porte." CR>)
	       (<VERB? LOOK-BEHIND>
		<TELL "Elle ne s'ouvre pas." CR>)>>

\

"SOUS-TITRE FONCTIONS ALÉATOIRES"

<ROUTINE BODY-FUNCTION ()
	 <COND (<VERB? TAKE>
		<TELL "Une force vous empêche de prendre les corps." CR>)
	       (<VERB? MUNG BURN>
		<JIGS-UP
"La voix du gardien du donjon tonne dans les ténèbres : « Votre irrespect vous coûtera la vie ! » Puis votre tête finit empalée sur une pique acérée.">)>>

<ROUTINE BLACK-BOOK ()
	 <COND (<VERB? OPEN>
		<TELL "Le livre est déjà ouvert à la page 569." CR>)
	       (<VERB? CLOSE>
		<TELL "Même si vous essayez, le livre ne peut pas être fermé." CR>)
	       (<OR <VERB? TURN>
		    <AND <VERB? READ-PAGE>
			 <EQUAL? ,PRSI ,INTNUM>
			 <NOT <EQUAL? ,P-NUMBER 569>>>>
		<TELL
"En dehors de la page 569, une seule autre page porte encore un texte lisible. La plus grande partie est indéchiffrable, mais le sujet semble être le bannissement du mal. Certains sons, certaines lumières et certaines prières paraissent efficaces à cette fin." CR>)
	       (<VERB? BURN>
		<REMOVE-CAREFULLY ,PRSO>
		<JIGS-UP
"Une voix tonitruante lance : « Faux, crétin ! » Vous constatez alors que vous êtes devenu un tas de poussière. Comment ? Je n'en ai pas la moindre idée.">)>>

<ROUTINE PAINTING-FCN ()
	 <COND (<VERB? MUNG>
		<PUTP ,PRSO ,P?TVALUE 0>
		<PUTP ,PRSO ,P?LDESC
"Il y a un morceau de toile sans valeur ici.">
		<TELL
"Félicitations ! Contrairement aux autres vandales, qui se sont contentés de voler les chefs-d'oeuvre de l'artiste, vous avez réussi à en détruire un." CR>)>>

\

"SOUS-TITRE QU'IL Y A DES SOURCES DE LUMIÈRE"

<GLOBAL LAMP-TABLE
	<TABLE (PURE)
	       100
	       "La lampe apparaît un peu "
	       70
	       "La lampe est définitivement plus faible maintenant."
	       15   
	       "La lampe est presque éteinte."
	       0>>

<ROUTINE LANTERN ()
	 <COND (<VERB? THROW>
		<TELL
"La lampe s'est écrasée contre le sol et la lumière s'est éteinte. éteint." CR>
		<DISABLE <INT I-LANTERN>>
		<REMOVE-CAREFULLY ,LAMP>
		<MOVE ,BROKEN-LAMP ,HERE>)
	       (<VERB? LAMP-ON>
		<COND (<FSET? ,LAMP ,RMUNGBIT>
		       <TELL "Une lampe grillée ne s'allume pas." CR>)
		      (T
		       <ENABLE <INT I-LANTERN>>
		       <>)>)
	       (<VERB? LAMP-OFF>
		<COND (<FSET? ,LAMP ,RMUNGBIT>
		       <TELL "La lampe est déjà grillée." CR>)
		      (T
		       <DISABLE <INT I-LANTERN>>
		       <>)>)
	       (<VERB? EXAMINE>
		<TELL "La lampe ">
		<COND (<FSET? ,LAMP ,RMUNGBIT>
		       <TELL "est grillé.">)
		      (<FSET? ,LAMP ,ONBIT>
		       <TELL "est allumé.">)
		      (T
		       <TELL "est allumé éteint.">)>
		<CRLF>)>>

<ROUTINE MAILBOX-F ()
	 <COND (<AND <VERB? TAKE> <EQUAL? ,PRSO ,MAILBOX>>
		<TELL "Il est solidement ancré." CR>)>>

<GLOBAL MATCH-COUNT 6>

<ROUTINE MATCH-FUNCTION ("AUX" CNT)
	 <COND (<AND <VERB? LAMP-ON BURN> <EQUAL? ,PRSO ,MATCH>>
		<COND (<G? ,MATCH-COUNT 0>
		       <SETG MATCH-COUNT <- ,MATCH-COUNT 1>>)>
		<COND (<NOT <G? ,MATCH-COUNT 0>>
		       <TELL
			"Je crains que vous n'ayez plus d'allumettes." CR>)
		      (<EQUAL? ,HERE ,LOWER-SHAFT ,TIMBER-ROOM>
		       <TELL
"Il y a des courants d'air dans cette salle et le match s'arrête instantanément." CR>)
		      (T
		       <FSET ,MATCH ,FLAMEBIT>
		       <FSET ,MATCH ,ONBIT>
		       <ENABLE <QUEUE I-MATCH 2>>
		       <TELL "L'un des matchs commence à brûler." CR>
		       <COND (<NOT ,LIT>
			      <SETG LIT T>
			      <V-LOOK>)>
		       <RTRUE>)>)
	       (<AND <VERB? LAMP-OFF> <FSET? ,MATCH ,FLAMEBIT>>
		<TELL "L'allumette est éteinte." CR>
		<FCLEAR ,MATCH ,FLAMEBIT>
		<FCLEAR ,MATCH ,ONBIT>
		<SETG LIT <LIT? ,HERE>>
		<COND (<NOT ,LIT> <TELL "Il fait noir ici !" CR>)>
		<QUEUE I-MATCH 0>
		<RTRUE>)
	       (<VERB? COUNT OPEN>
		<TELL "Vous avez ">
	        <SET CNT <- ,MATCH-COUNT 1>>
		<COND (<NOT <G? .CNT 0>> <TELL "non">)
		      (T <TELL N .CNT>)>
		<TELL " allumette">
		<COND (<NOT <1? .CNT>> <TELL "es.">) (T <TELL ".">)>
		<CRLF>)
	       (<VERB? EXAMINE>
		<COND (<FSET? ,MATCH ,ONBIT>
		       <TELL "L'allumette brûle.">)
		      (T
		       <TELL
"La boîte d'allumettes n'est pas très intéressante, à part ce qui est écrit dessus ">)>
		<CRLF>)>>

<ROUTINE I-MATCH ()
	 <TELL "L'allumette s'est éteinte." CR>
	 <FCLEAR ,MATCH ,FLAMEBIT>
	 <FCLEAR ,MATCH ,ONBIT>
	 <SETG LIT <LIT? ,HERE>>
	 <RTRUE>>

<ROUTINE I-LANTERN ("AUX" TICK (TBL <VALUE LAMP-TABLE>))
	 <ENABLE <QUEUE I-LANTERN <SET TICK <GET .TBL 0>>>>
	 <LIGHT-INT ,LAMP .TBL .TICK>
	 <COND (<NOT <0? .TICK>>
		<SETG LAMP-TABLE <REST .TBL 4>>)>>

<ROUTINE I-CANDLES ("AUX" TICK (TBL <VALUE CANDLE-TABLE>))
	 <FSET ,CANDLES ,TOUCHBIT>
	 <ENABLE <QUEUE I-CANDLES <SET TICK <GET .TBL 0>>>>
	 <LIGHT-INT ,CANDLES .TBL .TICK>
	 <COND (<NOT <0? .TICK>>
		<SETG CANDLE-TABLE <REST .TBL 4>>)>>

<ROUTINE LIGHT-INT (OBJ TBL TICK)
	 <COND (<0? .TICK>
		<FCLEAR .OBJ ,ONBIT>
		<FSET .OBJ ,RMUNGBIT>)>
	 <COND (<OR <HELD? .OBJ> <IN? .OBJ ,HERE>>
		<COND (<0? .TICK>
		       <TELL
"Tu ferais mieux d'avoir plus de lumière que celle du " D .OBJ "." CR>)
		      (T
		       <TELL <GET .TBL 1> CR>)>)>>

<ROUTINE MIN (N1 N2)
	 <COND (<L? .N1 .N2> .N1)
	       (T .N2)>>

<ROUTINE CANDLES-FCN ()
	 <COND (<NOT <FSET? ,CANDLES ,TOUCHBIT>>
		<ENABLE <INT I-CANDLES>>)>
	 <COND (<EQUAL? ,CANDLES ,PRSI> <RFALSE>)
	       (T
		<COND (<VERB? LAMP-ON BURN>
		       <COND (<FSET? ,CANDLES ,RMUNGBIT>
			      <TELL
"Hélas, il ne reste plus beaucoup de bougies." CR>)
			     (<NOT ,PRSI>
			      <COND (<FSET? ,MATCH ,FLAMEBIT>
				     <TELL "(avec l'allumette)" CR>
				     <PERFORM ,V?LAMP-ON ,CANDLES ,MATCH>
				     <RTRUE>)
				    (T
				     <TELL
"Vous devriez dire avec quoi les allumer." CR>
				     <RFATAL>)>)
			     (<AND <EQUAL? ,PRSI ,MATCH>
				   <FSET? ,MATCH ,ONBIT>>
			      <TELL "Les bougies sont ">
			      <COND (<FSET? ,CANDLES ,ONBIT>
				     <TELL "déjà allumé." CR>)
				    (T
				     <FSET ,CANDLES ,ONBIT>
				     <TELL "allumé." CR>
				     <ENABLE <INT I-CANDLES>>)>)
			     (<EQUAL? ,PRSI ,TORCH>
			      <COND (<FSET? ,CANDLES ,ONBIT>
				     <TELL
"Vous réalisez, juste à temps, que les bougies sont déjà allumées." CR>)
				    (T
				     <TELL
"La chaleur de la torche est si intense que les bougies sont vaporisées." CR>
				     <REMOVE-CAREFULLY ,CANDLES>)>)
			     (T
			      <TELL
"Vous devez les allumer avec quelque chose qui brûle, vous savez." CR>)>)
		      (<VERB? COUNT>
		       <TELL
"Voyons, combien d'objets dans une paire ? Ne me le dites pas, je vais le chercher." CR>)
		      (<VERB? LAMP-OFF>
		       <DISABLE <INT I-CANDLES>>
		       <COND (<FSET? ,CANDLES ,ONBIT>
			      <TELL "La flamme est éteinte.">
			      <FCLEAR ,CANDLES ,ONBIT>
			      <FSET ,CANDLES ,TOUCHBIT>
			      <SETG LIT <LIT? ,HERE>>
			      <COND (<NOT ,LIT>
				     <TELL " Il fait vraiment noir ici...">)>
			      <CRLF>
			      <RTRUE>)
			     (T <TELL "Les bougies ne sont pas allumées." CR>)>)
		      (<AND <VERB? PUT> <FSET? ,PRSI ,BURNBIT>>
		       <TELL "Ce ne serait pas intelligent." CR>)
		      (<VERB? EXAMINE>
		       <TELL "Les bougies sont ">
		       <COND (<FSET? ,CANDLES ,ONBIT>
			      <TELL "brûle.">)
			     (T <TELL "éteint.">)>
		       <CRLF>)>)>>

<GLOBAL CANDLE-TABLE
	<TABLE (PURE)
	       20
	       "Les bougies poussent plus courtes."
	       10
	       "Les bougies deviennent assez courtes."
	       5
	       "Les bougies ne dureront plus longtemps maintenant."
	       0>>

<ROUTINE CAVE2-ROOM (RARG)
  <COND (<EQUAL? .RARG ,M-END>
	 <COND (<AND <IN? ,CANDLES ,WINNER>
		     <PROB 50 80>
		     <FSET? ,CANDLES ,ONBIT>>
		<DISABLE <INT I-CANDLES>>
		<FCLEAR ,CANDLES ,ONBIT>
		<TELL
"Une bourrasque éteint vos bougies !" CR>
		<COND (<NOT <SETG LIT <LIT? ,HERE>>>
		       <TELL "Il fait maintenant complètement noir." CR>)>)>)>>

\

"SOUS-TITRE ARMES ASSORTIES"

<ROUTINE SWORD-FCN ("AUX" G)
	 <COND (<AND <VERB? TAKE> <EQUAL? ,WINNER ,ADVENTURER>>
		<ENABLE <QUEUE I-SWORD -1>>
		<>)
	       (<VERB? EXAMINE>
		<COND (<EQUAL? <SET G <GETP ,SWORD ,P?TVALUE>> 1>
		       <TELL
"Votre épée émet une faible lueur bleue." CR>)
		      (<EQUAL? .G 2>
		       <TELL
"Votre épée brille très fort." CR>)>)>>

"SOUS-TITRE CHARBON MINE"

<ROUTINE BOOM-ROOM (RARG "AUX" (DUMMY? <>) FLAME)
         <COND (<EQUAL? .RARG ,M-END>
		<COND (<AND <EQUAL? .RARG ,M-END>
			    <VERB? LAMP-ON BURN>
			    <EQUAL? ,PRSO ,CANDLES ,TORCH ,MATCH>>
		       <SET DUMMY? T>)>
		<COND (<OR <AND <HELD? ,CANDLES>
				<FSET? ,CANDLES ,ONBIT>>
			   <AND <HELD? ,TORCH>
				<FSET? ,TORCH ,ONBIT>>
			   <AND <HELD? ,MATCH>
				<FSET? ,MATCH ,ONBIT>>>
		       <COND (.DUMMY?
			      <TELL
"Quelle tristesse pour un aventurier en herbe d'allumer un " D ,PRSO "Heureusement, il y a la justice dans le monde." CR>)
			     (T
			      <TELL
"Oh là là... Il semble que l'odeur de cette salle ait été celle du grisou. À votre place, j'aurais réfléchi à deux fois avant d'y entrer avec des objets enflammés." CR>)>
		       <JIGS-UP "| ** BOOOOOOOOOOM **">)>)>> 

<ROUTINE BAT-D ("OPTIONAL" FOO)
	 <COND (<EQUAL? <LOC ,GARLIC> ,WINNER ,HERE>
		<TELL
"Dans un angle du plafond est suspendue une énorme chauve-souris vampire, manifestement dérangée, qui se pince le nez." CR>)
	       (T
		<TELL
"Une grande chauve-souris vampire, suspendue au plafond, fond sur vous !" CR>)>>

<ROUTINE BATS-ROOM (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Vous êtes dans une petite pièce qui n'a de portes qu'à l'est et au sud." CR>)
	       (<AND <EQUAL? .RARG ,M-ENTER> <NOT ,DEAD>>
		<COND (<NOT <EQUAL? <LOC ,GARLIC> ,WINNER ,HERE>>
		       <V-LOOK>
		       <CRLF>
		       <FLY-ME>)>)>>

<ROUTINE MACHINE-ROOM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"C'est une vaste salle froide dont l'unique sortie mène au nord. Dans un coin se trouve une machine qui évoque un sèche-linge. Sur sa façade, un interrupteur porte l'inscription « DÉMARRER ». Aucune main humaine ne semble pouvoir le manipuler, à moins de posséder des doigts d'environ 1/16 sur 1/4 de pouce. Un grand couvercle, sur le devant de la machine, est ">
		<COND (<FSET? ,MACHINE ,OPENBIT>
		       <TELL "ouvert.">)
		      (T <TELL "fermé.">)>
		<CRLF>)>>

<ROUTINE MACHINE-F ()
	 <COND (<AND <VERB? TAKE> <EQUAL? ,PRSO ,MACHINE>>
		<TELL "Il est beaucoup trop grand pour être transporté." CR>)
	       (<VERB? OPEN>
	        <COND (<FSET? ,MACHINE ,OPENBIT>
		       <TELL <PICK-ONE ,DUMMY> CR>)
		      (<FIRST? ,MACHINE>
		       <TELL "Le couvercle s'ouvre, révélant ">
		       <PRINT-CONTENTS ,MACHINE>
		       <TELL "." CR>
		       <FSET ,MACHINE ,OPENBIT>)
		      (T
		       <TELL "Le couvercle s'ouvre." CR>
		       <FSET ,MACHINE ,OPENBIT>)>)
	       (<VERB? CLOSE>
	        <COND (<FSET? ,MACHINE ,OPENBIT>
		       <TELL "Le couvercle se ferme." CR>
		       <FCLEAR ,MACHINE ,OPENBIT>
		       T)
		      (T
		       <TELL <PICK-ONE ,DUMMY> CR>)>)
	       (<VERB? LAMP-ON>
		<COND (<NOT ,PRSI>
		       <TELL
"On ne voit pas comment l'allumer à mains nues." CR>)
		      (T
		       <PERFORM ,V?TURN ,MACHINE-SWITCH ,PRSI>
		       <RTRUE>)>)>>

<ROUTINE MSWITCH-FUNCTION ("AUX" O)
	 <COND (<VERB? TURN>
		<COND (<EQUAL? ,PRSI ,SCREWDRIVER>
		       <COND (<FSET? ,MACHINE ,OPENBIT>
			      <TELL
"La machine ne semble vouloir rien faire." CR>)
			     (T <TELL
"La machine prend vie -- au sens figuré -- dans un éblouissant déploiement de lumières colorées et de bruits étranges. Après quelques instants, l'agitation retombe." CR>
			      <COND (<IN? ,COAL ,MACHINE>
				     <REMOVE-CAREFULLY ,COAL>
				     <MOVE ,DIAMOND ,MACHINE>)
				    (T
				     <REPEAT ()
					     <COND (<SET O <FIRST? ,MACHINE>>
						    <REMOVE-CAREFULLY .O>)
						   (T <RETURN>)>>
				     <MOVE ,GUNK ,MACHINE>)>)>)
		      (T
		       <TELL "Il semble qu'un " D ,PRSI " ne suffira pas." CR>)>)>>

<ROUTINE GUNK-FUNCTION ()
	 <REMOVE-CAREFULLY ,GUNK>
	 <TELL
"Les scories étaient plutôt insignifiantes et s'effritent en poussière. à votre contact." CR>>

<ROUTINE NO-OBJS (RARG "AUX" F)
	 <COND (<EQUAL? .RARG ,M-BEG>
		<SET F <FIRST? ,WINNER>>
		<SETG EMPTY-HANDED T>
		<REPEAT ()
			<COND (<NOT .F> <RETURN>)
			      (<G? <WEIGHT .F> 4>
			       <SETG EMPTY-HANDED <>>
			       <RETURN>)>
			<SET F <NEXT? .F>>>
		<COND (<AND <EQUAL? ,HERE ,LOWER-SHAFT> ,LIT>
		       <SCORE-UPD ,LIGHT-SHAFT>
		       <SETG LIGHT-SHAFT 0>)>
		<RFALSE>)>>

<ROUTINE SOUTH-TEMPLE-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-BEG>
		<SETG COFFIN-CURE <NOT <IN? ,COFFIN ,WINNER>>>
		<RFALSE>)>>

<GLOBAL LIGHT-SHAFT 13>
<GDECL (LIGHT-SHAFT) FIX>

\

"SOUS-TITRE OLD MAN RIVER, CETTE OLD MAN RIVER..."

<ROUTINE WHITE-CLIFFS-FUNCTION (RARG)
	 <COND (<EQUAL? .RARG ,M-END>
		<COND (<IN? ,INFLATED-BOAT ,WINNER>
		       <SETG DEFLATE <>>)
	       	      (T
		       <SETG DEFLATE T>)>)>>

<ROUTINE SCEPTRE-FUNCTION ()
	 <COND (<VERB? WAVE RAISE>
		<COND (<OR <EQUAL? ,HERE ,ARAGAIN-FALLS>
			   <EQUAL? ,HERE ,END-OF-RAINBOW>>
		       <COND (<NOT ,RAINBOW-FLAG>
			      <FCLEAR ,POT-OF-GOLD ,INVISIBLE>
			      <TELL
"Soudain, l'arc-en-ciel semble devenir solide et, oserais-je le dire, praticable. Les marches et la rampe constituaient sans doute un indice." CR>
			      <COND (<AND <EQUAL? ,HERE ,END-OF-RAINBOW>
					  <IN? ,POT-OF-GOLD ,END-OF-RAINBOW>>
				     <TELL
"Un pot d'or scintillant apparaît au bout de l'arc-en-ciel." CR>)>
			      <SETG RAINBOW-FLAG T>)
			     (T
			      <ROB ,ON-RAINBOW ,WALL>
			      <TELL
"L'arc-en-ciel semble être devenu quelque peu banal." CR>
			      <SETG RAINBOW-FLAG <>>
			      <RTRUE>)>)
		      (<EQUAL? ,HERE ,ON-RAINBOW>
		       <SETG RAINBOW-FLAG <>>
		       <JIGS-UP
"L'intégrité structurelle de l'arc-en-ciel est gravement compromise. Vous restez suspendu dans le vide, soutenu par la seule vapeur d'eau. Adieu.">)
		      (T
		       <TELL
"Un éclat éblouissant de couleurs émane brièvement du sceptre." CR>)>)>>

<ROUTINE FALLS-ROOM (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
	   <TELL
"Vous êtes au sommet des Chutes d'Aragain, une immense cascade haute d'environ 140 mètres. Le seul sentier se trouve à l'extrémité nord." CR>
	   <COND (,RAINBOW-FLAG
		  <TELL
"Un arc-en-ciel solide enjambe les chutes.">)
		 (T
		  <TELL
"Un magnifique arc-en-ciel est visible au-dessus des chutes, vers l'ouest.">)>
	   <CRLF>)>>

<ROUTINE RAINBOW-FCN ()
	 <COND (<VERB? CROSS THROUGH>
		<COND (<EQUAL? ,HERE ,CANYON-VIEW>
		       <TELL "D'ici ?!?" CR>
		       <RTRUE>)>
		<COND (,RAINBOW-FLAG
		       <COND (<EQUAL? ,HERE ,ARAGAIN-FALLS>
			      <GOTO ,END-OF-RAINBOW>)
			     (<EQUAL? ,HERE ,END-OF-RAINBOW>
			      <GOTO ,ARAGAIN-FALLS>)
			     (T
			      <TELL "Vous devrez dire dans quelle direction..." CR>)>)
		      (T
		       <TELL "Pouvez-vous marcher sur l'eau de la vapeur ?"
			     CR>)>)
	       (<VERB? LOOK-UNDER>
		<TELL "La Rivière Glaciale coule sous l'arc-en-ciel." CR>)>>

<ROUTINE DBOAT-FUNCTION ("AUX")
	 <COND (<AND <VERB? PUT PUT-ON>
		     <EQUAL? ,PRSO ,PUTTY>>
		<FIX-BOAT>)
	       (<VERB? INFLATE FILL>
		<TELL
"Aucune chance. Un crétin l'a percé." CR>)
	       (<VERB? PLUG>
		<COND (<EQUAL? ,PRSI ,PUTTY>
		       <FIX-BOAT>)
		      (T <WITH-TELL ,PRSI>)>)>>

<ROUTINE FIX-BOAT ()
	 <TELL "Bravo. Le bateau est réparé." CR>
	 <MOVE ,INFLATABLE-BOAT <LOC ,PUNCTURED-BOAT>>
	 <REMOVE-CAREFULLY ,PUNCTURED-BOAT>>

<ROUTINE RIVER-FUNCTION ()
	 <COND (<VERB? PUT>
		<COND (<EQUAL? ,PRSI ,RIVER>
		       <COND (<EQUAL? ,PRSO ,ME>
			      <JIGS-UP
"Vous barbotez un moment en luttant contre le courant, puis vous vous noyez.">)
			     (<EQUAL? ,PRSO ,INFLATED-BOAT>
			      <TELL
"Vous devriez d'abord monter dans le bateau, puis le mettre à l'eau." CR>)
			     (<FSET? ,PRSO ,BURNBIT>
			      <REMOVE-CAREFULLY ,PRSO>
			      <TELL
"Le " D ,PRSO " flotte pendant un moment, puis coule." CR>)
			     (T
			      <REMOVE-CAREFULLY ,PRSO>
			      <TELL
"Le " D ,PRSO " éclabousse dans l'eau et disparaît pour toujours." CR>)>)>)
	       (<VERB? LEAP THROUGH>
		<TELL
"Un regard avant de sauter révèle que la rivière est large et dangereuse, avec des courants rapides et de grandes roches à moitié cachées. Vous décidez de renoncer à votre baignade." CR>)>>

<GLOBAL RIVER-SPEEDS
	<LTABLE (PURE) RIVER-1 4 RIVER-2 4 RIVER-3 3 RIVER-4 2 RIVER-5 1>>

<GLOBAL RIVER-NEXT
	<LTABLE (PURE) RIVER-1 RIVER-2 RIVER-3 RIVER-4 RIVER-5>>

<GLOBAL RIVER-LAUNCH
	<LTABLE (PURE) DAM-BASE RIVER-1
		WHITE-CLIFFS-NORTH RIVER-3
		WHITE-CLIFFS-SOUTH RIVER-4
		SHORE RIVER-5
		SANDY-BEACH RIVER-4
		RESERVOIR-SOUTH RESERVOIR
		RESERVOIR-NORTH RESERVOIR
		STREAM-VIEW IN-STREAM>>

<ROUTINE I-RIVER ("AUX" RM)
	 <COND (<AND <NOT <EQUAL? ,HERE ,RIVER-1 ,RIVER-2 ,RIVER-3>>
		     <NOT <EQUAL? ,HERE ,RIVER-4 ,RIVER-5>>>
		<DISABLE <INT I-RIVER>>)
	       (<SET RM <LKP ,HERE ,RIVER-NEXT>>
		<TELL "Le débit de la rivière vous entraîne en aval." CR CR>
		<GOTO .RM>
		<ENABLE <QUEUE I-RIVER <LKP ,HERE ,RIVER-SPEEDS>>>)
	       (T
		<JIGS-UP
"Malheureusement, le bateau magique ne protège pas des rochers que l'on rencontre au pied des cascades. Notamment de celle-ci.">)>>

<ROUTINE RBOAT-FUNCTION ("OPTIONAL" (RARG <>) "AUX" TMP)
    <COND (<EQUAL? .RARG ,M-ENTER ,M-END ,M-LOOK> <>)	
	  (<EQUAL? .RARG ,M-BEG>
	   <COND (<VERB? WALK>
		  <COND (<EQUAL? ,PRSO ,P?LAND ,P?EAST ,P?WEST>
			 <RFALSE>)
			(<AND <EQUAL? ,HERE ,RESERVOIR>
			      <EQUAL? ,PRSO ,P?NORTH ,P?SOUTH>>
			 <RFALSE>)
			(<AND <EQUAL? ,HERE ,IN-STREAM>
			      <EQUAL? ,PRSO ,P?SOUTH>>
			 <RFALSE>)
			(T
			 <TELL
"Lisez l'étiquette pour connaître les instructions du bateau." CR>
			 <RTRUE>)>)
		 (<VERB? LAUNCH>
		  <COND (<OR <EQUAL? ,HERE ,RIVER-1 ,RIVER-2 ,RIVER-3>
			     <EQUAL? ,HERE ,RIVER-4 ,RESERVOIR ,IN-STREAM>>
			 <TELL
"Vous êtes sur le ">
			 <COND (<EQUAL? ,HERE ,RESERVOIR>
				<TELL "réservoir">)
			       (<EQUAL? ,HERE ,IN-STREAM>
				<TELL "courant">)
			       (T <TELL "rivière">)>
			 <TELL ", ou avez-vous oublié ?" CR>)
			(<EQUAL? <SET TMP <GO-NEXT ,RIVER-LAUNCH>> 1>
			 <ENABLE <QUEUE I-RIVER <LKP ,HERE ,RIVER-SPEEDS>>>
			 <RTRUE>)
			(<NOT <EQUAL? .TMP 2>>
			 <TELL "Vous ne pouvez pas le lancer ici." CR>
			 <RTRUE>)
			(T <RTRUE>)>)
		 (<OR <AND <VERB? DROP>
			   <FSET? ,PRSO ,WEAPONBIT>>
		      <AND <VERB? PUT>
			   <FSET? ,PRSO ,WEAPONBIT>
			   <EQUAL? ,PRSI ,INFLATED-BOAT>>
		      <AND <VERB? ATTACK MUNG>
			   <FSET? ,PRSI ,WEAPONBIT>>>
		  <REMOVE-CAREFULLY ,INFLATED-BOAT>
		  <MOVE ,PUNCTURED-BOAT ,HERE>
		  <ROB ,INFLATED-BOAT ,HERE>
		  <MOVE ,WINNER ,HERE>
		  <TELL
"Il semble que le ">
		  <COND (<VERB? DROP PUT> <TELL D ,PRSO>)
			(T <TELL D ,PRSI>)>
		  <TELL "n'était pas d'accord avec le bateau, comme en témoigne le bruit de sifflement qui en émane." CR>
		  <COND (<FSET? ,HERE ,NONLANDBIT>
			 <CRLF>
			 <COND (<==? ,HERE ,RESERVOIR ,IN-STREAM>
				<JIGS-UP
"Un autre crachat pathétique, cette fois de votre part, annonce votre noyade.">)
			       (T
				<JIGS-UP
"Autrement dit, vous luttez contre les courants furieux de la Rivière Glaciale. Vous tenez bon un moment, puis le flot vous emporte par-dessus une cascade et vous projette sur des rochers peu accueillants. Aïe !">)>)>
		  <RTRUE>)
		 (<VERB? LAUNCH>
	  	   <TELL "Vous n'êtes pas dans le bateau !" CR>)>)
	  (<VERB? BOARD>
	   <COND (<OR <IN? ,SCEPTRE ,WINNER>
		      <IN? ,KNIFE ,WINNER>
		      <IN? ,SWORD ,WINNER>
		      <IN? ,RUSTY-KNIFE ,WINNER>
		      <IN? ,AXE ,WINNER>
		      <IN? ,STILETTO ,WINNER>>
		  <TELL
"Oups ! Un objet pointu semble avoir glissé et percé le bateau. Celui-ci se dégonfle dans un concert de sifflements, de crachotements et de jurons." CR>
		  <REMOVE-CAREFULLY ,INFLATED-BOAT>
		  <MOVE ,PUNCTURED-BOAT ,HERE>
		  <THIS-IS-IT ,PUNCTURED-BOAT>
		  T)>)
	  (<VERB? INFLATE FILL>
	   <TELL "Le gonfler davantage l'éclaterait probablement." CR>)
	  (<VERB? DEFLATE>
	   <COND (<EQUAL? <LOC ,WINNER> ,INFLATED-BOAT>
		  <TELL
"Vous ne pouvez pas dégonfler le bateau pendant que vous êtes à bord. " CR>)
		 (<NOT <IN? ,INFLATED-BOAT ,HERE>>
		  <TELL
"Le bateau doit être au sol pour être dégonflé." CR>)
		 (T <TELL
"Le bateau se dégonfle." CR>
		  <SETG DEFLATE T>
		  <REMOVE-CAREFULLY ,INFLATED-BOAT>
		  <MOVE ,INFLATABLE-BOAT ,HERE>
		  <THIS-IS-IT ,INFLATABLE-BOAT>)>)>>

<ROUTINE BREATHE ()
	 <PERFORM ,V?INFLATE ,PRSO ,LUNGS>>

<ROUTINE IBOAT-FUNCTION ()
	 <COND (<VERB? INFLATE FILL>
		<COND (<NOT <IN? ,INFLATABLE-BOAT ,HERE>>
		       <TELL
"Le bateau doit être au sol pour être dégonflé. gonflé." CR>)
		      (<EQUAL? ,PRSI ,PUMP>
		       <TELL
"Le bateau se gonfle et semble en état de naviguer." CR>
		       <COND (<NOT <FSET? ,BOAT-LABEL ,TOUCHBIT>>
			      <TELL
"Une étiquette beige se trouve à l'intérieur du bateau." CR>)>
		       <SETG DEFLATE <>>
		       <REMOVE-CAREFULLY ,INFLATABLE-BOAT>
		       <MOVE ,INFLATED-BOAT ,HERE>
		       <THIS-IS-IT ,INFLATED-BOAT>)
		      (<EQUAL? ,PRSI ,LUNGS>
		       <TELL
"Vous n'avez pas assez de puissance pulmonaire. pour le gonfler." CR>)
		      (T
		       <TELL
"Avec un " D ,PRSI " ? Vous plaisantez sûrement !" CR>)>)>>

<GLOBAL BUOY-FLAG T>

<ROUTINE RIVR4-ROOM (RARG)
	 <COND (<EQUAL? .RARG ,M-END>
		<COND (<AND <IN? ,BUOY ,WINNER> ,BUOY-FLAG>
	      	       <TELL
"Vous remarquez quelque chose de drôle dans la sensation de la bouée." CR>
		       <SETG BUOY-FLAG <>>)>)>>

<GLOBAL BEACH-DIG -1>

<GDECL (BEACH-DIG) FIX>

<ROUTINE SAND-FUNCTION ()
	 <COND (<AND <VERB? DIG> <==? ,PRSI ,SHOVEL>>
		<SETG BEACH-DIG <+ 1 ,BEACH-DIG>>
		<COND (<G? ,BEACH-DIG 3>
		       <SETG BEACH-DIG -1>
		       <AND <IN? ,SCARAB ,HERE> <FSET ,SCARAB ,INVISIBLE>>
		       <JIGS-UP "Le trou s'effondre et vous ensevelit.">)
		      (<EQUAL? ,BEACH-DIG 3>
		       <COND (<FSET? ,SCARAB ,INVISIBLE>
			      <TELL
"Vous pouvez voir un scarabée ici dans le sable." CR>
			      <THIS-IS-IT ,SCARAB>
			      <FCLEAR ,SCARAB ,INVISIBLE>)>)
		      (T
		       <TELL <GET ,BDIGS ,BEACH-DIG> CR>)>)>>

<GLOBAL BDIGS
	<TABLE (PURE) "Vous semblez creuser un trou ici."
	       "Le trou devient plus profond, mais c'est à peu près tout."
	       "Vous êtes entouré d'un mur de sable de tous côtés.">>

\

"SOUS-TITRE TOITY POIPLE BOIDS A CHOIPIN' AN' A BOIPIN' ... "

<ROUTINE TREE-ROOM (RARG "AUX" F)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Vous êtes niché entre de grosses branches, à environ trois mètres au-dessus du sol. La branche suivante est hors de votre portée." CR>
		<COND (<AND <SET F <FIRST? ,PATH>>
			    <NEXT? .F>>
		       <TELL "Au sol en contrebas, vous pouvez voir : ">
		       <PRINT-CONTENTS ,PATH>
		       <TELL "." CR>)>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? CLIMB-DOWN> <EQUAL? ,PRSO ,TREE ,ROOMS>>
		       <DO-WALK ,P?DOWN>)
		      (<AND <VERB? CLIMB-UP CLIMB-FOO>
			    <EQUAL? ,PRSO ,TREE>>
		       <DO-WALK ,P?UP>)
		      (<VERB? DROP>
		       <COND (<NOT <IDROP>> <RTRUE>)
			     (<AND <EQUAL? ,PRSO ,NEST> <IN? ,EGG ,NEST>>
			      <TELL
"Le nid tombe au sol, et l'oeuf s'en déverse, gravement endommagé." CR>
			      <REMOVE-CAREFULLY ,EGG>
			      <MOVE ,BROKEN-EGG ,PATH>)
			     (<EQUAL? ,PRSO ,EGG>
			      <TELL
"L'oeuf tombe au sol et ressort s'ouvre, gravement endommagé.">
			      <MOVE ,EGG ,PATH>
			      <BAD-EGG>
			      <CRLF>)
			     (<NOT <EQUAL? ,PRSO ,WINNER ,TREE>>
			      <MOVE ,PRSO ,PATH>
			      <TELL
"Le " D ,PRSO " tombe au sol." CR>)
			     (<VERB? LEAP>
			      <JIGS-UP
			        "C'était juste un peu trop loin. vers le bas.">)>)>)
	       (<EQUAL? .RARG ,M-ENTER> <ENABLE <QUEUE I-FOREST-ROOM -1>>)>>

<ROUTINE EGG-OBJECT ()
	 <COND (<AND <VERB? OPEN MUNG> <EQUAL? ,PRSO ,EGG>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "L'oeuf est déjà ouvert." CR>)
		      (<NOT ,PRSI>
		       <TELL "Vous n'avez ni les outils ni l'expertise."
			     CR>)
		      (<EQUAL? ,PRSI ,HANDS>
		       <TELL "Je doute que vous puissiez le faire sans endommager "
			     CR>)
		      (<OR <FSET? ,PRSI ,WEAPONBIT>
			   <FSET? ,PRSI ,TOOLBIT>
			   <VERB? MUNG>>
		       <TELL
"L'oeuf est maintenant ouvert, mais la maladresse de votre tentative a sérieusement compromis son attrait esthétique.">
		       <BAD-EGG>
		       <CRLF>)
		      (<FSET? ,PRSO ,FIGHTBIT>
		       <TELL "Cela ne veut pas dire que l'utilisation du "
			     D ,PRSI
			     " n'est pas non plus originale..." CR>)
		      (T
		       <TELL "Le concept d'utilisation d'un "
			     D ,PRSI
			     " est certainement original." CR>
		       <FSET ,PRSO ,FIGHTBIT>)>)
	       (<VERB? CLIMB-ON HATCH>
		<TELL
"Un craquement très net retentit sous vous. Un examen rapide révèle que l'oeuf est ouvert et gravement endommagé.">
		<BAD-EGG>
		<CRLF>)
	       (<VERB? OPEN MUNG THROW>
		<COND (<VERB? THROW> <MOVE ,PRSO ,HERE>)>
		<TELL
"Votre manipulation assez indélicate de l'oeuf lui a causé quelques dommages, bien que vous ayez réussi à l'ouvrir.">
		<BAD-EGG>
		<CRLF>)>>

<ROUTINE BAD-EGG ("AUX" L)
	 <COND (<IN? ,CANARY ,EGG>
		<TELL " " <GETP ,BROKEN-CANARY ,P?FDESC>>)
	       (T <REMOVE-CAREFULLY ,BROKEN-CANARY>)>
	 <MOVE ,BROKEN-EGG <LOC ,EGG>>
	 <REMOVE-CAREFULLY ,EGG>
	 <RTRUE>>

<GLOBAL SING-SONG <>>

<ROUTINE CANARY-OBJECT ()
	 <COND (<VERB? WIND>
		<COND (<EQUAL? ,PRSO ,CANARY>
		       <COND (<AND <NOT ,SING-SONG> <FOREST-ROOM?>>
			      <TELL
"Le canari pépie, légèrement faux, un air tiré d'un opéra oublié. Un ravissant oiseau chanteur surgit de la verdure, se pose sur une branche juste au-dessus de votre tête et ouvre le bec pour chanter. Ce faisant, il laisse tomber une jolie babiole en laiton, qui rebondit sur votre crâne avant d'atterrir dans l'herbe en scintillant. Tandis que le mécanisme du canari s'arrête, l'oiseau s'envole." CR>
			     <SETG SING-SONG T>
			     <MOVE ,BAUBLE
				   <COND (<EQUAL? ,HERE ,UP-A-TREE> ,PATH)
					 (T ,HERE)>>)
			    (T
			     <TELL
"Le canari pépie joyeusement pendant quelques instants, quoique d'un timbre un peu métallique." CR>)>)
		     (T
		      <TELL
"Il y a un bruit de grincement désagréable provenant de l'intérieur du canari." CR>)>)>>

<ROUTINE FOREST-ROOM? ()
	 <OR <EQUAL? ,HERE ,FOREST-1 ,FOREST-2 ,FOREST-3>
	     <EQUAL? ,HERE ,PATH ,UP-A-TREE>>>

<ROUTINE I-FOREST-ROOM ()
	 <COND (<NOT <FOREST-ROOM?>>
		<DISABLE <INT I-FOREST-ROOM>>
		<RFALSE>)
	       (<PROB 15>
		<TELL
"Vous entendez au loin le chant d'un oiseau chanteur." CR>)>>

<ROUTINE FOREST-ROOM (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER> <ENABLE <QUEUE I-FOREST-ROOM -1>>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? CLIMB-FOO CLIMB-UP>
			    <EQUAL? ,PRSO ,TREE>>
		       <DO-WALK ,P?UP>)>)>>

<ROUTINE WCLIF-OBJECT ()
	 <COND (<VERB? CLIMB-UP CLIMB-DOWN CLIMB-FOO>
		<TELL "La falaise est trop raide pour être escaladée." CR>)>>

<ROUTINE CLIFF-OBJECT ()
	 <COND (<OR <VERB? LEAP>
		    <AND <VERB? PUT> <EQUAL? ,PRSO ,ME>>>
		<TELL
		 "Ce serait très imprudent. Peut-être même mortel." CR>)
	       (<EQUAL? ,PRSI ,CLIMBABLE-CLIFF>
		<COND (<VERB? PUT THROW-OFF>
		       <TELL
"Le " D ,PRSO " tombe dans la rivière et n'est plus revu." CR>
		       <REMOVE-CAREFULLY ,PRSO>)>)>>

\

"SOUS-TITRE CHUTES ET ÉCHELLES"

<ROUTINE ROPE-FUNCTION ("AUX" RLOC)
	 <COND (<NOT <EQUAL? ,HERE ,DOME-ROOM>>
		<SETG DOME-FLAG <>>
		<COND (<VERB? TIE>
		       <TELL "Vous ne pouvez pas attacher la corde à cela." CR>)>)
	       (<VERB? TIE>
		<COND (<EQUAL? ,PRSI ,RAILING>
		       <COND (,DOME-FLAG
			      <TELL
			       "La corde y est déjà attachée." CR>)
			     (T
			      <TELL
"La corde tombe sur le côté et arrive à moins de dix pieds du sol." CR>
			      <SETG DOME-FLAG T>
			      <FSET ,ROPE ,NDESCBIT>
			      <SET RLOC <LOC ,ROPE>>
			      <COND (<OR <NOT .RLOC>
					 <NOT <IN? .RLOC ,ROOMS>>>
				     <MOVE ,ROPE ,HERE>)>
			      T)>)>)
	       (<AND <VERB? CLIMB-DOWN> <EQUAL? ,PRSO ,ROPE ,ROOMS> ,DOME-FLAG>
		<DO-WALK ,P?DOWN>)
	       (<AND <VERB? TIE-UP>
		     <EQUAL? ,ROPE ,PRSI>>
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <COND (<L? <GETP ,PRSO ,P?STRENGTH> 0>
			      <TELL
"Votre tentative pour attacher le " D ,PRSO " le réveille.">
			      <AWAKEN ,PRSO>)
			     (T
			      <TELL
"Le " D ,PRSO " se débat et vous ne pouvez pas l'attacher." CR>)>)
		      (T
		       <TELL "Pourquoi voudriez-vous attacher un " D ,PRSO "?" CR>)>)
	       (<VERB? UNTIE>
		<COND (,DOME-FLAG
		       <SETG DOME-FLAG <>>
		       <FCLEAR ,ROPE ,NDESCBIT>
		       <TELL "La corde est maintenant déliée." CR>)
		      (T
		       <TELL "Elle n'est attachée à rien." CR>)>)
	       (<AND <VERB? DROP>
		     <EQUAL? ,HERE ,DOME-ROOM>
		     <NOT ,DOME-FLAG>>
		<MOVE ,ROPE ,TORCH-ROOM>
		<TELL "La corde tombe doucement sur le sol ci-dessous." CR>)
	       (<VERB? TAKE>
		<COND (,DOME-FLAG
		       <TELL "La corde est attachée à la balustrade." CR>)>)>>

<ROUTINE UNTIE-FROM ()
    <COND (<AND <EQUAL? ,PRSO ,ROPE>
		<AND ,DOME-FLAG <EQUAL? ,PRSI ,RAILING>>>
	   <PERFORM ,V?UNTIE ,PRSO>)
	  (T <TELL "Elle n'est pas attachée à cela !" CR>)>>

<ROUTINE SLIDE-FUNCTION ()
	 <COND (<OR <VERB? THROUGH CLIMB-UP CLIMB-DOWN CLIMB-FOO>
		    <AND <VERB? PUT> <EQUAL? ,PRSO ,ME>>>
		<COND (<EQUAL? ,HERE ,CELLAR>
		       <DO-WALK ,P?WEST>
		       <RTRUE>)
		      (T
		       <TELL "Vous dévalez la glissière..." CR>
		       <GOTO ,CELLAR>)>)
	       (<VERB? PUT>
		<SLIDER ,PRSO>)>>

<ROUTINE SLIDER (OBJ)
	 <COND (<FSET? .OBJ ,TAKEBIT>
		<TELL "Le " D .OBJ " tombe dans le toboggan et disparaît." CR>
		<COND (<EQUAL? .OBJ ,WATER> <REMOVE-CAREFULLY .OBJ>)
		      (T
		       <MOVE .OBJ ,CELLAR>)>)
	       (T <TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE SANDWICH-BAG-FCN ()
	 <COND (<AND <VERB? SMELL>
		     <IN? ,LUNCH ,PRSO>>
		<TELL "Ça sent le piment." CR>)>>

"PLUS ALÉATOIRE"

<ROUTINE DEAD-FUNCTION ("OPTIONAL" (FOO <>) "AUX" M)
	 <COND (<VERB? WALK>
		<COND (<AND <EQUAL? ,HERE ,TIMBER-ROOM>
			    <EQUAL? ,PRSO ,P?WEST>>
		       <TELL "Vous ne pouvez pas entrer dans votre condition." CR>)>)
	       (<VERB? BRIEF VERBOSE SUPER-BRIEF
		       VERSION ;AGAIN SAVE RESTORE QUIT RESTART>
		<>)
	       (<VERB? ATTACK MUNG ALARM SWING>
		<TELL "Toutes ces attaques sont vaines dans votre condition." CR>)
	       (<VERB? OPEN CLOSE EAT DRINK
		       INFLATE DEFLATE TURN BURN
		       TIE UNTIE RUB>
		<TELL
"Même une telle action dépasse vos capacités." CR>)
	       (<VERB? WAIT>
		<TELL "Cela pourrait aussi bien se produire. Vous avez une éternité." CR>)
	       (<VERB? LAMP-ON>
		<TELL "Vous n'avez pas besoin de lumière pour vous guider." CR>)
	       (<VERB? SCORE>
		<TELL "Vous êtes mort ! Comment pouvez-vous penser à votre score ?" CR>)
	       (<VERB? TAKE RUB>
		<TELL "Votre main le traverse." CR>)
	       (<VERB? DROP THROW INVENTORY>
		<TELL "Vous n'avez aucun bien." CR>)
	       (<VERB? DIAGNOSE>
		<TELL "Vous êtes mort." CR>)
	       (<VERB? LOOK>
		<TELL "La pièce a l'air étrange et surnaturel">
		<COND (<NOT <FIRST? ,HERE>>
		       <TELL ".">)
		      (T
		       <TELL " et les objets semblent indistincts.">)>
		<CRLF>
		<COND (<NOT <FSET? ,HERE ,ONBIT>>
		       <TELL
"Bien qu'il n'y ait pas de lumière, la pièce semble faiblement éclairée." CR>)>
		<CRLF>
		<>)
	       (<VERB? PRAY>
		<COND (<EQUAL? ,HERE ,SOUTH-TEMPLE>
		       <FCLEAR ,LAMP ,INVISIBLE>
		       <PUTP ,WINNER ,P?ACTION 0>
		       ;<SETG GWIM-DISABLE <>>
		       <SETG ALWAYS-LIT <>>
		       <SETG DEAD <>>
		       <COND (<IN? ,TROLL ,TROLL-ROOM>
			      <SETG TROLL-FLAG <>>)>
		       <TELL
"Au loin retentit une trompette solitaire. La salle s'emplit d'une lumière éblouissante et vous perdez toute sensation de votre corps. Puis l'éclat s'estompe ; vous vous sentez émerger d'un long sommeil, au plus profond des bois. Dans le lointain, vous percevez le chant d'un oiseau et les bruits de la forêt." CR CR>
		       <GOTO ,FOREST-1>)
		      (T
		       <TELL "Vos prières ne sont pas entendues." CR>)>)
	       (T
		<TELL "Vous ne pouvez même pas faire ça." CR>
		<SETG P-CONT <>>
		<RFATAL>)>>

;"Pseudo-object routines"

<ROUTINE LAKE-PSEUDO ()
	 <COND (,LOW-TIDE
		<TELL "Il ne reste plus grand-chose du lac..." CR>)
	       (<VERB? CROSS>
		<TELL "Il est trop large pour être traversé." CR>)
	       (<VERB? THROUGH>
		<TELL "Vous ne pouvez pas nager dans ce lac." CR>)>>

<ROUTINE STREAM-PSEUDO ()
	 <COND (<VERB? SWIM THROUGH>
		<TELL "Vous ne pouvez pas nager dans le ruisseau." CR>)
	       (<VERB? CROSS>
		<TELL "L'autre côté est une falaise rocheuse à pic." CR>)>>

<ROUTINE CHASM-PSEUDO ()
	 <COND (<OR <VERB? LEAP>
		    <AND <VERB? PUT> <EQUAL? ,PRSO ,ME>>>
		<TELL
"Vous regardez avant de sauter et réalisez que vous ne survivrez jamais." CR>)
	       (<VERB? CROSS>
		<TELL "C'est trop loin pour sauter, et il n'y a pas de pont." CR>)
	       (<AND <VERB? PUT THROW-OFF> <EQUAL? ,PRSI ,PSEUDO-OBJECT>>
		<TELL
"Le " D ,PRSO " tombe hors de vue dans le gouffre." CR>
		<REMOVE-CAREFULLY ,PRSO>)>>

<ROUTINE DOME-PSEUDO ()
	 <COND (<VERB? KISS>
		<TELL "numéro " CR>)>>

<ROUTINE GATE-PSEUDO ()
	 <COND (<VERB? THROUGH>
		<DO-WALK ,P?IN>
		<RTRUE>)
	       (T
		<TELL
"La porte est protégée par une force invisible. Elle fait mal à vos dents pour la toucher." CR>)>>

<ROUTINE DOOR-PSEUDO () ;"in Studio"
	 <COND (<VERB? OPEN CLOSE>
		<TELL "La porte ne bouge pas." CR>)
	       (<VERB? THROUGH>
		<DO-WALK ,P?SOUTH>)>>

<ROUTINE PAINT-PSEUDO ()
	 <COND (<VERB? MUNG>
		<TELL "Quelques éclats de peinture s'enlèvent, révélant davantage de peinture." CR>)>>

<ROUTINE GAS-PSEUDO ()
	 <COND (<VERB? BREATHE>	;"REALLY BLOW"
		<TELL "Il y en a trop. du gaz à souffler." CR>)
	       (<VERB? SMELL>
		<TELL "Ça sent le gaz de houille ici." CR>)>>

"SOUS-TITRE MÊLÉE"

"actions de mêlée (fonctions d'objet pour les méchants appelées avec ces"

<CONSTANT F-BUSY? 1>		;"busy recovering weapon?"
<CONSTANT F-DEAD 2>		;"mistah kurtz, he dead."
<CONSTANT F-UNCONSCIOUS 3>	;"into dreamland"
<CONSTANT F-CONSCIOUS 4>	;"rise and shine"
<CONSTANT F-FIRST? 5>		;"strike first?"

\

"résultats de coup"

<CONSTANT MISSED 1>		;"attacker misses"
<CONSTANT UNCONSCIOUS 2>	;"defender unconscious"
<CONSTANT KILLED 3>		;"defender dead"
<CONSTANT LIGHT-WOUND 4>	;"defender lightly wounded"
<CONSTANT SERIOUS-WOUND 5>	;"defender seriously wounded"
<CONSTANT STAGGER 6>		;"defender staggered (miss turn)"
<CONSTANT LOSE-WEAPON 7>	;"defender loses weapon"
<CONSTANT HESITATE 8>		;"hesitates (miss on free swing)"
<CONSTANT SITTING-DUCK 9>	;"sitting duck (crunch!)"

"tableaux de résultats de mêlée"

<GLOBAL DEF1
	<TABLE (PURE)
	 MISSED MISSED MISSED MISSED
	 STAGGER STAGGER
	 UNCONSCIOUS UNCONSCIOUS
	 KILLED KILLED KILLED KILLED KILLED>>

<GLOBAL DEF2A
	<TABLE (PURE)
	 MISSED MISSED MISSED MISSED MISSED
	 STAGGER STAGGER
	 LIGHT-WOUND LIGHT-WOUND
	 UNCONSCIOUS>>

<GLOBAL DEF2B
	<TABLE (PURE)
	 MISSED MISSED MISSED
	 STAGGER STAGGER
	 LIGHT-WOUND LIGHT-WOUND LIGHT-WOUND
	 UNCONSCIOUS
	 KILLED KILLED KILLED>>

<GLOBAL DEF3A
	<TABLE (PURE)
	 MISSED MISSED MISSED MISSED MISSED
	 STAGGER STAGGER
	 LIGHT-WOUND LIGHT-WOUND
	 SERIOUS-WOUND SERIOUS-WOUND>>

<GLOBAL DEF3B
	<TABLE (PURE)
	 MISSED MISSED MISSED
	 STAGGER STAGGER
	 LIGHT-WOUND LIGHT-WOUND LIGHT-WOUND
	 SERIOUS-WOUND SERIOUS-WOUND SERIOUS-WOUND>>

<GLOBAL DEF3C
	<TABLE (PURE)
	 MISSED
	 STAGGER STAGGER
	 LIGHT-WOUND LIGHT-WOUND LIGHT-WOUND LIGHT-WOUND
	 SERIOUS-WOUND SERIOUS-WOUND SERIOUS-WOUND>>

<GLOBAL DEF1-RES
	<TABLE DEF1
	       0 ;<REST ,DEF1 2>
	       0 ;<REST ,DEF1 4>>>

<GLOBAL DEF2-RES
	<TABLE DEF2A
	       DEF2B
	       0; <REST ,DEF2B 2>
	       0; <REST ,DEF2B 4>>>

<GLOBAL DEF3-RES
	<TABLE DEF3A
	       0 ;<REST ,DEF3A 2>
	       DEF3B
	       0 ;<REST ,DEF3B 2>
	       DEF3C>>

\

"utiles constantes"

<CONSTANT STRENGTH-MAX 7>
<CONSTANT STRENGTH-MIN 2>
<CONSTANT CURE-WAIT 30>

\

"I-FIGHT déplacé vers DEMONS"

<ROUTINE DO-FIGHT (LEN "AUX" CNT RES O OO (OUT <>))
	<REPEAT ()
	      <SET CNT 0>
	      <REPEAT ()
		      <SET CNT <+ .CNT 1>>
		      <COND (<EQUAL? .CNT .LEN>
			     <SET RES T>
			     <RETURN T>)>
		      <SET OO <GET ,VILLAINS .CNT>>
		      <SET O <GET .OO ,V-VILLAIN>>
		      <COND (<NOT <FSET? .O ,FIGHTBIT>>)
			    (<APPLY <GETP .O ,P?ACTION>
				    ,F-BUSY?>)
			    (<NOT <SET RES
				       <VILLAIN-BLOW
					.OO
					.OUT>>>
			     <SET RES <>>
			     <RETURN>)
			    (<EQUAL? .RES ,UNCONSCIOUS>
			     <SET OUT <+ 1 <RANDOM 3>>>)>>
	      <COND (.RES
		     <COND (<NOT .OUT> <RETURN>)
			   (T
			    <SET OUT <- .OUT 1>>
			    <COND (<0? .OUT> <RETURN>)>)>)
		    (T <RETURN>)>>>

\

"prend une remarque, un défenseur et une arme de gentil"

<ROUTINE REMARK (REMARK D W "AUX" (LEN <GET .REMARK 0>) (CNT 0) STR)
	 <REPEAT ()
	         <COND (<G? <SET CNT <+ .CNT 1>> .LEN> <RETURN>)>
		 <SET STR <GET .REMARK .CNT>>
		 <COND (<EQUAL? .STR ,F-WEP> <PRINTD .W>)
		       (<EQUAL? .STR ,F-DEF> <PRINTD .D>)
		       (T <PRINT .STR>)>>
	 <CRLF>>

"La force du joueur est une valeur de base (S) ajustée par sa propriété P?STRENGTH, qui est normalement 0"

<ROUTINE FIGHT-STRENGTH ("OPTIONAL" (ADJUST? T) "AUX" S)
	 <SET S
	      <+ ,STRENGTH-MIN
		 </ ,SCORE
		    </ ,SCORE-MAX
		       <- ,STRENGTH-MAX ,STRENGTH-MIN>>>>>
	 <COND (.ADJUST? <+ .S <GETP ,WINNER ,P?STRENGTH>>)(T .S)>>

<ROUTINE VILLAIN-STRENGTH (OO
			   "AUX" (VILLAIN <GET .OO ,V-VILLAIN>)
			   OD TMP)
	 <SET OD <GETP .VILLAIN ,P?STRENGTH>>
	 <COND (<NOT <L? .OD 0>>
		<COND (<AND <EQUAL? .VILLAIN ,THIEF> ,THIEF-ENGROSSED>
		       <COND (<G? .OD 2> <SET OD 2>)>
		       <SETG THIEF-ENGROSSED <>>)>
		<COND (<AND ,PRSI
			    <FSET? ,PRSI ,WEAPONBIT>
			    <EQUAL? <GET .OO ,V-BEST> ,PRSI>>
		       <SET TMP <- .OD <GET .OO ,V-BEST-ADV>>>
		       <COND (<L? .TMP 1> <SET TMP 1>)>
		       <SET OD .TMP>)>)>
	 .OD>

"trouver une arme (le cas échéant) en possession de l'argument"

<ROUTINE FIND-WEAPON (O "AUX" W)
	 <SET W <FIRST? .O>>
	 <COND (<NOT .W>
		<RFALSE>)>
	 <REPEAT ()
		 <COND (<OR <EQUAL? .W ,STILETTO ,AXE ,SWORD>
			    <EQUAL? .W ,KNIFE ,RUSTY-KNIFE>>
			<RETURN .W>)
		       (<NOT <SET W <NEXT? .W>>> <RFALSE>)>>>

\

<ROUTINE VILLAIN-BLOW (OO OUT?
		       "AUX" (VILLAIN <GET .OO ,V-VILLAIN>)
		       (REMARKS <GET .OO ,V-MSGS>)
		       DWEAPON ATT DEF OA OD TBL RES NWEAPON)
	 <FCLEAR ,WINNER ,STAGGERED>
	 <COND (<FSET? .VILLAIN ,STAGGERED>
		<TELL "Le " D .VILLAIN
		      " reprend lentement pied." CR>
		<FCLEAR .VILLAIN ,STAGGERED>
		<RTRUE>)>
	 <SET OA <SET ATT <VILLAIN-STRENGTH .OO>>>
	 <COND (<NOT <G? <SET DEF <FIGHT-STRENGTH>> 0>> <RTRUE>)>
	 <SET OD <FIGHT-STRENGTH <>>>
	 <SET DWEAPON <FIND-WEAPON ,WINNER>>
	 <COND (<L? .DEF 0> <SET RES ,KILLED>)
	       (T
		<COND (<1? .DEF>
		       <COND (<G? .ATT 2> <SET ATT 3>)>
		       <SET TBL <GET ,DEF1-RES <- .ATT 1>>>)
		      (<EQUAL? .DEF 2>
		       <COND (<G? .ATT 3> <SET ATT 4>)>
		       <SET TBL <GET ,DEF2-RES <- .ATT 1>>>)
		      (<G? .DEF 2>
		       <SET ATT <- .ATT .DEF>>
		       <COND (<L? .ATT -1> <SET ATT -2>)
			     (<G? .ATT 1> <SET ATT 2>)>
		       <SET TBL <GET ,DEF3-RES <+ .ATT 2>>>)>
		<SET RES <GET .TBL <- <RANDOM 9> 1>>>
		<COND (.OUT?
		       <COND (<EQUAL? .RES ,STAGGER> <SET RES ,HESITATE>)
			     (T <SET RES ,SITTING-DUCK>)>)>
		<COND (<AND <EQUAL? .RES ,STAGGER>
			    .DWEAPON
			    <PROB 25 <COND (.HERO? 10)(T 50)>>>
		       <SET RES ,LOSE-WEAPON>)>
		<REMARK
		  <RANDOM-ELEMENT <GET .REMARKS <- .RES 1>>>
		  ,WINNER
		  .DWEAPON>)>
	 <COND (<OR <EQUAL? .RES ,MISSED> <EQUAL? .RES ,HESITATE>>)
	       (<EQUAL? .RES ,UNCONSCIOUS>)
	       (<OR <EQUAL? .RES ,KILLED>
		    <EQUAL? .RES ,SITTING-DUCK>>
		<SET DEF 0>)
	       (<EQUAL? .RES ,LIGHT-WOUND>
		<SET DEF <- .DEF 1>>
		<COND (<L? .DEF 0> <SET DEF 0>)>
		<COND (<G? ,LOAD-ALLOWED 50>
		       <SETG LOAD-ALLOWED <- ,LOAD-ALLOWED 10>>)>)
	       (<EQUAL? .RES ,SERIOUS-WOUND>
		<SET DEF <- .DEF 2>>
		<COND (<L? .DEF 0> <SET DEF 0>)>
		<COND (<G? ,LOAD-ALLOWED 50>
		       <SETG LOAD-ALLOWED <- ,LOAD-ALLOWED 20>>)>)
	       (<EQUAL? .RES ,STAGGER> <FSET ,WINNER ,STAGGERED>)
	       (T
		;<AND <EQUAL? .RES ,LOSE-WEAPON> .DWEAPON>
		<MOVE .DWEAPON ,HERE>
		<COND (<SET NWEAPON <FIND-WEAPON ,WINNER>>
		       <TELL
"Heureusement, vous disposez toujours d'un " D .NWEAPON "." CR>)>)>
	 <WINNER-RESULT .DEF .RES .OD>>

<ROUTINE HERO-BLOW ("AUX" OO VILLAIN (OUT? <>) DWEAPON ATT DEF (CNT 0)
		    OA OD TBL RES NWEAPON (LEN <GET ,VILLAINS 0>))
	 <REPEAT ()
		 <SET CNT <+ .CNT 1>>
		 <COND (<EQUAL? .CNT .LEN> <RETURN>)>
		 <SET OO <GET ,VILLAINS .CNT>>
		 <COND (<EQUAL? <GET .OO ,V-VILLAIN> ,PRSO>
			<RETURN>)>>
	 <FSET ,PRSO ,FIGHTBIT>
	 <COND (<FSET? ,WINNER ,STAGGERED>
		<TELL
"Vous vous remettez encore de ce dernier coup, donc votre attaque est inefficace." CR>
		<FCLEAR ,WINNER ,STAGGERED>
		<RTRUE>)>
	 <SET ATT <FIGHT-STRENGTH>>
	 <COND (<L? .ATT 1> <SET ATT 1>)>
	 <SET OA .ATT>
	 <SET VILLAIN <GET .OO ,V-VILLAIN>>
	 <COND (<0? <SET OD <SET DEF <VILLAIN-STRENGTH .OO>>>>
		<COND (<EQUAL? ,PRSO ,WINNER>
		       <RETURN <JIGS-UP
"Eh bien, vous l'avez vraiment fait cette fois-là. Le suicide est-il indolore ?">>)>
		<TELL "Attaquer le " D .VILLAIN " est inutile." CR>
		<RTRUE>)>
	 <SET DWEAPON <FIND-WEAPON .VILLAIN>>
	 <COND (<OR <NOT .DWEAPON> <L? .DEF 0>>
		<TELL "Le ">
		<COND (<L? .DEF 0> <TELL "inconscient">)
		      (T <TELL "non armé">)>
		<TELL " " D .VILLAIN
		      " ne peut pas se défendre : il meurt." CR>
		<SET RES ,KILLED>)
	       (T
		<COND (<1? .DEF>
		       <COND (<G? .ATT 2> <SET ATT 3>)>
		       <SET TBL <GET ,DEF1-RES <- .ATT 1>>>)
		      (<EQUAL? .DEF 2>
		       <COND (<G? .ATT 3> <SET ATT 4>)>
		       <SET TBL <GET ,DEF2-RES <- .ATT 1>>>)
		      (<G? .DEF 2>
		       <SET ATT <- .ATT .DEF>>
		       <COND (<L? .ATT -1> <SET ATT -2>)
			     (<G? .ATT 1> <SET ATT 2>)>
		       <SET TBL <GET ,DEF3-RES <+ .ATT 2>>>)>
		<SET RES <GET .TBL <- <RANDOM 9> 1>>>
		<COND (.OUT?
		       <COND (<EQUAL? .RES ,STAGGER> <SET RES ,HESITATE>)
			     (T <SET RES ,SITTING-DUCK>)>)>
		<COND (<AND <EQUAL? .RES ,STAGGER> .DWEAPON <PROB 25>>
		       <SET RES ,LOSE-WEAPON>)>
		<REMARK
		  <RANDOM-ELEMENT <GET ,HERO-MELEE <- .RES 1>>>
		  ,PRSO
		  ,PRSI>)>
	 <COND (<OR <EQUAL? .RES ,MISSED> <EQUAL? .RES ,HESITATE>>)
	       (<EQUAL? .RES ,UNCONSCIOUS> <SET DEF <- .DEF>>)
	       (<OR <EQUAL? .RES ,KILLED> <EQUAL? .RES ,SITTING-DUCK>>
		<SET DEF 0>)
	       (<EQUAL? .RES ,LIGHT-WOUND>
		<SET DEF <- .DEF 1>>
		<COND (<L? .DEF 0> <SET DEF 0>)>)
	       (<EQUAL? .RES ,SERIOUS-WOUND>
		<SET DEF <- .DEF 2>>
		<COND (<L? .DEF 0> <SET DEF 0>)>)
	       (<EQUAL? .RES ,STAGGER> <FSET ,PRSO ,STAGGERED>)
	       (T
		;<AND <EQUAL? .RES ,LOSE-WEAPON> .DWEAPON>
		<FCLEAR .DWEAPON ,NDESCBIT>
		<FSET .DWEAPON ,WEAPONBIT>
		<MOVE .DWEAPON ,HERE>
		<THIS-IS-IT .DWEAPON>)>
	 <VILLAIN-RESULT ,PRSO .DEF .RES>>

\

<ROUTINE WINNER-RESULT (DEF RES OD)
	 <PUTP ,WINNER
	       ,P?STRENGTH
	       <COND (<0? .DEF> -10000)(T <- .DEF .OD>)>>
	 <COND (<L? <- .DEF .OD> 0>
		<ENABLE <QUEUE I-CURE ,CURE-WAIT>>)>
	 <COND (<NOT <G? <FIGHT-STRENGTH> 0>>
		<PUTP ,WINNER ,P?STRENGTH <+ 1 <- <FIGHT-STRENGTH <>>>>>
		<JIGS-UP
"Il semble que ce dernier coup était trop pour toi.">
		<>)
	       (T .RES)>>

<ROUTINE VILLAIN-RESULT (VILLAIN DEF RES)
	 <PUTP .VILLAIN ,P?STRENGTH .DEF>
	 <COND (<0? .DEF>
		<FCLEAR .VILLAIN ,FIGHTBIT>
		<TELL
"Presque aussitôt que le " D .VILLAIN " rend son dernier souffle. Une sinistre brume noire l'enveloppe et, lorsqu'elle se dissipe, la dépouille a disparu." CR>
		<REMOVE-CAREFULLY .VILLAIN>
		<APPLY <GETP .VILLAIN ,P?ACTION> ,F-DEAD>
		.RES)
	       (<EQUAL? .RES ,UNCONSCIOUS>
		<APPLY <GETP .VILLAIN ,P?ACTION> ,F-UNCONSCIOUS>
		.RES)
	       (T .RES)>>

\

<ROUTINE WINNING? (V "AUX" VS PS)
	 <SET VS <GETP .V ,P?STRENGTH>>
	 <SET PS <- .VS <FIGHT-STRENGTH>>>
	 <COND (<G? .PS 3> <PROB 90>)
	       (<G? .PS 0> <PROB 75>)
	       (<0? .PS> <PROB 50>)
	       (<G? .VS 1> <PROB 25>)
	       (T <PROB 10>)>>

<ROUTINE I-CURE ("AUX" (S <GETP ,WINNER ,P?STRENGTH>))
	 <COND (<G? .S 0> <SET S 0> <PUTP ,WINNER ,P?STRENGTH .S>)
	       (<L? .S 0> <SET S <+ .S 1>> <PUTP ,WINNER ,P?STRENGTH .S>)>
	 <COND (<L? .S 0>
		<COND (<L? ,LOAD-ALLOWED ,LOAD-MAX>
		       <SETG LOAD-ALLOWED <+ ,LOAD-ALLOWED 10>>)>
		<ENABLE <QUEUE I-CURE ,CURE-WAIT>>)
	       (T
		<SETG LOAD-ALLOWED ,LOAD-MAX>
		<DISABLE <INT I-CURE>>)>>

"COMBATS"

"messages pour le gagnant"

<CONSTANT F-WEP 0>	;"means print weapon name"
<CONSTANT F-DEF 1>	;"means print defender name (villain, e.g.)"

<GLOBAL HERO-MELEE
 <TABLE (PURE)
  <LTABLE (PURE)
   <LTABLE (PURE) "Votre " F-WEP " manque le " F-DEF " d'un pouce.">
   <LTABLE (PURE) "Une bonne barre oblique, mais elle manque le " F-DEF " d'un mile.">
   <LTABLE (PURE) "Vous chargez, mais le " F-DEF " saute agilement à part.">
   <LTABLE (PURE) "Clang ! Accident! Le " F-DEF " parade.">
   <LTABLE (PURE) "Un coup rapide, mais le " F-DEF " est en marche. garde.">
   <LTABLE (PURE) "Un bon coup, mais il est trop lent ; le " F-DEF " esquive.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "Votre " F-WEP " s'écrase, renversant le " F-DEF " pays des rêves.">
   <LTABLE (PURE) "Le " F-DEF " est frappé jusqu'à l'inconscience.">
   <LTABLE (PURE) "Un échange furieux, et le " F-DEF " est frappé. Sortez !">
   <LTABLE (PURE) "Le manche de votre " F-WEP " fait tomber le " F-DEF ".">
   <LTABLE (PURE) "Le " F-DEF " est frappé. Sortez !">>
  <LTABLE (PURE)
   <LTABLE (PURE) "Ce sont des rideaux pour le " F-DEF " alors que votre " F-WEP " lui enlève la tête.">
   <LTABLE (PURE) "Le coup fatal frappe le " F-DEF " carré dans le coeur : il meurt.">
   <LTABLE (PURE) "Le " F-DEF " prend un coup fatal et s'effondre au sol, mort.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "Le " F-DEF " est frappé au bras ; le sang commence à couler.">
   <LTABLE (PURE) "Votre " F-WEP " fait rosir le " F-DEF " sur le poignet, mais ce n'est pas grave.">
   <LTABLE (PURE) "Votre accident vasculaire cérébral atterrit, mais ce n'était que le plat de la lame.">
   <LTABLE (PURE) "Le coup atterrit, créant une entaille peu profonde dans le bras de " F-DEF " !">>
  <LTABLE (PURE)
   <LTABLE (PURE) "Le " F-DEF " reçoit une entaille profonde dans son côté.">
   <LTABLE (PURE) "Un coup sauvage sur la cuisse ! Le " F-DEF " est étourdi mais peut encore se battre !">
   <LTABLE (PURE) "Slash ! Votre coup atterrit ! Celui-là a touché une artère, ça pourrait être grave !">
   <LTABLE (PURE) "Slash ! Votre coup se connecte ! Cela pourrait être grave !">>
  <LTABLE (PURE)
   <LTABLE (PURE) "Le " F-DEF " est chancelant et tombe à genoux.">
   <LTABLE (PURE) "Le " F-DEF " est momentanément désorienté et ne peut pas riposter.">
   <LTABLE (PURE) "La force de votre coup repousse le " F-DEF " en arrière, étourdi.">
   <LTABLE (PURE) "Le " F-DEF " est confus et ne peut pas riposter.">
   <LTABLE (PURE) "La rapidité de votre poussée frappe le " F-DEF " en arrière, étourdi.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "Le " F-DEF " est projetée au sol, le laissant désarmé.">
   <LTABLE (PURE) "Le " F-DEF " est désarmé par une subtile feinte devant sa garde.">>>>

\

"messages pour le cyclope (notez qu'il n'a pas d'arme"

<GLOBAL CYCLOPS-MELEE
 <TABLE (PURE)
  <LTABLE (PURE)
   <LTABLE (PURE) "Le Cyclope rate son coup, mais le contre-courant vous renverse presque.">
   <LTABLE (PURE) "Le Cyclope vous précipite, mais se heurte au mur.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "Le Cyclope vous envoie vous écraser au sol, inconscient.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "Le Cyclope vous brise le cou avec un fracas massif.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "Un rapide coup de poing, mais ce n'était qu'un coup d'oeil.">
   <LTABLE (PURE) "Un coup d'oeil du poing du Cyclope.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "Le monstre brise son énorme poing dans votre poitrine, brisant plusieurs côtes.">
   <LTABLE (PURE) "Le Cyclope vous coupe presque le souffle avec un coup de poing rapide.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "Le Cyclope envoie un coup de poing qui coupe le vent aux vous.">
   <LTABLE (PURE) "Sans se soucier de vos armes, le cyclope vous projette contre la paroi rocheuse.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "Le Cyclope s'empare de votre " F-WEP ", le goût, et le jette au sol dans le dégoût.">
   <LTABLE (PURE) "Le monstre vous attrape au poignet, vous presse, et vous déposez votre" F-WEP " souffre.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "Le cyclope n'arrive pas à décider s'il doit faire griller son dîner ou le mijoter.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "Le Cyclope, non sportif, envoie sa victime inconsciente.">>>>

\

"messages pour troll"

<GLOBAL TROLL-MELEE
<TABLE (PURE)
 <LTABLE (PURE)
  <LTABLE (PURE) "Le troll balance son hache, mais elle manque.">
  <LTABLE (PURE) "La hache du troll manque à peine votre oreille.">
  <LTABLE (PURE) "La hache passe devant vous pendant que vous sautez. de côté.">
  <LTABLE (PURE) "La hache s'écrase contre le rocher en projetant des étincelles !">>
 <LTABLE (PURE)
  <LTABLE (PURE) "L'appartement de la hache du troll te frappe délicatement sur la tête, te tapant.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "Le troll enlève soigneusement votre tête.">
  <LTABLE (PURE) "Le coup de hache du troll vous fend du nombril jusqu'aux mâchoires.">
  <LTABLE (PURE) "La hache du troll vous enlève la tête.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "La hache vous frappe directement sur le côté. Aïe !">
  <LTABLE (PURE) "Le plat de la hache du troll traverse votre avant-bras.">
  <LTABLE (PURE) "La balançoire du troll t'a presque frappé à peine à temps.">
  <LTABLE (PURE) "Le troll balance sa hache, et elle vous entaille le bras pendant que vous esquivez.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "Le troll charge et sa hache vous frappe sur votre " F-WEP " bras.">
  <LTABLE (PURE) "Un coup de hache provoque une blessure profonde dans votre jambe.">
  <LTABLE (PURE) "La hache du troll bascule vers le bas, vous entaillant épaule.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "Le troll te frappe d'un coup éblouissant, et tu es momentanément stupéfait.">
  <LTABLE (PURE) "Le troll oscille; la lame tourne sur votre armure, mais s'écrase sur la tête.">
  <LTABLE (PURE) "Vous reculez sous une pluie de coups de hache.">
  <LTABLE (PURE) "Le coup formidable du troll vous jette à genoux.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "La hache frappe votre " F-WEP " et le fait tourner.">
  <LTABLE (PURE) "Le troll balance, vous parez, mais la force de son coup fait tomber votre " F-WEP ".">
  <LTABLE (PURE) "La hache fait tomber votre " F-WEP " de votre main. Il tombe au sol.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "Le troll hésite en jouant avec sa hache.">
  <LTABLE (PURE) "Le troll se gratte la tête ruminativement: Pourriez-vous être protégé magiquement, il se demande?">>
 <LTABLE (PURE)
  <LTABLE (PURE) "Conquérant ses peurs, le troll vous met à mort.">>>>

\

"messages pour voleur"

<GLOBAL THIEF-MELEE
<TABLE (PURE)
 <LTABLE (PURE)
  <LTABLE (PURE) "Le voleur frappe nonchalamment de son stylet, mais rate son coup.">
  <LTABLE (PURE) "Vous esquivez alors que le voleur arrive en bas.">
  <LTABLE (PURE) "Tu paries un coup de foudre, et le voleur te salue avec un clin d'oeil.">
  <LTABLE (PURE) "Le voleur essaie de se faufiler devant votre garde, mais vous vous détournez.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "Déplacement au milieu d'une poussée, le voleur vous frappe inconscient avec la pointe de son stiletto.">
  <LTABLE (PURE) "Le voleur vous assomme.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "En vous achevant, le voleur insère sa lame dans votre coeur.">
  <LTABLE (PURE) "Le voleur entre du côté, feint, et insère la lame dans vos côtes.">
  <LTABLE (PURE) "Le voleur s'incline formellement, élève son stiletto, et avec un sourire en colère, termine la bataille et votre vie.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "Une poussée rapide rose votre bras gauche, et le sang commence à s'abattre.">
  <LTABLE (PURE) "Le voleur fait couler du sang en passant son stylet sur votre bras.">
  <LTABLE (PURE) "Le stiletto clignote plus vite que vous pouvez suivre, et les puits de sang de votre jambe.">
  <LTABLE (PURE) "Le voleur approche lentement, frappe comme un serpent, et vous laisse blessé.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "Le voleur frappe comme un serpent ! La blessure qui en résulte est grave.">
  <LTABLE (PURE) "Le voleur vous poignarde une profonde coupure dans le haut du bras.">
  <LTABLE (PURE) "Le stiletto touche votre front, et le sang obscurcit votre vision.">
  <LTABLE (PURE) "Le voleur frappe à ton poignet, et soudain ta prise est glissante avec du sang.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "Le cul de son stiletto te fait craquer sur le crâne, et tu recules.">
  <LTABLE (PURE) "Le voleur te met la lame dans l'estomac, te laissant hors de son souffle.">
  <LTABLE (PURE) "Le voleur attaque et vous reculez désespérément.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "Une longue attaque théâtrale. Vous l'attrapez sur votre " F-WEP ", mais le voleur tord son couteau," F-WEP " s'envole.">
  <LTABLE (PURE) "Le voleur retourne soigneusement votre " F-WEP "et ça tombe par terre.">
  <LTABLE (PURE) "Vous parez une faible poussée, et votre " F-WEP " vous glisse des mains.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "Le voleur, homme d'une éducation supérieure, s'arrête un instant pour juger s'il serait convenable de vous achever.">
  <LTABLE (PURE) "Le voleur s'amuse à fouiller vos poches.">
  <LTABLE (PURE) "Le voleur s'amuse en fouillant dans votre pack.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "Le voleur, oubliant son éducation essentiellement genteel, te coupe la gorge.">
  <LTABLE (PURE) "Le voleur, un pragmatiste, vous envoie comme une menace pour sa subsistance.">>>>


"chaque entrée de table est :"

<CONSTANT V-VILLAIN 0>	;"villain"
<CONSTANT V-BEST 1>	;"best weapon"
<CONSTANT V-BEST-ADV 2>	;"advantage it confers"
<CONSTANT V-PROB 3>	;"prob of waking if unconscious"
<CONSTANT V-MSGS 4>	;"messages for that villain"

"Cette table doit être après TROLL-MELÉE, VOLEUR-MÊLÉE, CYCLOPS-MÉLÉE défini !"

<GLOBAL VILLAINS
	<LTABLE <TABLE TROLL SWORD 1 0 TROLL-MELEE>
		<TABLE THIEF KNIFE 1 0 THIEF-MELEE>
		<TABLE CYCLOPS <> 0 0 CYCLOPS-MELEE>>>

"DÉMONS"

"Démon de combat"

<ROUTINE I-FIGHT ("AUX" (FIGHT? <>) (LEN <GET ,VILLAINS 0>)
		  CNT OO O P)
      <COND (,DEAD <RFALSE>)>
      <SET CNT 0>
      <REPEAT ()
	      <SET CNT <+ .CNT 1>>
	      <COND (<EQUAL? .CNT .LEN> <RETURN>)>
	      <SET OO <GET ,VILLAINS .CNT>>
	      <COND (<AND <IN? <SET O <GET .OO ,V-VILLAIN>> ,HERE>
			  <NOT <FSET? .O ,INVISIBLE>>>
		     <COND (<AND <EQUAL? .O ,THIEF> ,THIEF-ENGROSSED>
			    <SETG THIEF-ENGROSSED <>>)
			   (<L? <GETP .O ,P?STRENGTH> 0>
			    <SET P <GET .OO ,V-PROB>>
			    <COND (<AND <NOT <0? .P>> <PROB .P>>
				   <PUT .OO ,V-PROB 0>
				   <AWAKEN .O>)
				  (T
				   <PUT .OO ,V-PROB <+ .P 25>>)>)
			   (<OR <FSET? .O ,FIGHTBIT>
				<APPLY <GETP .O ,P?ACTION> ,F-FIRST?>>
			    <SET FIGHT? T>)>)
		    (T
		     <COND (<FSET? .O ,FIGHTBIT>
			    <APPLY <GETP .O ,P?ACTION> ,F-BUSY?>)>
		     <COND (<EQUAL? .O ,THIEF> <SETG THIEF-ENGROSSED <>>)>
		     <FCLEAR ,WINNER ,STAGGERED>
		     <FCLEAR .O ,STAGGERED>
		     <FCLEAR .O ,FIGHTBIT>
		     <AWAKEN .O>)>>
      <COND (<NOT .FIGHT?> <RFALSE>)>
      <DO-FIGHT .LEN>>

<ROUTINE AWAKEN (O "AUX" (S <GETP .O ,P?STRENGTH>))
	 <COND (<L? .S 0>
		<PUTP .O ,P?STRENGTH <- 0 .S>>
		<APPLY <GETP .O ,P?ACTION> ,F-CONSCIOUS>)>
	 T>

"ÉPÉE démon"

<ROUTINE I-SWORD ("AUX" (DEM <INT I-SWORD>) (G <GETP ,SWORD ,P?TVALUE>)
		        (NG 0) P T L)
	 <COND (<IN? ,SWORD ,ADVENTURER>
		<COND (<INFESTED? ,HERE> <SET NG 2>)
		      (T
		       <SET P 0>
		       <REPEAT ()
			       <COND (<0? <SET P <NEXTP ,HERE .P>>>
				      <RETURN>)
				     (<NOT <L? .P ,LOW-DIRECTION>>
				      <SET T <GETPT ,HERE .P>>
				      <SET L <PTSIZE .T>>
				      <COND (<EQUAL? .L ,UEXIT ,CEXIT ,DEXIT>
					     <COND (<INFESTED? <GETB .T 0>>
						    <SET NG 1>
						    <RETURN>)>)>)>>)>
		<COND (<EQUAL? .NG .G> <RFALSE>)
		      (<EQUAL? .NG 2>
		       <TELL "Votre épée s'est mise à briller d'un éclat intense." CR>)
		      (<1? .NG>
		       <TELL "Votre épée émet une faible lueur bleue."
			     CR>)
		      (<0? .NG>
		       <TELL "Votre épée ne brille plus." CR>)>
		<PUTP ,SWORD ,P?TVALUE .NG>
		<RTRUE>)
	       (T
		<PUT .DEM ,C-ENABLED? 0>
		<RFALSE>)>>

<ROUTINE INFESTED? (R "AUX" (F <FIRST? .R>))
	 <REPEAT ()
		 <COND (<NOT .F> <RFALSE>)
		       (<AND <FSET? .F ,ACTORBIT> <NOT <FSET? .F ,INVISIBLE>>>
			<RTRUE>)
		       (<NOT <SET F <NEXT? .F>>> <RFALSE>)>>>

"VOLEUR démon"

<ROUTINE I-THIEF ("AUX" (RM <LOC ,THIEF>) ROBJ HERE? (ONCE <>) (FLG <>))
   <PROG ()
     <COND (<SET HERE? <NOT <FSET? ,THIEF ,INVISIBLE>>>
	    <SET RM <LOC ,THIEF>>)>
     <COND
      (<AND <EQUAL? .RM ,TREASURE-ROOM> <NOT <EQUAL? .RM ,HERE>>>
       <COND (.HERE? <HACK-TREASURES> <SET HERE? <>>)>
       <DEPOSIT-BOOTY ,TREASURE-ROOM> ;"silent")
      (<AND <EQUAL? .RM ,HERE>
	    <NOT <FSET? .RM ,ONBIT>>
	    <NOT <IN? ,TROLL ,HERE>>>
       <COND (<THIEF-VS-ADVENTURER .HERE?> <RTRUE>)>
       <COND (<FSET? ,THIEF ,INVISIBLE> <SET HERE? <>>)>)
      (T
       <COND (<AND <IN? ,THIEF .RM>
		   <NOT <FSET? ,THIEF ,INVISIBLE>>> ;"Leave if victim left"
	      <FSET ,THIEF ,INVISIBLE>
	      <SET HERE? <>>)>
       <COND (<FSET? .RM ,TOUCHBIT>     ;"Hack the adventurer's belongings"
	      <ROB .RM ,THIEF 75>
	      <SET FLG
		   <COND (<AND <FSET? .RM ,MAZEBIT>
			       <FSET? ,HERE ,MAZEBIT>>
			  <ROB-MAZE .RM>)
			 (T <STEAL-JUNK .RM>)>>)>)>
     <COND (<AND <SET ONCE <NOT .ONCE>> <NOT .HERE?>>
					   ;"Move to next room, and hack."
	    <RECOVER-STILETTO>
	    <REPEAT ()
		    <COND (<AND .RM <SET RM <NEXT? .RM>>>)
			  (T <SET RM <FIRST? ,ROOMS>>)>
		    <COND (<AND <NOT <FSET? .RM ,SACREDBIT>>
				<FSET? .RM ,RLANDBIT>>
			   <MOVE ,THIEF .RM>
			   <FCLEAR ,THIEF ,FIGHTBIT>
			   <FSET ,THIEF ,INVISIBLE>
			   <SETG THIEF-HERE <>>
			   <RETURN>)>>
	    <AGAIN>)>>
   <COND (<NOT <EQUAL? .RM ,TREASURE-ROOM>>
	  <DROP-JUNK .RM>)>
   .FLG>

<ROUTINE DROP-JUNK (RM "AUX" X N (FLG <>))
	 <SET X <FIRST? ,THIEF>>
	 <REPEAT ()
		 <COND (<NOT .X> <RETURN .FLG>)>
		 <SET N <NEXT? .X>>
		 <COND (<EQUAL? .X ,STILETTO ,LARGE-BAG>)
		       (<AND <0? <GETP .X ,P?TVALUE>> <PROB 30 T>>
			<FCLEAR .X ,INVISIBLE>
			<MOVE .X .RM>
			<COND (<AND <NOT .FLG> <EQUAL? .RM ,HERE>>
			       <TELL
"Le voleur, fouillant dans son sac, a laissé tomber quelques objets sans valeur." CR>
			       <SET FLG T>)>)>
		 <SET X .N>>>

<ROUTINE RECOVER-STILETTO ()
	 <COND (<IN? ,STILETTO <LOC ,THIEF>>
		<FSET ,STILETTO ,NDESCBIT>
		<MOVE ,STILETTO ,THIEF>)>>

<ROUTINE STEAL-JUNK (RM "AUX" X N)
	 <SET X <FIRST? .RM>>
	 <REPEAT ()
		 <COND (<NOT .X> <RFALSE>)>
		 <SET N <NEXT? .X>>
		 <COND (<AND <0? <GETP .X ,P?TVALUE>>
			     <FSET? .X ,TAKEBIT>
			     <NOT <FSET? .X ,SACREDBIT>>
			     <NOT <FSET? .X ,INVISIBLE>>
			     <OR <EQUAL? .X ,STILETTO>
				 <PROB 10 T>>>
			<MOVE .X ,THIEF>
			<FSET .X ,TOUCHBIT>
			<FSET .X ,INVISIBLE>
			<COND (<EQUAL? .X ,ROPE> <SETG DOME-FLAG <>>)>
			<COND (<EQUAL? .RM ,HERE>
			       <TELL "Vous remarquez soudainement que le "
				     D .X " a disparu." CR>
			       <RTRUE>)
			      (ELSE <RFALSE>)>)>
		 <SET X .N>>>

<ROUTINE ROB (WHAT WHERE "OPTIONAL" (PROB <>) "AUX" N X (ROBBED? <>))
	 <SET X <FIRST? .WHAT>>
	 <REPEAT ()
		 <COND (<NOT .X> <RETURN .ROBBED?>)>
		 <SET N <NEXT? .X>>
		 <COND (<AND <NOT <FSET? .X ,INVISIBLE>>
			     <NOT <FSET? .X ,SACREDBIT>>
			     <G? <GETP .X ,P?TVALUE> 0>
			     <OR <NOT .PROB> <PROB .PROB>>>
			<MOVE .X .WHERE>
			<FSET .X ,TOUCHBIT>
			<COND (<EQUAL? .WHERE ,THIEF> <FSET .X ,INVISIBLE>)>
			<SET ROBBED? T>)>
		 <SET X .N>>>

;"special-cased routines"

<ROUTINE V-DIAGNOSE ("AUX" (MS <FIGHT-STRENGTH <>>)
		     (WD <GETP ,WINNER ,P?STRENGTH>) (RS <+ .MS .WD>))
	 #DECL ((MS WD RS) FIX)
	 <COND (<0? <GET <INT I-CURE> ,C-ENABLED?>> <SET WD 0>)
	       (ELSE <SET WD <- .WD>>)>
	 <COND (<0? .WD> <TELL "Vous êtes en parfaite santé.">)
	       (T
		<TELL "Vous avez ">
		<COND (<1? .WD> <TELL "une blessure légère,">)
		      (<EQUAL? .WD 2> <TELL "une blessure grave,">)
		      (<EQUAL? .WD 3> <TELL "plusieurs blessures,">)
		      (<G? .WD 3> <TELL "plaies graves,">)>)>
	 <COND (<NOT <0? .WD>>
		<TELL " qui seront guéries après ">
		<PRINTN
		 <+ <* ,CURE-WAIT <- .WD 1>>
		    <GET <INT I-CURE> ,C-TICK>>>
		<TELL " tours.">)>
	 <CRLF>
	 <TELL "Vous pouvez ">
	 <COND (<0? .RS> <TELL "attendre la mort bientôt">)
	       (<1? .RS> <TELL "être tué par une lumière supplémentaire blessure">)
	       (<EQUAL? .RS 2> <TELL "être tué par une blessure grave">)
	       (<EQUAL? .RS 3> <TELL "survivre à une blessure grave">)
	       (<G? .RS 3>
		<TELL "survivre à plusieurs blessures">)>
	 <TELL "." CR>
	 <COND (<NOT <0? ,DEATHS>>
		<TELL "Vous avez été tué ">
		<COND (<1? ,DEATHS> <TELL "une fois">)
		      (T <TELL "deux fois">)>
		<TELL "." CR>)>>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
	 #DECL ((ASK?) <OR ATOM FALSE>)
	 <TELL "Score : ">
	 <TELL N ,SCORE>
	 <TELL " sur 350, après ">
	 <TELL N ,MOVES>
	 <COND (<1? ,MOVES> <TELL " tour.">) (ELSE <TELL " tours.">)>
	 <CRLF>
	 <TELL "Votre rang : ">
	 <COND (<EQUAL? ,SCORE 350> <TELL "Maître aventurier">)
	       (<G? ,SCORE 330> <TELL "Sorcier">)
	       (<G? ,SCORE 300> <TELL "Maître">)
	       (<G? ,SCORE 200> <TELL "Aventurier">)
	       (<G? ,SCORE 100> <TELL "Aventurier junior">)
	       (<G? ,SCORE 50> <TELL "Aventurier novice">)
	       (<G? ,SCORE 25> <TELL "Aventurier amateur">)
	       (T <TELL "Débutant">)>
	 <TELL "." CR>
	 ,SCORE>

<ROUTINE JIGS-UP (DESC "OPTIONAL" (PLAYER? <>))
 	 <SETG WINNER ,ADVENTURER>
	 <COND (,DEAD
		<TELL "|Il faut un talent certain pour parvenir à se faire tuer quand on est déjà mort. VOUS possédez ce talent. Malheureusement, il en faudrait autant pour résoudre la situation, et je ne l'ai pas. Désolé." CR>
		<FINISH>)>
	 <TELL .DESC CR>
	 <COND (<NOT ,LUCKY>
		<TELL "Pas de chance, hein ?" CR>)>
	 <PROG ()
	       <SCORE-UPD -10>
	       <TELL "| **** Vous êtes mort **** | |">
	       <COND (<FSET? <LOC ,WINNER> ,VEHBIT>
		      <MOVE ,WINNER ,HERE>)>
	       <COND
		(<NOT <L? ,DEATHS 2>>
		 <TELL
"Vous êtes manifestement suicidaire. Les déséquilibrés ne sont pas admis dans la caverne : ils risqueraient de blesser les autres aventuriers. Vos restes seront installés au Pays des Morts-Vivants, où vos compagnons pourront venir les contempler avec satisfaction." CR>
		 <FINISH>)
		(T
		 <SETG DEATHS <+ ,DEATHS 1>>
		 <MOVE ,WINNER ,HERE>
		 <COND (<FSET? ,SOUTH-TEMPLE ,TOUCHBIT>
			<TELL
"En rendant votre dernier souffle, vous vous sentez délivré de vos fardeaux. Cette impression s'évanouit lorsque vous vous retrouvez devant les portes de l'Enfer, où les esprits vous raillent et vous refusent l'entrée. Vos sens sont troublés. Les objets du donjon paraissent indistincts, délavés, presque irréels." CR CR>
			<SETG DEAD T>
			<SETG TROLL-FLAG T>
			;<SETG GWIM-DISABLE T>
			<SETG ALWAYS-LIT T>
			<PUTP ,WINNER ,P?ACTION DEAD-FUNCTION>
			<GOTO ,ENTRANCE-TO-HADES>)
		       (T
			<TELL
"Voyons un peu... Eh bien, vous méritez sans doute une autre chance. Je ne peux pas vous remettre entièrement en état, mais on ne peut pas tout avoir." CR CR>
			<GOTO ,FOREST-1>)>
		 <FCLEAR ,TRAP-DOOR ,TOUCHBIT>
		 <SETG P-CONT <>>
		 <RANDOMIZE-OBJECTS>
		 <KILL-INTERRUPTS>
		 <RFATAL>)>>>

<ROUTINE RANDOMIZE-OBJECTS ("AUX" (R <>) F N L)
	 <COND (<IN? ,LAMP ,WINNER>
		<MOVE ,LAMP ,LIVING-ROOM>)>
	 <COND (<IN? ,COFFIN ,WINNER>
		<MOVE ,COFFIN ,EGYPT-ROOM>)>
	 <PUTP ,SWORD ,P?TVALUE 0>
	 <SET N <FIRST? ,WINNER>>
	 <SET L <GET ,ABOVE-GROUND 0>>
	 <REPEAT ()
		 <SET F .N>
		 <COND (<NOT .F> <RETURN>)>
		 <SET N <NEXT? .F>>
		 <COND (<G? <GETP .F ,P?TVALUE> 0>
			<REPEAT ()
				<COND (<NOT .R> <SET R <FIRST? ,ROOMS>>)>
				<COND (<AND <FSET? .R ,RLANDBIT>
					    <NOT <FSET? .R ,ONBIT>>
					    <PROB 50>>
				       <MOVE .F .R>
				       <RETURN>)
				      (ELSE <SET R <NEXT? .R>>)>>)
		       (ELSE
			<MOVE .F <GET ,ABOVE-GROUND <RANDOM .L>>>)>>>

<ROUTINE KILL-INTERRUPTS ()
	 <DISABLE <INT I-XB>>
	 <DISABLE <INT I-XC>>
	 <DISABLE <INT I-CYCLOPS>>
	 <DISABLE <INT I-LANTERN>>
	 <DISABLE <INT I-CANDLES>>
	 <DISABLE <INT I-SWORD>>
	 <DISABLE <INT I-FOREST-ROOM>>
	 <DISABLE <INT I-MATCH>>
	 <FCLEAR ,MATCH ,ONBIT>
	 <RTRUE>>

<ROUTINE BAG-OF-COINS-F ()
	 <STUPID-CONTAINER ,BAG-OF-COINS "pièces">>

<ROUTINE TRUNK-F ()
	 <STUPID-CONTAINER ,TRUNK "bijoux">>

<ROUTINE STUPID-CONTAINER (OBJ STR)
	 <COND (<VERB? OPEN CLOSE>
		<TELL
"Le " .STR " sont en sécurité à l'intérieur ; ce n'est pas nécessaire." CR>)
	       (<VERB? LOOK-INSIDE EXAMINE>
		<TELL
"Il y a beaucoup de " .STR " là-dedans." CR>)
	       (<AND <VERB? PUT> <EQUAL? ,PRSI .OBJ>>
		<TELL
"Ne soyez pas stupide. Ce ne serait plus un " D .OBJ "." CR>)>>

<ROUTINE DUMB-CONTAINER ()
	 <COND (<VERB? OPEN CLOSE LOOK-INSIDE>
		<TELL "Vous ne pouvez pas faire ça." CR>)
	       (<VERB? EXAMINE>
		<TELL "Il ressemble beaucoup à un " D ,PRSO "." CR>)>>

<ROUTINE GARLIC-F ()
	 <COND (<VERB? EAT>
		<REMOVE-CAREFULLY ,PRSO>
		<TELL
"Et puis zut ! Ce n'est pas ainsi que vous vous ferez des amis, mais personne n'est très amical par ici de toute façon. Gloups !" CR>)>>

<ROUTINE CHAIN-PSEUDO ()
	 <COND (<VERB? TAKE MOVE>
		<TELL "La chaîne est sécurisée." CR>)
	       (<VERB? RAISE LOWER>
		<TELL "Peut-être devriez-vous faire cela avec le panier." CR>)
	       (<VERB? EXAMINE>
		<TELL "La chaîne retient un panier à l'intérieur du puits." CR>)>>

<ROUTINE TROLL-ROOM-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <IN? ,TROLL ,HERE>>
		<THIS-IS-IT ,TROLL>)>>
