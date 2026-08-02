"ACTIONS3 pour ZORK III: Le Maître du Donjon Le Grand Empire Souterrain (Partie 3) (c) Copyright 1982 Infocom, Inc. Tous droits réservés."

"ÉPÉE démon"

<ROUTINE I-SWORD ("AUX" (DEM <INT I-SWORD>) (NG 0) P T L)
	 <COND (<IN? ,SWORD ,ADVENTURER>
		<COND (<AND <==? ,HERE ,CLIFF> <NOT ,MAN-GONE>> <SET NG 1>)
		      (<AND <==? ,HERE ,CLIFF-LEDGE> ,MAN-FLAG> <SET NG 1>)
		      (<INFESTED? ,HERE> <SET NG 2>)
		      (<OR <AND <==? ,MLOC ,MRG> <==? ,HERE ,IN-MIRROR>>
			   <EQUAL? ,HERE ,MRGE ,MRG ,MRGW>>
		       <SET NG 1>)
		      (ELSE
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
		<COND (<==? .NG ,SWORD-STATE> <RFALSE>)
		      (<==? .NG 2>
		       <TELL "Votre épée s'est mise à briller d'un éclat intense." CR>)
		      (<1? .NG>
		       <TELL "Votre épée brille d'un bleu pâle brille."
			     CR>)
		      (<0? .NG>
		       <TELL "Votre épée ne brille plus." CR>)>
		<SETG SWORD-STATE .NG>
		<RTRUE>)
	       (ELSE <DISABLE .DEM> <RFALSE>)>>

<GLOBAL SWORD-STATE 0>

<ROUTINE INFESTED? (R "AUX" (F <FIRST? .R>)) 
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN <>>)
		       (<AND <FSET? .F ,ACTORBIT> <NOT <FSET? .F ,INVISIBLE>>>
			<RETURN .F>)
		       (<NOT <SET F <NEXT? .F>>> <RETURN <>>)>>>

"ancienne ACTIONS.ZIL"

<GLOBAL YUKS
	<LTABLE
	 "Une vaillante tentative."
	 "Vous ne pouvez pas être sérieux."
	 "Une idée intéressante..."
	 "Quel concept !">>

<ROUTINE FIND-WEAPON (O "AUX" W)
	 <SET W <FIRST? .O>>
	 <COND (<NOT .W>
		<RFALSE>)>
	 <REPEAT ()
		 <COND (<EQUAL? .W ,SWORD>
			<RETURN .W>)
		       (<NOT <SET W <NEXT? .W>>> <RFALSE>)>>>

<ROUTINE SWORD-FCN ()
	 <COND (,SWORD-IN-STONE?
		<COND (<VERB? TAKE MOVE>
		       <COND (<PROB 10>
			      <TELL
"Pour qui pensez-vous être ? Arthur ?" CR>)
			     (T <TELL
"L'épée est profondément enfoncée dans la roche. Vous ne pouvez pas la bouger." CR>)>)>)
	       (<AND <VERB? TAKE> <==? ,WINNER ,ADVENTURER>>
		<ENABLE <QUEUE I-SWORD -1>>
		<>)>>

<GLOBAL LAMP-TABLE
	<TABLE 300
	       "La lampe apparaît un peu "
	       100
	       "La lampe est définitivement plus faible maintenant."
	       50
	       "La lampe est presque éteinte."
	       0>>

<ROUTINE LANTERN ()
	 <COND (<VERB? THROW>
		<TELL "La lampe se brise. La lumière est maintenant éteinte." CR>
		<DISABLE <INT I-LANTERN>>
		<REMOVE ,LAMP>
		<SETG CURRENT-LAMP ,BROKEN-LAMP>
		<MOVE ,BROKEN-LAMP ,HERE>)
	       (<VERB? LAMP-ON>
		<COND (<NOT <FSET? ,LAMP ,LIGHTBIT>>
		       <TELL "Une lampe grillée ne s'allume pas." CR>)
		      (ELSE
		       <ENABLE <INT I-LANTERN>>
		       <>)>)
	       (<VERB? LAMP-OFF>
		<COND (<NOT <FSET? ,LAMP ,LIGHTBIT>>
		       <TELL "La lampe est déjà grillée." CR>)
		      (ELSE
		       <DISABLE <INT I-LANTERN>>
		       <>)>)
	       (<VERB? EXAMINE>
		<COND (<NOT <FSET? ,LAMP ,LIGHTBIT>>
		       <TELL "La lampe est grillée.">)
		      (<FSET? ,LAMP ,ONBIT>
		       <TELL "La lampe est allumée.">)
		      (ELSE
		       <TELL "La lampe est allumée. éteint.">)>
		<CRLF>)>>

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

<ROUTINE I-LANTERN ("AUX" TICK (TBL <VALUE LAMP-TABLE>))
	 <ENABLE <QUEUE I-LANTERN <SET TICK <GET .TBL 0>>>>
	 <LIGHT-INT ,LAMP .TBL .TICK>
	 <COND (<NOT <0? .TICK>>
		<SETG LAMP-TABLE <REST .TBL 4>>)>>

;<ROUTINE LIGHT-INT (OBJ INTNAM TBLNAM "AUX" (TBL <VALUE .TBLNAM>) TICK)
	 #DECL ((OBJ) OBJECT (TBLNAM INTNAM) ATOM (TBL) <PRIMTYPE VECTOR>
		(TICK) FIX)
	 <ENABLE <QUEUE .INTNAM <SET TICK <GET .TBL 0>>>>
	 <COND (<0? .TICK>
		<FCLEAR .OBJ ,LIGHTBIT>
		<FCLEAR .OBJ ,ONBIT>)>
	 <COND (<OR <HELD? .OBJ> <IN? .OBJ ,HERE>>
		<COND (<0? .TICK>
		       <TELL
"J'espère que vous avez plus de lumière que celle du " D .OBJ "." CR>)
		      (T
		       <TELL <GET .TBL 1> CR>)>)>
	 <COND (<NOT <0? .TICK>>
		<SETG .TBLNAM <REST .TBL 4>>)>>

<ROUTINE CHASM-FCN ()
	 <COND (<OR <VERB? LEAP>
		    <AND <VERB? PUT> <==? ,PRSO ,ME>>>
		<TELL
"Vous regardez avant de sauter et réalisez que vous ne survivrez jamais." CR>)
	       (<VERB? CROSS>
		<TELL "Vous devrez trouver un pont." CR>)
	       (<AND <VERB? PUT> <==? ,PRSI ,PSEUDO-OBJECT>>
		<TELL
"Le " D ,PRSO " tombe hors de vue dans le gouffre." CR>
		<REMOVE ,PRSO>)>>

<ROUTINE TUNNEL-OBJECT ()
	 <COND (<AND <VERB? THROUGH> <GETP ,HERE ,P?IN>>
		<DO-WALK ,P?IN>
		<RTRUE>)
	       (T <PATH-OBJECT>)>>

\

"SOUS-TITRE DE LA SECTION DE L'ÉNIGME CHINOISE (AVEC L'AIMABLE AUTORISATION DE WILL WENG)"

<GLOBAL CPHERE 1>

<GLOBAL CPOBJS <ITABLE NONE <* 8 2 36>>>

<GLOBAL CPTABLE
      <TABLE   1
	       0
	       -1
	       0
	       0
	       -1
	       0
	       -1
	       0
	       1
	       0
	       -2
	       0
	       0
	       0
	       0
	       0
	       1
	       0
	       -3
	       0
	       0
	       -1
	       -1
	       0
	       0
	       0
	       -1
	       0
	       0
	       0
	       1
	       1
	       0
	       0
	       0
	       1>>

;" 0 is no wall
    1 is fixed wall
   -1 is movable wall (-2 is good ladder, -3 bad ladder)"

<GLOBAL CPWALLS <LTABLE CPSWL 6 CPNWL -6 CPEWL 1 CPWWL -1>>

<GLOBAL CPEXITS <LTABLE
       P?NORTH
       -6
       P?SOUTH
       6
       P?EAST
       1
       P?WEST
       -1
       P?NE
       -5
       P?NW
       -7
       P?SE
       7
       P?SW
       5>>

<GLOBAL CP-MOVED <>>

<ROUTINE CPEXIT ("AUX" FX NFX)
	#DECL ((FX NFX) FIX)
	<SETG CP-MOVED <>>
	<COND (<==? ,PRSO ,P?UP>
	       <COND (<==? ,CPHERE 1>
		      <COND (<==? <GET ,CPTABLE 2> -2>
			     <TELL
"À l'aide de l'échelle, vous sortez du puzzle." CR>
			     ,CP-ANTE)
			    (T
			     <TELL
			      "La sortie est trop au-dessus de votre tête." CR>
			     <RFALSE>)>)
		     (T
		      <TELL "Il n'y a aucun moyen. vers le haut." CR>
		      <RFALSE>)>)
	      (<AND <==? ,CPHERE 33>
		    <==? ,PRSO ,P?WEST>
		    ,CP-FLAG>
	       <FCLEAR ,CP ,TOUCHBIT>
	       ,CP-OUT)
	      (<==? ,PRSO ,P?DOWN>
	       <TELL "Il n'y a aucun moyen de descendre ici." CR>
	       <RFALSE>)
	      (<AND <==? ,CPHERE 33>
		    <==? ,PRSO ,P?WEST>>
	       <TELL "La porte métallique barre le passage." CR>
	       <RFALSE>)
	      (T
	       <SET FX <LKP ,PRSO ,CPEXITS>>
	       <COND (<OR <G? <SET NFX <+ .FX ,CPHERE>> 36>
			  <L? .NFX 0>
			  <ILLCP ,CPHERE .FX>>
		      <TELL "Il y a un mur là." CR>
		      <RFALSE>)
		     (<EQUAL? <ABS .FX> 1 6>
		      <CPMOVE .FX>)
		     (<AND <G? .FX 0> ; "SW AND SE"
			   <EQUAL? 0
				   <GET ,CPTABLE <+ ,CPHERE 6>>
				   <GET ,CPTABLE <+ ,CPHERE <- .FX 6>>>>>
		      <CPMOVE .FX>)
		     (<AND <L? .FX 0>
			   <EQUAL? 0
				   <GET ,CPTABLE <- ,CPHERE 6>>
				   <GET ,CPTABLE <+ <+ ,CPHERE 6> .FX>>>>
		      <CPMOVE .FX>)
		     (T
		      <TELL "Il y a un mur là." CR>)>
	       <RFALSE>)>>

<GLOBAL MINUS-SEVEN -7>
<GLOBAL MINUS-FIVE -5>
<GLOBAL MINUS-FOUR -4>
<GLOBAL MINUS-ONE -1>

<ROUTINE ILLCP (ONE TWO)
	 <COND (<AND <==? <MOD .ONE 6> 0>
		     <EQUAL? .TWO ,MINUS-FIVE 1 7>> <RTRUE>)
	       (<AND <==? <MOD .ONE 6> 1>
		     <EQUAL? .TWO ,MINUS-SEVEN ,MINUS-ONE 5>> <RTRUE>)
	       (<AND <L? .ONE 7> <L? .TWO ,MINUS-FOUR>> <RTRUE>)
	       (<AND <G? .ONE 30> <G? .TWO 4>> <RTRUE>)>>

<ROUTINE CPMOVE (FX)
	 <COND (<0? <GET ,CPTABLE <SET FX <+ ,CPHERE .FX>>>>
	        <CPGOTO .FX>)
	       (T
	        <TELL "Il y a un mur là." CR>)>>

<ROUTINE CPENTER ()
	<COND (<OR <NOT <==? ,YEAR ,YEAR-PRESENT>> ,CPBLOCK-FLAG>
	       <TELL "Le trou est bouché par du grès." CR>
	       <RFALSE>)
	      (T
	       <SETG CPHERE 1>
	       ,CP)>>

<ROUTINE CPANT-ROOM (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL
"Il s'agit d'une petite pièce carrée, au milieu de laquelle se trouve un trou rond">
		<COND (<OR ,CPBLOCK-FLAG <NOT <==? ,YEAR ,YEAR-PRESENT>>>
		       <TELL
			" qui est bloqué par du grès lisse. grès." CR>)
		      (T
		       <TELL
"La zone sous le trou est sombre, mais il semble être complètement enfermé dans la roche. Quoi qu'il en soit, il ne semble pas probable que vous puissiez remonter. Les sorties sont à l'ouest et, en haut de quelques marches, au nord." CR>)>)>>

<GLOBAL CPPUSH-FLAG <>>  

<GLOBAL CPSOLVE-FLAG <>>

<ROUTINE CPLADDER-OBJECT ()
	 <COND (<==? <GET ,CPTABLE <- ,CPHERE 1>> -3>
		<CPLADDER-JUNK <>>)
	       (<==? <GET ,CPTABLE <+ ,CPHERE 1>> -2>
		<CPLADDER-JUNK T>)
	       (T <TELL "Vous ne voyez aucune échelle ici." CR>)>>

<ROUTINE CPLADDER-JUNK (FLG)
	 <COND (<VERB? CLIMB-UP CLIMB-FOO>
		<COND (<AND .FLG <==? ,CPHERE 1>>
		       <SETG CPSOLVE-FLAG T>
		       <GOTO ,CP-ANTE>)
		      (T
		       <TELL
"Vous vous êtes cogné la tête contre le plafond et êtes tombé du sol. échelle." CR>)>)
	       (T <TELL "Viens, viens !" CR>)>> 

<ROUTINE CPWALL-OBJECT ("AUX" WL NWL NXT NNXT CNT TOP (SNAP <>))
	#DECL ((NXT WL NNXT NWL) FIX (UVEC) <UVECTOR [REST FIX]>)
	<COND (<VERB? MOVE> <TELL "Vous ne pouvez pas saisir le mur pour le tirer." CR>)
	      (<VERB? PUSH>
	       <SET NXT <CPNEXT ,CPHERE ,PRSO>>
	       <COND (<0? .NXT>
		      <TELL "Le mur ne tient pas bouge." CR>
		      <RTRUE>)>
	       <SET WL <GET ,CPTABLE .NXT>>
	       <COND (<0? .WL>
		      <TELL "Il n'y a qu'un passage dans cette direction." CR>)
		     (<1? .WL>
		      <TELL "Le mur ne tient pas bouge." CR>)
		     (<0? <SET NNXT <CPNEXT .NXT ,PRSO>>>
		      <TELL "Le mur cède à peine." CR>)
		     (<NOT <0? <SET NWL <GET ,CPTABLE .NNXT>>>>
		      <TELL "Le mur cède à peine." CR>)
		     (T
		      <TELL
"Le mur glisse vers l'avant et vous suivez il">
	   	      <COND (,CPPUSH-FLAG <TELL " à cette position :" CR>)
			    (T
			     <SETG SCORE <+ ,SCORE 1>>
			     <TELL
"....| L'architecture de cette région devient complexe, de sorte que d'autres descriptions seront des diagrammes du voisinage immédiat dans une grille 3x3. Les murs ici sont de roche, mais de deux types différents - grès et marbre. Les notations suivantes seront utilisées:|">
			     <FIXED-FONT-ON>
			     <TELL
"| .. = votre position (au milieu de la grille)| MM = mur de marbre| SS = mur de grès| ?? = inconnu (bloquant par les murs)| |">
			     <FIXED-FONT-OFF>)>
		      <SETG CPPUSH-FLAG T>
		      <PUT ,CPTABLE .NXT 0>
		      <PUT ,CPTABLE .NNXT .WL>
		      <COND (<NOT <EQUAL? .NNXT 0>>
			     <SET TOP <* 8 <- .NNXT 1>>>
			     <SET CNT <GET ,CPOBJS .TOP>>
			     <REPEAT ()
				     <COND (<0? .CNT> <RETURN>)
					   (T
					    <SET TOP <+ .TOP 1>>
					    <MOVE <GET ,CPOBJS .TOP> ,CP-OUT>
					    <COND (<NOT .SNAP>
						   <SET SNAP T>
						   <TELL
"Vous entendez un léger « claquement » derrière le mur que vous poussiez." CR>)>
					    <SET CNT <- .CNT 1>>)>>)>
		      <COND (<==? .NNXT 1>
			     <SETG CPBLOCK-FLAG T>)>
		      <CPGOTO .NXT>)>)>>

<ROUTINE FIXED-FONT-ON () <PUT 0 8 <BOR <GET 0 8> 2>>>

<ROUTINE FIXED-FONT-OFF() <PUT 0 8 <BAND <GET 0 8> -3>>>

"Drapeau pour bloquer l'entrée principale"

<GLOBAL CPBLOCK-FLAG <>>

<CONSTANT GCARDLOC 168>	;"8*(22-1)"

<ROUTINE CPGOTO (FX "AUX" F X CNT TOP)
	#DECL ((FX CNT TOP) FIX (F X) <OR FALSE OBJECT>)
	<SETG CP-MOVED T>
	<FCLEAR ,HERE ,TOUCHBIT>
	<SET TOP <* 8 <- ,CPHERE 1>>>
	<SET CNT <+ .TOP 1>>
	<SET F <FIRST? ,CP>>
	<REPEAT ()
		<SET X <NEXT? .F>>
		<COND (<NOT .F> <RETURN>)
		      (<==? .F ,ADVENTURER> T)
		      (T
		       <PUT ,CPOBJS .CNT .F>
		       <REMOVE .F>
		       <SET CNT <+ .CNT 1>>)>
		<COND (<NOT .X> <RETURN>)
		      (T <SET F .X>)>>
	<PUT ,CPOBJS .TOP <- <- .CNT .TOP> 1>>
	<SETG CPHERE .FX>
	<SET TOP <* 8 <- ,CPHERE 1>>>
	<SET CNT <GET ,CPOBJS .TOP>>
	<REPEAT ()
		<COND (<0? .CNT> <RETURN>)
		      (T
		       <SET TOP <+ .TOP 1>>
		       <MOVE <GET ,CPOBJS .TOP> ,CP>
		       <SET CNT <- .CNT 1>>)>>
	<PERFORM ,V?LOOK>
	<RTRUE>> 

<ROUTINE CPNEXT (RM OBJ "AUX" FX)
	#DECL ((RM) FIX (OBJ) OBJECT)
	<SET FX <LKP .OBJ ,CPWALLS>>
	<COND (<ILLCP .RM .FX> 0)
	      (T <+ .RM .FX>)>>

<ROUTINE CPDOOR-F ()
	 <COND (<AND <==? ,HERE ,CP> <NOT <==? ,CPHERE 33>>>
		<TELL "Vous ne voyez aucun acier porte ici." CR>)
	       (<VERB? OPEN>
		<COND (,CP-FLAG <TELL "La porte en acier est déjà ouverte." CR>)
		      (T <TELL "Vous ne pouvez pas forcer son ouverture." CR>)>)
	       (<VERB? CLOSE>
		<COND (,CP-FLAG <TELL
"Il ne semble pas y avoir de moyen de la fermer. " CR>)
		      (T <TELL "Pensez-vous que ce n'est pas déjà le cas ?" CR>)>)
	       (<VERB? MUNG>
		<TELL
"La porte est, en première approximation, indestructible." CR>)
	       (<VERB? KNOCK>
		<TELL
"À part une grande quantité de réverbération, rien ne se passe." CR>)>>

<ROUTINE CP-ROOM (RARG)
	<COND (<==? .RARG ,M-ENTER>
	       <SETG CPHERE
		     <COND (<==? ,PRSO ,P?DOWN> 1)
		     	   (T 33)>>)
	      (<==? .RARG ,M-LOOK>
	       <COND (,CPPUSH-FLAG <CPWHERE>)
		     (T
		      <TELL
"Vous êtes dans une petite pièce carrée délimitée au nord et à l'ouest avec des murs en marbre et à l'est et au sud avec des murs en grès." CR>)>)>>   

<ROUTINE CPNS (NUM)
	 #DECL ((NUM) FIX)
	 <COND (<OR <G? .NUM 36> <L? .NUM 1>> 1)
	       (T <GET ,CPTABLE .NUM>)>>

<ROUTINE CPEW (NUM FOO)
	 #DECL ((NUM FOO) FIX)
	 <COND (<==? <MOD .NUM 6> .FOO> 1)
	       (T <GET ,CPTABLE .NUM>)>>

<ROUTINE CPWHERE ("AUX"  (N <CPNS <+ ,CPHERE -6>>)
			 (S <CPNS <+ ,CPHERE 6>>)
			 (E <CPEW <+ ,CPHERE 1> 1>)
			 (W <CPEW <+ ,CPHERE -1> 0>))
	#DECL ((N S E W) FIX)
	<FIXED-FONT-ON>
	<TELL "      +">			      ;"Top Row"
	<CP-CORNER ,MINUS-SEVEN .N .W>
	<TELL " ">
	<CP-ORTHO .N>
	<TELL " ">
	<CP-CORNER ,MINUS-FIVE .N .E>
	<TELL "+" CR>
	<TELL "Ouest +">			   ;"Middle Row"
	<CP-ORTHO .W>
	<TELL " .. ">
	<CP-ORTHO .E>
	<TELL "+ Est" CR>
	<TELL "      +">			   ;"Bottom Row"
	<CP-CORNER 5 .S .W>
	<TELL " ">
	<CP-ORTHO .S>
	<TELL " ">
	<CP-CORNER 7 .S .E>
	<TELL "+" CR>
	<FIXED-FONT-OFF>
	<COND (<==? ,CPHERE 1>
	       <TELL
"Au plafond au-dessus de vous se trouve une grande pièce circulaire ouverture." CR>)
	      (<==? ,CPHERE 22>
	       <TELL
"Le centre du sol ici est sensiblement en dépression." CR>)
	      (<==? ,CPHERE 33>
	       <TELL
"Au centre du mur ouest se trouve une porte en acier qui est ">
	       <COND (,CP-FLAG <TELL "ouvert">)
		     (T <TELL "fermé">)>
	       <TELL
". D'un côté de la porte est une fente étroite." CR>)>
	<COND (<==? .E -2>
	       <TELL
"Il y a ici une échelle, fermement fixée au mur est." CR>)>
	<COND (<==? .W -3>
	       <TELL
"Il y a ici une échelle, fermement fixée à l'ouest. mur." CR>)>>

"Afficher où se trouvent les huit voisins les plus proches situé" 

<ROUTINE CP-ORTHO (CONTENTS)
	#DECL ((CONTENTS) FIX)
	<COND (<0? .CONTENTS> <TELL "  ">)
	      (<1? .CONTENTS> <TELL "MM">)
	      (T <TELL "SS">)>>

;"Show an orthogonal neighbor"

<ROUTINE CP-CORNER (DIR COL ROW "AUX" LOCN)
	#DECL ((DIR COL ROW) FIX)
	<SET LOCN <+ ,CPHERE .DIR>>
	<COND (<AND <NOT <==? .COL 0>> <NOT <==? .ROW 0>>> <TELL "??">)
	      (<ILLCP ,CPHERE .DIR> <TELL "MM">)
	      (<0? <SET COL
			<COND (<OR <L? .LOCN 1> <G? .LOCN 36>> 1)
			      (T <GET ,CPTABLE .LOCN>)>>>
	       <TELL "  ">)
	      (<1? .COL> <TELL "MM">)
	      (T <TELL "SS">)>>

<ROUTINE CP-SLOT-FCN ()
	<COND (<VERB? PUT>
	       <COND (<G? <GETP ,PRSO ,P?SIZE> 10>
		      <TELL "Ce n'est pas le cas fit." CR>
		      <RTRUE>)>
	       <REMOVE ,PRSO>
	       <COND (<==? ,PRSO ,LORE-BOOK>
	       	      <SETG CP-FLAG T>
	              <TELL
"Le livre tombe dans la fente et disparaît. La porte métallique coulisse, dévoilant un passage vers l'ouest, tandis qu'un panneau lumineux affiche :|
    \"Droit de sortie de l'Énigme royale acquitté|
          Objet confisqué\"" CR>)
		     (<FSET? ,PRSO ,ACTORBIT>
		      <TELL <PICK-ONE ,YUKS> CR>)
		     (T
		      <TELL
"L'objet disparaît dans la fente. Un instant plus tard, un panneau jusqu'alors invisible affiche \"Déchets à l'entrée, déchets à la sortie\" et éjecte " D ,PRSO " (maintenant atomisé)." CR>)>)>>
	     
<ROUTINE CPOUT-ROOM (RARG)
	<COND (<==? .RARG ,M-LOOK>
	       <TELL
"Vous êtes dans une pièce étroite, éclairée d'en haut. Un vol de marches mène au nord, et un">
	       <COND (,CP-FLAG <TELL "passage">)
		     (T <TELL "porte métallique">)>
	       <TELL " mène à l'est." CR>)>>

"Ancienne fin de partie trucs"

;"SUBTITLE It's All Done with Mirrors"

<GLOBAL MLOC <>>

<GLOBAL MR1-FLAG T>

<GLOBAL MR2-FLAG T>

<GLOBAL MIRROR-OPEN-FLAG <>>

<GLOBAL WOOD-OPEN-FLAG <>>

<GLOBAL MRSWPUSH-FLAG <>>

<GLOBAL R-SOUTHS <LTABLE FRONT-DOOR MRD MRG MRC MRB MRA MREYE>>
<GLOBAL R-NORTHS <LTABLE MREYE MRA MRB MRC MRG MRD>>

<ROUTINE MRGO ("AUX" TORM)
	 <COND (<EQUAL? ,PRSO ,P?NORTH ,P?NW ,P?NE>
		<SET TORM <LKP ,HERE ,R-NORTHS>>)
	       (T <SET TORM <LKP ,HERE ,R-SOUTHS>>)>
	 <COND (<EQUAL? ,PRSO ,P?NORTH ,P?SOUTH>
	        <COND (<==? ,MLOC .TORM>
		       <COND (<0? <MOD ,MDIR 180>>
			      <TELL
 "Il y a un mur en bois qui bloque votre chemin." CR>
			      <RFALSE>)
			     (<MIRIN <>> ,IN-MIRROR)
			     (T <MIRBLOCK> <RFALSE>)>)
		     (T .TORM)>)
	       (<==? ,MLOC .TORM>
	        <COND (<0? <MOD ,MDIR 180>> <GO-E-W .TORM>)
		      (T <MIRBLOCK> <RFALSE>)>)
	       (T .TORM)>>

<ROUTINE MIRBLOCK ("AUX" MD)
	 <SET MD ,MDIR>
	 <COND (<==? ,PRSO ,P?SOUTH>
	        <SET MD <MOD <+ ,MDIR 180> 360>>)>
	 <COND (<OR <AND <==? .MD 270> <NOT ,MR1-FLAG>>
		    <AND <==? .MD 90> <NOT ,MR2-FLAG>>>
	        <TELL "Il y a un grand miroir brisé qui bloque votre chemin." CR>)
	       (T
	        <TELL "Il y a un grand miroir qui bloque votre chemin. " CR>)>>

<ROUTINE GO-E-W (RM)
	<COND (<EQUAL? ,PRSO ,P?NE ,P?SE>
	       <LKP .RM ,R-EASTS>)
	      (T <LKP .RM ,R-WESTS>)>>

<GLOBAL R-EASTS <LTABLE MRA MRAE MRB MRBE MRC MRCE MRG MRGE MRD MRDE>>
<GLOBAL R-WESTS <LTABLE MRA MRAW MRB MRBW MRC MRCW MRG MRGW MRD MRDW>>

<DEFMAC N-S () '<0? <MOD ,MDIR 180>>>

<DEFMAC E-W ('FX) <FORM OR <FORM ==? .FX 90> <FORM ==? .FX 270>>>

<ROUTINE EWTELL (RM "AUX" (EAST? <>) (M1? <>) MWIN)
	 <COND (<OR <EQUAL? .RM ,MRAE ,MRBE ,MRCE>
		    <EQUAL? .RM ,MRGE ,MRCE>>
		<SET EAST? T>)>
	 <COND (<==? <+ ,MDIR <COND (.EAST? 0) (T 180)>> 180>
		<SET M1? T>)>
	 <COND (.M1? <SET MWIN ,MR1-FLAG>) (T <SET MWIN ,MR2-FLAG>)>
	 <TELL "Vous êtes dans une pièce étroite, dont le mur "
	       <COND (.EAST? "ouest") (T "est")>
	       " est un grand "
	       <COND (.MWIN "miroir.")
		     (T "panneau en bois qui contenait autrefois un miroir.")>
	       CR>
	 <COND (<AND .M1? ,MIRROR-OPEN-FLAG>
		<TELL <COND (.MWIN
"Le miroir est monté sur un panneau ouvert vers l'extérieur.")
			    (T "Le panneau a été ouvert vers l'extérieur.")>
		      CR>)>
	 <TELL "Le contraire le mur est constitué de roche solide." CR>>

<GLOBAL GUARDIANS-SEEN <>>

<ROUTINE MRDEW ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-LOOK>
	        <EWTELL ,HERE>
	        <SETG GUARDIANS-SEEN T>
		<TELL "Un peu au sud" ,GUARDSTR CR>)>>

<ROUTINE MRCEW ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-LOOK>
	        <EWTELL ,HERE>
	        <SETG GUARDIANS-SEEN T>
		<TELL "Un peu au nord" ,GUARDSTR CR>)>>

<ROUTINE MRBEW ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-LOOK>
	        <EWTELL ,HERE>
	        <TELL "Au nord et au sud, il y a de grandes couloirs." CR>)>>

<ROUTINE MRAEW ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-LOOK>
	        <EWTELL ,HERE>
	        <TELL "Au nord se trouve un grand couloir." CR>)>>

<GLOBAL GUARDSTR
"Les statues représentent les Gardiens de Zork, un ordre militaire d'ancienne lignée. Elles sont présentées comme des guerriers lourdement blindés qui ferment de formidables rouages.">

<ROUTINE LOOK-TO (RMN RMS "AUX" (NORTH? <>) (NTELL <>) (STELL <>)
		  		MIR? (M1? <>) DIR)
	 <COND (<NOT <EQUAL? ,HERE ,MREYE ,FRONT-DOOR>>
		<TELL
"C'est une partie du long couloir. Les murs est et ouest sont en pierre habillée. Au centre du hall est un canal en pierre peu profonde. Au centre de la pièce, le canal s'élargit dans un grand trou autour duquel est gravé une rose boussole." CR>)>
	 <COND (<==? ,HERE ,MRG>
		<SETG GUARDIANS-SEEN T>
		<TELL
"De part et d'autre de vous, il y a des statues de pierre identiques tenant des rouages. Elles semblent prêtes à frapper, mais pour le moment, elles restent impassives." CR>)
	       (<==? ,HERE ,MRC>
	        <SETG GUARDIANS-SEEN T>
		<TELL "Un peu au nord" ,GUARDSTR CR>
		<SET NTELL T>)
	       (<==? ,HERE ,FRONT-DOOR>
		<TELL
"Vous êtes dans un couloir nord-sud qui se termine, au nord, à une grande porte en bois." CR>
		<SET NTELL T>)
	       (<==? ,HERE ,MRD>
	        <SETG GUARDIANS-SEEN T>
		<TELL "Un peu au sud" ,GUARDSTR CR>
		<SET STELL T>)
	       (<==? ,HERE ,MRA>
		<TELL "Le couloir continue vers le sud." CR>
		<SET STELL T>)>
	 <COND (<EQUAL? ,MLOC .RMN .RMS>
	        <COND (<==? ,MLOC .RMN>
		       <SET NORTH? T>
		       <SET NTELL T>
		       <SET DIR "nor">)
		      (T
		       <SET STELL T>
		       <SET DIR "sou">)>
	        <SET MIR?
		    <COND (<AND .NORTH? <G? ,MDIR 180> <L? ,MDIR 359>>
			   <SET M1? T>
			   ,MR1-FLAG)
			  (<AND <NOT .NORTH?> <G? ,MDIR 0> <L? ,MDIR 179>>
			   <SET M1? T>
			   ,MR1-FLAG)
			  (T ,MR2-FLAG)>>
	        <COND (<0? <MOD ,MDIR 180>>
		       <TELL "Le "
			     .DIR
"le côté de la pièce est divisé par un mur en bois en petits couloirs">
		       <TELL .DIR "est et ">
		       <TELL .DIR "ouest." CR>)
		      (T
		       <TELL <COND (.MIR? "Un grand miroir remplit le ")
				   (T "Un grand panneau remplit le ")>
			     .DIR
			     "ème côté du couloir." CR>
		       <COND (<AND .M1? ,MIRROR-OPEN-FLAG>
			      <TELL <COND (.MIR?
"Le miroir est monté sur un panneau ouvert vers l'extérieur.")
					  (T
"Le panneau a été ouvert vers l'extérieur.")> CR>)>)>)>
	 <COND (<AND <NOT .NTELL> <NOT .STELL>>
		<TELL "Le couloir continue vers le nord et vers le sud." CR>)
	       (<NOT .NTELL>
		<TELL "Le couloir continue vers le nord." CR>)
	       (<NOT .STELL>
		<TELL "Le couloir continue vers le sud." CR>)>
	 <RTRUE>>

<ROUTINE MRDF ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-LOOK>
	        <LOOK-TO ,FRONT-DOOR ,MRG>)>>

<ROUTINE MRCF ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-LOOK>
	        <LOOK-TO ,MRG ,MRB>)>>

<ROUTINE MRBF ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-LOOK>
	        <LOOK-TO ,MRC ,MRA>)>>

<ROUTINE MRAF ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-LOOK>
	        <LOOK-TO ,MRB <>>)>>

<ROUTINE GUARDIANS ("OPTIONAL" (RARG <>))
   	 <COND (<==? .RARG ,M-LOOK>
		<COND (<==? ,HERE ,MRG>
		       <LOOK-TO ,MRD ,MRC>)
		      (T
		       <EWTELL ,HERE>
		       <TELL
"À l'est et à l'ouest se tiennent les Gardiens de Zork, parfaitement symétriques. D'ici, impossible de savoir lequel des deux n'est qu'un reflet !" CR>)>)
	       (<AND <==? .RARG ,M-ENTER> <NOT ,INVIS>>
	        <JIGS-UP
"Les Gardiens se réveillent, et à l'unisson parfait, vous pulvérisent avec leurs rouages. Satisfaits, ils reprennent leurs postes.">)
	       (<NOT <==? .RARG ,M-END>> <RFALSE>)
	       (<VERB? EXAMINE>
		<COND (<==? ,HERE ,IN-MIRROR>
		       <TELL "On ne les voit pas d'ici." CR>)
		      (T <TELL
"Les Gardiens sont impressionnants." CR>)>)
	       (<AND <VERB? THROW> <==? ,PRSI ,GUARDIAN>>
		<COND (<EQUAL? ,PRSO ,ME>
		       <TELL "Vous marchez">)
		      (T
		       <TELL "Le " D ,PRSO " tombe">
		       <REMOVE ,PRSO>)>
		<TELL
" devant les Gardiens, qui ">
		<COND (<EQUAL? ,PRSO ,ME>
		       <TELL "vous décimer">)
		      (T <TELL "détruisez-le">)>
		<TELL "Satisfaits, ils reprennent leurs postes." CR>)
	       (<VERB? ATTACK>
	        <TELL
"Tu n'es pas assez proche, et même si tu l'étais, le combat serait un peu unilatéral." CR>)
	       (<VERB? HELLO>
	        <TELL "Les statues sont impassibles." CR>)>>

<ROUTINE MIRROR-DIR? (DIR RM "AUX" TBL)
         <SET TBL <COND (<==? .DIR ,P?NORTH> ,R-NORTHS) (T ,R-SOUTHS)>>
	 <COND (<AND <GETPT .RM .DIR>
		     <==? ,MLOC <LKP .RM .TBL>>>
		<COND (<AND <==? .DIR ,P?NORTH>
			    <G? ,MDIR 180>
			    <L? ,MDIR 360>>
		       1)
		      (<AND <==? .DIR ,P?SOUTH>
			    <G? ,MDIR 0>
			    <L? ,MDIR 180>>
		       1)
		      (T 2)>)>>

<ROUTINE WOODEN-WALL-F ()
	 <COND (<AND <0? <MOD ,MDIR 180>>
		     <OR <MIRROR-DIR? ,P?NORTH ,HERE>
			 <MIRROR-DIR? ,P?SOUTH ,HERE>>>
		<COND (<VERB? PUSH>
		       <TELL "La structure ne bouge pas." CR>)>)
	       (T <TELL "Vous n'en voyez pas. mur en bois ici." CR>)>>

<ROUTINE MIRROR-HERE? (RM "AUX" TMP)
	 <COND (<OR <EQUAL? ,HERE ,MRAE ,MRAW ,MRBE>
		    <EQUAL? ,HERE ,MRBW ,MRCE ,MRCW>
		    <EQUAL? ,HERE ,MRGE ,MRGW ,MRDE>
		    <EQUAL? ,HERE ,MRDW>>
		<COND (<==? 180
			    <+ ,MDIR <COND (<OR <EQUAL? .RM ,MRAE ,MRBE ,MRCE>
						<EQUAL? .RM ,MRGE ,MRDE>> 0)
					   (T 180)>>>
		       1)
		      (T 2)>)
	       (<0? <MOD ,MDIR 180>> <RFALSE>)
	       (<SET TMP <MIRROR-DIR? ,P?NORTH .RM>> .TMP)
	       (<SET TMP <MIRROR-DIR? ,P?SOUTH .RM>> .TMP)
	       (T <RFALSE>)>>

<ROUTINE MIRROR-FUNCTION ("AUX" MIRROR)
 	 <COND (<NOT <SET MIRROR <MIRROR-HERE? ,HERE>>>
	        <TELL "Vous ne pouvez voir aucun miroir ici." CR>)
	       (<VERB? OPEN MOVE>
	        <TELL
"Vous ne voyez pas de moyen d'ouvrir le miroir ici." CR>)
	       (<VERB? LOOK-INSIDE>
	        <COND (<OR <AND <==? .MIRROR 1> ,MR1-FLAG> ,MR2-FLAG>
		       <COND (,INVIS
			      <TELL
"Étonnamment, vous n'avez aucun reflet !" CR>)
			     (T
			      <TELL
"Un aventurier échevelé vous regarde." CR>)>)
		      (T
		       <TELL
"Vous avez détruit le miroir, ou avez-vous oublié ?" CR>)>)
	       (<VERB? MUNG>
	        <COND (<1? .MIRROR>
		       <COND (,MR1-FLAG
			      <SETG MR1-FLAG <>>
			      <TELL
"Le miroir se brise, révélant un panneau de bois derrière lui. Les fragments de miroir scintillent tranquillement en non-existence." CR>)
			     (T <TELL "Le miroir a déjà été brisé."
				      CR>)>)
		      (,MR2-FLAG
		       <SETG MR2-FLAG <>>
		       <TELL
"Le miroir se brise, révélant un panneau de bois derrière lui. Les fragments de miroir scintillent tranquillement en non-existence." CR>)
		      (T <TELL "Le miroir a déjà été brisé." CR>)>)
	       (<OR <AND <==? .MIRROR 1> <NOT ,MR1-FLAG>> <NOT ,MR2-FLAG>>
	        <TELL
"Il ne reste plus de miroir." CR>)
	       (<VERB? PUSH>
	        <TELL <COND (<==? .MIRROR 1>
"Le miroir est monté sur un panneau en bois qui se déplace légèrement vers l'intérieur pendant que vous poussez, et en arrière quand vous lâchez.")
			    (T
"Le miroir est inflexible, mais semble fragile.")> CR>)>>

<ROUTINE PANEL-FUNCTION ("AUX" MIRROR)
 	 <COND (<NOT <SET MIRROR <MIRROR-HERE? ,HERE>>>
	        <TELL "Vous ne pouvez voir aucun panneau ici." CR>)
	       (<VERB? OPEN MOVE>
	        <TELL "Vous ne voyez pas un moyen d'ouvrir le panneau ici." CR>)
	       (<VERB? MUNG>
	        <COND (<==? .MIRROR 1>
		       <COND (,MR1-FLAG
			      <TELL ,MIRROR-FIRST CR>)
			     (T <TELL
"Le panneau n'est pas si facilement détruit." CR>)>)
		      (,MR2-FLAG
		       <TELL ,MIRROR-FIRST CR>)
		      (T <TELL "Le panneau n'est pas si facilement détruit." CR>)>)
	       (<VERB? PUSH>
	        <TELL <COND (<==? .MIRROR 1>
"Le panneau en bois se déplace légèrement vers l'intérieur pendant que vous poussez, et reculez quand vous laissez aller.")
			    (T
"Le panneau est inflexible.")> CR>)>>

<GLOBAL MIRROR-FIRST
"Pour briser le panneau, vous devez d'abord casser le miroir.">

<GLOBAL DIRVEC <LTABLE P?NORTH 0 P?NE 45 P?EAST 90 P?SE 135
		       P?SOUTH 180 P?SW 225 P?WEST 270 P?NW 315>>

<ROUTINE MIROUT ("AUX" DIR RM)
	 <COND (<==? ,PRSO ,P?OUT> <SET DIR 1>)
	       (T <SET DIR <LKP ,PRSO ,DIRVEC>>)>
	 <COND (,MIRROR-OPEN-FLAG
	        <COND (<OR <==? .DIR 1>
			   <==? <MOD <+ ,MDIR 270> 360> .DIR>>
		       <COND (<0? <MOD ,MDIR 180>>
			      <MIREW>)
			     (T <MIRNS <L? ,MDIR 180> T>)>)
		      (T
		       <TELL "Il y a un " CR>
		       <RFALSE>)>)
	       (,WOOD-OPEN-FLAG
	        <COND (<OR <==? .DIR 1>
			   <==? <MOD <+ ,MDIR 180> 360> .DIR>>
		       <COND (<0? ,MDIR> <SET RM <>>) (T <SET RM T>)>
		       <COND (<SET RM <MIRNS .RM T>>
		              <TELL "Lorsque vous partez, la porte se ferme." CR>
			      <SETG WOOD-OPEN-FLAG <>>
			      .RM)
			     (T
			      <TELL "Vous ne pouvez pas aller jusque là. chemin." CR>
			      <RFALSE>)>)
		      (T
		       <TELL "Vous heurterez l'un des panneaux." CR>
		       <RFALSE>)>)
	       (T
		<TELL "Vous êtes à l'intérieur d'un espace fermé. box!" CR>
		<RFALSE>)>>

"MRNS -- retourne la pièce dans une direction donnée du miroir (nord ou sud comme indiqué par le premier argument). Si le second arg est T, alors nous sortons, nous ne bougeons pas le miroir, alors ne vous inquiétez pas des extrémités."

<ROUTINE MIRNS (NORTH? "OPTIONAL" (EXIT? <>) "AUX" S T)
	 <COND (<NOT .EXIT?>
		<COND (<AND .NORTH? <==? ,MLOC ,MRD>>
	               <RFALSE>)
		      (<AND <NOT .NORTH?> <==? ,MLOC ,MRA>>
		       <RFALSE>)>)>
	 <COND (<SET T <GETPT ,MLOC <COND (.NORTH? ,P?NORTH)
					  (T ,P?SOUTH)>>>
		<COND (<==? <SET S <PTSIZE .T>> ,UEXIT>
		       <GETB .T 0>)
		      (.NORTH?
		       <LKP ,MLOC ,R-NORTHS>)
		      (T
		       <LKP ,MLOC ,R-SOUTHS>)>)>>

<ROUTINE MIREW ()
    	 <COND (<0? ,MDIR> <LKP ,MLOC ,R-WESTS>)
	       (T <LKP ,MLOC ,R-EASTS>)>>

<ROUTINE MIRIN ("OPTIONAL" (VRB T))
         <COND (<AND <==? <MIRROR-HERE? ,HERE> 1> ,MIRROR-OPEN-FLAG>
		,IN-MIRROR)
	       (<NOT .VRB> <RFALSE>)
	       (<==? <MIRROR-HERE? ,HERE> 1>
	        <COND (<AND <NOT ,MIRROR-OPENED> ,MR1-FLAG>
		       <TELL "Un miroir bloque votre chemin." CR>
		       <RFALSE>)
		      (T <TELL "Le panneau est fermé." CR> <RFALSE>)>)
	       (T <TELL "La structure bloque votre chemin." CR> <RFALSE>)>>

<ROUTINE MREYE-ROOM ("OPTIONAL" (RARG <>) "AUX" O)
         <COND (<AND <==? .RARG ,M-BEG>
		     <VERB? DROP>
		     <IN? ,PRSO ,WINNER>
		     <NOT <BEAM-STOPPED?>>>
		<MOVE ,PRSO ,HERE>
		<TELL
"Vous déposez facilement le " D ,PRSO "en position de bloquer le faisceau de lumière." CR>)
	       (<==? .RARG ,M-LOOK>
	        <TELL
"Vous êtes au milieu d'un long couloir nord-sud dont les murs sont en pierre polie. Un étroit faisceau rouge de lumière traverse la pièce à l'extrémité nord, pouces au-dessus du sol." CR>
	        <COND (<SET O <BEAM-STOPPED?>>
		       <TELL
"La poutre est bloquée par un " D .O " posé sur le sol." CR>)>
		<LOOK-TO ,MRA <>>)>>

<ROUTINE BEAM-STOPPED? ("AUX" N)
	 <SET N <FIRST? ,MREYE>>
	 <REPEAT ()
		 <COND (<NOT <EQUAL? .N ,PLAYER ,BEAM>>
			<SETG BEAM-BREAKER .N>
			<RETURN .N>)
		       (<NOT <SET N <NEXT? .N>>> <RFALSE>)>>>

; "This function cannot have its .PRSI and .PRSO's changed to ,PRSI etc!!"

<GLOBAL BEAM-BREAKER <>>

<ROUTINE BEAM-FUNCTION ("AUX" PRO PRI)
	 <COND (<VERB? LEAP>
		<TELL
"Vous sautez par-dessus la poutre et dans le couloir." CR>
		<GOTO ,MRA>
		<RTRUE>)
	       (<VERB? FOLLOW>
		<TELL 
"Il traverse simplement l'extrémité nord de la pièce, donc il n'y a nulle part où la suivre." CR>)
	       (<VERB? EXAMINE>
		<TELL
"Le faisceau rouge de lumière traverse l'extrémité nord de la pièce à seulement un pouce au-dessus du sol.">
		<COND (<BEAM-STOPPED?>
		       <TELL " La poutre est brisée par un " D ,BEAM-BREAKER
			     " posé au sol.">)>
		<CRLF>)
	       (<VERB? PUT MUNG>
	        <COND (<VERB? PUT>
		       <SET PRI ,PRSO>
		       <SET PRO ,PRSI>)
		      (T
		       <SET PRI ,PRSI>
		       <SET PRO ,PRSO>)>
	        <COND (<OR <NOT .PRI> <NOT <==? .PRO ,BEAM>>> <RFALSE>)
		      (<IN? .PRI ,WINNER>
		       <MOVE .PRI ,HERE>
		       <SETG BEAM-BREAKER .PRI>
		       <TELL
"La poutre est maintenant interrompue par un " D .PRI " posé sur le sol." CR>)
		      (<IN? .PRI ,HERE>
		       <TELL
"Le " D .PRI " brise déjà le faisceau." CR>)
		      (<==? .PRI ,HANDS>
		       <TELL
"Le faisceau est brièvement brisé lors de son passage." CR>)
		      (T <TELL
"Vous ne tenez pas le " D .PRI "." CR>)>)
	       (<AND <VERB? TAKE> <==? ,PRSO ,BEAM>>
	        <TELL
"Vous avez sans aucun doute également une bouteille de rayons de lune." CR>)>>

<GLOBAL MIRROR-OPENED <>>

<ROUTINE MRSWITCH ()
	 <COND (<VERB? PUSH>
	        <COND (,MRSWPUSH-FLAG
		       <TELL "Cliquez." CR>)
		      (T
		       <COND (<BEAM-STOPPED?>
			      <TELL "Cliquez. Snap !" CR>
			      <ENABLE <QUEUE I-MRINT 7>>
			      <SETG MRSWPUSH-FLAG T>
			      <SETG MIRROR-OPEN-FLAG T>
			      <SETG MIRROR-OPENED T>
			      <FCLEAR ,MRA ,TOUCHBIT>)
			     (T <TELL "Cliquez." CR>)>)>)>>

<ROUTINE I-MRINT ()
	 <SETG MRSWPUSH-FLAG <>>
	 <SETG MIRROR-OPEN-FLAG <>>
	 <COND (<OR <==? <MIRROR-HERE? ,HERE> 1>
		    <==? ,HERE ,IN-MIRROR>>
		<TELL "Le miroir se ferme silencieusement." CR>)
	       (<==? ,HERE ,MR-ANTE>
		<TELL "Le bouton revient à sa position d'origine." CR>)>>

<GLOBAL MDIR 270>

;"mirror points... 0 = north"

<GLOBAL POLEUP-FLAG 0>

;"pole raised?: 0 -- in hole or channel, 1 -- foor level, 2 -- in air"

<ROUTINE MAGIC-MIRROR ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-LOOK>
	        <TELL
"Vous êtes à l'intérieur d'une boîte rectangulaire en bois dont la structure est plutôt
compliqué. Quatre côtés et le toit sont remplis et le sol est
ouvert.|
|
Lorsque vous faites face au côté opposé à l'entrée, deux petits côtés de
le bois sculpté et poli se trouve à gauche et à droite. Le panneau de gauche
c'est de l'acajou, le pin droit. Le mur auquel vous faites face est rouge à sa gauche
moitié et noir à sa droite. Côté entrée, le mur est blanc
en face de la partie rouge du mur auquel il fait face, et jaune en face de la
partie noire. Les murs peints font au moins deux fois la longueur de
ceux non peints. Le plafond est peint en bleu.|
|
Dans le sol se trouve un canal en pierre d'environ six pouces de large et un pied
profond. Le canal est orienté nord-sud. Dans le
Au centre exact de la pièce, le canal s'élargit en un cercle
dépression d'environ deux pieds de large. Incisé dans la pierre autour de ça
la zone est une rose des vents.|
|
Courir d'un petit mur à l'autre à peu près à hauteur de taille
est une barre en bois, soigneusement sculptée et percée. Cette barre est percée
à deux endroits. Le premier trou est au centre de la barre (et donc
le centre de la pièce). La seconde est à l'extrémité gauche de la pièce
(face à l'entrée). À travers chaque trou passe un bois
poteau.|
|
Le poteau à l'extrémité gauche de la barre est court et s'étend sur environ un pied.
au-dessus de la barre et se termine par une poignée. Le poteau ">
	        <COND (<AND <==? ,MLOC ,MRB> <==? ,MDIR 270>>
		       <COND (<NOT <0? ,POLEUP-FLAG>>
			      <TELL
"a été sorti d'un trou sculpté dans le sol en pierre. Il y a évidemment assez de friction pour empêcher le poteau de retomber.">)
			     (T
			      <TELL "a été lâché dans un trou sculpté dans le sol en pierre.">)>)
		      (<EQUAL? ,MDIR 0 180>
		       <COND (<NOT <0? ,POLEUP-FLAG>>
			      <TELL "est placé au-dessus du canal de pierre dans le plancher.">)
			     (T
			      <TELL "a été déposé dans le canal de pierre incisé dans le sol.">)>)
		      (T
		       <TELL "se repose sur le sol en pierre.">)>
	       <TELL
"| | Le long poteau au centre de la barre s'étend du plafond à travers la barre jusqu'à la zone circulaire dans le canal de pierre. Cette extrémité inférieure du poteau a un peu moins de deux pieds de long attaché à elle, et sur la barre en T est sculptée une flèche. La flèche et la barre en T pointent"
		     <GET ,LONGDIRS </ ,MDIR 45>>
		     ".">
	       <COND (,WOOD-OPEN-FLAG
		      <TELL
"| Le panneau en pin a été ouvert vers l'extérieur.">)>
	       <CRLF>)>>

<GLOBAL LONGDIRS <TABLE "nord" "nord-est" "est" "sud-est"
			"sud" "sud-ouest" "ouest" "nord-ouest">>

;"MOVEMENT"

<ROUTINE MPANELS ("AUX" MD)
         <COND (<VERB? PUSH>
	        <COND (<NOT <0? ,POLEUP-FLAG>>
		       <COND (<==? ,MLOC ,MRG>
			      <COND (,GUARDIANS-SEEN
				     <JIGS-UP
"Les Gardiens se réveillent, et à l'unisson parfait, vous détruisent complètement avec leurs rouages de pierre. Satisfaits, ils reprennent leurs postes.">
				     <RTRUE>)
				    (T
				     <JIGS-UP
"Tout d'un coup, deux immenses rouages de pierre viennent à travers le sommet de la structure, vous écrasant.">
				     <RTRUE>)>)>
		       <COND (<EQUAL? ,PRSO ,RED-PANEL ,YELLOW-PANEL>
			      <SET MD <MOD <+ ,MDIR 45> 360>>
			      <TELL "La structure tourne dans le sens des aiguilles d'une montre." CR>)
			     (T
			      <SET MD <MOD <+ ,MDIR 315> 360>>
			      <TELL
"La structure tourne dans le sens inverse des aiguilles d'une montre." CR>)>
		       <TELL "La flèche sur la rose des vents indique maintenant "
			     <GET ,LONGDIRS </ .MD 45>>
			     "." CR>
		       <COND (,WOOD-OPEN-FLAG
			      <SETG WOOD-OPEN-FLAG <>>
			      <TELL "Le mur en pin se ferme silencieusement." CR>)>
		       <SETG MDIR .MD>
		       <RTRUE>)
		      (<0? <MOD ,MDIR 180>>
		       <TELL
 "Le poteau court empêche la structure de tourner." CR>)
		      (T
		       <TELL
 "La structure tremble légèrement mais ne bouge pas. déplacer." CR>)>)>>

<ROUTINE MENDS ("AUX" RM)
	 <COND (<VERB? CLOSE> <TELL "Vous ne pouvez pas faire cela avec le panneau." CR>)
	       (<OR <VERB? PUSH>
		    <AND <VERB? OPEN> <==? ,PRSO ,PINE-PANEL>>>
	        <COND (<NOT <0? <MOD ,MDIR 180>>>
		       <TELL
"La structure oscille légèrement d'avant en arrière mais ne bouge pas." CR>)
		      (<==? ,PRSO ,MAHOGANY-PANEL>
		       <COND (<SET RM <MIRNS <L? ,MDIR 180>>>
			      <MIRMOVE <0? ,MDIR> .RM>)
			     (T
			      <TELL
"La structure a atteint l'extrémité du canal de pierre et ne bouge pas." CR>)>)
		      (T
		       <TELL "Le mur en pin s'ouvre." CR>
		       <COND (<OR <AND <==? ,MLOC ,MRD>
				       <==? ,MDIR 0>>
				  <AND <==? ,MLOC ,MRC>
				       <==? ,MDIR 180>>
				  <==? ,MLOC ,MRG>>
			      <COND (,GUARDIANS-SEEN
				     <TELL
"La porte en pin s'ouvre sur le champ de vision des Gardiens." CR>)
				    (T
				     <TELL
"La porte en pin s'ouvre dans le champ de vision des Gardiens de Zork, représentés par deux statues de pierre identiques armées de massues." CR>)>
			      <JIGS-UP
"Les Gardiens se réveillent, et à l'unisson parfait, vous détruisent complètement avec leurs rouages de pierre. Satisfaits, ils reprennent leurs postes.">
			      <RTRUE>)>
		       <SETG WOOD-OPEN-FLAG T>
		       <ENABLE <QUEUE I-PININ 5>>)>)>>

<ROUTINE I-PININ ()
	 <COND (,WOOD-OPEN-FLAG
		<SETG WOOD-OPEN-FLAG <>>
		<TELL "Le mur en pin se ferme silencieusement." CR>)>>

<ROUTINE MIRMOVE (NORTH? RM "AUX" (PU? <>) (LOSE <>))
	 <COND (<NOT <0? ,POLEUP-FLAG>> <SET PU? T>)>
	 <TELL <COND (.PU? "La structure oscille de manière instable ")
		     (T "La structure glisse ")>
	       <COND (.NORTH? "nord") (T "sud")>
	       " et s'arrête au-dessus d'une autre rose des vents." CR>
	 <SETG MLOC .RM>
	 <COND (<AND <==? .RM ,MRG> <==? ,HERE ,IN-MIRROR>>
	        <COND (.PU?
		       <SET LOSE T>)
		      (<OR <NOT ,MR1-FLAG> <NOT ,MR2-FLAG>>
		       <SET LOSE T>)
		      (<OR ,MIRROR-OPEN-FLAG ,WOOD-OPEN-FLAG>
		       <SET LOSE T>)>
	        <COND (.LOSE
		       <COND (,GUARDIANS-SEEN
			      <JIGS-UP
"Soudain les Gardiens se rendent compte que quelqu'un essaie de se faufiler par eux dans la structure. Ils se réveillent et, à l'unisson parfait, martelent le contenu de la boîte (en d'autres termes vous) à la pulpe.">)
			     (T
			      <JIGS-UP
"Soudain, deux chaumes de pierre identiques passent par le toit et martelent le contenu de la boîte en pulpe.">)>)>
		<RTRUE>)>
	 T>	

<ROUTINE SHORT-POLE-F ()
         <COND (<VERB? RAISE MOVE>
	        <COND (<==? ,POLEUP-FLAG 2>
		       <TELL "Le poteau ne peut pas être élevé davantage." CR>)
		      (T
		       <SETG POLEUP-FLAG 2>
		       <TELL "Le poteau est maintenant légèrement au-dessus du sol." CR>)>)
	       (<OR <AND <VERB? PUT> <==? ,PRSI ,CHANNEL>>
		    <VERB? PUSH LOWER>>
	        <COND (<0? ,POLEUP-FLAG>
		       <TELL "Le poteau ne peut pas être abaissé. plus loin." CR>)
		      (<0? <MOD ,MDIR 180>>
		       <TELL "Le poteau est descendu dans le canal." CR>
		       <SETG POLEUP-FLAG 0>
		       T)
		      (<AND <==? ,MDIR 270> <==? ,MLOC ,MRB>>
		       <SETG POLEUP-FLAG 0>
		       <TELL "Le poteau est descendu dans le trou de pierre." CR>)
		      (<==? ,POLEUP-FLAG 1>
		       <TELL "Le poteau repose déjà sur le sol." CR>)
		      (T
		       <SETG POLEUP-FLAG 1>
		       <TELL "Le poteau repose maintenant sur le sol en pierre." CR>)>)>>

\

<ROUTINE DUNGEON-MASTER-F ("OPTIONAL" (RARG <>)) 
	 <COND (<==? .RARG ,M-OBJDESC> <RFALSE>)
	       (<==? ,WINNER ,DUNGEON-MASTER>
		<COND (<VERB? FOLLOW>
		       <COND (<IN? ,DUNGEON-MASTER <LOC ,PLAYER>>
			      <ENABLE <QUEUE I-FOLIN -1>>
			      <TELL
"Le maître du donjon répond : \"Je vais suivez.\"" CR>)
			     (T
			      <TELL
"La voix du maître du donjon répond : \"Vous devez d'abord venir ici !\"" CR>)>)
		      (<VERB? STAY WAIT>
		       <QUEUE I-FOLIN 0>
		       <TELL
"Le maître du donjon répond : \"Je vais reste.\"" CR>)
		      (<VERB? WALK>
		       <COND (<AND <EQUAL? ,PRSO ,P?SOUTH ,P?ENTER>
				   <==? ,HERE ,NORTH-CORRIDOR>>
			      <TELL
"\"Je ne suis pas autorisé à entrer dans la cellule de la prison.\"" CR>)
			     (<AND <==? ,PRSO ,P?NORTH>
				   <==? ,HERE ,NORTH-CORRIDOR>>
			      <MOVE ,DUNGEON-MASTER ,PARAPET>
			      <SETG HERE ,PARAPET>
			      <TELL
"\"Très bien, je suis au parapet !\"" CR>
			      <QUEUE I-FOLIN 0>)
			     (<AND <EQUAL? ,PRSO ,P?NORTH ,P?ENTER>
				   <==? ,HERE ,SOUTH-CORRIDOR>>
			      <TELL
"\"Je ne suis pas autorisé à entrer dans la cellule de la prison.\"" CR>)
			     (T
			      <TELL
"\"Je préfère rester où. Oui, merci.\"" CR>)>)
		      (<AND <VERB? WALK-TO> <==? ,PRSO ,PARAPET-OBJ>>
		       <MOVE ,DUNGEON-MASTER ,PARAPET>
		       <SETG HERE ,PARAPET>
		       <QUEUE I-FOLIN 0>
		       <TELL
"\"Très bien !\"" CR>)
		      (<VERB? TAKE>
		       <TELL
"\"Ça ne me servira à rien, j'en ai peur.\"" CR>)
		      (<AND <VERB? OPEN>
			    <==? ,PRSO ,DUNGEON-DOOR>
			    ,IN-DUNGEON>
		       <TELL
"Le maître des donjons semble en colère. \"Ne fuyez pas votre quête: vous approchez de la fin!\"" CR>)
		      (<VERB? PUSH TURN SPIN FOLLOW STAY OPEN CLOSE WAIT
			      ATTACK WALK-TO>
		       <COND (<VERB? STAY FOLLOW WAIT> T)
			     (T <TELL "\"Si vous le souhaitez\", répond-il." CR>)>
		       <RFALSE>)
		      (T <TELL
"\"Ne soyez pas stupide ! Considérez la fin de votre quête!\"" CR>)>)
	       (<VERB? EXAMINE>
		<TELL
"Il est simplement vêtu d'une capuche et d'une cape. Il porte une amulette et une bague, tient un vieux livre sous un bras et s'appuie sur un bâton de bois. Une unique clé, qui semble ouvrir une cellule, pend à sa ceinture." CR>)
	       (<VERB? ATTACK MUNG>
		<REALLY-DEAD
"Le maître du donjon est pris par surprise. Il esquive votre coup, et avec une expression déçue sur son visage, trace un motif compliqué dans l'air avec son bâton.">)
	       (<VERB? TAKE>
		<TELL
"\"Je suis prêt à vous accompagner, mais pas à rouler dans votre poche !\"" CR>)
	       (<AND <VERB? GIVE> <==? ,PRSI ,DUNGEON-MASTER>>
		<TELL
"\"Je n'ai pas besoin de ces choses-là.\"" CR>)>>

<ROUTINE MASTER-F () 
	 <COND (<EQUAL? ,HERE ,PRISON-CELL ,GOOD-CELL>
		<COND (<HELLO? ,MASTER>
		       <TELL "Il ne vous entend pas." CR>)
		      (T <TELL "Il n'est pas ici." CR>)>)
	       (<VERB? TELL>
		<COND (,IN-DUNGEON
		       <SETG PRSO ,DUNGEON-MASTER>
		       <RFALSE>)
		      (ELSE
		       <SETG P-CONT <>>
		       <SETG QUOTE-FLAG <>>
		       <TELL "Le maître du donjon n'est pas là." CR>)>)
	       (<AND <VERB? GIVE SGIVE> <IN? ,DUNGEON-MASTER ,HERE>>
		<TELL
"Il refuse poliment votre offre." CR>)
	       (<AND <VERB? EXAMINE>
		     <EQUAL? ,HERE ,CELL ,NORTH-CORRIDOR>
		     <IN? ,DUNGEON-MASTER ,PARAPET>>
		<TELL "Le maître du donjon se tient sur le parapet." CR>)
	       (T <TELL "Le maître du donjon n'est pas là." CR>)>>

<GLOBAL DM-SEEN <>>

<ROUTINE BEHIND-DOOR-F ("OPTIONAL" (RARG <>))
         <COND (<AND <==? .RARG ,M-ENTER> <NOT ,DM-SEEN>>
		<ENABLE <QUEUE I-FOLIN -1>>
		<SETG DM-SEEN T>)
	       (<==? .RARG ,M-LOOK>
		<TELL
"Vous êtes dans un étroit couloir nord-sud. À l'extrémité sud est une porte et à l'extrémité nord est un couloir est-ouest.">
		<DPR ,DUNGEON-DOOR>)>>

<ROUTINE FRONT-DOOR-F ("OPTIONAL" (RARG <>))
    	 <COND (<==? .RARG ,M-ENTER>
		<QUEUE I-FOLIN 0>)
	       (<==? .RARG ,M-LOOK>
		<LOOK-TO <> ,MRD>
		<TELL
"La porte en bois a un panneau barré dedans à environ la hauteur de la tête.">
	        <DPR ,DUNGEON-DOOR>)>>

<ROUTINE LOOK-LIKE-DM? ()
	 <AND <IN? ,CLOAK ,WINNER>
	      <IN? ,HOOD ,WINNER>
	      <IN? ,AMULET ,WINNER>
	      <IN? ,STAFF ,WINNER>
	      <IN? ,RING ,WINNER>
	      <IN? ,LORE-BOOK ,WINNER>
	      <IN? ,KEY ,WINNER>>>

<ROUTINE DUNGEON-PANEL-F ()
	 <COND (<VERB? OPEN>
		<TELL "Vous ne pouvez pas ouvrir le panneau. Il est placé dans la porte." CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL "Il n'y a pas grand chose à voir." CR>)>>

<ROUTINE DUNGEON-DOOR-F ()
    	 <COND (<VERB? OPEN CLOSE>
		<TELL "La porte ne bouge pas." CR>)
	       (<AND <VERB? KNOCK> <EQUAL? ,HERE ,FRONT-DOOR>>
		<TELL
"Pendant un certain temps, il semble qu'il n'y aura pas de réponse. Alors vous entendez quelqu'un déverrouiller le petit panneau. Par les barres de la grande porte, le visage ridé d'un vieil homme apparaît.">
		<COND (,INVIS
		       <TELL "Il ne semble pas vous remarquer un instant, puis se rétablit.">)>
		<COND (<LOOK-LIKE-DM?>
		       <TELL " Il sourit largement et ouvre sans bruit la porte massive. Le vieil homme vous fait signe, et vous vous sentez attiré vers lui.|
\"Je suis le Maître du Donjon !\" tonne-t-il. \"Je vous ai observé attentivement tout au long de votre voyage dans le Grand Empire Souterrain. Oui !\" reprend-il, comme s'il se remémorait une époque presque oubliée, \"nous nous sommes déjà rencontrés, même si mon apparence était alors différente.\" Vous scrutez son visage profondément ridé et y reconnaissez les traits du vieil homme près de la porte secrète, de votre \"ami\" de la falaise et de la silhouette encapuchonnée. \"Vous avez témoigné de la bonté au vieil homme et de la compassion envers l'homme encapuchonné. Vous avez fait preuve de patience dans l'énigme et de confiance à la falaise. Vous avez démontré votre force, votre ingéniosité et votre courage. Une ultime épreuve vous attend toutefois. À présent ! Donnez-moi vos ordres et achevez votre quête !\"|" CR>
		       <GOTO ,BEHIND-DOOR>
		       <SETG IN-DUNGEON T>)
		      (T
		       <TELL "Il vous regarde avec un regard perçant, puis il parle profondément.">
		       <TELL <GET ,DM-REASONS <DMISH>>>
		       <TELL "Je resterai ici. Quand vous sentirez que vous êtes prêt, allez à la porte secrète et dites \"FROTZ OZMOO\"! Allez, maintenant!\" Il remue le doigt en avertissement. \"N'oubliez pas les doubles citations!\" Un moment plus tard, vous vous retrouvez dans la salle des boutons." CR>
		       <GOTO ,MR-ANTE <>>
		       <RTRUE>)>)>>

<GLOBAL IN-DUNGEON <>>

<GLOBAL DM-REASONS <TABLE
"mais je crains que mon attente ne soit vaine."
"mais vous avez beaucoup à parcourir avant d'y parvenir. prêt."
"et vous semblez avoir fait de légers progrès."
"et votre voyage est à moitié terminé. Soyez de bonne humeur !"
"et vous approchez de la fin de votre longue quête !"
"et vous ne tarderez pas à être prêt !"
"et vous êtes presque prêt pour le dernier test !">>

<ROUTINE DMISH ("AUX" (CNT 0))
	 <COND (<IN? ,AMULET ,WINNER> <SET CNT <+ .CNT 1>>)>
	 <COND (<IN? ,LORE-BOOK ,WINNER> <SET CNT <+ .CNT 1>>)>
	 <COND (<IN? ,HOOD ,WINNER> <SET CNT <+ .CNT 1>>)>
	 <COND (<IN? ,CLOAK ,WINNER> <SET CNT <+ .CNT 1>>)>
	 <COND (<IN? ,RING ,WINNER> <SET CNT <+ .CNT 1>>)>
	 <COND (<IN? ,KEY ,WINNER> <SET CNT <+ .CNT 1>>)>
	 <COND (<IN? ,STAFF ,WINNER> <SET CNT <+ .CNT 1>>)>
	 .CNT>
	
<GLOBAL FOLFLAG T>	;"Following?"

<ROUTINE I-FOLIN ()
	 <COND (<IN? ,DUNGEON-MASTER ,HERE> <RFALSE>)
	       (<AND <EQUAL? ,HERE ,PRISON-CELL ,CELL> ,FOLFLAG>
		<TELL
"Vous remarquez que le maître du donjon ne vous suit pas." CR>
		<SETG FOLFLAG <>>
		<RTRUE>)
	       (<EQUAL? <LOC ,PLAYER> ,PRISON-CELL ,CELL> <RFALSE>)
	       (<NOT ,FOLFLAG>
		<SETG FOLFLAG T>
		<TELL "Le Maître du Donjon vous rejoint." CR>
		<MOVE ,DUNGEON-MASTER ,HERE>
		<RTRUE>)
	       (T
		<TELL "Le maître du donjon vous suit." CR>
		<MOVE ,DUNGEON-MASTER ,HERE>
		<RTRUE>)>>

\

;"SUBTITLE
 'The end had come, and this was it; he dropped her in the Flaming Pit.'"

<GLOBAL LCELL 1> ;"cell in slot"

<GLOBAL PNUMB 1> ;"cell pointed at"

<GLOBAL CELLOBJS <ITABLE NONE <* 8 2 8>>>

<ROUTINE MOVE-CELL-OBJECTS ("AUX" TOP CNT F X)
	 <SET TOP <* 8 <- ,LCELL 1>>>
	 <SET CNT <+ .TOP 1>>
	 <SET F <FIRST? ,CELL>>
	 <COND (.F
		<REPEAT ()
			<SET X <NEXT? .F>>
			<COND (<NOT .F> <RETURN>)
			      (T
			       <PUT ,CELLOBJS .CNT .F>
			       <REMOVE .F>
			       <SET CNT <+ .CNT 1>>)>
			<COND (<NOT .X> <RETURN>)
			      (T <SET F .X>)>>)>
	 <PUT ,CELLOBJS .TOP <- <- .CNT .TOP> 1>>
	 <SET TOP <* 8 <- ,PNUMB 1>>>
	 <SET CNT <GET ,CELLOBJS .TOP>>
	 <REPEAT ()
		 <COND (<0? .CNT> <RETURN>)
		       (T
			<SET TOP <+ .TOP 1>>
			<MOVE <GET ,CELLOBJS .TOP> ,CELL>
			<SET CNT <- .CNT 1>>)>>>

<ROUTINE CELL-MOVE ("AUX" F X)
	 <FCLEAR ,CELL-DOOR ,OPENBIT>
	 <FCLEAR ,BRONZE-DOOR ,OPENBIT>
	 <COND (<NOT <==? ,PNUMB ,LCELL>>
	        <COND (<==? ,PNUMB 4> <FCLEAR ,BRONZE-DOOR ,INVISIBLE>)
		      (ELSE <FSET ,BRONZE-DOOR ,INVISIBLE>)>
	        <COND (<IN? ,PLAYER ,CELL>
		       <SETG WINNER ,PLAYER>
		       <FCLEAR ,GOOD-CELL ,TOUCHBIT>
		       <FCLEAR ,PRISON-CELL ,TOUCHBIT>
		       <GOTO <COND (<==? ,LCELL 4>
				    <FCLEAR ,BRONZE-DOOR ,INVISIBLE>
				    ,GOOD-CELL)
				   (ELSE ,PRISON-CELL)>>
		       <SET F <FIRST? ,CELL>>
		       <COND (.F
			      <REPEAT ()
				      <SET X <NEXT? .F>>
				      <COND (<NOT .F> <RETURN>)
					    (T <MOVE .F ,HERE>)>
				      <COND (<NOT .X> <RETURN>)
					    (T <SET F .X>)>>)>)
		      (T <MOVE-CELL-OBJECTS>)>
	        <SETG LCELL ,PNUMB>)>>

<ROUTINE PARAPET-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
	        <TELL
"Vous êtes debout derrière un mur de soutènement de pierre qui borde un parapet surplombant une fosse ardente. Il est difficile de voir à travers la fumée et la flamme qui remplit la fosse, mais il semble être sans fond. La fosse elle-même est circulaire, environ deux cents pieds de diamètre, et est façonnée de pierre grossièrement taillée. Les flammes génèrent une chaleur considérable, donc il est plutôt inconfortable de se tenir ici.| Il y a un objet ici qui ressemble à un cadran solaire. Sur il est une flèche indicateur entourant un grand bouton. Sur la face du cadran sont les numéros 1 à 8."
N ,PNUMB "." CR>
		<TELL
"Au sud, à travers un couloir étroit, se trouve une cellule de prison." CR>)>>

<ROUTINE DIAL ("AUX" N)
	 <COND (<VERB? EXAMINE>
		<TELL "Le cadran indique " N ,PNUMB "." CR>)
	       (<VERB? TURN>
	        <COND (<==? ,PRSI ,INTNUM>
		       <COND (<OR <0? ,P-NUMBER>
				  <G? ,P-NUMBER 8>>
			      <TELL "Un tel réglage n'existe pas." CR>
			      <RTRUE>)>
		       <SETG PNUMB ,P-NUMBER>
		       <COND (<==? ,WINNER ,PLAYER>
			      <TELL
"Le cadran pointe maintenant vers " N ,PNUMB "." CR>)>
		       <RTRUE>)
		      (<NOT ,PRSI>
		       <TELL "Vous devez spécifier ce que vous souhaitez régler. à." CR>)
		      (T <TELL "Le cadran ne contient que des chiffres." CR>)>)
	       (<VERB? SPIN>
	        <SETG PNUMB <RANDOM 8>>
	        <COND (<==? ,WINNER ,PLAYER>
		       <TELL
"Le cadran tourne et s'arrête en pointant vers " N ,PNUMB ".">)>
		<RTRUE>)>>

<ROUTINE DIALBUTTON ("AUX" C)
	 <SET C <FSET? ,CELL-DOOR ,OPENBIT>>
	 <FCLEAR ,CELL ,TOUCHBIT>
	 <COND (<VERB? PUSH>
	        <COND (<==? ,WINNER ,PLAYER>
		       <TELL
"Le bouton s'enfonce avec un léger clic, et réapparaît." CR>)>
		<CELL-MOVE>
		<COND (.C <TELL
"Vous remarquez que la porte de la cellule est maintenant fermée." CR>)>
		<RTRUE>)>>

<ROUTINE CELL-ROOM (RARG)
         <COND (<==? .RARG ,M-LOOK>
	        <TELL
"Vous êtes dans une cellule de prison sans particularité. Vous pouvez voir ">
		<COND (<FSET? ,CELL-DOOR ,OPENBIT>
		       <TELL "Un couloir est-ouest à l'extérieur de la porte de la cellule. Votre vue prend aussi dans le parapet et une grande fosse ardente." CR>)
		      (T
		       <TELL "par la petite fenêtre dans la porte fermée le parapet, et, derrière cela, la fumée et les flammes se lèvent d'une fosse ardente." CR>)>
		<COND (<IN? ,DUNGEON-MASTER ,PARAPET>
		       <TELL
"Le maître du donjon est au parapet, appuyé sur son bâton. Son regard aigu est fixé sur vous et il semble tendu, comme s'il attendait quelque chose." CR>)> 
	        <COND (<==? ,LCELL 4>
		       <TELL
"Derrière vous, au sud, se trouve une porte en bronze qui est ">
		       <DPR ,BRONZE-DOOR>)>
		<RTRUE>)>>
		
<ROUTINE NCELL-ROOM (RARG)
         <COND (<==? .RARG ,M-LOOK>
	        <TELL
"Vous êtes dans une cellule de prison nue. Sa porte en bois est solidement attachée, et vous ne pouvez voir que des flammes et de la fumée à travers sa petite fenêtre.">
	        <DPR ,BRONZE-DOOR>)>>

<ROUTINE DPR (OBJ)
	 <COND (<FSET? .OBJ ,OPENBIT> <TELL "ouvert." CR>)
	       (T <TELL "fermé." CR>)>>

<ROUTINE NORTH-CORRIDOR-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
	        <TELL
"Il s'agit d'un large couloir est-ouest qui s'ouvre sur un parapet nord à son centre. Vous pouvez voir des flammes et de la fumée en regardant vers le parapet. Le couloir tourne vers le sud à chaque extrémité, et au centre du mur sud est une lourde porte en bois avec une petite fenêtre barrée.">
		<DPR ,CELL-DOOR>)>>

<ROUTINE SOUTH-CORRIDOR-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
	        <TELL
"Vous êtes dans un couloir est-ouest qui tourne au nord à ses extrémités est et ouest. Les murs sont faits du marbre le plus beau. Une autre salle mène au sud au centre du couloir." CR>
	       <COND (<==? ,LCELL 4>
		      <TELL
"Au centre du mur nord se trouve une porte en bronze qui est ">
		      <DPR ,BRONZE-DOOR>)>
	       <RTRUE>)>>

<GLOBAL BRONZE-DOOR-LOCKED T>

<ROUTINE BRONZE-DOOR-F ()
	 <COND (<AND <VERB? OPEN>
		     <NOT <FSET? ,BRONZE-DOOR ,OPENBIT>>
		     <==? ,HERE ,GOOD-CELL>
		     <NOT ,BRONZE-DOOR-LOCKED>>
		<TELL
"De l'autre côté de la porte en bronze est un passage étroit qui s'ouvre dans une zone plus grande." CR>
		<FSET ,BRONZE-DOOR ,OPENBIT>)
	       (<AND <VERB? OPEN> ,BRONZE-DOOR-LOCKED>
		<TELL
"La porte en bronze est verrouillée." CR>)>>

<ROUTINE LOCKED-DOOR-F ()
	 <COND (<VERB? OPEN UNLOCK>
	        <TELL "La porte est solidement fermée." CR>)>>

\

"========== Le gain ultime =========="

<ROUTINE NIRVANA-F (RARG)
	 <COND (<==? .RARG ,M-END>
	        <TELL
"Alors que vous contemplez les richesses nouvellement acquises, le Maître du Donjon se matérialise à vos côtés et déclare : \"Maintenant que vous avez percé tous les mystères du Donjon, le moment est venu de prendre la place qui vous revient de droit dans l'ordre des choses. J'ai longtemps attendu un être capable de me libérer de mon fardeau !\" Il vous touche doucement la tête de son bâton en murmurant quelques incantations soigneusement choisies ; vous vous sentez changer, vieillir et vous voûter. Pendant un instant, deux mages identiques se tiennent parmi les trésors, puis votre double se dissout en brume et disparaît, un sourire sardonique aux lèvres.|
|
Pendant un instant, vous êtes soulagé, certain d'avoir enfin achevé votre quête dans ZORK. Vous sentez en vous les vastes pouvoirs et le savoir désormais à votre disposition, et brûlez de trouver une occasion de vous en servir.|
|
">
	       <FINISH>)>>

<ROUTINE BRONZE-DOOR-EXIT ()
	 <COND (<FSET? ,BRONZE-DOOR ,INVISIBLE>
		<TELL "Vous ne pouvez pas aller jusque là. chemin." CR>
		<RFALSE>)
	       (<FSET? ,BRONZE-DOOR ,OPENBIT>
		,CELL)
	       (T
		<TELL "La porte en bronze est fermée." CR>
		<RFALSE>)>>

;<ROUTINE MASTER-F ()
	 <PERFORM ,PRSA ,DUNGEON-MASTER>
	 <RTRUE>>

<GLOBAL OLD-MAN-GONE <>>
<GLOBAL OLD-MAN-FED <>>

<GLOBAL SECRET-DOOR-DESC
"Au-delà de la porte secrète sont sombres, interdisant les escaliers menant à un passage en dessous.">

<ROUTINE SECRET-DOOR-F ()
	 <COND (<AND <VERB? OPEN> <NOT <FSET? ,SECRET-DOOR ,OPENBIT>>>
		<TELL "La porte massive en pierre s'ouvre sans bruit. "
		      ,SECRET-DOOR-DESC CR>
		<FSET ,SECRET-DOOR ,OPENBIT>)>>

<ROUTINE MSTAIRS-F (RARG)
	 <COND (<AND <==? .RARG ,M-ENTER>
		     <PROB 30>
		     <NOT ,OLD-MAN-FED>
		     <NOT ,OLD-MAN-GONE>>
		<MOVE ,OLD-MAN ,HERE>)
	       (<==? .RARG ,M-LOOK>
		<TELL
"Vous êtes dans une pièce avec des passages en direction sud-ouest et sud-est. Le mur nord est orné, rempli de runes étranges et d'écriture dans une langue inconnue." CR>
		<COND (<FSET? ,SECRET-DOOR ,OPENBIT>
		       <TELL ,SECRET-DOOR-DESC CR>)
		      (<NOT <FSET? ,SECRET-DOOR ,INVISIBLE>>
		       <TELL
"Le contour d'une porte est à peine visible parmi les runes." CR>)>)>>

<ROUTINE HELLO? (WHO)
	 <COND (<OR <==? ,WINNER .WHO>
		    <VERB? TELL ANSWER REPLY SAY HELLO INCANT>>
		<COND (<VERB? TELL ANSWER SAY INCANT REPLY>
		       <SETG P-CONT <>>
		       <SETG QUOTE-FLAG <>>)>
		<RTRUE>)>>

<ROUTINE OLD-MAN-F ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-OBJDESC>
		<COND (,OLD-MAN-AWAKE
		       <TELL
"Il y a un vieil homme dans le coin, qui vous regarde prudemment." CR>)
		      (T
		       <TELL
"Un vieil homme sournois est enroulé, endormi, dans le coin. Il ronfle fort, et semble assez faible et fragile." CR>)>)
	       (<AND <VERB? GIVE> <==? ,PRSI ,OLD-MAN>>
		<COND (,OLD-MAN-AWAKE
		       <COND (<==? ,PRSO ,WAYBREAD>
			      <REMOVE ,WAYBREAD>
			      <TELL
"Il vous regarde et prend le pain. Lentement, il mange le pain et s'arrête quand il est fini. Il commence à dire: «Peut-être que ce que vous cherchez est par là!» Il pointe au mur sculpté au nord, où vous remarquez maintenant le contour nu d'une porte secrète. Quand vous tournez en arrière, le vieil homme est parti!" CR>
			      <FCLEAR ,SECRET-DOOR ,INVISIBLE>
			      <SETG OLD-MAN-GONE T>
			      <REMOVE ,OLD-MAN>)
			     (<IN? ,WAYBREAD ,WINNER>
			      <TELL
"Il refuse votre offre, mais les mouvements du bras vers le pain dans votre main." CR>)
			     (T
			      <TELL
"Le vieil homme refuse le " D ,PRSO " d'un geste de la main." CR>)>)
		      (T <TELL "Il est endormi !" CR>)>)
	       (<VERB? EXAMINE>
		<COND (,OLD-MAN-AWAKE
		       <TELL
"Le vieil homme est à peine réveillé et semble se détacher chaque instant. Il a des yeux brillants, qui semblent voir à travers votre corps." CR>)
		      (T
		       <TELL
"L'homme est très, très vieux et wizened. Il a une longue barbe à cordes et ronfle assez fort." CR>)>)
	       (<VERB? LISTEN>
		<COND (,OLD-MAN-AWAKE <TELL "Il ne parle pas." CR>)
		      (T
		       <TELL
"Il ronfle comme une scie circulaire." CR>)>)
	       (<HELLO? ,OLD-MAN>
		<COND (,OLD-MAN-AWAKE
		       <TELL
"Il vous fait un signe de tête sans avoir l'air d'avoir compris." CR>)
		      (T
		       <TELL
"Il dort profondément et ne répond pas." CR>)>)
	       (<VERB? SHAKE ALARM>
		<TELL
"Le vieil homme est éveillé à la conscience. Il s'attache à vous à travers des yeux qui semblent beaucoup plus jeunes et plus forts que son corps fragile et attend, comme s'il attendait quelque chose." CR>
		<SETG OLD-MAN-AWAKE T>
		<ENABLE <QUEUE I-OLD-MAN-SLEEPS 3>>)
	       (<VERB? ATTACK MUNG>
		<TELL
"L'attaque semble avoir laissé le vieil homme indemne! Vous regardez dans l'admiration comme il s'élève à ses pieds et semble tourner au-dessus de vous. Il appréhende, puis tristement et lamentablement. \"Pas encore,\" il pleure, et disparaît dans une bouffée de fumée." CR>
		<SETG OLD-MAN-GONE T>
		<REMOVE ,OLD-MAN>)>>

<GLOBAL OLD-MAN-AWAKE <>>

<ROUTINE I-OLD-MAN-SLEEPS ()
	 <SETG OLD-MAN-AWAKE <>>
	 <COND (<IN? ,OLD-MAN ,HERE>
		<TELL "Vous remarquez que le vieil homme s'est endormi." CR>)>>

<ROUTINE RUNES-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL
"Les runes sont dans une langue ancienne. Certaines images parmi les runes représentent des flammes, des statues de pierre, et un vieil homme." CR>)>>

<ROUTINE T-BAR-F ()
	 <COND (<VERB? TURN>
		<TELL
"Vous n'avez pas assez d'effet de levier pour tourner la barre en T. Vous pourriez être capable de tourner toute la structure, cependant." CR>)>>

<ROUTINE FLAMING-PIT-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"La fosse enflammée est un abîme apparemment sans fond rempli de fumée et de flamme." CR>)
	       (<AND <VERB? PUT> <==? ,PRSI ,FLAMING-PIT>>
		<COND (<EQUAL? ,HERE ,PARAPET ,NORTH-CORRIDOR>
		       <COND (<==? ,PRSO ,ME>
			      <TELL
"Ce serait dommage de mettre fin à vos jours si près de la fin de votre quête !" CR>)
			     (T
			      <TELL
"Vous lancez le " D ,PRSO " dans la fosse, là où il se trouve. perdu à jamais." CR>
			      <REMOVE ,PRSO>)>)
		      (T <TELL "Vous n'êtes pas assez près." CR>)>)>>

<ROUTINE PARAPET-OBJ-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<EQUAL? ,HERE ,CELL ,NORTH-CORRIDOR>
		       <TELL
"Vous pouvez voir le parapet et le cadran solaire d'ici.">
		       <COND (<IN? ,DUNGEON-MASTER ,PARAPET>
			      <TELL "Le maître du donjon est là aussi, appuyé sur son bâton.">)>
		       <CRLF>)
		      (T <V-LOOK>)>)>>

<ROUTINE ROSE-F ()
	  <COND (<VERB? TURN MOVE>
		 <TELL
"La rose boussole est faite de pierre et est incrustée dans le sol. Vous ne pourriez pas le tourner ou le déplacer." CR>)>>

<ROUTINE CELL-DOOR-F ()
	 <COND (<AND <VERB? PUT> <==? ,PRSI ,CELL-DOOR>>
		<TELL "Vous devrez d'abord entrer dans la cellule." CR>)
	       (<VERB? THROUGH>
		<COND (<==? ,HERE ,CELL>
		       <TELL "Regardez autour." CR>)
		      (T
		       <DO-WALK ,P?SOUTH>
		       <RTRUE>)>)>>

<ROUTINE LORE-BOOK-F ()
	 <COND (<AND <VERB? BURN> <NOT <IN? ,LORE-BOOK ,WINNER>>>
		<TELL
"Le livre est consumé dans un affichage éblouissant de couleur." CR>
		<REMOVE ,PRSO>
		<RTRUE>)
	       (<AND ,IN-DUNGEON <VERB? OPEN EXAMINE READ>>
		<TELL
"Le livre semble s'ouvrir à une page spécifique. Il montre une image de huit petites pièces situées autour d'un grand cercle de flamme. Toutes sont identiques sauf une, qui a une porte en bronze menant à une pièce baignée de lumière dorée. Une légende sous l'image dit \"Le Donjon et Trésor de Zork.\"" CR>)
	       (<VERB? OPEN>
		<TELL
"Le livre peut être parcouru mais ne peut pas être laissé ouvert." CR>)>>

<ROUTINE CP-HOLE-F ()
	 <COND (<VERB? THROUGH>
		<DO-WALK ,P?DOWN>
		<RTRUE>)>>

<ROUTINE TORCH-PSEUDO ()
	 <TELL "Les torches sont épuisées. atteindre." CR>>

<ROUTINE WATER-FCN ("AUX" AV PI?)
	 #DECL ((AV) <OR OBJECT FALSE> (PI?) <OR ATOM FALSE>)
	 <COND (<VERB? SGIVE> <RFALSE>)
	       (<VERB? THROUGH>
		<PERFORM ,V?SWIM ,PRSO>
		<RTRUE>)
	       (<VERB? FILL>	;"fill bottle with water =>"
		<SETG PRSA ,V?PUT>
		<SETG PRSI ,PRSO>
		<SETG PRSO ,GLOBAL-WATER>
		<SET PI? <>>)
	       (<EQUAL? ,PRSO ,GLOBAL-WATER>
		<SET PI? <>>)
	       (,PRSI
		<SET PI? T>)>
	 <COND (.PI? <SETG PRSI ,GLOBAL-WATER>)
	       (T <SETG PRSO ,GLOBAL-WATER>)>
	 <COND (<AND <VERB? TAKE PUT> <NOT .PI?>>
		<TELL "L'eau glisse à travers votre doigts." CR>)
	       (.PI? <TELL "Vous ne pouvez pas faire ça." CR>)
	       (<VERB? DROP GIVE THROW>
		<TELL "Vous n'avez pas d'eau." CR>)>>

<ROUTINE RANDOM-WALL ()
	 <COND (<VERB? PUSH>
		<COND (<==? ,HERE ,IN-MIRROR>
		       <TELL
"Vous devez spécifier le panneau que vous souhaitez pousser." CR>)
		      (T <TELL
"Vous ne pouvez pas le déplacer ; du moins d'ici." CR>)>)>>

^/L

;"special-cased routines"

;"put GO here, eventually"

<ROUTINE V-DIAGNOSE ()
	 <TELL <GET ,DIAG ,P-STRENGTH> CR>>

<GLOBAL DIAG <TABLE
"Vous êtes mort."
"Vous êtes très grièvement blessé. Une blessure supplémentaire vous tuerait très probablement."
"Vous êtes assez grièvement blessé. Une blessure majeure vous tuerait probablement."
"Vous avez quelques blessures, qui n'altèrent pas sérieusement votre force."
"Vous êtes légèrement blessé. Vous avez beaucoup de force en réserve."
"Vous êtes en parfait santé.">>

<ROUTINE JIGS-UP (DESC "OPTIONAL" (PLAYER? <>))
 	 #DECL ((DESC) STRING (PLAYER?) <OR ATOM FALSE>)
 	 <SETG SWORD-STATE 0>
	 <SETG P-STRENGTH 5>
	 <SETG S-STRENGTH 5>
	 <TELL .DESC CR>
	 <COND (<NOT <==? ,YEAR ,YEAR-PRESENT>> <QUIT>)>
	 <COND (<NOT <==? ,ADVENTURER ,WINNER>>
		<TELL "
| **** Le " D ,WINNER "est mort **** | |">
		<REMOVE ,WINNER>
		<SETG WINNER ,ADVENTURER>
		<SETG HERE <LOC ,WINNER>>
		<RFATAL>)>
	 <TELL "| **** Vous êtes mort ****| |">
	 <COND (<G? <SETG DEATHS <+ ,DEATHS 1>> 3>
		<TELL
"Vous vous sentez désincarné dans une profonde noirceur. Une voix du vide dit: «J'ai attendu longtemps pour vous, mon ami, mais peut-être que c'est une autre que je cherchais. Bonne nuit, oh digne aventurier!» C'est la dernière que vous entendez." CR>
		<QUIT>)
	       (T
		<TELL
"Vous vous retrouvez dans les profondeurs de la terre, au fond d'une cellule nue. Par la fenêtre barrée de fer, vous apercevez une immense fosse embrasée. Les flammes jaillissent et manquent de peu de vous brûler vif. Au bout d'un moment, des pas retentissent au loin, puis se rapprochent... La porte pivote, laissant entrer un vieil homme.|
|
Il est simplement vêtu d'une capuche et d'une cape. Il porte une amulette et une bague, tient un vieux livre sous un bras et s'appuie sur un bâton de bois. Une unique clé, qui semble ouvrir une immense cellule, pend à sa ceinture.|
|
Il lève son bâton vers vous et vous l'entendez parler comme dans un rêve : \"Je vous attends, même si votre voyage sera long et périlleux. Allez, et ne me faites pas attendre trop longtemps !\" Vous sentez une force immense monter en vous et vous tombez au sol. L'instant suivant, vous vous réveillez comme après un profond sommeil." CR>)>
	 <MOVE ,CURRENT-LAMP ,ZORK2-STAIR>
	 <COND (<AND <IN? ,KEY ,WINNER>
		     <OR <EQUAL? ,HERE ,DARK-1 ,DARK-2 ,KEY-ROOM>
			 <EQUAL? ,HERE ,AQ-1 ,AQ-2>>>
		<MOVE ,KEY ,KEY-ROOM>)>
	 <CRLF>
	 <GOTO ,ZORK2-STAIR>
	 <SETG P-CONT <>>
	 <RANDOMIZE-OBJECTS>
	 <KILL-INTERRUPTS>
	 <RFATAL>>

<ROUTINE RANDOMIZE-OBJECTS ("AUX" (R <>) F N L)
	 <SET N <FIRST? ,WINNER>>
	 <REPEAT ()
		 <SET F .N>
		 <COND (<NOT .F> <RETURN>)>
		 <SET N <NEXT? .F>>
		 <MOVE .F <RANDOM-ELEMENT ,DEAD-OBJ-LOCS>>>>

<GLOBAL DEAD-OBJ-LOCS
	<LTABLE JUNCTION CLEARING DAMP-PASSAGE CREEPY-CRAWL TIGHT-SQUEEZE
		FOGGY-ROOM DEAD-END>>

<ROUTINE KILL-INTERRUPTS ()
	 <DISABLE <INT I-MAN-LEAVES>>
	 <DISABLE <INT I-MAN-RETURNS>>
	 <DISABLE <INT I-VIEW-SNAP>>
	 <DISABLE <INT I-FOLIN>>
	 <RTRUE>>

<GLOBAL SCORE-MAX 7>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
	 #DECL ((ASK?) <OR ATOM FALSE>)
	 <TELL "Potentiel : " N ,SCORE>
	 <TELL " sur " N ,SCORE-MAX ", après ">
	 <TELL N ,MOVES>
	 <COND (<1? ,MOVES> <TELL " coup.">) (ELSE <TELL " coups.">)>
	 <CRLF>
	 ,SCORE>

\

"vieux TM.ZIL"

"Time Machine incroyablement bizarre Problème"

<OBJECT VOICES
	(IN GLOBAL-OBJECTS)
	(DESC "voix")
	(SYNONYM VOICE VOICES GUARDS OFFICI)
	(ADJECTIVE ARMED)
	(FLAGS NDESCBIT)
	(ACTION VOICES-F)>

<ROOM TIGHT-SQUEEZE
      (IN ROOMS)
      (DESC "Pression serrée")
      (LDESC
"Il s'agit d'un passage très bas et étroit menant à l'est vers ouest.")
      (WEST TO CREEPY-CRAWL)
      (EAST TO ROCKY-ROOM)
      (FLAGS RLANDBIT)>

<ROOM ROCKY-ROOM
      (IN ROOMS)
      (DESC "Grotte de cristal")
      (LDESC
"C'est une chambre d'une beauté à couper le souffle. De puissantes stalagmites forment des formations rocheuses incrustées cristallines. Les mousses phosphorescentes, alimentées par un filet d'eau d'en haut, font briller les cristaux de toutes les couleurs de l'arc-en-ciel.")
      (SOUTH TO WIDE-HALL)
      (WEST TO TIGHT-SQUEEZE)
      (GLOBAL MOSS CRYSTALS)
      (FLAGS ONBIT RLANDBIT)>

<OBJECT CRYSTALS
	(IN ROCKY-ROOM)
	(DESC "structure rocheuse")
	(SYNONYM CRYSTAL STALAG)
	(FLAGS NDESCBIT)>

<ROOM WIDE-HALL
      (IN ROOMS)
      (DESC "Salle royale")
      (LDESC
"C'est l'extrémité nord d'une grande salle avec un plafond voûté. Un long couloir carrelé mène au nord à travers une grande arche. Bien que l'objet de cette salle est peu clair, il ya un grand rendu du sceau royal de Seigneur Nigaud Tête-Plate sculpté sur le mur.")
      (NORTH TO ROCKY-ROOM)
      (SOUTH TO MUSEUM-ANTE)
      (FLAGS RLANDBIT)>     

<OBJECT ROYAL-SEAL
	(IN WIDE-HALL)
	(DESC "Sceau royal de Nigaud Tête-Plate")
	(SYNONYM SEAL CARVIN RENDER)
	(ADJECTIVE LARGE ROYAL)
	(FLAGS NDESCBIT READBIT)
	(TEXT
"Le Sceau est vintage Tête-Plate, avec des signes d'excès presque partout. Il montre une curieuse figure à tête plate portant une couronne gaudée, entourée des bijoux de la Couronne de l'Empire.")> 

<ROOM MUSEUM-ANTE
      (IN ROOMS)
      (DESC "Grande porte")
      (NORTH TO WIDE-HALL)
      (EAST TO MUSEUM-ENTRANCE
       	    IF CLEFT-FLAG ELSE "La grande porte en fer est fermée par rouille.")
      (FLAGS RLANDBIT)
      (ACTION MUSEUM-ANTE-F)
      (GLOBAL IRON-DOOR CLEFT)>

<ROOM MUSEUM-ENTRANCE
      (IN ROOMS)
      (DESC "Musée Entrée")
      (EAST TO JEWEL-ROOM IF JEWEL-DOOR IS OPEN)
      (WEST TO MUSEUM-ANTE IF CLEFT-FLAG ELSE "La porte en fer est fermée par rouille.")
      (SOUTH TO CP-ANTE)
      (DOWN TO CP-ANTE)
      (NORTH TO TECH-MUSEUM IF WOODEN-DOOR IS OPEN)
      (FLAGS ONBIT RLANDBIT)
      (ACTION MUSEUM-ENTRANCE-F)
      (GLOBAL IRON-DOOR JEWEL-DOOR WOODEN-DOOR STAIRS CLEFT)>

<OBJECT CLEFT
	(IN LOCAL-GLOBALS)
	(DESC "crevasse")
	(SYNONYM CLEFT)
	(ACTION CLEFT-F)
	(FLAGS DOORBIT OPENBIT INVISIBLE)>

<ROOM JEWEL-ROOM
      (IN ROOMS)
      (DESC "Bijou Salle")
      (WEST TO MUSEUM-ENTRANCE IF JEWEL-DOOR IS OPEN)
      (OUT TO MUSEUM-ENTRANCE IF JEWEL-DOOR IS OPEN)
      (FLAGS ONBIT RLANDBIT)
      (ACTION JEWEL-ROOM-F)
      (GLOBAL JEWEL-DOOR)>

<ROOM TECH-MUSEUM
      (IN ROOMS)
      (DESC "Musée de la technologie")
      (SOUTH TO MUSEUM-ENTRANCE IF WOODEN-DOOR IS OPEN)
      (OUT TO MUSEUM-ENTRANCE IF WOODEN-DOOR IS OPEN)
      (FLAGS RLANDBIT ONBIT)
      (ACTION TECH-MUSEUM-F)
      (GLOBAL WOODEN-DOOR)>

<ROOM MID-CP-ANTE
      (IN ROOMS)
      (DESC "Puzzle Royal Entrée")
      (WEST TO MID-CP-OUT)
      (NORTH TO MID-MUSEUM-ENTRANCE)
      (UP TO MID-MUSEUM-ENTRANCE)
      (DOWN PER CPENTER)
      (FLAGS RLANDBIT ONBIT)
      (ACTION CPANT-ROOM)
      (GLOBAL STAIRS)>

<ROOM MID-CP-OUT
      (IN ROOMS)
      (DESC "Pièce latérale")
      (NORTH TO MID-CP-ANTE)
      (EAST "La porte en acier est fermée.")
      (FLAGS RLANDBIT ONBIT)
      (ACTION CPOUT-ROOM)
      (GLOBAL CPDOOR STAIRS)>

<ROOM MID-MUSEUM-ENTRANCE
      (IN ROOMS)
      (DESC "Musée Entrée")
      (EAST TO MID-JEWEL-ROOM IF JEWEL-DOOR IS OPEN)
      (WEST "La porte en fer est fermée par rouille.")
      (SOUTH TO MID-CP-ANTE)
      (DOWN TO MID-CP-ANTE)
      (NORTH TO MID-TECH-MUSEUM IF WOODEN-DOOR IS OPEN)
      (FLAGS ONBIT RLANDBIT)
      (ACTION MUSEUM-ENTRANCE-F)
      (GLOBAL IRON-DOOR JEWEL-DOOR WOODEN-DOOR STAIRS)>

<ROOM MID-JEWEL-ROOM
      (IN ROOMS)
      (DESC "Bijou Salle")
      (WEST TO MID-MUSEUM-ENTRANCE IF JEWEL-DOOR IS OPEN)
      (OUT TO MID-MUSEUM-ENTRANCE IF JEWEL-DOOR IS OPEN)
      (FLAGS ONBIT RLANDBIT)
      (ACTION JEWEL-ROOM-F)
      (GLOBAL JEWEL-DOOR)>

<ROOM MID-TECH-MUSEUM
      (IN ROOMS)
      (DESC "Musée de la technologie")
      (SOUTH TO MID-MUSEUM-ENTRANCE IF WOODEN-DOOR IS OPEN)
      (OUT TO MID-MUSEUM-ENTRANCE IF WOODEN-DOOR IS OPEN)
      (FLAGS RLANDBIT ONBIT)
      (ACTION TECH-MUSEUM-F)
      (GLOBAL WOODEN-DOOR)>

<ROOM OLD-TECH-MUSEUM
      (IN ROOMS)
      (DESC "Musée de la technologie")
      (FLAGS ONBIT RLANDBIT)
      (ACTION OLD-TECH-MUSEUM-F)
      (SOUTH TO OLD-MUSEUM-ENTRANCE IF WOODEN-DOOR IS OPEN)
      (OUT TO OLD-MUSEUM-ENTRANCE IF WOODEN-DOOR IS OPEN)
      (GLOBAL WOODEN-DOOR ROBOT)>

<ROOM OLD-JEWEL-ROOM
      (IN ROOMS)
      (DESC "Bijou Salle")
      (FLAGS ONBIT RLANDBIT)
      (ACTION OLD-TECH-MUSEUM-F)
      (WEST TO OLD-MUSEUM-ENTRANCE IF JEWEL-DOOR IS OPEN)
      (OUT TO OLD-MUSEUM-ENTRANCE IF JEWEL-DOOR IS OPEN)
      (GLOBAL JEWEL-DOOR ROBOT)>

<ROOM OLD-MUSEUM-ENTRANCE
      (IN ROOMS)
      (DESC "Musée Entrée")
      (FLAGS ONBIT RLANDBIT)
      (ACTION OLD-TECH-MUSEUM-F)
      (EAST TO OLD-JEWEL-ROOM IF JEWEL-DOOR IS OPEN)
      (WEST "Les gardes ont verrouillé la porte en fer derrière eux.")
      (NORTH TO OLD-TECH-MUSEUM IF WOODEN-DOOR IS OPEN)
      (SOUTH "Les escaliers aboutissent aveuglément au sud.")
      (GLOBAL WOODEN-DOOR JEWEL-DOOR IRON-DOOR ROBOT)>
     
<OBJECT TIME-MACHINE
	(IN TECH-MUSEUM)
	(DESC "machine à or")
	(SYNONYM MACHINE TEMPORIZER)
	(ADJECTIVE TIME GOLD GOLDEN)
	(FLAGS VEHBIT OPENBIT CONTBIT)
	(CAPACITY 100)
	(DESCFCN TIME-MACHINE-F)
	(ACTION TIME-MACHINE-F)>

<OBJECT PRESSURIZER
	(IN TECH-MUSEUM)
	(DESC "machine grise")
	(SYNONYM MACHINE DRYER PRESSURIZER)
	(ADJECTIVE GRAY GREY WASHING)
	(ACTION MUSEUM-PIECES)
	(DESCFCN MUSEUM-PIECES)>

<OBJECT SPINNER
	(IN TECH-MUSEUM)
	(DESC "machine noire")
	(SYNONYM MACHINE PIPES WIRES MOTORS)
	(ADJECTIVE BLACK)
	(DESCFCN MUSEUM-PIECES)
	(ACTION MUSEUM-PIECES)>

<OBJECT TM-BUTTON
	(IN TIME-MACHINE)
	(DESC "bouton")
	(SYNONYM BUTTON)
	(FLAGS NDESCBIT)
	(ACTION TM-BUTTON-F)>

<OBJECT TM-HOLLOW
	(IN TIME-MACHINE)
	(DESC "siège")
	(SYNONYM AREA)
	(ADJECTIVE SMALL HOLLOW)
	(FLAGS NDESCBIT OPENBIT CONTBIT)
	(CAPACITY 20)
	(ACTION TM-HOLLOW-F)>

<ROUTINE TM-HOLLOW-F ()
	 <COND (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,TM-HOLLOW>>
		<PERFORM ,V?PUT-UNDER ,PRSO ,TM-SEAT>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE>
		<PERFORM ,V?LOOK-UNDER ,TM-SEAT>
		<RTRUE>)
	       (<EQUAL? ,PRSO ,TM-HOLLOW>
		<PERFORM ,PRSA ,TM-SEAT ,PRSI>
		<RTRUE>)
	       (<EQUAL? ,PRSI ,TM-HOLLOW>
		<PERFORM ,PRSA ,PRSO ,TM-SEAT>
		<RTRUE>)>>

<OBJECT TM-SEAT
	(IN TIME-MACHINE)
	(DESC "siège")
	(SYNONYM SEAT CHAIR)
	(FLAGS NDESCBIT OPENBIT CONTBIT SURFACEBIT)
	(CAPACITY 20)
	(ACTION TM-SEAT-F)>

<OBJECT TM-DIAL
	(IN TIME-MACHINE)
	(DESC "cadran")
	(SYNONYM DIAL CONSOLE DISPLAY)
	(FLAGS NDESCBIT TURNBIT)
	(ACTION TM-DIAL-F)>

<OBJECT IRON-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "porte en fer")
	(SYNONYM DOOR)
	(ADJECTIVE IRON)
	(FLAGS DOORBIT CONTBIT)
	(ACTION IRON-DOOR-F)>

<OBJECT JEWEL-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "pierre porte")
	(SYNONYM DOOR)
	(ADJECTIVE STONE EAST)
	(ACTION JEWEL-DOOR-F)
	(FLAGS DOORBIT CONTBIT)>

<OBJECT WOODEN-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "en bois porte")
	(SYNONYM DOOR)
	(ADJECTIVE WOODEN WOOD NORTH)
	(FLAGS DOORBIT CONTBIT OPENBIT)
	(ACTION WOODEN-DOOR-F)>

<OBJECT SCEPTRE
	(IN PEDESTAL)
	(DESC "sceptre")
	(SYNONYM SCEPTRE JEWELS)
	(ADJECTIVE CROWN)
	(FLAGS TAKEBIT NDESCBIT TRYTAKEBIT)
	(SIZE 30)
	(ACTION CROWN-JEWELS-F)>

<OBJECT JEWELLED-KNIFE
	(IN PEDESTAL)
	(DESC "couteau bijou")
	(SYNONYM KNIFE JEWELS)
	(ADJECTIVE JEWELLED CROWN)
	(FLAGS TAKEBIT NDESCBIT TRYTAKEBIT)
	(SIZE 20)
	(ACTION CROWN-JEWELS-F)>

<OBJECT RING
	(IN PEDESTAL)
	(DESC "anneau doré")
	(SYNONYM RING JEWELS)
	(ADJECTIVE GOLDEN CROWN)
	(FLAGS TAKEBIT NDESCBIT TRYTAKEBIT WEARBIT)
	(SIZE 5)
	(ACTION CROWN-JEWELS-F)>

<OBJECT PEDESTAL
	(IN JEWEL-ROOM)
	(DESC "piédestal")
	(SYNONYM PEDESTAL)
	(FLAGS NDESCBIT OPENBIT CONTBIT SURFACEBIT)
	(CAPACITY 50)
	(ACTION PEDESTAL-F)>

<OBJECT CAGE
	(IN JEWEL-ROOM)
	(DESC "acier cage")
	(SYNONYM CAGE)
	(ADJECTIVE STEEL)
	(FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT)
	(CAPACITY 5)
	(ACTION CAGE-F)>

<OBJECT TECH-PLAQUE
	(IN TECH-MUSEUM)
	(DESC "plaque")
	(SYNONYM PLAQUE TEXT)
	(FLAGS NDESCBIT READBIT)
	(ACTION TECH-PLAQUE-F)>

<OBJECT PLAQUE
	(IN CAGE)
	(DESC "plaque de bronze")
	(SYNONYM PLAQUE TEXT)
	(ADJECTIVE BRONZE)
	(FLAGS NDESCBIT READBIT)
	(ACTION PLAQUE-F)>

;"The present year using the GUE calendar."

<GLOBAL MACHINE-DAMAGED <>>

<GLOBAL YEAR 948>

<CONSTANT YEAR-BUILT 776>

<CONSTANT YEAR-CAGED 777>

<GLOBAL YEAR-CLOSED 883>

<CONSTANT REAL-YEAR-CLOSED 883>

<CONSTANT YEAR-PRESENT 948>

<ROUTINE IRON-DOOR-F ()
	 <COND (<VERB? OPEN UNLOCK THROUGH>
	        <COND (<L? ,YEAR ,YEAR-PRESENT>
		       <TELL
"La porte en fer est verrouillée depuis le à l'extérieur." CR>)
		      (T
		       <TELL
"La porte en fer est rouillée et ne peut pas être ouverte." CR>)>)>>

<GLOBAL CLEFT-FLAG <>>

<ROUTINE I-CLEFT ()
	 <COND (<OR <EQUAL? ,HERE ,ZORK-IV ,ROOM-8 ,TIMBER-ROOM>
		    <EQUAL? ,HERE ,LOWER-SHAFT ,LADDER-BOTTOM ,LADDER-TOP>>
		<TELL
"Vous ressentez un léger tremblement de l'intérieur de la terre qui passe rapidement." CR>)
	       (T
		<TELL
"Il y a une grande secousse à l'intérieur de la terre. Le donjon entier secoue violemment et des débris lâches tombent de dessus vous." CR>)>
	 <COND (<==? ,HERE ,MUSEUM-ANTE>
		<TELL
"À l'est, près de la grande porte de fer, une brèche s'ouvre et dévoile un espace au-delà !" CR>)
	       (<==? ,HERE ,AQ-VIEW>
		<TELL
"Un des piliers géants soutenant l'aqueduc s'effondre dans un tas de fumée et de décombres !" CR>)
	       (<EQUAL? ,HERE ,AQ-2 ,AQ-3>
		<TELL
"Le canal sous vos pieds tremble. Ensuite, le canal jusqu'au ">
		<COND (<==? ,HERE ,AQ-2> <TELL "nord">)
		      (T <TELL "sud">)>
		<TELL " s'effondre et tombe dans le gouffre !" CR>)>
	 <SETG CLEFT-FLAG T>
	 <FCLEAR ,CLEFT ,INVISIBLE>
	 <SETG AQ-FLAG <>>
	 <RTRUE>>

<ROUTINE CLEFT-F ()
	 <COND (<NOT <==? ,YEAR ,YEAR-PRESENT>>
		<TELL "Il n'y a pas de fente ici." CR>)>>

<ROUTINE MUSEUM-ANTE-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<COND (,CLEFT-FLAG
		       <TELL
"C'est l'extrémité sud d'une salle monumentale, pleine de débris d'un tremblement de terre récent. À l'est est une grande porte de fer, rouillée fermée." CR>)
		      (T
		       <TELL
"Vous êtes dans la moitié sud d'une salle monumentale. À l'est se trouve une énorme porte de fer qui semble être rouillée fermée." CR>)>)>>
		
<ROUTINE DDESC (STR1 DOOR STR2)
	 #DECL ((STR1) STRING (DOOR) OBJECT (STR2) <OR FALSE STRING>)
	 <TELL .STR1>
	 <COND (<FSET? .DOOR ,OPENBIT> <TELL "ouvert">)
	       (T <TELL "fermé">)>
	 <TELL .STR2 CR>>

<ROUTINE MUSEUM-ENTRANCE-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<COND (<FSET? ,CAGE ,INVISIBLE>
		       <TELL
"Il s'agit d'un hall d'entrée d'une certaine manière, à en juger par la grande porte de fer à l'ouest, et les portes en pierre ornementée et en bois qui mènent respectivement à l'est et au nord." CR>)
		      (T
		       <TELL
"C'est l'entrée du Musée Royal, la plus belle et la plus grande de la Grand Empire Souterrain. Au sud, en bas de quelques marches, est l'entrée du Puzzle Royal et à l'est, par une porte en pierre, est la Collection Royal Jewel.">
		      <TELL <COND (<FSET? ,WOODEN-DOOR ,OPENBIT> "ouvert")
		                  (T "fermé")> "et mène au Musée de la Technologie.">
		      <COND (<==? ,YEAR ,YEAR-PRESENT>
			     <TELL
"À l'ouest se trouve une grande porte de fer, rouillée fermée. À sa gauche, cependant, est une fente dans la roche fournissant une sortie du musée." CR>)
			    (<L? ,YEAR ,YEAR-PRESENT>
			     <TELL
"À l'ouest se trouve une grande porte en fer, fermée par rouille." CR>)
			    (T
			     <TELL
"À l'ouest se trouve une grande porte de fer, rouillée, fermée. La fente dans la roche, présente quand vous avez commencé, a rempli de décombres." CR>)>)>)>>

<GLOBAL TM-YEAR 948>

<ROUTINE TIME-MACHINE-F ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-OBJDESC>
		<TELL
"Directement devant vous est une grande machine dorée, qui a un siège avec une console devant. Sur la console est un seul bouton et un cadran connecté à un écran à trois chiffres qui lit" N ,TM-YEAR
". La machine est étonnamment brillante et montre peu de signes de vieillissement." CR>)
	       (<==? .RARG ,M-BEG>
		<COND (<VERB? MOVE>
		       <TELL
"Vous pourrez peut-être déplacer la machine en la poussant." CR>)
		      (<AND <VERB? PUSH-TO>
			    <==? ,PRSO ,TIME-MACHINE>>
		       <TELL
"Ce serait une bonne astuce de l'intérieur. " CR>)
		      (<VERB? WALK>
		       <TELL
"Vous n'allez nulle part dans ce tas." CR>)
		      (<AND <VERB? TAKE PUT MOVE PUSH OPEN CLOSE>
			    <NOT <HELD? ,PRSO>>
			    <NOT <IN? ,PRSO ,TIME-MACHINE>>>
		       <TELL
"Vous ne pouvez pas faire cela depuis l'intérieur de la machine." CR>)>)
	       (<NOT .RARG>
		<COND (<AND <VERB? PUT> <==? ,PRSI ,TIME-MACHINE>>
		       <TELL
"Vous ne pouvez rien mettre sur ou à l'intérieur de la machine elle-même." CR>)
		      (<==? ,PRSO ,TIME-MACHINE>
		       <COND (<VERB? OPEN CLOSE>
			      <TELL "Il s'agit d'une machine, pas d'une boîte." CR>)
			     (<VERB? EXAMINE>
			      <TELL
"La machine se compose d'un siège et d'une console contenant un petit bouton et un cadran connecté à un écran qui lit" N ,TM-YEAR "." CR>)
			     (<AND <VERB? BOARD> <FIRST? ,TM-SEAT>>
			      <TELL
"Ce sera quelque peu inconfortable !" CR>)
			     (<VERB? TAKE RAISE>
			      <TELL
"La machine doit peser des centaines de livres et ne peut pas être transportée." CR>)
			     (<VERB? PUSH MOVE>
			      <TELL
"Vous devez préciser dans quelle direction pousser la machine." CR>)
			     (<VERB? PUSH-TO>
			      <COND (<NOT <==? <DO-WALK ,P-DIRECTION>
					       ,M-FATAL>>
				     <TELL
"Avec un certain effort, vous poussez la machine dans la pièce avec vous." CR>
				     <COND (<EQUAL? ,HERE
						    ,CP-ANTE ,MID-CP-ANTE>
					    <TELL
"Cependant, la machine semble avoir subi des dommages dus à la traversée des escaliers." CR>
					    <SETG MACHINE-DAMAGED T>)
					   (<==? ,HERE ,MUSEUM-ANTE>
					    <TELL
"Pousser la machine à travers la fente semble l'avoir endommagé." CR>
					    <SETG MACHINE-DAMAGED T>)>
				     <MOVE ,TIME-MACHINE ,HERE>)>
			      <RTRUE>)>)>)>>

<GLOBAL RING-CONCEALED <>>

<ROUTINE TM-SEAT-F ()
	 <COND (<VERB? CLIMB-ON BOARD>
		<PERFORM ,V?BOARD ,TIME-MACHINE>
		<RTRUE>)
	       (<AND <VERB? PUT-UNDER PUT-BEHIND> <==? ,PRSI ,TM-SEAT>>
		<COND (<==? ,PRSO ,RING>
		       <TELL "L'anneau est dissimulé sous le " CR>
		       <SETG RING-CONCEALED T>
		       <REMOVE ,RING>)
		      (T
		       <TELL
"Il est trop grand pour être caché sous le siège." CR>)>)
	       (<VERB? RUB>
		<TELL "Il n'y a rien d'étrange dans la sensation du siège." CR>)
	       (<VERB? LOOK-UNDER RAISE MOVE>
		<COND (,RING-CONCEALED
		       <TELL
"Vous trouvez l'anneau sous le siège. siège et placez-le sur votre doigt." CR>
		       <MOVE ,RING ,WINNER>
		       <SETG RING-CONCEALED <>>
		       <RTRUE>)
		      (T <TELL
"Vous remarquez une petite zone creuse sous le siège." CR>)>)>>

<ROUTINE TM-DIAL-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "Le cadran est réglé sur " N ,TM-YEAR "." CR>)
	       (<VERB? TURN>
		<COND (<==? ,PRSI ,INTNUM>
		       <COND (<G? ,P-NUMBER 999>
			      <TELL "Vous ne pouvez pas le régler au-delà 999." CR>)
			     (T
			      <SETG TM-YEAR ,P-NUMBER>
			      <TELL "Le cadran est réglé sur " N ,TM-YEAR "." CR>)>)
		      (<NOT ,PRSI>
		       <TELL "Vous devez dire vers quoi le tourner !" CR>)
		      (T <TELL "Vous ne pouvez pas faire ça !" CR>)>)>>

<GLOBAL TM-POINT <>>

<ROUTINE TM-BUTTON-F ()
	 <COND (<VERB? PUSH>
		<COND (<AND <==? ,TM-YEAR ,YEAR-BUILT> <NOT ,TM-POINT>>
		       <SETG SCORE <+ ,SCORE 1>>
		       <SETG TM-POINT T>)>
		<COND (<OR ,MACHINE-DAMAGED
		           <NOT <IN? ,WINNER ,TIME-MACHINE>>>
		       <TELL "Rien ne semble s'être passé." CR>)
		      (<L? ,TM-YEAR ,YEAR-BUILT>
		       <REALLY-DEAD
"Vous vivez une période de désorientation. La région autour de vous semble se solidifier! Les formations rocheuses se rapprochent de vous et vous devenez engloutis dans la pierre!">)
		      (<==? ,YEAR ,TM-YEAR>
		       <TELL "Rien ne semble s'être passé." CR>)
		      (<L? ,TM-YEAR ,YEAR-CLOSED>
		       <TELL
"Vous vivez une brève période de désorientation. Lorsque votre vision revient, ">
		       <COND (<EQUAL? ,HERE ,MUSEUM-ENTRANCE
				      ,MID-MUSEUM-ENTRANCE
				      ,OLD-MUSEUM-ENTRANCE>
			      <COND (<==? ,TM-YEAR ,YEAR-CAGED>
				     <TELL
"vous êtes entouré par un certain nombre de gardes lourdement armés, dont la robe et le discours semblent étranges et inconnus. Une commotion commence à une porte à l'est et une personne avec une tête plate, portant une couronne gaudée et une robe pourpre, éclate dans la pièce." CR>
				     <FLATHEAD-SENTENCE>)
				    (T
				     <GUARDS-KILL>)>)
			     (<EQUAL? ,HERE ,JEWEL-ROOM ,MID-JEWEL-ROOM
				            ,OLD-JEWEL-ROOM>
			      <COND (<==? ,TM-YEAR ,YEAR-CAGED>
				     <TELL
"vous vous retrouvez au milieu d'une sorte de cérémonie, avec un étrange homme à tête plate portant des vêtements royaux sur le point de casser une bouteille sur les barres d'une cage en fer contenant de magnifiques bijoux.">
				     <FLATHEAD-SENTENCE>)
				    (<G? ,TM-YEAR ,YEAR-CAGED>
				     <GUARDS-KILL>)
				    (T
				     <TELL ,SURROUNDINGS-CHANGED CR>
				     <TGOTO ,OLD-JEWEL-ROOM>)>)
			     (<EQUAL? ,HERE ,TECH-MUSEUM ,MID-TECH-MUSEUM
				            ,OLD-TECH-MUSEUM>
			      <COND (<NOT <==? ,TM-YEAR ,YEAR-BUILT>>
				     <GUARDS-KILL>)
				    (T
				     <TELL ,SURROUNDINGS-CHANGED CR>
				     <TGOTO ,OLD-TECH-MUSEUM>)>)>)
		      (T
		       <HAPPY-NEW-YEAR>)>)>>

<GLOBAL SURROUNDINGS-CHANGED
"Votre environnement semble avoir changé.">

<ROUTINE HAPPY-NEW-YEAR ()
	 <TELL
"Vous ressentez une brève période de désorientation. Lorsque votre vision revient, votre environnement semble quelque peu altéré." CR>
	 <COND (<EQUAL? ,HERE ,OLD-JEWEL-ROOM ,MID-JEWEL-ROOM ,JEWEL-ROOM>
		<COND (<L? ,TM-YEAR ,YEAR-PRESENT> <TGOTO ,MID-JEWEL-ROOM>)
		      (T <TGOTO ,JEWEL-ROOM>)>)
	       (<EQUAL? ,HERE ,OLD-TECH-MUSEUM ,MID-TECH-MUSEUM
			      ,TECH-MUSEUM>
		<COND (<L? ,TM-YEAR ,YEAR-PRESENT> <TGOTO ,MID-TECH-MUSEUM>)
		      (T <TGOTO ,TECH-MUSEUM>)>)
	       (<L? ,TM-YEAR ,YEAR-PRESENT> <TGOTO ,MID-MUSEUM-ENTRANCE>)
	       (T <TGOTO ,MUSEUM-ENTRANCE>)>>

<GLOBAL SNAP-LOC <>>

<ROUTINE I-SNAP ()
	 <COND (<==? ,YEAR ,YEAR-PRESENT>
		<RFALSE>)>
	 <SETG TM-YEAR ,YEAR-PRESENT>
	 <TELL
"Vous commencez à vous sentir léger et rapidement désorienté. Quand votre tête s'éclaircit, vous réalisez que votre environnement a changé." CR>
	 <TGOTO ,SNAP-LOC T>>

<ROUTINE MOVE-JEWELS ()
	 <COND (<==? ,TM-YEAR ,YEAR-BUILT>
		<MOVE ,PEDESTAL ,OLD-JEWEL-ROOM>)
	       (<L? ,TM-YEAR ,YEAR-PRESENT>
		<MOVE ,PEDESTAL ,MID-JEWEL-ROOM>)
	       (T
		<MOVE ,PEDESTAL ,JEWEL-ROOM>)>
	 <COND (,RING-STOLEN <RTRUE>)>
	 <MOVE ,SCEPTRE ,PEDESTAL>
	 <FSET ,SCEPTRE ,NDESCBIT>
	 <MOVE ,JEWELLED-KNIFE ,PEDESTAL>
	 <FSET ,JEWELLED-KNIFE ,NDESCBIT>
	 <COND (<NOT ,RING-CONCEALED>
		<MOVE ,RING ,PEDESTAL>
		<FSET ,RING ,NDESCBIT>)>>

<ROUTINE TGOTO ("OPTIONAL" (RM <>) (SNAP <>))
	 <SETG MOVES <+ ,MOVES 1>>
	 <QUEUE I-GUARDS-LEAVE 0>
	 <SETG INVIS <>>
	 <COND (<G? ,YEAR ,YEAR-BUILT>
		<SETG GUARDS-PRESENT T>)>
	 <COND (<==? ,YEAR ,YEAR-PRESENT>
		<SETG SNAP-LOC ,HERE>
		<ENABLE <QUEUE I-SNAP 40>>)>
	 <COND (<==? ,TM-YEAR ,YEAR-PRESENT>
		<SETG CLEFT-FLAG T>)
	       (T <SETG CLEFT-FLAG <>>)>
	 <FCLEAR ,JEWEL-DOOR ,OPENBIT>
	 <FCLEAR ,WOODEN-DOOR ,OPENBIT>
	 <FCLEAR ,IRON-DOOR ,OPENBIT>
	 <COND (<==? ,YEAR ,YEAR-BUILT>
		<COND (<AND ,RING-CONCEALED
			    <IN? ,TIME-MACHINE ,OLD-TECH-MUSEUM>
			    <IN? ,SCEPTRE ,PEDESTAL>
			    <IN? ,JEWELLED-KNIFE ,PEDESTAL>>
		       <SETG RING-STOLEN T>
		       <FSET ,CAGE ,INVISIBLE>
		       ;<FSET ,PEDESTAL ,INVISIBLE>
		       <REMOVE ,SCEPTRE>
		       <REMOVE ,JEWELLED-KNIFE>)
		      (<OR <NOT <IN? ,TIME-MACHINE ,OLD-TECH-MUSEUM>>
			   ,RING-CONCEALED>
		       <SETG CLUMSY-ROBBERY T>
		       <REMOVE ,TIME-MACHINE>)
		      (<OR <NOT <IN? ,RING ,PEDESTAL>>
			   <NOT <IN? ,SCEPTRE ,PEDESTAL>>
			   <NOT <IN? ,JEWELLED-KNIFE ,PEDESTAL>>>
		       <SETG MYSTERY T>)>)>
	 <COND (<==? ,TM-YEAR ,YEAR-BUILT>
		<SETG MYSTERY <>>
		<SETG CLUMSY-ROBBERY <>>)>
	 <SETG YEAR ,TM-YEAR>
	 <MOVE-TM-OBJECTS>
	 <MOVE-JEWELS>
	 <MOVE ,WINNER ,HERE>
	 <GOTO .RM <>>
	 <COND (<==? ,YEAR ,YEAR-BUILT>
		<MOVE ,TIME-MACHINE ,OLD-TECH-MUSEUM>
		<MOVE ,SPINNER ,OLD-TECH-MUSEUM>
		<MOVE ,PRESSURIZER ,OLD-TECH-MUSEUM>
		<MOVE ,TECH-PLAQUE ,OLD-TECH-MUSEUM>)
	       (<L? ,YEAR ,YEAR-PRESENT>
		<COND (<NOT ,CLUMSY-ROBBERY>
		       <MOVE ,TIME-MACHINE ,MID-TECH-MUSEUM>)>
		<MOVE ,SPINNER ,MID-TECH-MUSEUM>
		<MOVE ,PRESSURIZER ,MID-TECH-MUSEUM>
		<MOVE ,TECH-PLAQUE ,MID-TECH-MUSEUM>
		<MOVE ,CAGE ,MID-JEWEL-ROOM>)
	       (T
		<MOVE ,TIME-MACHINE ,TECH-MUSEUM>
		<MOVE ,SPINNER ,TECH-MUSEUM>
		<MOVE ,PRESSURIZER ,TECH-MUSEUM>
		<MOVE ,TECH-PLAQUE ,TECH-MUSEUM>
		<MOVE ,CAGE ,JEWEL-ROOM>)>
	 <COND (<OR ,CLUMSY-ROBBERY
		    <NOT <EQUAL? ,HERE ,TECH-MUSEUM
				 ,MID-TECH-MUSEUM
				 ,OLD-TECH-MUSEUM>>>
		<COND (<NOT .SNAP>
		       <TELL
"Vous remarquez que la machine dorée a disparu !" CR>)>)
	       (T <MOVE ,WINNER ,TIME-MACHINE>)>
	 <COND (,CLUMSY-ROBBERY <REMOVE ,TIME-MACHINE>)>
	 <RTRUE>>

<ROUTINE MOVE-TM-OBJECTS ("AUX" F (MFLG <>) (WFLG <>) N)
	 <SET F <FIRST? ,TIME-MACHINE>>
	 <COND (.F
	        <REPEAT ()
			<COND (<OR <EQUAL? .F ,TM-DIAL ,TM-SEAT ,TM-BUTTON>
				   <EQUAL? .F ,PLAYER>> T)
			      (<NOT .MFLG>
			       <SET MFLG T>
			       <TELL
"Vous remarquez que tout dans la machine est disparu">)>
			<SET N <NEXT? .F>>
			<COND (<NOT <EQUAL? .F ,TM-DIAL ,TM-SEAT ,TM-BUTTON>>
			       <MOVE .F ,HERE>)>
			<SET F .N>
			<COND (<NOT .F> <RETURN>)>>)>
	 <SET F <FIRST? ,WINNER>>
	 <COND (.F
		<REPEAT ()
			<COND (<NOT .WFLG>
			       <SET WFLG T>
			       <COND (.MFLG
				      <TELL "Tout ce que tu tiens a disparu aussi.">)
				     (T <TELL
"Vous remarquez que tout ce que vous teniez a disparu">)>)>
			<SET N <NEXT? .F>>
			<MOVE .F ,HERE>
			<SET F .N>
			<COND (<NOT .F> <RETURN>)>>)>
	 <COND (<OR .MFLG .WFLG> <TELL "!" CR>)>>

<ROUTINE GUARDS-KILL ()
	 <TELL <PICK-ONE ,GUARD-KILLERS> CR>
	 <REALLY-DEAD " ">>

<GLOBAL GUARD-KILLERS <LTABLE 0
"Vous êtes entouré de gardes lourdement armés, apparemment impressionnés par votre présence. L'un d'eux, dont le QI doit avoisiner 15, pointe vers vous un étrange instrument en forme de gaufrier, puis tout devient noir."
"vous êtes confronté à beaucoup de gens particulièrement stupides, vêtus d'uniformes particuliers et pointant des objets ressemblant à des gaufres dans votre direction."
"vous voyez une rangée de militaires qui, si les apparences ne trompent pas, ont l'intelligence cumulative d'un pamplemousse non mûr. L'un d'eux vise un instrument en forme de gaufre dans votre direction et vous devenez engourdi puis paralysé et puis mort.">>

<ROUTINE FLATHEAD-SENTENCE ()
	 <REALLY-DEAD "Il parle fort, presque assourdissant le pauvre fonctionnaire dont le devoir est de voir que ses désirs sont réalisés. « Ah ! un voleur ! Je ne vous ai pas dit que nous avions besoin de plus de sécurité ! Mais, non ! Vous avez tous dit que mon idée de construire le musée sous deux milles de montagne et entouré de cinq cents pieds d'acier était impraticable ! Maintenant, que faire de cela ... intrus ? Je l'ai ! Nous allons construire une forteresse énorme sur le sommet de la montagne le plus haut, avec une échelle étroite s'étirant des milliers de pieds jusqu'au pinacle. Là, il restera pour le reste de sa vie ! » Son assistant hésite. « Ne pensez-vous pas, Votre Seigneurie, que votre plan est un peu, bien, un peu ? » Tête-Plate lui donne une seconde pensée. « Non, pas vraiment. » dit-il, et vous êtes emmené loin. Quelques années plus tard, votre prison est terminée.">>

<ROUTINE REALLY-DEAD (STR)
	 <TELL .STR "| | **** Vous êtes mort ****| |">
	 <FINISH>>

<GLOBAL FLATHEAD-HEARD <>>

<GLOBAL RING-STOLEN <>>
<GLOBAL CLUMSY-ROBBERY <>>
<GLOBAL MYSTERY <>>

<GLOBAL GUARDS-PRESENT T>

<ROUTINE HEAR-FLATHEAD ()
	 <SETG FLATHEAD-HEARD T>
	 <TELL
"Une voix particulièrement forte et râpée peut être entendue au-dessus des autres à l'extérieur de la pièce. \"Très bien! Très bien! Pas assez de sécurité, mais très bien! Maintenant, Seigneur Feepness, faites attention! J'ai pensé que ce que nous avons besoin est un barrage, un barrage énorme pour contrôler la rivière Frigid, avec des milliers de portes. Nous l'appellerons ... Digue de contrôle des inondations #2. Non, pas tout à fait bien. Ah! Digue de contrôle des inondations #3. \"Pardonne-moi, mon Seigneur, mais ne serait-ce pas juste un peu excessif?\" \"Non-sens! Maintenant, laissez-moi vous dire mon idée de vider les volcans...\"" CR>>

<ROUTINE OLD-TECH-MUSEUM-F (RARG)
	 <COND (<AND <==? .RARG ,M-LOOK> <==? ,HERE ,OLD-JEWEL-ROOM>>
		<TELL
"Vous êtes dans une chambre à hauts plafonds, au centre de laquelle est un piédestal qui">
		<COND (<NOT ,RING-STOLEN>
		       <TELL "est la maison prévue des bijoux de la Couronne du Grand Empire Souterrain : un couteau à bijoux, un anneau doré et le sceptre royal.">
		       <COND (<OR <NOT <IN? ,SCEPTRE ,PEDESTAL>>
				  <NOT <IN? ,RING ,PEDESTAL>>
				  <NOT <IN? ,JEWELLED-KNIFE ,PEDESTAL>>>
			      <TELL
" Cependant, tous les joyaux ne sont pas en place.">)>)
		      (T <TELL "est nu.">)>
		<TELL "La pièce est, par apparence, inachevée." CR>
		<COND (,GUARDS-PRESENT
		       <TELL ,HEAR-VOICES CR>)>
		<RTRUE>)
	       (<==? .RARG ,M-LOOK>
		<COND (<==? ,HERE ,OLD-TECH-MUSEUM>
		       <TELL
"Vous êtes dans une grande pièce inachevée, probablement destinée à faire partie du Musée royal." CR>)
		      (T
		       <TELL
"Il semble qu'il s'agisse d'une entrée inachevée du Musée royal. Il y a des portes vers l'est et le nord, et un escalier aveugle vers le sud." CR>)>
		<COND (,GUARDS-PRESENT
		       <TELL ,HEAR-VOICES CR>)>
		<RTRUE>)
	       (<AND <==? .RARG ,M-END>
		     <NOT ,FLATHEAD-HEARD>
		     ,GUARDS-PRESENT
		     <PROB 6>>
		<HEAR-FLATHEAD>)
	       (<AND <==? .RARG ,M-ENTER> ,GUARDS-PRESENT>
		<ENABLE <QUEUE I-GUARDS-LEAVE <+ 3 <RANDOM 12>>>>)
	       (<AND <==? .RARG ,M-BEG>
		     <VERB? OPEN>
		     <EQUAL? ,PRSO ,WOODEN-DOOR ,JEWEL-DOOR>
		     ,GUARDS-PRESENT>
		<TELL
"Tu ouvres la porte si légèrement et tu vois des dizaines d'officiers armés, tu fermes la porte rapidement, tu réalises que tu serais tué en un instant si tu quittes la pièce." CR>)
	       (<AND <==? .RARG ,M-BEG> ,GUARDS-PRESENT <PROB 3>>
		<GUARD-CAUGHT>)>>

<GLOBAL HEAR-VOICES
"Par la porte, vous pouvez entendre des voix qui, de leur son, appartiennent à des militaires ou des policiers.">

<ROUTINE I-GUARDS-LEAVE ()
	 <SETG GUARDS-PRESENT <>>
	 <TELL
"Vous entendez, de l'extérieur de la porte, des gardes qui s'éloignent, leurs voix s'effacent. Après quelques instants, un crash en plein essor signale la fermeture de ce qui doit être une porte énorme." CR>>

<ROUTINE GUARD-CAUGHT ()
	 <REALLY-DEAD
"Un garde particulièrement vicieux entre dans la pièce et vous voit. Il se broie les dents désagréablement, tire une gaufre de son vêtement, et vous vaporise avec un fil de son doigt.">>

<OBJECT ROBOT
	(IN LOCAL-GLOBALS)
	(DESC "robot")
	(SYNONYM ROBOT DEVICE)
	(ACTION ROBOT-F)>

<ROUTINE ROBOT-F ()
	 <COND (<VERB? FOLLOW>
		<TELL "Il s'est déplacé rapidement et a laissé la porte fermée." CR>)
	       (T <TELL "Il n'y a pas de robot ici." CR>)>>

<ROUTINE JEWEL-ROOM-F (RARG)
	 <COND (<AND <==? .RARG ,M-END>
		     <IN? ,TIME-MACHINE ,HERE>
		     <PROB 4>>
		<TELL
"Un appareil semblable à un robot se glisse, poussant le sol au fur et à mesure qu'il se déplace. Sa tête gyrate brièvement au fur et à mesure qu'elle scanne la machine. \"Shame. Honte,\" dit-il, assez téméraire. \"Quelqu'un a à nouveau trafiqué les machines.\" Six yeux mécaniques percés se concentrent sur vous alors que le robot prend la machine en or." CR>
		<FCLEAR ,JEWEL-DOOR ,OPENBIT>
		<FCLEAR ,WOODEN-DOOR ,OPENBIT>
		<MOVE ,TIME-MACHINE ,TECH-MUSEUM>)
	       (<==? .RARG ,M-LOOK>
		<TELL
"Vous êtes dans une chambre à haut plafond">
		<COND (<NOT <FSET? ,CAGE ,INVISIBLE>>
		       <TELL "Au milieu de la cage se trouve un piédestal sur lequel reposent les bijoux de la Couronne du Grand Empire Souterrain : un sceptre, un couteau bijouté et un anneau d'or. Une petite plaque de bronze, maintenant ternie, est sur la cage." CR>)
		      (T
		       <TELL "au milieu de laquelle est un piédestal nu. La pièce est inachevée sans indication de son but. Une petite plaque est fixée à un mur." CR>)>)>>

;"You can take the jewels in YEAR-BUILT; otherwise, it is enclosed.
  If you take it, YEAR-CLOSED is updated to YEAR-CAGED (history changes)"

<ROUTINE CROWN-JEWELS-F ()
	 <COND (<VERB? TAKE>
		<COND (<HELD? ,PRSO> <RFALSE>)
		      (<OR <==? ,YEAR ,YEAR-BUILT>
			   <FSET? ,CAGE ,INVISIBLE>>
		       <FCLEAR ,PRSO ,NDESCBIT>
		       <RFALSE>)
		      (T
		       <TELL
"Les bijoux sont à l'intérieur d'une cage verrouillée." CR>)>)
	       (<AND <VERB? PUT>
		     <==? ,PRSI ,PEDESTAL>
		     <IN? ,PRSO ,WINNER>>
		<TELL "Le " D ,PRSO " repose désormais sur le socle." CR>
		<MOVE ,PRSO ,PEDESTAL>
		<FSET ,PRSO ,NDESCBIT>
		<RTRUE>)
	       (<AND <VERB? PUT> <NOT <HELD? ,PRSO>>>
		<TELL "Vous n'avez pas le " D ,PRSO "." CR>)>>
		
<ROUTINE TECH-MUSEUM-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<COND (<FSET? ,CAGE ,INVISIBLE>
		       <DDESC
"C'est une exposition de la technologie Empire." ,WOODEN-DOOR ".">)
		      (T
		       <DDESC
"C'est un grand hall qui a accueilli les expositions technologiques du Grand Empire Souterrain. Une porte au sud est"
,WOODEN-DOOR ".">)>)>>
		      
<ROUTINE PLAQUE-F ()
	 <COND (<VERB? EXAMINE READ>
		<COND (,RING-STOLEN
		       <TELL
"La plaque explique que cette pièce devait être la maison des joyaux de la Couronne de l'Empire. Cependant, suite à la disparition inexpliquée d'un anneau inestimable pendant les dernières étapes de la construction, Lord Tête-Plate a décidé de placer les autres bijoux dans un endroit plus sûr." CR>
		       <RTRUE>)>
		<FIXED-FONT-ON>
		<TELL
"|
         Joyaux de la Couronne|
|
  Offerts au Musée royal|
  Par Sa Gracieuse Seigneurie|
|
        NIGAUD TÊTE-PLATE|
|
          Inauguré|
         * 777 GUE *">
		<FIXED-FONT-OFF>
		<COND (,CLUMSY-ROBBERY
		       <TELL CR CR
"Sous la plaque, en petit lettrage, est une description d'une tentative maladroite de voler les bijoux à l'aide d'une machine de temps du Musée Technologique que les conservateurs ont été surpris de découvrir n'était pas un modèle non-travaillant.">)
		      (,MYSTERY
		       <TELL CR CR
"Sous la plaque, en petites lettres, est une description d'un mystérieux qui se passe pendant les dernières étapes de construction du Musée, dans lequel certains des joyaux de la couronne ont été trouvés déplacés de leurs positions propres. Heureusement, rien n'a été manquant. Le mystère n'a jamais été résolu et le musée a été ouvert malgré les objections de Lord Tête-Plate que la sécurité était trop laxiste.">)>
		<CRLF>
		<RTRUE>)>>

<ROUTINE WOODEN-DOOR-F ()
	 <COND (<AND <VERB? LISTEN> ,GUARDS-PRESENT>
		<PERFORM ,V?LISTEN ,VOICES>
		<RTRUE>)
	       (<AND <VERB? KNOCK> ,GUARDS-PRESENT>
		<TELL
"Vous réalisez qu'attirer l'attention sur vous serait fatal." CR>)>>

<ROUTINE JEWEL-DOOR-F ()
	 <COND (<AND <VERB? KNOCK> ,GUARDS-PRESENT>
	        <PERFORM ,V?KNOCK ,WOODEN-DOOR>
		<RTRUE>)
	       (<VERB? OPEN UNLOCK>
		<COND (<FSET? ,JEWEL-DOOR ,OPENBIT>
		       <TELL "Il est déjà ouvert." CR>)
		      (<AND <==? ,YEAR ,YEAR-BUILT>
			    <==? ,HERE ,OLD-MUSEUM-ENTRANCE>>
		       <TELL
"La porte est verrouillée, probablement par les gardes en route. " CR>)
		      (T
		       <TELL "La porte est maintenant ouverte." CR>
		       <FSET ,JEWEL-DOOR ,OPENBIT>)>)>>
		

<ROUTINE CAGE-F ()
	 <COND (<VERB? OPEN> <TELL "La cage est verrouillée." CR>)
	       (<VERB? CLOSE> <TELL "La cage est déjà fermée." CR>)>>

<ROUTINE VOICES-F ()
	 <COND (<AND ,GUARDS-PRESENT <==? ,YEAR ,YEAR-BUILT>>
		<TELL
"Les voix sont étouffées par la porte qui, malheureusement pour vous, vous sépare.">
		<TELL <PICK-ONE ,BLATHER> "." CR>)
	       (T <TELL "Entendez-vous des choses maintenant ?" CR>)>>

<GLOBAL BLATHER
	<LTABLE 0
		"échelles salariales des gardes"
		"le caractère excessif du Royal Gouvernement"
		"le puzzle royal qui sera bientôt construit"
		"la bonne façon d'exécuter les intrus"
		"torturer voleurs"
		"le bannissement du Magicien de Frobozz">>

<ROUTINE MUSEUM-PIECES ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-OBJDESC>
		<COND (<==? ,DESC-OBJECT ,SPINNER>
		       <RTRUE>)>
		<TELL
"Une étrange machine grise, en forme de sèche-linge, se trouve d'un côté de la pièce.De l'autre côté du hall se trouve une puissante machine noire, un enchevêtrement serré de fils, tuyaux et moteurs.| Une plaque est montée près de la porte.">
		<COND (<L? ,YEAR ,YEAR-CLOSED>
		       <TELL
" La machine grise est en fait un Pressuriseur magique Frobozz, autrefois employé dans les mines de charbon de l'Empire. La machine noire est un Pivot de salle magique Frobozz. La machine dorée porte le nom de Temporisateur. Ce sont tous des modèles hors service offerts par John D. Tête-Plate, président de Frobozzco." CR>)
		      (T <TELL
"L'écriture est cependant effacée et ne peut pas être faite clairement. Les deux machines semblent être en mauvais état, rouillées dans de nombreux endroits." CR>)>)
	       (<VERB? TAKE MOVE>
		<TELL "Il est massif et ne peut même pas être déplacé." CR>)
	       (<VERB? PUSH PUSH-TO>
		<TELL "Il est trop lourd pour être poussé." CR>)
	       (<VERB? MUNG>
		<TELL "Cela semble assez indestructible." CR>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,SPINNER ,PRESSURIZER>>
		<TELL "Il n'y a pas de bon endroit pour y mettre quoi que ce soit." CR>)>>

<ROUTINE TECH-PLAQUE-F ()
	 <COND (<VERB? TAKE>
		<TELL "Il est boulonné au mur." CR>)
	       (<VERB? EXAMINE READ>
		<COND (<L? ,YEAR ,YEAR-CLOSED>
		       <TELL
"La plaque identifie simplement les machines et les noms de leur donneur. Ce sont des modèles inopérants de machines de pointe existantes." CR>)
		      (T <TELL "Les mots ne peuvent pas être déchiffrés." CR>)>)>>

<ROUTINE PEDESTAL-F ()
	 <COND (<VERB? EXAMINE LOOK-ON>
		<COND (<FIRST? ,PEDESTAL>
		       <TELL
"Les joyaux royaux sont sur le piédestal." CR>)>)
	       (<AND <VERB? PUT PUT-ON TAKE> <NOT <FSET? ,CAGE ,INVISIBLE>>>
		<TELL "Vous ne pouvez pas l'atteindre à travers la cage." CR>)>>

\

"vieux SHADOW.ZIL"

<ROOM CREEPY-CRAWL
      (IN ROOMS)
      (DESC "Effrayant Crawl")
      (LDESC
"Vous êtes dans un chemin sombre et assez effrayant avec des passages partant vers le nord, l'est, le sud et le sud-ouest.")
      (FLAGS RLANDBIT)
      (NORTH TO JUNCTION)
      (SOUTH TO FOGGY-ROOM)
      (SW TO SHADOW-1)
      (EAST TO TIGHT-SQUEEZE)
      (ACTION CREEPY-CRAWL-F)>

<ROOM SHADOW-1
      (IN ROOMS)
      (DESC "Terre de l'Ombre")
      (LDESC
"Vous êtes à l'extrémité est d'un paysage sombre et sans caractéristiques de collines peu profondes.")
      (FLAGS RLANDBIT)
      (ACTION SHADOW-ROOMS)
      (NE "Des murs rocheux imposants vous barrent la route.")
      (NORTH "Des murs rocheux imposants vous barrent la route.")
      (SOUTH TO SHADOW-5)
      (EAST TO CREEPY-CRAWL)
      (NW TO SHADOW-2)
      (WEST TO SHADOW-3)
      (SW TO SHADOW-4)
      (SE TO FOGGY-ROOM)>

<ROOM SHADOW-2
      (IN ROOMS)
      (DESC "Terre de l'Ombre")
      (LDESC
"Vous êtes dans une terre ombragée de basses collines vallonnées s'étendant à l'ouest et au sud. La terre est bordée au nord par un mur de pierre massif. Ancien et soumis aux intempéries, le mur s'est suffisamment émietté à un point pour permettre le passage.")
      (FLAGS RLANDBIT)
      (ACTION SHADOW-ROOMS)
      (NE "Un mur de pierre bloque le passage.")
      (NORTH TO CLEARING)
      (NW "Un mur de pierre bloque le passage.")
      (SE TO SHADOW-1)
      (SW TO SHADOW-7)
      (SOUTH TO SHADOW-3)
      (WEST TO SHADOW-8)
      (EAST TO SHADOW-1)
      (GLOBAL RUBBLE STONE-WALL)>

<ROOM SHADOW-3
      (IN ROOMS)
      (DESC "Terre de l'Ombre")
      (LDESC
"Vous êtes dans une terre sombre et ombreuse. Tout autour de vous sont de douces collines et ombres étranges. Loin au-dessus, enveloppé de brouillard, vous pouvez à peine faire le plafond de l'énorme caverne qui s'étend sur toute cette terre.")
      (FLAGS RLANDBIT)
      (ACTION SHADOW-ROOMS)
      (PSEUDO "BRUME" MIST-PSEUDO)
      (NW TO SHADOW-8)
      (NE TO SHADOW-1)
      (SE TO SHADOW-1)
      (SW TO SHADOW-6)
      (NORTH TO SHADOW-2)
      (SOUTH TO SHADOW-4)
      (WEST TO SHADOW-7)
      (EAST TO SHADOW-1)>

<ROOM SHADOW-4
      (IN ROOMS)
      (DESC "Terre de l'Ombre")
      (LDESC
"Vous êtes dans une terre sombre de collines vallonnées. Le sol devient plus doux au sud.")
      (FLAGS RLANDBIT)
      (ACTION SHADOW-ROOMS)
      (NORTH TO SHADOW-3)
      (EAST TO SHADOW-1)
      (NE TO SHADOW-1)
      (SE TO SHADOW-5)
      (SOUTH TO SHADOW-5)
      (SW "Le sol devient trop mou pour marcher dans cette direction.")
      (WEST TO SHADOW-6)
      (NW TO SHADOW-7)>

<ROOM SHADOW-5
      (IN ROOMS)
      (DESC "Terre de l'Ombre")
      (LDESC
"Vous êtes à l'extrémité sud d'une terre ombragée. Le sol ici est assez doux, et la région est entourée par des sables mouvants sur la plupart des côtés.")
      (FLAGS RLANDBIT)
      (ACTION SHADOW-ROOMS)
      (PSEUDO "RAPIDES" QUICKSAND-PSEUDO)
      (NORTH TO SHADOW-4)
      (NW TO SHADOW-6)
      (NE TO SHADOW-1)
      (SE "Les sables mouvants empêchent tout mouvement dans cette direction.")
      (WEST "Les sables mouvants empêchent tout mouvement dans cette direction.")
      (SOUTH "Les sables mouvants empêchent tout mouvement dans cette direction.")
      (SW "Les sables mouvants empêchent tout mouvement dans cette direction.")
      (EAST "Les sables mouvants empêchent tout mouvement dans cette direction.")>

<ROOM SHADOW-6
      (IN ROOMS)
      (DESC "Terre de l'Ombre")
      (LDESC
"Vous êtes près de l'extrémité sud de la terre de l'ombre. Le sol ici est doux et spongieux, et il devient des sables rapides au sud. Le nord et l'est d'ici sont des collines douces et glissantes.")
      (FLAGS RLANDBIT)
      (ACTION SHADOW-ROOMS)
      (NORTH TO SHADOW-7)
      (NW TO FLATHEAD-OCEAN)
      (WEST TO FLATHEAD-OCEAN)
      (DOWN TO FLATHEAD-OCEAN)
      (SE TO SHADOW-5)
      (EAST TO SHADOW-4)
      (NE TO SHADOW-3)
      (SOUTH "Les sables mouvants empêchent tout mouvement dans cette direction.")
      (SW "Les sables mouvants empêchent tout mouvement dans cette direction.")
      (PSEUDO "RAPIDES" QUICKSAND-PSEUDO)>

<ROOM SHADOW-7
      (IN ROOMS)
      (DESC "Terre de l'Ombre")
      (LDESC
"Vous êtes dans une terre d'ombres sombres et de collines peu profondes, qui s'étendent dans toutes les directions.")
      (FLAGS RLANDBIT)
      (ACTION SHADOW-ROOMS)
      (NE TO SHADOW-2)
      (EAST TO SHADOW-3)
      (SE TO SHADOW-4)
      (SOUTH TO SHADOW-6)
      (NORTH TO SHADOW-8)
      (DOWN TO FLATHEAD-OCEAN)
      (NW TO FLATHEAD-OCEAN)
      (WEST TO FLATHEAD-OCEAN)
      (SW TO FLATHEAD-OCEAN)>

<ROOM SHADOW-8
      (IN ROOMS)
      (DESC "Terre de l'Ombre")
      (LDESC
"Vous êtes debout au sommet d'une falaise abrupte, regardant vers l'ouest au-dessus d'un vaste océan. Loin au-dessous, les livres de surf à une plage de sable. Au sud et à l'est sont des collines vallonnées remplies d'ombres étranges. Un chemin coupé dans la face de la falaise descend vers la plage. Au nord est un haut mur de pierre, qui se termine au bord de la falaise.")
      (FLAGS RLANDBIT)
      (ACTION SHADOW-ROOMS)
      (SOUTH TO SHADOW-7)
      (EAST TO SHADOW-2)
      (SE TO SHADOW-3)
      (SW TO FLATHEAD-OCEAN)
      (WEST TO FLATHEAD-OCEAN)
      (NE "Un mur de pierre bloque le passage.")
      (NW "Un mur de pierre bloque le passage.")
      (DOWN TO FLATHEAD-OCEAN)
      (NORTH TO CLIFF)
      (GLOBAL RUBBLE STONE-WALL)>

<ROOM FLATHEAD-OCEAN
      (IN ROOMS)
      (DESC "Tête-Plate Océan")
      (FLAGS RLANDBIT ONBIT)
      (NORTH TO CLIFF-BASE)
      (ENTER"Entre les rochers, le vent et les vagues, vous ne tiendrez pas une minute.")
      (WEST "Entre les rochers, le vent et les vagues, vous ne tiendrez pas une minute.")
      (SW "Entre les rochers, le vent et les vagues, vous ne tiendrez pas une minute.")
      (NW "Entre les rochers, le vent et les vagues, vous ne tiendrez pas une minute.")
      (ACTION FLATHEAD-OCEAN-F)
      (SE TO SHADOW-6)
      (NE TO SHADOW-8)
      (EAST TO SHADOW-7)
      (SOUTH "Les sables mouvants empêchent tout mouvement ici.")
      (PSEUDO "RAPIDES" QUICKSAND-PSEUDO "BRUME" MIST-PSEUDO)>

<OBJECT SHADOW
	(DESC "à capuche figurine")
	(SYNONYM SHADOW FIGURE MAN WOMAN)
	(ADJECTIVE HOODED CLOAKED)
	(FLAGS ACTORBIT TRANSBIT CONTBIT OPENBIT)
	(ACTION SHADOW-F)
	(DESCFCN SHADOW-F)>

<OBJECT HOOD
	(IN SHADOW)
	(DESC "capuche")
	(SYNONYM HOOD)
	(FLAGS NDESCBIT TRYTAKEBIT TAKEBIT WEARBIT)
	(ACTION HOOD-F)>

<OBJECT CLOAK
	(IN SHADOW)
	(DESC "cape")
	(SYNONYM CLOAK)
	(FLAGS NDESCBIT TRYTAKEBIT TAKEBIT WEARBIT)
	(ACTION CLOAK-F)>
	
<GLOBAL DIRS
	<LTABLE P?NORTH "nord" P?SOUTH "sud" P?EAST "est" P?WEST "ouest"
		P?NW "nord-ouest" P?NE "nord-est" P?SE "sud-est"
		P?SW "sud-ouest" P?UP "escaliers" P?DOWN "escaliers">>

<GLOBAL DIR-TBL <TABLE 0 0 0 0 0 0 0 0 0 0 0 0>>

<ROUTINE PICK-DIRECTION (RM "AUX" (NXT 0) (CNT 0) (OFFS 0))
	 <REPEAT ()
		 <COND (<==? <SET NXT <NEXTP .RM .NXT>> 0>
			<RETURN>)
		       (<NOT <L? .NXT ,LOW-DIRECTION>>
			<COND (<NOT <EQUAL? .NXT ,P?UP ,P?DOWN>>
			       <SET OFFS <+ .OFFS 1>>
			       <PUT ,DIR-TBL .OFFS .NXT>
			       <SET CNT <+ .CNT 1>>)>)>>
	 <GET ,DIR-TBL <RANDOM .CNT>>>
	
<ROUTINE SHADOW-F ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-OBJDESC>
		<COND (<NOT ,BLOCKED-DIR>
		       <SETG BLOCKED-DIR <PICK-DIRECTION ,HERE>>)>
		<TELL
"Une personne masquée et cagoulée, portant une épée semblable à la vôtre propre,">
		<COND (<G? ,S-STRENGTH 3>
		       <TELL "est en train de bloquer le chemin">
		       <TELL <LKP ,BLOCKED-DIR ,DIRS> "." CR>)
		      (T <TELL "est ici." CR>)>
		<TELL "La figurine à capuche" <GET ,SHADOW-DIAG ,S-STRENGTH> CR>)
	       (<AND <VERB? GIVE> <==? ,PRSI ,SHADOW>>
		<TELL
"La figurine à capuche n'est pas intéressée par vos cadeaux." CR>)
	       (<HELLO? ,SHADOW>
		<TELL
"La figurine à capuche ne répond pas à vos mots." CR>)
	       (<AND <VERB? ATTACK> <==? ,PRSI ,SWORD>>
		<COND (<NOT ,SHADOW-POINT-2>
		       <SETG SCORE <+ ,SCORE 1>>
		       <SETG SHADOW-POINT-2 T>)>
		<SHADOW-ATTACK>)
	       (<VERB? ATTACK>
		<TELL
"La silhouette encapuchonnée ignore votre faible attaque." CR>
		<SETG ATTACK-MODE T>
		<ENABLE <QUEUE I-CURE 10>>
		<ENABLE <QUEUE I-SHADOW-REPLY -1>>)>>

<GLOBAL SHADOW-DIAG
	<TABLE
"?"
" semble être grièvement blessé et sans défense."
" est blessé et sa force semble s'estomper."
" a quelques blessures et n'est probablement pas capable de gêner votre mouvement."
" a une blessure légère qui n'a pas affecté sa force apparemment grande."
" a une grande force, correspondant peut-être à la vôtre.">>

<GLOBAL P-STRENGTH 5>
<GLOBAL S-STRENGTH 5>

<GLOBAL ATTACK-MODE <>>
<GLOBAL SHADOW-GONE <>>

<ROUTINE I-CURE ()
	 <COND (<NOT <==? ,P-STRENGTH 5>>
		<SETG P-STRENGTH <+ ,P-STRENGTH 1>>)>
	 <COND (<NOT <==? ,S-STRENGTH 5>>
		<SETG S-STRENGTH <+ ,S-STRENGTH 1>>)>
	 <COND (<NOT <==? <+ ,P-STRENGTH ,S-STRENGTH> 10>>
		<QUEUE I-CURE 10>)>
	 <RFALSE>>
		      
<ROUTINE SHADOW-ATTACK ()
	 <COND (<NOT ,ATTACK-MODE>
		<ENABLE <QUEUE I-CURE 10>>
		<SETG ATTACK-MODE T>
		<ENABLE <QUEUE I-SHADOW-REPLY -1>>)>
	 <COND (<PROB <+ <* ,P-STRENGTH 10> 10>>
		<COND (<PROB 85>
		       <SETG S-STRENGTH <- ,S-STRENGTH 1>>
		       <COND (<0? ,S-STRENGTH>
			      <SHADOW-DIES>
			      <RTRUE>)>
		       <TELL <PICK-ONE ,P-HITS> CR>
		       <TELL "Le figurine" <GET ,SHADOW-DIAG ,S-STRENGTH> CR>)
		      (T
		       <SETG S-STRENGTH <- ,S-STRENGTH 2>>
		       <COND (<0? ,S-STRENGTH> <SETG S-STRENGTH 1>)
			     (<L? ,S-STRENGTH 1>
			      <SHADOW-DIES>
			      <RTRUE>)>
		       <TELL
"Un coup sec et la figurine cagoulée est grièvement blessée !" CR>
		       <TELL "Le figurine" <GET ,SHADOW-DIAG ,S-STRENGTH> CR>)>)
	       (T
		<COND (<L? ,S-STRENGTH 2>
		       <TELL
"Votre adversaire bloque votre attaque avec son épée." CR>)
		      (T <TELL <PICK-ONE ,P-MISSES> CR>)>)>>

<GLOBAL P-HITS <LTABLE 0
"Une bonne parade ! Votre épée blesse la figurine à capuche !"
"Un coup rapide attrape la figure à capuche hors garde !"
"La figurine à capuche est frappée avec un coup rapide !">>

<GLOBAL P-MISSES <LTABLE 0
"Votre mouvement n'a pas été assez rapide et rate le "
"Un coup rapide, mais le personnage encapuchonné est sur ses gardes."
"Un bon coup, mais il est trop lent."
"Un bon slash, mais il manque d'un mile."
"Vous chargez, mais la silhouette encapuchonnée saute agilement sur le côté.">>

<GLOBAL S-HITS <LTABLE 0
"La silhouette encapuchonnée vous surprend et vous blesse !"
"Vous êtes blessé par un éclair. poussée !"
"Vos réflexes rapides ne peuvent pas arrêter le mouvement de la figurine à capuche ! Vous êtes touché !">>

<ROUTINE I-SHADOW-REPLY ()
	 <COND (<OR <NOT ,ATTACK-MODE> <NOT <IN? ,SHADOW ,HERE>>>
                <QUEUE I-SHADOW-REPLY 0>
		<SETG ATTACK-MODE <>>
		<RFALSE>)>
	 <COND (<NOT <IN? ,SWORD ,WINNER>>
		<MOVE ,SWORD ,WINNER>
		<TELL
"Votre épée, rougeoyante sauvagement, saute dans votre main !" CR>)>
	 <COND (<AND <PROB <+ <* ,S-STRENGTH 10> 10>> <G? ,S-STRENGTH 1>>
		<COND (<PROB 90>
		       <COND (<L? <SETG P-STRENGTH <- ,P-STRENGTH 1>> 1>
			      <SETG P-STRENGTH 1>
			      <TELL
"La figure à capuchon balance son épée et envoie la vôtre voler vers le sol. Bien que vous soyez sans défense, la figure atteint pour votre épée et vous la remet, hurlant." CR>)
			     (T
			      <TELL <PICK-ONE ,S-HITS> CR>)>)
		      (T
		       <COND (<L? <SETG P-STRENGTH <- ,P-STRENGTH 2>> 1>
			      <JIGS-UP
"Dans votre état blessé, vous ne pouvez pas vous défendre contre votre adversaire immobile. Lentement et soigneusement, la figure commence à enlever son capot quand vous tombez au sol, mort.">)
			     (T
			      <TELL
"Une feinte brillante vous met hors de garde, et la figure à capuchon glisse son épée entre vos côtes." CR>)>)>)
	       (<L? ,S-STRENGTH 3>
		<TELL
"La figure à capuchon tente une poussée, mais son état affaibli empêche de vous frapper." CR>)
	       (T
		<TELL <PICK-ONE ,S-MISSES> CR>)>>

<GLOBAL S-MISSES <LTABLE 0
"La figurine encapuchonnée poignarde nonchalamment avec son épée et rate."
"Vous esquivez alors que la figurine encapuchonnée entre. bas."
"La silhouette encapuchonnée tente de se faufiler derrière votre garde, mais vous vous écartez."
"La silhouette à capuche pousse, mais tu te bats et tu l'envoies voler au sol !">>

<ROUTINE SHADOW-DIES ()
	 <TELL
"La figure à capuchon, mortellement blessée, s'écroule au sol. Elle vous regarde une fois, et vous attrapez un bref aperçu des yeux profonds et tristes. Avant de pouvoir réagir, la figure disparaît dans un nuage de vapeur fétide." CR>
	 <REMOVE ,SHADOW>
	 <SETG SHADOW-GONE T>
	 <SETG BLOCKED-DIR <>>>

<ROUTINE HOOD-F ()
	 <COND (<AND <VERB? LOOK-UNDER> <IN? ,HOOD ,SHADOW>>
		<TELL
"Le capot de la figure jette une ombre sombre sur son visage. Il n'y a aucun moyen d'où vous vous tenez pour regarder en dessous." CR>)
	       (<AND <VERB? TAKE PUT> <IN? ,HOOD ,SHADOW>>
		<COND (<==? ,S-STRENGTH 1>
		       <TELL
"Vous retirez lentement la capuche de votre adversaire gravement blessé et reculez dans l'horreur à la vue de votre propre visage, fatigué et blessé. Un sourire faible vient aux lèvres et puis le visage commence à changer, très lentement, dans celui d'une personne vieille, wizé. L'image s'efface et avec elle le corps de votre adversaire capuche. Le manteau reste sur le sol." CR>
		       <REMOVE ,SHADOW>
		       <SETG SHADOW-GONE T>
		       <MOVE ,HOOD ,WINNER>
		       <FCLEAR ,HOOD ,NDESCBIT>
		       <MOVE ,CLOAK ,HERE>
		       <FCLEAR ,CLOAK ,NDESCBIT>)
		      (<==? ,S-STRENGTH 2>
		       <TELL
"La figure à capuchon, bien que se rétablissant des blessures, est assez forte pour vous forcer à revenir." CR>)
		      (T
		       <TELL
"Vous ne pouvez pas vous approcher suffisamment de la figurine encapuchonnée pour retirer la capuche." CR>)>)>>

<ROUTINE CLOAK-F ()
	 <COND (<AND <VERB? LOOK-UNDER> <IN? ,CLOAK ,SHADOW>>
		<TELL
"Vous ne pouvez pas vous approcher suffisamment pour regarder sous la cape." CR>)
	       (<AND <VERB? TAKE> <IN? ,CLOAK ,SHADOW>>
		<TELL
"Le manteau est attaché autour du cou de la figure à capuchon. Il serait difficile à enlever." CR>)>>

<GLOBAL BLOCKED-DIR <>>

<ROUTINE SHADOW-ROOMS (RARG)
	 <COND (<AND <==? .RARG ,M-BEG>
		     <VERB? WALK>
		     <==? ,PRSO ,BLOCKED-DIR>>
		<TELL "Votre chemin est bloqué par la silhouette encapuchonnée." CR>)
	       (<==? .RARG ,M-END>
		<COND (<NOT <IN? ,SHADOW ,HERE>>
		       <SETG BLOCKED-DIR <>>
		       <REMOVE ,SHADOW>)>
		<COND (,SHADOW-GONE <RFALSE>)
		      (<IN? ,SHADOW ,HERE>
		       <COND (<AND <PROB 30> <NOT ,ATTACK-MODE>>
			      <SETG ATTACK-MODE T>
			      <ENABLE <QUEUE I-CURE 10>>
			      <ENABLE <QUEUE I-SHADOW-REPLY -1>>)>)
		      (<PROB 30>
		       <TELL
"Vous pouvez entendre des pas silencieux à proximité." CR>)
		      (<AND <PROB 30> ,LIT <G? ,S-STRENGTH 3>>
		       <SETG BLOCKED-DIR <PICK-DIRECTION ,HERE>>
		       <TELL
"À travers les ombres, une figure cachée et capuche apparaît devant vous, bloquant la">
		       <TELL <LKP ,BLOCKED-DIR ,DIRS>
			     "ern sortir de la pièce et porter une épée éclatante." CR>
		       <SHADOW-ARRIVAL>
		       <RTRUE>)>)>>

<ROUTINE SHADOW-ARRIVAL ()
	 <MOVE ,SHADOW ,HERE>
	 <COND (<NOT ,SHADOW-POINT-1>
		<SETG SCORE <+ ,SCORE 1>>
		<SETG SHADOW-POINT-1 T>)>
	 <COND (<NOT <IN? ,SWORD ,WINNER>>
		<MOVE ,SWORD ,WINNER>
		<COND (,SWORD-IN-STONE?
		       <TELL
"De nulle part, l'épée de la jonction apparaît dans votre main, sauvagement éclatante !" CR>)
		      (T
		       <TELL
"Votre épée, rougeoyante sauvagement, apparaît dans votre main !" CR>)>
		<SETG SWORD-IN-STONE? <>>)>>

<GLOBAL SHADOW-POINT-1 <>>
<GLOBAL SHADOW-POINT-2 <>>

<ROUTINE CREEPY-CRAWL-F (RARG)
	 <COND (<==? .RARG ,M-END>
		<SETG BLOCKED-DIR <>>
		<RTRUE>)>>

;" Cooperative Problem"

<ROOM ZORK2-STAIR
      (IN ROOMS)
      (DESC "Escalier sans fin")
      (LDESC
"Vous êtes au pied d'un escalier qui paraît sans fin et serpente hors de votre champ de vision. Une lumière inquiétante, venue de toutes parts, projette d'étranges ombres sur les murs. Au sud s'enfonce un sentier sombre et sinueux.")
      (FLAGS ONBIT RLANDBIT)
      (NORTH "Les escaliers sont interminables.")
      (UP "Les escaliers sont interminables.")
      (SOUTH TO JUNCTION)
      (GLOBAL STAIRS)>

<ROOM JUNCTION
      (IN ROOMS)
      (DESC "Jonction")
      (LDESC
"Vous êtes à la jonction d'un passage nord-sud et d'un passage est-ouest. Au nord, vous distinguez le bas d'un escalier. Les passages vers l'est et le sud sont assez étroits, tandis qu'un sentier plus large mène à l'ouest.")
      (FLAGS RLANDBIT)
      (WEST TO CLEARING)
      (NORTH TO ZORK2-STAIR)
      (SOUTH TO CREEPY-CRAWL)
      (EAST TO DAMP-PASSAGE)>

<ROOM CLEARING
      (IN ROOMS)
      (DESC "Zone aride")
      (LDESC
"Vous êtes à l'ouest de la jonction, où le passage rocheux s'élargit dans une grande zone plate. Bien que la terre ici soit stérile, vous pouvez voir de la végétation à l'ouest. Au sud d'ici est un mur puissant de pierre, antique et effondré. Au sud-ouest le mur s'est suffisamment délabré pour former une ouverture, à travers laquelle coule une brume mince.")
      (FLAGS RLANDBIT)
      (SW TO SHADOW-2)
      (NW TO SLOPE)
      (SOUTH "Un mur de pierre bloque votre chemin.")
      (SE "Un mur de pierre bloque votre chemin.")
      (WEST TO CLIFF)
      (EAST TO JUNCTION)
      (GLOBAL RUBBLE STONE-WALL)
      (PSEUDO "BRUME" MIST-PSEUDO)>

<ROOM SLOPE
      (IN ROOMS)
      (DESC "Boucle en épingle à cheveux")
      (LDESC
"Vous êtes à un virage serré sur un sentier étroit et en pente raide, parsemé de blocs de différentes tailles. Le sentier monte brusquement vers une plaine déserte au sud-est. Au sud-ouest d'ici, le sentier serpente vers la base d'une falaise.")
      (SE TO CLEARING)
      (UP TO CLEARING)
      (SW TO CLIFF-BASE)
      (DOWN TO CLIFF-BASE)
      (GLOBAL RUBBLE)
      (FLAGS RLANDBIT)>

<ROOM CLIFF-BASE
      (IN ROOMS)
      (DESC "Base de la falaise")
      (LDESC
"Vous êtes à la base d'une falaise abrupte. Directement au-dessus de vous est un large rebord et bien au-dessus que certains soleils naturels peuvent être vus. Au nord-est est un chemin d'escalade abrupte et le sol devient sableux vers le sud.")
      (FLAGS ONBIT RLANDBIT)
      (UP "Vous ne pouvez pas gravir la paroi rocheuse.")
      (SOUTH TO FLATHEAD-OCEAN)
      (NE TO SLOPE)
      (ACTION CLIFF-BASE-F)
      (GLOBAL LEDGE)>

<ROOM CLIFF
      (IN ROOMS)
      (DESC "Falaise")
      (FLAGS ONBIT RLANDBIT)
      (DOWN TO CLIFF-LEDGE IF ROPE-FLAG ELSE "La chute vous tuerait.")
      (UP "Il n'y a aucun arbre ici approprié pour escalade.")
      (SW TO SHADOW-8)
      (EAST TO CLEARING)
      (ACTION CLIFF-F)
      (GLOBAL GLOBAL-MAN RUBBLE STONE-WALL CLIFF-OBJECT)
      (PSEUDO "BRUME" MIST-PSEUDO)>

<ROOM CLIFF-LEDGE
      (IN ROOMS)
      (DESC "Corniche de la falaise")
      (FLAGS ONBIT RLANDBIT)
      (UP "Vous tentez l'ascension mais redescendez.")
      (DOWN TO CLIFF-BASE)
      (ACTION CLIFF-LEDGE-F)
      (GLOBAL RUBBLE GLOBAL-ROPE GLOBAL-MAN LEDGE CLIFF-OBJECT)>

<ROOM FOGGY-ROOM
      (IN ROOMS)
      (DESC "Brumeux Salle")
      (LDESC
"Vous êtes dans un passage dank rempli d'un brouillard brumeux. Un passage effrayant mène au nord et un sentier plus large s'en va vers le sud. À l'ouest, le sentier quitte la roche et entre dans une terre aride et ombragée.")
      (NORTH TO CREEPY-CRAWL)
      (SOUTH TO LAKE-SHORE)
      (WEST TO SHADOW-1)
      (FLAGS RLANDBIT)>

<ROOM LAKE-SHORE
      (IN ROOMS)
      (DESC "Rive du lac")
      (LDESC
"Vous êtes dans une vaste caverne sur la rive nord d'un petit lac. Quelques pas en pierre polie mènent au sud-est et une face de roche pure empêche tout mouvement autour du lac au sud-ouest. La caverne est faiblement éclairée d'en haut.")
      (SE TO AQ-VIEW)
      (DOWN TO AQ-VIEW)
      (SOUTH "Si vous voulez vraiment entrer dans le lac, vous devriez le dire.")
      (SW "La paroi rocheuse abrupte empêche tout mouvement le long du lac rivage.")
      (NORTH TO FOGGY-ROOM)
      (FLAGS ONBIT RLANDBIT)
      (GLOBAL LAKE STAIRS)
      (PSEUDO "RIVAGE" SHORE-PSEUDO "PLAGE" SHORE-PSEUDO)>

<ROOM AQ-VIEW
      (IN ROOMS)
      (DESC "Aqueduc Vue")
      (LDESC
"Il s'agit d'un petit balcon sculpté dans une falaise proche de la verticale. A l'est, s'étendant du nord au sud, se dresse un aqueduc monumental soutenu par de puissants piliers en pierre, dont certains commencent à s'effondrer de l'âge. Vous ressentez un sentiment de perte et de tristesse alors que vous réfléchissez à cette structure autrefois fière et à l'échec de l'Empire qui a créé cette merveille et d'autres génies.")
      (NW TO LAKE-SHORE)
      (UP TO LAKE-SHORE)
      (DOWN "La chute serait fatale.")
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL AQUEDUCT STAIRS)>
     
<ROOM ON-LAKE
      (IN ROOMS)
      (DESC "Sur le lac")
      (LDESC
"Vous flottez à la surface du lac. L'eau est froide et votre capacité à survivre ici pendant longtemps est très douteuse. Un nord de natation vous met à votre point de départ. Les conditions à l'est sont pauvres où le lac se transforme en marécage. Les rives ouest et sud sont adaptées à la marche, cependant.")
      (NORTH TO LAKE-SHORE)
      (SOUTH TO SOUTH-SHORE)
      (PSEUDO "SWAMP" SWAMP-PSEUDO)
      (SE "Le marais est infranchissable.")
      (EAST "Le marais est infranchissable.")
      (NE "Le marais est infranchissable.")
      (WEST TO FAR-SHORE)
      (NW TO FAR-SHORE)
      (SW TO SOUTH-SHORE)
      (DOWN TO IN-LAKE)
      (FLAGS RLANDBIT NONLANDBIT ONBIT)
      (ACTION ON-LAKE-F)
      (GLOBAL LAKE FISH)>

<ROOM IN-LAKE
      (IN ROOMS)
      (DESC "Sous l'eau")
      (LDESC
"Vous êtes au-dessous de la surface du lac. Il s'avère que le lac est assez peu profond et le fond est à quelques pieds au-dessous de vous. Vu la température frigide de l'eau, vous ne devriez probablement pas planifier un séjour prolongé. Le fond du lac est sableux et quelques plantes copieuses et algues y vivent.")
      (UP TO ON-LAKE)
      (DOWN "Vous êtes déjà au fond du lac.")
      (NORTH TO IN-LAKE)
      (SOUTH TO IN-LAKE)
      (EAST TO IN-LAKE)
      (WEST TO IN-LAKE)
      (NE TO IN-LAKE)
      (NW TO IN-LAKE)
      (SE TO IN-LAKE)
      (SW TO IN-LAKE)
      (FLAGS RLANDBIT NONLANDBIT ONBIT)
      (ACTION IN-LAKE-F)
      (GLOBAL LAKE FISH)>

<ROOM FAR-SHORE
      (IN ROOMS)
      (DESC "Ouest Rive")
      (LDESC
"Vous êtes sur la rive ouest du lac. Le sol ici est assez dur, mais quelques roseaux malades parviennent à se développer près du bord de l'eau. Le seul sentier mène à la roche au sud.")
      (EAST "Si vous voulez entrer dans le lac, vous devez le dire.")
      (SOUTH TO VIEW-ROOM)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL LAKE)
      (PSEUDO "RIVAGE" SHORE-PSEUDO "PLAGE" SHORE-PSEUDO)>

<OBJECT REEDS
      (IN FAR-SHORE)
      (SYNONYM REEDS)
      (ADJECTIVE SICKLY)
      (DESC "roseaux")
      (FLAGS NDESCBIT)>

<ROOM VIEW-ROOM
      (IN ROOMS)
      (DESC "Panorama Vista")
      (LDESC "")
      (FLAGS ONBIT RLANDBIT)
      (NORTH TO FAR-SHORE)
      (ACTION VIEW-ROOM-F)>

<OBJECT VIEWING-TABLE
	(IN VIEW-ROOM)
	(DESC "table d'observation")
	(SYNONYM TABLE SURFACE)
	(ADJECTIVE VIEWING)
	(FLAGS NDESCBIT)
	(ACTION VIEWING-TABLE-F)>

<OBJECT TORCH
	(IN VIEW-ROOM)
	(DESC "torche")
	(FDESC
"Monté sur un mur est une torche flamboyante, qui remplit la pièce d'une lumière clignotante.")
	(SYNONYM TORCH)
	(FLAGS LIGHTBIT TAKEBIT ONBIT FLAMEBIT)
	(ACTION TORCH-F)>

<OBJECT FRIED-TORCH
	(DESC "torche éteinte")
	(SYNONYM TORCH)
	(ADJECTIVE BURNED DEAD)
	(FLAGS TAKEBIT)
	(ACTION FRIED-TORCH-F)>

<OBJECT CLIFF-OBJECT
	(IN LOCAL-GLOBALS)
	(DESC "falaise")
	(SYNONYM CLIFF)
	(ACTION CLIFF-OBJECT-F)>

<OBJECT STONE-WALL
	(IN LOCAL-GLOBALS)
	(DESC "mur de pierre")
	(SYNONYM WALL)
	(ADJECTIVE STONE MASSIVE)
	(FLAGS NDESCBIT)>

<OBJECT LAKE
	(IN LOCAL-GLOBALS)
	(DESC "lac")
	(SYNONYM LAKE WATER SURFACE)
	(ACTION LAKE-F)>

<OBJECT AMULET
	(DESC "doré amulette")
	(SYNONYM AMULET OBJECT)
	(ADJECTIVE GOLD GOLDEN SHINY)
	(FLAGS TAKEBIT WEARBIT NDESCBIT)>

<OBJECT SAND
	(IN IN-LAKE)
	(DESC "sable")
	(SYNONYM SAND FLOOR BOTTOM)
	(FLAGS NDESCBIT)
	(ACTION SAND-F)>

<OBJECT FRIED-LAMP
	(DESC "lampe")
	(SYNONYM LAMP LANTERN)
	(ADJECTIVE BRASS)
	(FLAGS TAKEBIT)
	(SIZE 10)
	(ACTION FRIED-LAMP-F)>

<OBJECT ALGAE
	(IN IN-LAKE)
	(DESC "plantes et algues")
	(SYNONYM PLANT PLANTS ALGAE)
	(FLAGS NDESCBIT)
	(ACTION ALGAE-F)>

<OBJECT SHINY-OBJECT
	(IN IN-LAKE)
	(DESC "objet brillant")
	(SYNONYM OBJECT AMULET)
	(ADJECTIVE SHINY)
	(FLAGS TRYTAKEBIT NDESCBIT)
	(ACTION SHINY-OBJECT-F)>

<OBJECT LEDGE
	(IN LOCAL-GLOBALS)
	(DESC "rebord")
	(SYNONYM LEDGE)
	(ADJECTIVE WIDE)
	(FLAGS NDESCBIT)
	(ACTION LEDGE-F)>

<ROUTINE LEDGE-F ()
	 <COND (<AND <==? ,HERE ,CLIFF-LEDGE>
		     <VERB? THROW-OFF>
		     <==? ,PRSI ,LEDGE>>
		<COND (<NOT <IN? ,PRSO ,WINNER>>
		       <TELL "Tu ne tiens pas ça !" CR>
		       <RTRUE>)>
		<MOVE ,PRSO ,CLIFF-BASE>
		<TELL
"Le " D ,PRSO " tombe au pied de la falaise en contrebas." CR>)>> 

<OBJECT WAYBREAD
	(IN CLIFF)
	(DESC "morceau de pain")
	(LDESC "Un morceau de pain est par terre ici.")
	(FDESC
"Il semble que quelqu'un soit venu ici récemment, car il y a du pain frais sous l'un des autres arbres.")
	(SYNONYM BREAD WAYBREAD PIECE)
	(ADJECTIVE WAY FRESH)
	(FLAGS TAKEBIT FOODBIT)
	(SIZE 3)
	(ACTION WAYBREAD-F)>

<ROUTINE WAYBREAD-F ()
	 <COND (<AND <VERB? CUT> <==? ,PRSI ,SWORD>>
		<TELL
"Le pain est écrasé plutôt que coupé par ton épée, et les miettes se dispersent au vent." CR>
		<REMOVE ,WAYBREAD>)>>

<OBJECT ROPE
	(IN CLIFF)
	(DESC "corde")
	(SYNONYM ROPE)
	(ADJECTIVE LONG)
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION ROPE-F)>

<OBJECT GLOBAL-ROPE
	(IN LOCAL-GLOBALS)
	(DESC "corde")
	(SYNONYM ROPE)
	(ADJECTIVE DANGLING)
	(ACTION GLOBAL-ROPE-F)>

<OBJECT TREE
	(IN CLIFF)
	(DESC "arbre")
	(SYNONYM TREE TREES)
	(ADJECTIVE LARGE TALL)
	(FLAGS NDESCBIT)
	(ACTION TREE-F)>
	
<OBJECT STAFF
	(DESC "bâton en bois")
	(SYNONYM STAFF)
	(ADJECTIVE WOODEN)
	(FLAGS TAKEBIT)
	(SIZE 10)
	(ACTION STAFF-F)>
	
<OBJECT BROKEN-STAFF
	(DESC "bâton cassé")
	(SYNONYM STAFF)
	(ADJECTIVE BROKEN)
	(FLAGS TAKEBIT)
	(SIZE 10)
	(ACTION STAFF-F)>
	
<ROUTINE STAFF-F ()
	 <COND (<AND <VERB? BURN> <==? ,PRSI ,TORCH>>
		<REMOVE ,PRSO>
		<JIGS-UP
"Le bâton est instantanément consumé dans une boule de flammes. Vous l'accompagnez.">)>>

<OBJECT CHEST
	(IN CLIFF-LEDGE)
	(DESC "coffre")
	(FDESC
"Un grand coffre, fermé et verrouillé, se trouve parmi les des rochers.")
	(SYNONYM CHEST)
	(ADJECTIVE LOCKED)
	(FLAGS TAKEBIT CONTBIT)
	(SIZE 40)
	(CAPACITY 20)
	(ACTION CHEST-F)>

<OBJECT GLOBAL-MAN
	(IN LOCAL-GLOBALS)
	(DESC "homme")
	(SYNONYM MAN FRIEND)
	(FLAGS ACTORBIT)
	(ACTION GLOBAL-MAN-F)>
	
<OBJECT VALUABLES
	(IN MAN)
	(DESC "pile d'objets de valeur variés")
       	(SYNONYM VALUABLES TREASURE PILE)
	(ADJECTIVE ASSORTED)
	(FLAGS NDESCBIT TAKEBIT)
	(ACTION VALUABLES-F)>

<OBJECT MAN
	(SYNONYM MAN FRIEND)
	(DESC "homme")
	(FLAGS ACTORBIT OPENBIT CONTBIT)
	(ACTION MAN-F)>

<GLOBAL CHEST-LIFTED <>>

<ROUTINE I-MAN-APPEARS ()
	 <COND (<OR <NOT <==? ,HERE ,CLIFF-LEDGE>>
		    <NOT <EQUAL? <LOC ,CHEST> ,CLIFF-LEDGE ,WINNER>>>
		<RFALSE>)
	       (,CHEST-TIED
		<SETG MAN-SEEN T>
		<TELL
"Tout d'un coup, la poitrine est levée de toi. Levant les yeux, on voit un homme au sommet de la falaise, tirant intensément sur la corde. « C'est très gentil de ta part, je le dis ! » Il ricane désagréablement. « Oh, tu es coincé, n'est-ce pas. Eh bien, je reviens tout de suite te chercher ! » Il quitte la vue." CR>
		<SETG CHEST-LIFTED T>
		<MOVE ,CHEST ,MAN>
		<FSET ,CHEST ,TOUCHBIT>
		<SETG ROPE-FLAG <>>
		<SETG CHEST-TIED <>>
		<ENABLE <QUEUE I-MAN-RETURNS 10>>
		<RTRUE>)
	       (T
		<TELL
"Au bord de la falaise au-dessus de vous, un homme apparaît. Il vous regarde et vous parle. \"Bonjour, là-bas! Vous semblez avoir un problème. Peut-être que je peux vous aider.\" Il se branle d'une manière troublante. \"Peut-être que si vous attachiez cette poitrine à l'extrémité de la corde, je pourrais la traîner pour vous. Alors, je serai plus qu'heureux de vous aider!\"" CR>
		<SETG MAN-FLAG T>
		<SETG MAN-SEEN T>
		<ENABLE <QUEUE I-MAN-PRESENT -1>>)>>

<GLOBAL MAN-SEEN <>>

<ROUTINE I-MAN-PRESENT ()
	 <COND (<OR <NOT <==? ,HERE ,CLIFF-LEDGE>>
		    <NOT ,MAN-FLAG>
		    <IN? ,CHEST ,MAN>>
		<QUEUE I-MAN-PRESENT 0>
		<SETG MAN-FLAG <>>
		<RFALSE>)
	       (<G? <SETG MAN-WAITING <+ ,MAN-WAITING 1>> 10>
		<TELL
"L'homme a l'air très mécontent. « Très bien, alors. Je suppose que quelqu'un d'autre peut toujours m'aider! A bientôt, le sport! » Il disparaît." CR>
		<QUEUE I-MAN-PRESENT 0>
		<SETG MAN-FLAG <>>
		<RTRUE>)
	       (T <TELL <PICK-ONE ,MAN-WAITS> CR>)>>

<ROUTINE CLIFF-BASE-F (RARG)
	 <COND (<AND <==? .RARG ,M-ENTER>
		     ,CHEST-TIED>
		<SETG CHEST-TIED <>>
		<SETG ROPE-FLAG <>>
		<QUEUE I-MAN-APPEARS 0>)>>

<GLOBAL MAN-WAITS <LTABLE 0
"L'homme semble devenir quelque peu impatient."
"Votre ami au sommet de la falaise a commencé à faire les cent pas nerveusement. autour."
"\"Yoo hoo!\" » appelle l'homme au bord de la falaise. \"Tu te souviens de moi ?\""
"L'homme sur les vagues de falaise sur vous. \"Il faudrait juste un moment pour attacher cette corde à la poitrine. Je serais très obligé, et il pourrait même y avoir quelque chose pour vous!\""
"Quelques petites pierres tombent près de tes pieds. Tu regardes et tu vois ton ami agiter. \"Je n'ai pas toute la journée, mon gars. Sois un ami et passe la poitrine!\""
"\"Je ne veux pas vous précipiter, mais j'ai des fiançailles pressantes...\"">>

<GLOBAL MAN-WAITING 0>
<GLOBAL MAN-FLAG <>>
<GLOBAL MAN-POINT <>>
<GLOBAL MAN-GONE <>>

<ROUTINE CLIFF-LEDGE-F (RARG)
	 <COND (<AND <==? .RARG ,M-BEG>
		     <VERB? WALK>
		     <IN? ,CHEST ,WINNER>
		     ,CHEST-TIED>
		<TELL
"Vous ne pouvez aller nulle part en tenant ce coffre. La corde est nouée autour !" CR>)
	       (<AND <==? .RARG ,M-ENTER>
		     <NOT ,MAN-SEEN>
		     <NOT ,MAN-FLAG>
		     <NOT ,MAN-GONE>>
		<COND (<NOT ,MAN-POINT>
		       <SETG SCORE <+ ,SCORE 1>>
		       <SETG MAN-POINT T>)>
		<ENABLE <QUEUE I-MAN-APPEARS 5>>)
	       (<==? .RARG ,M-LOOK>
		<TELL
"C'est un rebord de rocher près de la base d'une haute falaise. Le fond de la falaise est encore quinze pieds en dessous. Vous avez peu d'espoir d'escalade sur la falaise, mais vous pourriez être en mesure de brouillonner d'ici (bien qu'il soit douteux que vous pourriez revenir)." CR>
		<COND (,ROPE-FLAG
		       <TELL
"Un long morceau de corde descend du haut de la falaise et est à votre portée." CR>)>
		<RTRUE>)>>

<ROUTINE CLIFF-F (RARG)
	 <COND (<AND <==? .RARG ,M-ENTER> <IN? ,CHEST ,MAN>>
		<QUEUE I-MAN-RETURNS 0>
		<MOVE ,CHEST ,HERE>
		<FSET ,CHEST ,OPENBIT>
		<SETG ROPE-FLAG T>
		<SETG CHEST-TIED <>>
		<SETG CHEST-OPENED T>
		<RFALSE>)
	       (<==? .RARG ,M-LOOK>
		<TELL
"C'est un endroit remarquable dans le donjon. Peut-être que deux cents pieds au-dessus de vous est un trou béant dans la surface de la terre à travers lequel coule un soleil éclatant! Quelques semis du monde d'en haut, nourris par la lumière du soleil et des pluies occasionnelles, ont grandi en arbres géants, ce qui en fait une oasis virtuelle dans le désert de l'Empire Underground. À l'ouest est un pur précipice, tombant près de cinquante pieds aux rochers déchiquetés en dessous. La voie sud est barrée par un mur de pierre interdit, s'écroulant à partir de l'âge." CR>
		<COND (,ROPE-FLAG
		       <TELL
"Une corde est attachée à l'un des grands arbres ici et flotte sur le côté de la falaise, atteignant l'étagère en bas." CR>)>
		<RTRUE>)
	       (<AND <==? .RARG ,M-END>
		     <PROB 15>
		     <NOT <FSET? ,CLIFF-LEDGE ,TOUCHBIT>>>
		<TELL
"Vous attrapez, hors du coin de l'œil, un mouvement parmi les arbres." CR>)
	       (<AND <==? .RARG ,M-END>
		     <PROB 20>>
		<TELL
"Vous semblez entendre, venant du sud-ouest, les bruits de la mer." CR>)>>

<ROUTINE GLOBAL-ROPE-F ()
	 <COND (<NOT ,ROPE-FLAG>
		<TELL "On ne voit aucune corde ici." CR>)
	       (<VERB? CLIMB-FOO>
		<V-CLIMB-UP ,P?DOWN T>)
	       (<VERB? TAKE MOVE CLIMB-ON>
		<COND (<NOT ,MAN-FLAG>
		       <TELL
"Un petit remorqueur sur la corde vous convainc qu'il est solidement fixé d'en haut." CR>)
		      (<IN? ,CHEST ,MAN>
		       <SETG HOLDING-ROPE T>
		       <TELL
"Vous vous accrochez solidement à la corde." CR>)
		      (T
		       <TELL
"\"Je peux vous aider, mais pas avant d'avoir cette poitrine.\" Il pointe vers la poitrine près de vous sur le rebord." CR>)>)
	       (<VERB? CLIMB-UP>
		<TELL
"Vous essayez de grimper la corde, mais vous ne pouvez pas atteindre le sommet même avec votre meilleur effort." CR>)
	       (<VERB? TIE>
		<COND (<EQUAL? ,CHEST ,PRSO ,PRSI>
		       <TELL
"La poitrine est maintenant attachée à la corde." CR>
		       <SETG CHEST-TIED T>
		       <COND (<AND ,MAN-FLAG <NOT ,MAN-GONE>>
			      <TELL
"L'homme au-dessus de vous a l'air content. \"Maintenant il y a un bon ami! Merci beaucoup, en effet!\" Il tire sur la corde et la poitrine est levée au sommet de la falaise et hors de vue. Avec un petit rire, il disparaît. \"Je reviens dans un court moment!\" sont ses derniers mots." CR>
			      <MOVE ,CHEST ,MAN>
			      <FSET ,CHEST ,TOUCHBIT>
			      <SETG CHEST-TIED <>>
			      <SETG ROPE-FLAG <>>
			      <ENABLE <QUEUE I-MAN-RETURNS 10>>
			      <SETG MAN-FLAG <>>
			      <RTRUE>)>
		       <RTRUE>)
		      (<EQUAL? ,ME ,PRSI ,PRSO>
		       <COND (<AND ,MAN-FLAG <IN? ,CHEST ,MAN>>
			      <TELL
"\"Attrapez-le !\", beugle l'homme." CR>)
			     (,MAN-FLAG
			      <TELL
"L'homme a l'air de se croiser. \"Je veux la poitrine, pas toi!\" il s'agite." CR>)
			     (T
			      <TELL
"Vous ne parvenez pas à attacher la corde autour de vous." CR>)>)
		      (T
		       <TELL
"Vous ne parvenez pas à attacher la corde à cela." CR>)>)
	       (<VERB? UNTIE>
		<COND (,CHEST-TIED
		       <SETG CHEST-TIED <>>
		       <TELL
"Le coffre est maintenant déconnecté de la corde." CR>)
		      (T
		       <TELL
"La corde n'est attachée à rien." CR>)>)>>

<GLOBAL CHEST-TIED <>>
<GLOBAL HOLDING-ROPE <>>

<ROUTINE I-MAN-RETURNS ()
	 <SETG ROPE-FLAG T>
	 <COND (<==? ,HERE ,CLIFF-LEDGE>
		<TELL
"Une voix familière t'appelle. « Es-tu toujours là ? » dit-il avec un rire grossier. « Eh bien, alors, attrape la corde et nous verrons ce que nous pouvons faire. » La corde tombe à votre portée." CR>
		<SETG MAN-FLAG T>
		<ENABLE <QUEUE I-MAN-LIFT -1>>
		<RTRUE>)>>

<GLOBAL LIFT-WAIT 0>

<ROUTINE I-MAN-LIFT ()
	 <COND (<NOT <==? ,HERE ,CLIFF-LEDGE>>
		<QUEUE I-MAN-LIFT 0>
		<MOVE ,CHEST ,CLIFF>
		<FSET ,CHEST ,OPENBIT>
		<SETG CHEST-OPENED T>
		<REMOVE ,MAN>
		<RFALSE>)
	       (,HOLDING-ROPE
		<TELL
"L'homme commence à se hisser sur la corde et en quelques instants vous arrivez au sommet de la falaise. L'homme enlève les derniers objets de valeur de la poitrine et se prépare à partir. \"Vous avez été un bon sport! Tenez, prenez ceci, pour quelque bien que ce soit! Je ne vois pas que j'en ai besoin!\" Il vous tend un bâton en bois uni du bas de la poitrine et commence à examiner ses objets de valeur." CR>
		<QUEUE I-MAN-LIFT 0>
		<MOVE ,STAFF ,WINNER>
		<SETG HOLDING-ROPE <>>
		<SETG ROPE-FLAG T>
		<MOVE ,WINNER ,CLIFF>
		<MOVE ,CHEST ,CLIFF>
		<FSET ,CHEST ,OPENBIT>
		<TELL
"Le coffre, ouvert et vide, est à vos pieds." CR>
		<SETG CHEST-OPENED T>
		<MOVE ,MAN ,CLIFF>
		<ENABLE <QUEUE I-MAN-LEAVES -1>>
		<RTRUE>)
	       (<G? <SETG LIFT-WAIT <+ ,LIFT-WAIT 1>> 4>
		<TELL
"-- Eh bien, je n'ai pas toute la journée. A bientôt." CR>
		<SETG MAN-FLAG <>>
		<MOVE ,CHEST ,CLIFF>
		<FSET ,CHEST ,OPENBIT>
		<SETG CHEST-OPENED T>
		<QUEUE I-MAN-LIFT 0>)
	       (T
		<TELL
"L'homme semble impatient. \"Vous venez alors ou pas ?\"" CR>)>>

<GLOBAL CHEST-OPENED <>>

<ROUTINE CHEST-F ()
	 <COND (,CHEST-OPENED
		<COND (<AND <VERB? TIE> <==? ,ROPE ,PRSO ,PRSI>>
		       <TELL "À quoi ça sert ?" CR>)
		      (<AND <VERB? PUT> <EQUAL? ,PRSO ,STAFF ,LAMP ,TORCH>>
		       <TELL "Ce n'est pas le cas fit.">
		       <COND (<EQUAL? ,PRSO ,STAFF>
			      <TELL
" Terriblement étrange, cependant, puisque c'est là que le personnel est venu de.">)>
		       <CRLF>)
		      (T <RFALSE>)>)
	       (<VERB? OPEN UNLOCK>
		<COND (,MAN-FLAG
		       <TELL
"L'homme t'appelle. \"Est-ce ce que tu cherches?\" il se tape, agitant une petite clé sur sa tête. Tu essaies d'ouvrir la poitrine, mais elle est verrouillée." CR>)
		      (T
		       <TELL
"Le coffre est verrouillé et ne peut pas être ouvert." CR>)>)>>

<GLOBAL ROPE-FLAG T>

<ROUTINE I-MAN-LEAVES ()
	 <COND (<NOT <==? ,HERE ,CLIFF>>
		<REMOVE ,MAN>
		<SETG MAN-GONE T>
		<SETG MAN-FLAG <>>
		<SETG ROPE-FLAG T>
		<QUEUE I-MAN-LEAVES 0>
		<RFALSE>)
	       (<PROB 40>
		<TELL
"Votre \"ami\", se déplaçant rapidement, évite derrière certains arbres et est perdu de vue." CR>
		<REMOVE ,MAN>
		<SETG MAN-FLAG <>>
		<SETG MAN-GONE T>
		<SETG ROPE-FLAG T>
		<QUEUE I-MAN-LEAVES 0>
		<RTRUE>)
	       (T
		<TELL
"Votre « ami » examine ses objets de valeur avec une grande fierté." CR>)>>

<ROUTINE MAN-F ()
	 <COND (<VERB? HELLO>
		<TELL
"Il répond joyeusement. \"C'est une journée merveilleuse, n'est-ce pas ?\"" CR>)
	       (<HELLO? ,MAN>
		<TELL
"L'homme est complètement absorbé dans l'examen de son butin et ne semble pas vous entendre." CR>)
	       (<VERB? EXAMINE>
		<TELL
"L'homme est bas et de taille moyenne, avec plusieurs jours de croissance de chaume sur son visage. Il porte un certain nombre de valeurs sous son bras, probablement de la poitrine maintenant ouverte." CR>)
	       (<VERB? ATTACK>
		<COND (<==? ,PRSI ,SWORD>
		       <TELL
"L'homme est pris par surprise et frappé par l'épée. Il vous attrape et vous jette à terre">
		       <COND (<EQUAL? <LOC ,STAFF> ,WINNER ,HERE>
			      <TELL ", brisant le bâton dans le processus">
			      <REMOVE ,STAFF>
			      <MOVE ,BROKEN-STAFF ,HERE>)>
		       <TELL "Il meurt, et disparaît sans cérémonie dans le style habituel du Grand Empire Souterrain. Ses objets de valeur variés restent derrière." CR>
		       <REMOVE ,MAN>
		       <MOVE ,VALUABLES ,HERE>
		       <FCLEAR ,VALUABLES ,NDESCBIT>
		       <QUEUE I-MAN-LEAVES 0>
		       <SETG MAN-GONE T>)
		      (T <TELL "Vous ne lui feriez pas de mal avec ça !" CR>)>)>>

<ROUTINE VALUABLES-F ()
	 <COND (<AND <VERB? TAKE PUT MOVE> <IN? ,MAN ,CLIFF>>
		<TELL
"L'homme recule brusquement. \"Ces choses ici sont les miennes. C'est ma poitrine et ce sont mes objets de valeur. Vous avez beaucoup de nerf essayant de me les prendre après que je vous ai sauvé comme ça!\"" CR>)
	       (<AND ,MAN-GONE <IN? ,VALUABLES ,MAN>>
		<TELL
"Quels objets de valeur ?" CR>)>>

<ROUTINE ROPE-F ()
	 <COND (<VERB? TAKE MOVE>
		<COND (,ROPE-FLAG
		       <TELL
"La corde est attachée à un arbre." CR>)>)
	       (<VERB? CLIMB-FOO>
		<V-CLIMB-UP ,P?DOWN T>)
	       (<VERB? BURN>
		<TELL
"La corde refuse de prendre feu." CR>)
	       (<VERB? UNTIE>
		<TELL
"La corde est très solidement attachée et ne peut pas être défaite." CR>)
	       (<AND <VERB? CUT> <==? ,PRSI ,SWORD>>
		<TELL
"La corde est faite d'un matériau assez résistant et ne coupé." CR>)>>
		     
<ROUTINE GLOBAL-MAN-F ()
	 <COND (<==? ,HERE ,CLIFF>
		<COND (,MAN-GONE
		       <TELL
"Vous l'avez perdu parmi les arbres." CR>)
		      (T
		       <TELL
"Vous ne voyez aucun homme ici." CR>)>)
	       (<NOT ,MAN-FLAG>
		<TELL
"Vous ne voyez aucun homme ici." CR>)
	       (<VERB? GIVE>
		<TELL
"Vous n'êtes même pas près de lui !" CR>)
	       (<VERB? HELLO>
		<TELL
"L'homme lui répond amicalement." CR>)
	       (<HELLO? ,GLOBAL-MAN>
		<TELL
"Il répond en criant : \"Qu'est-ce que tu dis ? Je ne vous entends pas très bien.">
		<COND (<NOT ,CHEST-LIFTED>
		       <TELL
"Juste attacher la corde à la poitrine et nous pouvons discuter après!\" Il sourit largement.">)
		      (T <TELL "\"">)>
		<CRLF>)
	       (<VERB? ATTACK MUNG>
		<TELL
"Il est peu probable que vous réussissiez à cette distance." CR>)
	       (<AND <VERB? THROW> <==? ,PRSI ,GLOBAL-MAN> <IN? ,PRSO ,WINNER>>
		<TELL
"Le " D ,PRSO "Vole vers le haut, mais pas assez loin pour frapper l'homme. Il semble cependant l'amuser, surtout qu'il passe à quelques centimètres de votre tête. \"Nous perdons du temps maintenant. Soyez un bon gars et attachez la corde!\"" CR>
		<MOVE ,PRSO ,HERE>)>>

<ROUTINE LAKE-F ()
	 <COND (<VERB? THROUGH LEAP BOARD>
		<COND (<EQUAL? ,HERE ,LAKE-SHORE ,FAR-SHORE ,SOUTH-SHORE>
		       <GO-ON-LAKE>)
		      (<==? ,HERE ,ON-LAKE>
		       <GOTO ,IN-LAKE>)
		      (T
		       <TELL "Où pensez-vous être ?" CR>)>)
	       (<VERB? LOOK-UNDER>
		<COND (<==? ,HERE ,ON-LAKE>
		       <TELL
"Vous ne distinguez pas vraiment le fond du lac depuis ici..." CR>)
		      (T <TELL
"Vous ne pouvez pas voir sous la surface d'ici." CR>)>)>>

<ROUTINE IN-LAKE-F (RARG)
	 <COND (<==? .RARG ,M-ENTER>
		<ENABLE <QUEUE I-IN-LAKE 3>>)
	       (<AND <==? .RARG ,M-BEG>
		     <VERB? TAKE>
		     <NOT <EQUAL? ,PRSO ,SHINY-OBJECT>>>
		<COND (<G? <WEIGHT ,WINNER> 25>
		       <TELL "Vous ne pouvez pas transporter autant de choses sous l'eau." CR>)
		      (<NOT <FSET? ,PRSO ,TAKEBIT>>
		       <TELL "Vous ne pouvez pas emporter ça !" CR>)
		      (<PROB 30>
		       <TELL "Le " D ,PRSO
" est à toi pendant un moment, mais il échappe à ta portée." CR>)>)
	       (<==? .RARG ,M-END>
		<COND (<PROB 10>
		       <TELL
"Un gros poisson à l'air affamé nage dans le quartier." CR>)
		      (<AND <PROB 4> <NOT ,INVIS>>
		       <QUEUE I-ROC 0>
		       <QUEUE I-ON-LAKE 0>
		       <JIGS-UP
"Oh, non ! Un énorme poisson vient de vous avaler en entier !">)
		      (<IN? ,SHINY-OBJECT ,HERE>
		       <COND (<==? ,MOVES ,LAST-MOVES> <RTRUE>)
			     (<PROB 40>
			      <TELL
"Hors du coin de l'œil, un petit objet brillant apparaît dans le sable. Un moment plus tard, il est parti !" CR>)
			     (<PROB 70>
			      <TELL
"Vous apercevez brièvement quelque chose de brillant dans le sable." CR>)
			     (T
			      <TELL
"Quelque chose de scintillant dans le sable attire votre attention pendant un moment. moment." CR>)>
		       <SETG LAST-MOVES ,MOVES>)>)>>

<GLOBAL LAST-MOVES 0>

<ROUTINE I-IN-LAKE ()
	 <COND (<==? ,HERE ,IN-LAKE>
		<TELL
"Vous manquez d'air et retournez à la surface." CR>
		<GOTO ,ON-LAKE>)>>

<GLOBAL LAKE-POINT <>>

<ROUTINE ON-LAKE-F (RARG)
	 <COND (<==? .RARG ,M-ENTER>
		<QUEUE I-IN-LAKE 0>
		<COND (<NOT ,LAKE-POINT>
		       <SETG SCORE <+ ,SCORE 1>>
		       <SETG LAKE-POINT T>)>)
	       (<AND <==? .RARG ,M-BEG> <VERB? LEAP> <NOT ,PRSO>>
		<DO-WALK ,P?DOWN>
		<RTRUE>)>>

<GLOBAL CURRENT-LAMP LAMP>

<ROUTINE GO-ON-LAKE ("AUX" F N (TOLD <>))
	 <COND (<SET F <FIRST? ,WINNER>>
		<REPEAT ()
			<SET N <NEXT? .F>>
			<COND (<NOT <FSET? .F ,WEARBIT>>
			       <MOVE .F ,IN-LAKE>
			       <COND (<==? .F ,TORCH>
				      <REMOVE ,TORCH>
				      <MOVE ,FRIED-TORCH ,IN-LAKE>)
				     (<EQUAL? .F ,LAMP>
				      <MOVE ,LAMP ,LOCAL-GLOBALS>
				      <MOVE ,FRIED-LAMP ,IN-LAKE>
				      <SETG CURRENT-LAMP ,FRIED-LAMP>)
				     (<==? .F ,WAYBREAD>
				      <REMOVE ,WAYBREAD>)>
			       <COND (<NOT .TOLD>
				      <SET TOLD T>
				      <TELL
"Le choc d'entrer dans l'eau frigide vous a fait tomber tous vos biens dans le lac !" CR>)>)>
			<COND (<NOT .N> <RETURN>)
			      (T <SET F .N>)>>)>
	 <COND (<NOT .TOLD>
		<TELL
"Vous êtes presque paralysé par les eaux glacées alors que vous nagez dans le centre du lac." CR>)>
	 <CRLF>
	 <GOTO ,ON-LAKE>
	 <SETG LAKE-TIME 0>
	 <ENABLE <QUEUE I-ON-LAKE -1>>>

<GLOBAL LAKE-TIME <>>

<ROUTINE I-ON-LAKE ()
	 <SETG LAKE-TIME <+ ,LAKE-TIME 1>>
	 <COND (<AND <PROB 10> <==? ,HERE ,ON-LAKE> <NOT ,INVIS>>
		<TELL
"Un roc géant, autrefois caché parmi les rochers, se dirige vers vous, sa bouche s'entassant largement !" CR>
		<ENABLE <QUEUE I-ROC 2>>)
	       (<NOT <EQUAL? ,HERE ,ON-LAKE ,IN-LAKE>>
		<QUEUE I-ON-LAKE 0>
		<QUEUE I-IN-LAKE 0>
		<QUEUE I-ROC 0>
		<RFALSE>)
	       (<==? ,LAKE-TIME 4>
		<TELL
"Les eaux glacées sont en train de faire leurs dégâts." CR>)
	       (<==? ,LAKE-TIME 6>
		<TELL
"Tu deviens très faible, tu ferais mieux de quitter l'eau avant de te noyer !" CR>)
	       (<==? ,LAKE-TIME 8>
		<QUEUE I-ON-LAKE 0>
		<QUEUE I-IN-LAKE 0>
		<QUEUE I-ROC 0>
		<JIGS-UP
"Votre force s'épuise et vous vous noyez dans les eaux glaciales.">)>>

<ROUTINE I-ROC ()
	 <COND (<AND <==? ,HERE ,ON-LAKE> <NOT ,INVIS>>
		<QUEUE I-ON-LAKE 0>
		<QUEUE I-IN-LAKE 0>
		<JIGS-UP
"Le rocher vous attrape dans ses mâchoires et vous tient pour déjeuner.">)>>

<ROUTINE SHINY-OBJECT-F ()
	 <COND (<AND <VERB? TAKE FIND> <NOT <IN? ,AMULET ,WINNER>>>
		<COND (<PROB 50>
		       <REMOVE ,SHINY-OBJECT>
		       <MOVE ,AMULET ,WINNER>
		       <THIS-IS-IT ,AMULET>
		       <FCLEAR ,AMULET ,NDESCBIT>
		       <TELL
"Vous atteignez l'objet brillant. C'est une simple amulette dorée !" CR>)
		      (T
		       <TELL
"L'objet brillant glisse de votre prise et revient sur le sol du lac, où il est recouvert de sable." CR>)>)>>

<ROUTINE SAND-F ()
	 <COND (<VERB? DIG>
		<TELL "Vous ne rencontrez rien d'inhabituel." CR>)
	       (<VERB? EXAMINE>
		<TELL
"Il n'y a rien de remarquable sur le sol du lac, sauf quelques plantes et algues." CR>)
	       (<VERB? TAKE>
		<TELL "Ça glisse entre vos doigts." CR>)>>

<ROUTINE ALGAE-F ()
	 <COND (<VERB? EAT> <TELL "Ouais !" CR>)>>

<ROUTINE FRIED-LAMP-F ()
	 <COND (<VERB? LAMP-ON>
		<TELL
"La lampe ne fonctionne pas (probablement après avoir été mouillé)." CR>)>>

<GLOBAL VIEW-POINT 1>

<ROUTINE I-VIEW-SNAP ()
	 <TELL "Vous vous retrouvez soudainement dans la salle d'observation !" CR>
	 <GOTO ,VIEW-ROOM <>>
	 <RTRUE>>

<ROUTINE VIEWING-TABLE-F ("AUX" L)
	 <COND (<VERB? RUB>
		<SETG SCORE <+ ,SCORE ,VIEW-POINT>>
		<SETG VIEW-POINT 0>
		<TELL
"Vous touchez la table et êtes instantanément transporté vers un autre endroit !" CR>
		<CRLF>
		<ENABLE <QUEUE I-VIEW-SNAP 3>>
		<GOTO <GET ,VIEW-ROOMS ,ACTIVE-VIEW>>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
"La surface est pâle et sans relief, mais lentement, une image prend forme !" CR>
	        <TELL <GET ,VIEWS ,ACTIVE-VIEW> CR>
		<TELL
"L'image s'estompe lentement." CR>)>>

<ROUTINE I-VIEW-CHANGE ()
	 <SETG ACTIVE-VIEW <+ ,ACTIVE-VIEW 1>>
	 <COND (<==? ,ACTIVE-VIEW 5> <SETG ACTIVE-VIEW 1>)>
	 <QUEUE I-VIEW-CHANGE 4>
	 <COND (<==? ,HERE ,VIEW-ROOM>
		<TELL
"L'indicateur au-dessus de la table clignote brièvement, puis passe à \"">
		<TELL <GET ,VIEW-ROMANS ,ACTIVE-VIEW> "\"." CR>)>>

<ROUTINE VIEW-ROOM-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL
"Vous êtes dans une petite chambre taillée dans la roche, dont l'unique sortie se trouve au nord. Une table portant l'inscription \"Panorama\" est fixée à un mur ; sa surface lisse est inclinée vers vous. On pourrait croire qu'elle servait à signaler les points remarquables visibles depuis cet endroit, comme dans de nombreux parcs. Pourtant, les lieux sont exigus et, même avec beaucoup d'imagination, on ne saurait les qualifier de pittoresques. Un indicateur placé au-dessus de la table affiche \"">
		<TELL <GET ,VIEW-ROMANS ,ACTIVE-VIEW> "\"." CR>)>>
		
<GLOBAL VIEW-ROMANS <TABLE 0 "I" "II" "III" "IV">>

<GLOBAL ACTIVE-VIEW 1>

<GLOBAL VIEW-ROOMS <LTABLE TIMBER-ROOM ROOM-8 DAMP-PASSAGE ZORK-IV>>

<GLOBAL VIEWS <LTABLE
"Vous voyez un passage encombré de bois cassés. Une ouverture extrêmement étroite peut être vue au bout de la pièce."
"Vous voyez une petite pièce avec des murs rugueux. Ciselés grossièrement sur un mur est le nombre \"8\". La seule sortie apparente semble être un flou."
"Vous voyez une grande pièce avec deux passages presque identiques menant à l'est et au nord-est. Un large canal descend abruptement dans la pièce et semble bloqué par des décombres."
"Vous voyez l'intérieur d'un immense temple grossièrement construit de blocs de basalte. Torches enflammées ont jeté une lumière de suif sur un autel encore humide avec le sang du sacrifice humain, ses couvertures de velours tachées et incrustées de gore.">>

<ROUTINE CLIFF-OBJECT-F ()
	 <COND (<==? ,HERE ,CLIFF>
		<COND (<VERB? LEAP>
		       <JIGS-UP
"Vous auriez dû regarder avant de sauter.">)
		      (<VERB? CLIMB-DOWN>
		       <COND (,ROPE-FLAG
			      <GOTO ,CLIFF-LEDGE>
			      <RTRUE>)
			     (T <TELL "La chute vous tuerait." CR>)>)
		      (<AND <VERB? THROW-OFF> <==? ,PRSI ,CLIFF-OBJECT>>
		       <COND (<==? ,PRSO ,ROPE>
			      <TELL
"La corde pend au bord de la falaise. déjà." CR>
			      <RTRUE>)
			     (<NOT <IN? ,PRSO ,WINNER>>
			      <TELL
"Vous ne tenez pas le " D ,PRSO "." CR>
			      <RTRUE>)>
		       <MOVE ,PRSO ,CLIFF-LEDGE>
		       <TELL
"Le " D ,PRSO " franchit la falaise et atterrit parmi les rochers en contrebas." CR>
		       <COND (<==? ,PRSO ,LAMP>
			      <REMOVE ,PRSO>
			      <MOVE ,BROKEN-LAMP ,CLIFF-LEDGE>
			      <SETG CURRENT-LAMP ,BROKEN-LAMP>)
			     (<==? ,PRSO ,STAFF>
			      <REMOVE ,PRSO>
			      <MOVE ,BROKEN-STAFF ,CLIFF-LEDGE>)>
		       <RTRUE>)>)
	       (<VERB? CLIMB-UP>
		<TELL "Vous n'avez pas assez de force pour escalader la falaise." CR>)
	       (T <TELL "La falaise est au-dessus vous !" CR>)>>

<ROUTINE TREE-F ()
	 <COND (<VERB? CLIMB-UP CLIMB-FOO>
		<TELL "Les troncs sont trop grands pour que vous puissiez y grimper." CR>)
	       (<AND <VERB? EXAMINE LOOK-INSIDE> <NOT ,MAN-SEEN>>
		<TELL
"Il semble n'y avoir personne là-bas, mais c'est difficile de dites-le." CR>)
	       (<VERB? BURN>
		<JIGS-UP
"Smokey l'ours éteint le feu et vous.">)>>

<ROUTINE FRIED-TORCH-F ()
	 <COND (<VERB? LAMP-ON>
		<TELL "C'est sans espoir. La torche est mouillée." CR>)>>

<ROUTINE TORCH-F ()
	 <COND (<VERB? LAMP-ON>
		<COND (<FSET? ,TORCH ,ONBIT> <TELL "Elle est déjà allumée." CR>)
		      (T <TELL "Vous n'avez rien pour l'allumer." CR>)>)
	       (<VERB? LAMP-OFF>
		<COND (<FSET? ,TORCH ,ONBIT>
		       <TELL "Vous parvenez à éteindre la torche. flamme." CR>
		       <FCLEAR ,TORCH ,ONBIT>)
		      (T <TELL "Elle a déjà été éteinte." CR>)>)>>

;"Here's some ZORK I"

<OBJECT TIMBERS	;"was OTIMB"
	(IN TIMBER-ROOM)
	(SYNONYM TIMBERS PILE)
	(ADJECTIVE WOODEN BROKEN)
	(DESC "bois brisé")
	(FLAGS TAKEBIT)
	(SIZE 50)>

<ROOM LADDER-TOP	;"was TLADD"
      (IN ROOMS)
      (LDESC
"C'est une très petite pièce. Dans le coin est une échelle en bois ricket, menant vers le bas. Il pourrait être sûr de descendre. Il y a aussi un escalier menant vers le haut.")
      (DESC "Haut de l'échelle")
      (DOWN TO LADDER-BOTTOM)
      (FLAGS RLANDBIT)
      (GLOBAL LADDER STAIRS)>

<OBJECT LADDER
	(IN LOCAL-GLOBALS)
	(SYNONYM LADDER)
	(ADJECTIVE WOODEN RICKETY NARROW)
	(DESC "en bois échelle")
	(FLAGS NDESCBIT CLIMBBIT)>

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
      (LDESC "Vous êtes arrivé à une impasse dans la mine.| Il y a un petit tas de charbon ici.")
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
      (FLAGS RLANDBIT)>

<ROOM LOWER-SHAFT	;"was BSHAF"
      (IN ROOMS)
      (DESC "Salle des courants d'air")
      (SOUTH TO MACHINE-ROOM)
      (OUT TO TIMBER-ROOM)
      (EAST TO TIMBER-ROOM)
      (ACTION NO-OBJS)
      (FLAGS RLANDBIT)>

<ROOM MACHINE-ROOM
      (IN ROOMS)
      (DESC "Salle des machines")
      (FLAGS RLANDBIT)>

<GLOBAL EMPTY-HANDED <>>

<ROUTINE NO-OBJS (RARG "AUX" F)
	 <COND (<==? .RARG ,M-BEG>
		<SET F <FIRST? ,WINNER>>
		<SETG EMPTY-HANDED T>
		<REPEAT ()
			<COND (<NOT .F> <RETURN>)
			      (<G? <WEIGHT .F> 4>
			       <SETG EMPTY-HANDED <>>
			       <RETURN>)>
			<SET F <NEXT? .F>>>
		<RFALSE>)>>

;"Stuff from ZORK II"

<ROOM ROOM-8
      (IN ROOMS)
      (LDESC
"C'est une petite chambre taillée dans la roche à la fin d'une courte rampe. Sur le mur est grossièrement ciselé le nombre \"8\". La seule sortie apparente, à l'est, semble être un flou et un son bruyant et bruyant résonne à travers la roche.")
      (DESC "Salle 8")
      (FLAGS RLANDBIT)
      (EAST "Vous êtes repoussé de la sortie par un vent violent.")>

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

<ROUTINE REPELLENT-FCN ()
	 <COND (<VERB? SHAKE>
		<COND (,SPRAY-USED? <TELL "La boîte semble vide." CR>)
		      (T <TELL "Il y a un bruit de clapotis provenant de à l'intérieur." CR>)>)
	       (<VERB? BURN>
		<JIGS-UP
"La canette explose et vous mourez d'une mort horriblement puante.">)
	       (<AND <VERB? SPRAY PUT-ON> <==? ,PRSO ,REPELLENT>>
		<COND (,SPRAY-USED?
		       <TELL
"Le répulsif a entièrement disparu." CR>)
		      (<NOT ,PRSI>
		       <SETG SPRAY-USED? T>
		       <TELL
"Le spray pue incroyablement pendant quelques instants, puis s'éloigne." CR>)
		      (ELSE
		       <COND (<==? ,PRSI ,ME>
			      <ENABLE <QUEUE I-SPRAY 5>>
			      <SETG SPRAYED? T>)>
		       <SETG SPRAY-USED? T>
		       <TELL
"Le spray sent comme un mélange de vieilles chaussettes et de caoutchouc brûlant." CR>)>)>>

<GLOBAL SPRAY-USED? <>>

<ROUTINE I-SPRAY ()
	 <SETG SPRAYED? <>>
	 <TELL "Cette horrible odeur est beaucoup moins âcre maintenant." CR>>

;"Stuff from ZORK IV"

<ROOM ZORK-IV
      (IN ROOMS)
      (DESC "Autel sacrificiel")
      (FLAGS ONBIT RLANDBIT)
      (ACTION ZORK-IV-F)>

<ROUTINE ZORK-IV-F (RARG)
	 <COND (<==? .RARG ,M-ENTER>
		<JIGS-UP
"Autel sacrificiel|
C'est l'intérieur d'un immense temple de construction primitive. Quelques-uns
des torches vacillantes projettent une illumination jaunâtre sur l'autel, qui est
encore trempé du sang du sacrifice humain. Derrière l'autel se trouve un
énorme statue d'un démon qui semble tendre vers vous avec
des crocs dégoulinants et des serres acérées comme des rasoirs. Un faible bruit commence derrière vous,
et vous vous retournez pour voir des centaines de formes voûtées et poilues. Un guttural
chantent des choses de leur gorge. Près de vous se tient une silhouette drapée dans un
robe du noir le plus profond, brandissant une énorme épée. Le chant devient plus fort
alors que la silhouette en robe s'approche de l'autel. La grande silhouette vous repère et
s'approche d'un air menaçant. Il plonge la main dans son manteau et en sort un grand
poignard brillant. Il vous attire vers l'autel et, avec un murmure de
l'approbation de la foule vous coupe soigneusement l'abdomen.">)>>

;"Last Section"

<ROOM SOUTH-SHORE
      (IN ROOMS)
      (DESC "Rive Sud")
      (LDESC
"Vous êtes sur la rive sud du lac. Les formations rocheuses empêchent le mouvement vers l'ouest et les marécages épaississants à l'est rend la marche tout sauf impossible. Au sud, où la plage rencontre une formation rocheuse, vous pouvez faire un passage sombre en pente raide vers le haut dans la roche.")
      (EAST "Le marais est trop épais.")
      (UP TO DARK-1)
      (NORTH "Si vous voulez aller dans le lac, vous devriez le dire.")
      (SOUTH TO DARK-1)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL LAKE)
      (PSEUDO "PLAGE" SHORE-PSEUDO "SWAMP" SWAMP-PSEUDO)>

<ROOM DARK-1
      (IN ROOMS)
      (DESC "Lieu obscur")
      (NORTH TO SOUTH-SHORE)
      (SOUTH TO DARK-2)
      (UP TO DARK-2)
      (DOWN TO SOUTH-SHORE)
      (FLAGS RLANDBIT)>

<ROOM DARK-2
      (IN ROOMS)
      (DESC "Lieu obscur")
      (NORTH TO DARK-1)
      (EAST TO KEY-ROOM)
      (UP TO KEY-ROOM)
      (DOWN TO DARK-1)
      (FLAGS RLANDBIT)>

<ROOM KEY-ROOM
      (IN ROOMS)
      (DESC "Clé Pièce")
      (WEST TO DARK-2)
      (DOWN TO AQ-1 IF COVER-MOVED
       		    ELSE "Vous ne pouvez pas traverser un morceau de métal.")
      (ACTION KEY-ROOM-F)
      (FLAGS RLANDBIT ONBIT)>

<ROOM AQ-1
      (IN ROOMS)
      (DESC "Aqueduc")
      (UP "Le trou est trop au-dessus de votre tête.")
      (LDESC
"Vous êtes dans un large canal en pierre, une partie du système d'approvisionnement en eau pour le Grand Empire Souterrain. La source d'eau était une cascade au sud, qui a depuis longtemps séché. L'eau a coulé le long de l'aqueduc au nord. Cette région est éclairée d'en haut, bien que la source de lumière ne soit pas apparente.")
      (SOUTH "Vous ne pouvez pas escalader la cascade asséchée.")
      (NORTH TO AQ-2)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL AQUEDUCT WATER-CHANNEL MOSS)
      (PSEUDO "WATERF" WATERFALL-PSEUDO)>

<ROOM AQ-2
      (IN ROOMS)
      (DESC "Élevé Arche")
      (NORTH TO AQ-3 IF AQ-FLAG ELSE "L'arche devant vous est cassée.")
      (SOUTH TO AQ-1)
      (DOWN "C'est un long chemin vers le bas....")
      (FLAGS RLANDBIT ONBIT)
      (ACTION AQ-2-F)
      (GLOBAL AQUEDUCT WATER-CHANNEL MOSS)
      (PSEUDO "ARCH" ARCH-PSEUDO)>

<ROOM AQ-3
      (IN ROOMS)
      (DESC "Toboggan aquatique")
      (NORTH TO DAMP-PASSAGE)
      (DOWN TO DAMP-PASSAGE)
      (SOUTH TO AQ-2 IF AQ-FLAG ELSE "L'arche au sud est brisée.")
      (FLAGS RLANDBIT ONBIT)
      (ACTION AQ-3-F)
      (GLOBAL AQUEDUCT WATER-CHANNEL MOSS)
      (PSEUDO "ARCH" ARCH-PSEUDO)>

<OBJECT AQUEDUCT
	(IN LOCAL-GLOBALS)
	(DESC "aqueduc")
	(SYNONYM AQUEDUCT DUCT CHASM)
	(ADJECTIVE STONE)
	(ACTION AQUEDUCT-F)>

<OBJECT WATER-CHANNEL
	(IN LOCAL-GLOBALS)
	(DESC "canal")
	(SYNONYM CHANNEL)
	(ADJECTIVE WATER)
	(ACTION WATER-CHANNEL-F)>

<OBJECT MOSS
	(IN LOCAL-GLOBALS)
	(DESC "mousse et lichen")
	(SYNONYM MOSS LICHEN)
	(ACTION MOSS-F)>

<ROUTINE AQUEDUCT-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"L'aqueduc est grand et impressionnant. C'était probablement la principale méthode de transport de l'eau dans l'Empire." CR>)
	       (<VERB? LEAP>
		<JIGS-UP
"Vous exécutez un plongeon de cygne parfait dans les rochers en contrebas !">)>>

<ROUTINE WATER-CHANNEL-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"Le canal a quelques pieds de profondeur et dix pieds de largeur, avec un fond arrondi." CR>)
	       (<VERB? BOARD>
		<COND (<==? ,HERE ,DAMP-PASSAGE>
		       <TELL
"Entrer dans le canal ne serait pas d'une grande utilité." CR>)
		      (T
		       <TELL
"Sinon, tu flotterais en plein air au-dessus de roches très vilaines." CR>)>)>>

<ROUTINE MOSS-F ()
	 <COND (<VERB? TAKE MOVE>
		<TELL "Ne soyez pas stupide." CR>)>>

<ROUTINE AQ-2-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL
"Vous êtes maintenant sur l'un des plus hauts arches de l'aqueduc, des centaines de pieds au-dessus d'un chasme rocheux. L'immensité du projet d'aqueduc est apparente d'ici. Les supports de pierre se lèvent du plancher rocheux pour former des arches massives, qui traversent la région du nord au sud. Le canal porte-eau ici est large et profond. À l'ouest et au-dessous, vous pouvez faire un balcon qui doit commander une vue large de l'aqueduc." CR>
		<COND (<NOT ,AQ-FLAG>
		       <TELL
"Le chenal se termine brusquement vers votre nord où un pilier de support s'est effondré, jetant l'arc dans le chasme." CR>)>)>> 

<ROUTINE AQ-3-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL
"Vous êtes près de l'extrémité nord de ce segment du système d'aqueduc. Au sud et légèrement en amont, la majeure partie de l'aqueduc se profile de façon inquiétante, au-dessus d'une gorge. Au nord, le canal d'eau tombe de façon précipitée et entre dans un trou rocheux." CR>
		<COND (<NOT ,AQ-FLAG>
		       <TELL
"La partie sud du système d'aqueduc est inaccessible en raison de l'effondrement de l'un des arcs porteurs d'eau." CR>)>)>>

<GLOBAL AQ-FLAG T>

<GLOBAL COVER-MOVED <>>

<OBJECT COVER
	(IN KEY-ROOM)
	(DESC "regard")
	(SYNONYM COVER)
	(ADJECTIVE MANHOLE LARGE)
	(FLAGS NDESCBIT)
	(ACTION COVER-F)>

<ROUTINE COVER-F ()
	 <COND (<VERB? MOVE RAISE OPEN>
		<TELL
"La couverture est déplacée un peu d'un côté, révélant un petit trou menant à l'obscurité." CR>
		<SETG COVER-MOVED T>)
	       (<VERB? TAKE>
		<TELL
"La couverture est beaucoup trop lourde à supporter." CR>)>>

<ROUTINE KEY-ROOM-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL
"Vous vous trouvez entre le roc et un lieu obscur. Une faible lumière venue d'en haut révèle un unique sentier sombre qui descend vers l'ouest." CR>
		<COND (,COVER-MOVED
		       <TELL
"Un lourd couvercle de trou d'homme a été déplacé pour révéler un passage sombre en dessous." CR>)
		      (T
		       <TELL
"D'un côté de la pièce se trouve un grand trou d'homme. couverture." CR>)>)>>

<OBJECT KEY
	(IN KEY-ROOM)
	(DESC "clé étrange")
	(FDESC
"La lumière d'en haut semble être focalisée au centre de la pièce, où une seule clé se trouve dans la poussière.")
	(SYNONYM KEY)
	(ADJECTIVE STRANGE RUSTY LONG SHORT HEAVY THIN SHARP POINTED)
	(FLAGS TAKEBIT)
	(SIZE 10)
	(ACTION KEY-F)>

<ROUTINE KEY-F ()
	 <COND (<AND <VERB? UNLOCK> <==? ,PRSI ,KEY>>
		<COND (<AND <==? ,PRSO ,BRONZE-DOOR> <==? ,HERE ,GOOD-CELL>>
		       <COND (,BRONZE-DOOR-LOCKED
			      <TELL
"La clé semble se mouler à la forme de la serrure. Avec une simple torsion de votre main, le boulon massif cède la place." CR>)
			     (T <TELL "C'est déjà le cas." CR>)>
		       <SETG BRONZE-DOOR-LOCKED <>>
		       <RTRUE>)
		      (<==? ,PRSO ,BRONZE-DOOR>
		       <TELL
"La clé se moule à la serrure mais ne tourne pas." CR>)
		      (<OR <EQUAL? ,PRSO ,CHEST>
			   <FSET? ,PRSO ,DOORBIT>>
		       <TELL
"La clé, qui semblait initialement certaine de s'adapter à la serrure, semble changer de forme et n'entrera pas dans le trou de clé." CR>)>)
	       (<VERB? EXAMINE>
		<TELL <PICK-ONE ,KEY-DESCS> CR>
		<TELL
"Étrange, cependant. La clé semble changer de forme constamment." CR>)>>

<GLOBAL KEY-DESCS <LTABLE 0
"La clé est une clé squelette longue et lourde."
"La clé est courte et trapue, en forme de serrure que vous n'avez jamais connue. vu."
"La clé est ronde et fine, plus comme un crayon qu'une clé."
"La clé est brillante avec de nombreuses dents."
"La clé est pointue. comme un poinçon et a beaucoup rouillé.">>

<OBJECT VIEW-INDICATOR
	(IN VIEW-ROOM)
	(DESC "indicateur")
	(SYNONYM INDICATOR DIAL)
	(FLAGS NDESCBIT READBIT)
	(ACTION VIEW-INDICATOR-F)>

<ROUTINE VIEW-INDICATOR-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL "L'indicateur indique \""
		      <GET ,VIEW-ROMANS ,ACTIVE-VIEW>
		      "\"." CR>)>>

<GLOBAL BOAT-SEEN <>>

<ROUTINE FLATHEAD-OCEAN-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL
"Vous êtes sur le rivage d'une mer souterraine étonnante, le sujet de beaucoup d'une légende parmi les aventuriers. Peu étaient connus pour être arrivés à cet endroit, et moins pour revenir. Il ya un surf lourd et une brise souffle sur terre. La terre monte raidement à l'est et le sable rapide empêche le mouvement vers le sud. Une brume épaisse couvre l'océan et s'étend sur les collines à l'est. Un sentier se dirige vers le nord le long de la plage." CR>
		<COND (<NOT <FSET? ,VIKING-SHIP ,INVISIBLE>>
		       <TELL
"Un ancien navire viking passe le long du rivage, un vieux marin croustillant à la barre." CR>)>
		<RTRUE>)
	       (<AND <==? .RARG ,M-END>
		     <PROB 20>
		     <NOT ,BOAT-SEEN>
		     ,LIT>
		<SETG BOAT-SEEN T>
		<ENABLE <QUEUE I-BOAT-DISAPPEAR 2>>
		<TELL
"Passant le long du rivage est maintenant un vieux bateau, rappelant un ancien navire viking. Se tenant sur la proue du navire est un vieux marin croustillant, regardant au-dessus de l'océan misty." CR>
		<FCLEAR ,VIKING-SHIP ,INVISIBLE>)>>

<GLOBAL SHIP-GONE <>>

<ROUTINE I-BOAT-DISAPPEAR ()
	 <FSET ,VIKING-SHIP ,INVISIBLE>
	 <SETG SHIP-GONE T>
	 <COND (<==? ,HERE ,FLATHEAD-OCEAN>
		<TELL
"Le bateau navigue silencieusement à travers la brume et hors de vue." CR>)>>

<OBJECT VIKING-SHIP
	(IN FLATHEAD-OCEAN)
	(DESC "Viking Navire")
	(FLAGS NDESCBIT INVISIBLE)
	(ADJECTIVE VIKING)
	(SYNONYM BOAT SHIP CRAFT)>

<OBJECT VIAL
	(DESC "flacon")
	(SYNONYM VIAL ODOR GIFT)
	(FLAGS TAKEBIT CONTBIT)
	(SIZE 3)
	(CAPACITY 3)
	(ACTION VIAL-F)>

<OBJECT POTION
	(IN VIAL)
	(DESC "liquide lourd mais invisible")
	(SYNONYM POTION LIQUID CONTENTS FLUID)
	(ADJECTIVE HEAVY SWEET INVISIBLE SMELLING)
	(SIZE 2)
	(FLAGS)
	(ACTION POTION-F)>

<ROUTINE I-VISIBLE ()
	 <SETG INVIS <>>
	 <COND (<EQUAL? ,HERE ,MRG ,MRGE ,MRGW>
		<JIGS-UP
"L'une des figures de pierre (ou peut-être les deux, c'est difficile à dire) jaillit soudainement à la vie et vous écrase avec son coup de pierre.">)>
	 <RFALSE>>

<ROUTINE POTION-F ()
	 <COND (<VERB? DRINK>
		<REMOVE ,POTION>
		<SETG INVIS T>
		<ENABLE <QUEUE I-VISIBLE 3>>
		<TELL
"Vous « buvez » le contenu dans un goupille, mais rien d'inhabituel ne semble s'être produit en conséquence." CR>)
	       (<AND <VERB? POUR-ON> <==? ,PRSO ,POTION>>
		<REMOVE ,POTION>
		<TELL "Il se répand sur le " D ,PRSI " et disparaît." CR>)
	       (<VERB? EXAMINE>
		<TELL
"On dirait qu'il y a quelque chose à l'intérieur, mais on ne voit rien même si la fiole est transparente." CR>)
	       (<VERB? SMELL>
		<TELL
"Le flacon (ou quelque chose qu'il contient) sent bon." CR>)
	       (<VERB? DROP TAKE>
		<TELL
"Rien ne semble sortir, bien que l'odeur douce disparaisse du flacon, semblant pénétrer brièvement l'air avant de s'évanouir complètement." CR>
		<REMOVE ,POTION>)>>

<GLOBAL INVIS <>>

<ROUTINE VIAL-F ()
	 <COND (<VERB? FILL> <TELL "Vous n'arrivez pas à y mettre quoi que ce soit." CR>)
	       (<AND <VERB? DRINK-FROM> <IN? ,POTION ,VIAL>>
		<PERFORM ,V?DRINK ,POTION>
		<RTRUE>)
	       (<AND <VERB? SMELL> <IN? ,POTION ,VIAL>>
		<PERFORM ,V?SMELL ,POTION>
		<RTRUE>)
	       (<AND <VERB? SHAKE> <IN? ,POTION ,VIAL> <FSET? ,VIAL ,OPENBIT>>
		<TELL
"Rien ne semble sortir, bien que le flacon soit plus léger maintenant." CR>
		<REMOVE ,POTION>)
	       (<VERB? OPEN>
		<FSET ,VIAL ,OPENBIT>
		<TELL
"Le flacon est ouvert.">
		<COND (<IN? ,POTION ,VIAL>
		       <TELL
"Il y a une odeur sucrée dans le flacon, apparemment provenant d'un liquide lourd mais invisible.">)>
		<CRLF>)
	       (<VERB? EXAMINE>
		<TELL "C'est un petit flacon transparent ">
		<COND (<IN? ,POTION ,VIAL>
		       <TELL
"qui a l'air vide mais est étrangement lourd." CR>)
		      (T
		       <TELL
"qui est léger et vide." CR>)>)>>

<OBJECT OCEAN
	(IN GLOBAL-OBJECTS)
	(DESC "Tête-Plate Océan")
	(SYNONYM OCEAN WATER)
	(ADJECTIVE FLATHEAD)
	(FLAGS NDESCBIT)
	(ACTION OCEAN-F)>

<ROUTINE OCEAN-F ()
	 <COND (<NOT <==? ,HERE ,FLATHEAD-OCEAN>>
		<TELL "Il n'y a pas d'océan ici." CR>)
	       (<VERB? THROUGH BOARD>
		<TELL "Vous seriez tué par les vagues déferlantes !" CR>)
	       (<AND <VERB? PUT THROW> <==? ,PRSI ,OCEAN>>
		<TELL
"Le " D ,PRSO " tombe dans l'océan et se perd pour toujours." CR>
		<REMOVE ,PRSO>)>>

<OBJECT STONE
	(DESC "grand rocher")
	(SYNONYM ROCK STONE)
	(ADJECTIVE GREAT)
	(IN JUNCTION)
	(DESCFCN STONE-DESC)
	(FLAGS CONTBIT OPENBIT)
	(CAPACITY 30)
	(ACTION STONE-F)>

<GLOBAL SWORD-IN-STONE? T>

<ROUTINE STONE-DESC (FOO)
	 <TELL
"Un imposant rocher se dresse devant vous.">
	 <COND (,SWORD-IN-STONE?
		<TELL " Une épée elfique y est enchâssée.">)>
	 <CRLF>>

<ROUTINE STONE-F ()
	 <COND (<VERB? OPEN CLOSE>
		<TELL "Vous ne pouvez pas être sérieux." CR>)
	       (<AND <VERB? PUT> <==? ,PRSI ,STONE>>
		<TELL "Vous ne pouvez rien forcer dans la pierre." CR>)
	       (<AND <VERB? MOVE TAKE PUSH> <==? ,PRSO ,STONE>>
		<TELL
"La pierre est beaucoup trop massive pour être déplacée." CR>)
	       (<VERB? LOOK-UNDER>
		<TELL
"Comme elle ne peut pas être déplacée, il est difficile de savoir ce qu'il y a là." CR>)>>

<OBJECT FISH
	(IN LOCAL-GLOBALS)
	(DESC "poisson")
	(SYNONYM FISH)
	(FLAGS NDESCBIT)
	(ACTION FISH-F)>

<ROUTINE FISH-F ()
	 <TELL "Aucun poisson n'est visible pour le moment." CR>>
	 
<ROUTINE QUICKSAND-PSEUDO ()
	 <COND (<VERB? THROUGH LEAP>
		<JIGS-UP
"Vous entrez dans les sables mouvants et sombrez lentement vers un nouveau plus bas dans l'aventure.">)
	       (<VERB? RUB>
		<TELL "C'est bien des sables mouvants !" CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL "Il est difficile de dire ce qu'il y a dedans ! là." CR>)>>

<ROUTINE SWAMP-PSEUDO ()
	 <COND (<VERB? THROUGH>
		<TELL "Beurk." CR>)>>

<ROUTINE MIST-PSEUDO ()
	 <COND (<VERB? LOOK-INSIDE>
		<TELL "On ne distingue rien à travers la brume." CR>)
	       (<VERB? SMELL>
		<TELL "Ça sent vaguement salé." CR>)>>

<ROUTINE SHORE-PSEUDO ()
	 <COND (<VERB? DIG>
		<TELL "Il n'y a rien là-bas." CR>)>>
	       

<ROUTINE WATERFALL-PSEUDO ()
	 <COND (<VERB? CLIMB-UP>
		<TELL "C'est beaucoup trop glissant." CR>)>>

<ROUTINE ARCH-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<COND (,AQ-FLAG
		       <TELL
"Les arches montrent toutes des signes de salé. pourriture." CR>)
		      (T
		       <TELL
"L'arche devant vous est brisée. Les autres montrent des signes de délabrement." CR>)>)>>

