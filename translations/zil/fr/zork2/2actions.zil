"ACTIONS2 pour Zork II: Le Magicien de Frobozz (c) Copyright 1981, 1983 Infocom, Inc. Tous droits réservés."

<ROUTINE SWORD-FCN ()
	 <COND (<AND <VERB? TAKE>
		     <EQUAL? ,WINNER ,ADVENTURER>>
		<ENABLE <QUEUE I-SWORD -1>>
		<RFALSE>)>>

"ÉPÉE démon"

<GLOBAL SWORD-GLOW 0>

<ROUTINE I-SWORD ("AUX" (DEM <INT I-SWORD>) (NG 0) G P TX L)
	 <SET G ,SWORD-GLOW>
	 <COND (<IN? ,SWORD ,ADVENTURER>
		<COND (<INFESTED? ,HERE> <SET NG 2>)
		      (T
		       <SET P 0>
		       <REPEAT ()
			       <COND (<0? <SET P <NEXTP ,HERE .P>>>
				      <RETURN>)
				     (<NOT <L? .P ,LOW-DIRECTION>>
				      <SET TX <GETPT ,HERE .P>>
				      <SET L <PTSIZE .TX>>
				      <COND (<EQUAL? .L ,UEXIT ,CEXIT ,DEXIT>
					     <COND (<INFESTED? <GETB .TX 0>>
						    <SET NG 1>
						    <RETURN>)>)>)>>)>
		<COND (<EQUAL? .NG .G> <RFALSE>)
		      (<EQUAL? .NG 2>
		       <TELL "Votre épée s'est mise à briller d'un éclat intense." CR>)
		      (<1? .NG>
		       <TELL "Votre épée brille d'un bleu pâle brille."
			     CR>)
		      (<0? .NG>
		       <TELL "Votre épée ne brille plus." CR>)>
		<SETG SWORD-GLOW .NG>
		<RTRUE>)
	       (T
		<PUT .DEM ,C-ENABLED? 0>
		<RFALSE>)>>

<ROUTINE INFESTED? (R "AUX" (F <FIRST? .R>))
	 <REPEAT ()
		 <COND (<NOT .F> <RFALSE>)
		       (<AND <FSET? .F ,ACTORBIT>
			     <NOT <FSET? .F ,INVISIBLE>>
			     <NOT <EQUAL? .F ,ROBOT>>>
			<RETURN .F>)
		       (<NOT <SET F <NEXT? .F>>> <RFALSE>)>>>

<ROUTINE CAROUSEL-ROOM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Vous êtes dans une grande pièce circulaire dont le haut plafond est perdu dans l'obscurité. Huit passages identiques quittent la pièce." CR>
		<COND (<NOT ,CAROUSEL-FLIP-FLAG>
		       <TELL
"Un bruit fort et flippant vient de partout, et vous vous sentez un peu désorienté ici." CR>)>
		<RTRUE>)
	       (<AND <NOT ,CAROUSEL-FLIP-FLAG>
		     <EQUAL? .RARG ,M-BEG>
		     <VERB? WALK>>
		<COND (<EQUAL? ,PRSO ,P?UP ,P?DOWN>
		       <RFALSE>)>
		<COND (<EQUAL? ,PRSO ,P?OUT>
		       <TELL
"Vous vous sentez étourdi, vous choisissez une direction au hasard." CR CR>
		       <SETG PRSO ,P?EAST>)
		      (T
		       <TELL
"Vous n'êtes pas sûr de la direction que c'est." CR CR>)>
		<COND (<OR <EQUAL? ,PRSO ,P?WEST> <PROB 80>>
		       <SETG PRSO <GET ,EIGHT-DIRECTIONS <- <RANDOM 7> 1>>>)>
		<V-WALK>
		<RTRUE>)>>

<ROUTINE VIOLIN-FCN ()
	 <COND (<AND <VERB? PLAY>
		     <EQUAL? ,PRSO ,VIOLIN>>
	        <TELL
"Un bruit incroyablement offensant provient du violon." CR>)>>

<GLOBAL EIGHT-DIRECTIONS
	<TABLE P?NORTH P?EAST P?SOUTH P?NE P?SE P?SW P?NW>>

<GLOBAL MUNGED-ROOM <>>

<ROUTINE OPEN-CLOSE (OBJ STROPN STRCLS)
	 #DECL ((OBJ) OBJECT (STROPN STRCLS) STRING)
	 <COND (<VERB? OPEN>
		<COND (<FSET? .OBJ ,OPENBIT>
		       <TELL <RANDOM-ELEMENT ,DUMMY>>)
		      (T
		       <TELL .STROPN>
		       <FSET .OBJ ,OPENBIT>)>
		<CRLF>)
	       (<VERB? CLOSE>
		<COND (<FSET? .OBJ ,OPENBIT>
		       <TELL .STRCLS>
		       <FCLEAR .OBJ ,OPENBIT>
		       T)
		      (T <TELL <RANDOM-ELEMENT ,DUMMY> CR>)>
		<CRLF>)>>

;"SUBTITLE THE VOLCANO"

<GLOBAL BTIE-FLAG <>>
<GLOBAL BINF-FLAG <>>
<GLOBAL BLAB-FLAG <>>
<GLOBAL SAFE-FLAG <>>

<ROUTINE BALLOON-FCN ("OPTIONAL" (RARG <>) "AUX" M R RC)
	 #DECL ((RARG) <OR FIX FALSE> (M) <OR FALSE TABLE> (R) OBJECT)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<COND (,BINF-FLAG
		       <TELL "Le sac en tissu est gonflé et ">
		       <COND (<FSET? ,RECEPTACLE ,OPENBIT>
			      <TELL
"il y a un " D ,BINF-FLAG " brûle dans le récipient.">)
			     (T
			      <TELL
"de la fumée s'échappe du récipient fermé.">)>)
		      (T
		       <TELL "Le sac en tissu est drapé sur le côté du panier.">
		       <COND (<FSET? ,RECEPTACLE ,OPENBIT>
			      <TELL "ouvert">
			      <SET RC <FIRST? ,RECEPTACLE>>
			      <COND (.RC
				     <TELL ". Un "
					   D .RC
					   " est "
					   <COND (<EQUAL? ,BINF-FLAG .RC>
						  "brûlant")
						 (T
						  "niché")>
					   " à l'intérieur">)>)
			     (T <TELL "fermé">)>
		       <TELL ".">)>
		<COND (,BTIE-FLAG
		       <TELL
" Le ballon est attaché à un crochet par le fil tressé." CR>)
		      (T
		       <TELL
" Un fil tressé pend sur le côté du panier." CR>)>
		<RTRUE>)
	       (<EQUAL? .RARG ,M-OBJDESC>
		<TELL
"Il y a un grand panier en osier extrêmement lourd ici.">
		<COND (,BINF-FLAG
		       <TELL
"Un récipient en métal est fixé au centre du panier.">
		       <COND (<FSET? ,RECEPTACLE ,OPENBIT>
			      <TELL "À l'intérieur se trouve une combustion " D ,BINF-FLAG>)
			     (T
			      <TELL
"De la fumée s'échappe autour du couvercle fermé">)>)
		      (T
		       <TELL
"est drapé sur le côté et est fermement attaché au panier. Un récipient en métal est fixé au centre du panier">)>
		<COND (,BTIE-FLAG
		       <TELL
". Un morceau de fil attaché à un crochet maintient le ballon en place." CR>)
		      (T
		       <TELL
". Un morceau de fil tressé pend au panier." CR>)>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<VERB? WALK>
		       <COND (<SET M <GETPT ,HERE ,PRSO>>
			      <COND (,BTIE-FLAG
				     <TELL "Vous êtes attaché au rebord." CR>
				     <RTRUE>)
				    (T
				     <AND <EQUAL? <PTSIZE .M> 1>
					  <NOT <FSET? <SET R <GETB .M 0>>
						      ,RMUNGBIT>>
					  <SETG BLOC .R>>
				     <ENABLE <QUEUE I-BALLOON 3>>
				     <RFALSE>)>)
			     (T
			      <TELL
"Vous ne pouvez pas contrôler le ballon ici façon." CR>
			      <RTRUE>)>)
		      (<AND <VERB? OPEN>
			    ,BINF-FLAG
			    <EQUAL? ,PRSO ,RECEPTACLE>
			    <FIRST? ,RECEPTACLE>>
		       <TELL "L'ouverture révèle une combustion "
			     D ,BINF-FLAG "." CR>
		       <FSET ,RECEPTACLE ,OPENBIT>
		       <RTRUE>)
		      (<AND <VERB? TAKE>
			    <EQUAL? ,BINF-FLAG ,PRSO>>
		       <TELL "Vous n'avez pas vraiment envie de maintenir une combustion "
			     D ,PRSO "." CR>
		       <RTRUE>)
		      (<AND <VERB? PUT>
			    <EQUAL? ,PRSI ,RECEPTACLE>
			    <FIRST? ,RECEPTACLE>>
		       <TELL "Le réceptacle est déjà occupé." CR>
		       <RTRUE>)
		      (<AND <VERB? PUT>
			    <EQUAL? ,PRSI ,RECEPTACLE>>
		       <FSET ,PRSO ,NDESCBIT>
		       <RFALSE>)
		      (<VERB? INFLATE>
		       <TELL
"Il faut plus que des mots pour gonfler un ballon." CR>)>)>>

<ROUTINE I-BALLOON ()
	 <COND (<AND <FSET? ,RECEPTACLE ,OPENBIT> ,BINF-FLAG>
		<RISE-AND-SHINE>)
	       (<EQUAL? ,HERE ,LEDGE-1 ,LEDGE-2>
		<RISE-AND-SHINE>)
	       (T
		<DECLINE-AND-FALL>)>>

<ROUTINE BALLOON-BURN ()
 	<TELL "Le " D ,PRSO " brûle à l'intérieur du récipient." CR>
	<ENABLE <QUEUE I-BURNUP <* <GETP ,PRSO ,P?SIZE> 20>>>
	<FSET ,PRSO ,FLAMEBIT>
	<FSET ,PRSO ,ONBIT>
	<FCLEAR ,PRSO ,TAKEBIT>
	<FCLEAR ,PRSO ,READBIT>
	<COND (,BINF-FLAG <RTRUE>)
	      (T
	       <TELL
		"Le sac en tissu se gonfle au fur et à mesure. se remplit d'air chaud." CR>
	       <COND (<NOT ,BLAB-FLAG>
		      <TELL
"Une petite étiquette tombe du sac dans le panier." CR>
		      <MOVE ,BALLOON-LABEL ,BALLOON>)>
	       <SETG BLAB-FLAG T>
	       <SETG BINF-FLAG ,PRSO>
	       <ENABLE <QUEUE I-BALLOON 3>>)>>

<ROUTINE PUT-BALLOON (THERE STR)
	#DECL ((THERE) OBJECT (STR) STRING)
	<COND (<EQUAL? ,HERE ,LEDGE-1 ,LEDGE-2 ,VOLCANO-BOTTOM>
	       <TELL "Vous regardez le ballon lentement " .STR CR>)>
	<MOVE ,BALLOON .THERE>
	<SETG BLOC .THERE>>

<GLOBAL BALLOON-UPS
	<LTABLE VAIR-1 VAIR-2 VAIR-3 VAIR-4>>

<GLOBAL BALLOON-FLOATS
	<LTABLE LEDGE-1 VAIR-2 LEDGE-2 VAIR-4>>

<GLOBAL BALLOON-DOWNS
	<LTABLE VAIR-4 VAIR-3 VAIR-2 VAIR-1>>

<ROUTINE RISE-AND-SHINE ("AUX" (IN <IN? ,WINNER ,BALLOON>) R)
	#DECL ((IN) <OR ATOM FALSE> (R) <OR FALSE OBJECT>)
	<ENABLE <QUEUE I-BALLOON 3>>
	<COND (<EQUAL? ,BLOC ,VAIR-4>
	       <DISABLE <INT I-BURNUP>>
	       <DISABLE <INT I-BALLOON>>
	       <REMOVE ,BALLOON>
	       <COND (.IN
		      <JIGS-UP
"Le ballon flotte majestueusement hors du volcan, révélant une vue à couper le souffle sur une vallée boisée entourée de montagnes impraticables. Dans une clairière se dresse une maison blanche. Vous dérivez dans des vents élevés, qui vous conduisent vers les sommets enneigés. Oh, non! Vous vous écrasez dans les falaises déchiquetées des montagnes Tête-Plate!">)
		     (<EQUAL? ,HERE ,LEDGE-1 ,LEDGE-2 ,VOLCANO-BOTTOM>
		      <TELL
"Vous regardez le ballon dériver par-dessus le bord et s'éloigner au gré du vent." CR>)>
	       <SETG BLOC ,VOLCANO-BOTTOM>)
	      (<SET R <LKP ,BLOC ,BALLOON-UPS>>
	       <COND (.IN
		      <TELL "Le ballon monte." CR CR>
		      <SETG BLOC .R>
		      <GOTO .R>)
		     (T
		      <PUT-BALLOON .R "monte.">)>)
	      (<SET R <LKP ,BLOC ,BALLOON-FLOATS>>
	       <COND (.IN
		      <TELL "Le ballon quitte le rebord." CR CR>
		      <SETG BLOC .R>
		      <GOTO .R>)
		     (T
		      <ENABLE <QUEUE I-GNOME 10>>
		      <PUT-BALLOON .R
"s'envole. Il semble monter, en raison de sa faible charge.">
		      <FSET ,RECEPTACLE ,OPENBIT>)>)
	      (.IN
	       <SETG BLOC ,VAIR-1>
	       <TELL "Le ballon s'élève lentement du sol." CR CR>
	       <GOTO ,VAIR-1>)
	      (T
	       <PUT-BALLOON ,VAIR-1 "décolle.">)>>

<ROUTINE DECLINE-AND-FALL ("AUX" (IN <IN? ,WINNER ,BALLOON>) R)
    #DECL ((IN) <OR ATOM FALSE> (R) <OR FALSE OBJECT>)
    <ENABLE <QUEUE I-BALLOON 3>>
    <COND (<EQUAL? ,BLOC ,VAIR-1>
	   <COND (.IN
		  <SETG BLOC ,VOLCANO-BOTTOM>
		  <COND (,BINF-FLAG
			 <TELL "Le ballon a a atterri." CR CR>
			 <GOTO ,VOLCANO-BOTTOM>
			 ;<QUEUE I-BALLOON 0>)
			(T
			 <REMOVE ,BALLOON>
			 <MOVE ,DEAD-BALLOON ,BLOC>
			 <MOVE ,WINNER ,HERE>
			 <DISABLE <INT I-BALLOON>>
			 <TELL
			  "Vous avez atterri, mais le ballon n'a pas survécu."
			  CR CR>
			 <GOTO ,VOLCANO-BOTTOM>)>)
		 (T <PUT-BALLOON ,VOLCANO-BOTTOM "atterrit.">)>)
	   (<SET R <LKP ,BLOC ,BALLOON-DOWNS>>
	    <COND (.IN
		   <TELL "Le ballon descend." CR CR>
		   <SETG BLOC .R>
		   <GOTO .R>)
		  (T <PUT-BALLOON .R "descend.">)>)>>

<ROUTINE BCONTENTS ()
	 <COND (<VERB? TAKE>
		<TELL
"Le " D ,PRSO "fait partie intégrante du panier et ne peut être enlevé.">
		<COND (<EQUAL? ,PRSO ,BRAIDED-WIRE>
		       <TELL " Le fil pourrait cependant être attaché.">)>
		<CRLF>)
	       (<AND <EQUAL? ,PRSO ,CLOTH-BAG>
		     <VERB? LOOK-INSIDE OPEN>>
		<COND (<VERB? OPEN>
		       <TELL
"Le sac est énorme. L'idée de l'ouvrir ici est ridicule." CR>)
		      (T
		       <TELL
"Il ne semble pas y avoir quoi que ce soit à l'intérieur." CR>)>)
	       (<AND <VERB? EXAMINE> <EQUAL? ,PRSO ,RECEPTACLE>>
		<TELL "Le réceptacle est ">
		<COND (<FSET? ,PRSO ,OPENBIT> <TELL "ouvert." CR>)
		      (T <TELL "fermé." CR>)>)
	       (<VERB? FIND EXAMINE>
	        <TELL
"Le " D ,PRSO "peut être manipulé dans le panier mais ne peut pas être enlevé." CR>)>>

<ROUTINE WIRE-FCN ()
        <COND (<VERB? TAKE FIND EXAMINE>
	       <BCONTENTS>)
	      (<VERB? TIE>
	       <COND (<AND <EQUAL? ,PRSO ,BRAIDED-WIRE>
			   <EQUAL? ,PRSI ,HOOK-1 ,HOOK-2>>
		      <SETG BTIE-FLAG ,PRSI>
		      <FSET ,PRSI ,NDESCBIT>
		      <DISABLE <INT I-BALLOON>>
		      <TELL "Le ballon est fixé au crochet." CR>)>)
	      (<AND <VERB? UNTIE>
	            <EQUAL? ,PRSO ,BRAIDED-WIRE>>
	       <COND (,BTIE-FLAG
		      <ENABLE <QUEUE I-BALLOON 3>>
	       	      <FCLEAR ,BTIE-FLAG ,NDESCBIT>
		      <SETG BTIE-FLAG <>>
	              <TELL "Le fil tombe du crochet." CR>)
		     (T <TELL "Le fil n'est pas attaché. à quoi que ce soit." CR>)>)>>

<ROUTINE I-BURNUP ("AUX" (OBJ <FIRST? ,RECEPTACLE>))
    #DECL ((OBJ) OBJECT)
    <COND (<EQUAL? ,HERE ,BLOC>
	   <TELL
"Le " D .OBJ " a maintenant brûlé et le sac en tissu commence à se dégonfler." CR>)>
    <REMOVE .OBJ>
    <SETG BINF-FLAG <>>
    T>

<ROUTINE SAFE-ROOM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Vous êtes dans une vieille pièce poussiéreuse sans caractéristiques, à l'exception d'une sortie du côté nord." CR>
		<COND (<NOT ,SAFE-FLAG>
		       <TELL
"Imbécile dans le mur lointain est une boîte rouillée. Il semble être quelque peu endommagé, car un trou oblong a été écaillé hors de l'avant." CR>)
		      (T
		       <TELL
"Sur le mur du fond se trouve une boîte rouillée dont la porte a été arrachée." CR>)>)>>

<ROUTINE SAFE-FCN ()
	<COND (<AND <VERB? TAKE> <EQUAL? ,PRSO ,SAFE>>
	       <TELL "La boîte est encastrée dans le " CR>)
	      (<VERB? OPEN>
	       <COND (,SAFE-FLAG <TELL "La boîte n'a pas de porte !" CR>)
		     (T <TELL "La boîte est rouillée et ne s'ouvre pas." CR>)>)
	      (<VERB? CLOSE>
	       <COND (,SAFE-FLAG <TELL "La boîte n'a pas de porte !" CR>)
		     (T <TELL "La boîte n'est pas ouvrez !" CR>)>)>>

<ROUTINE BRICK-FCN ()
	 <COND (<VERB? BURN>
		<REMOVE ,BRICK>
		<JIGS-UP ,OTHER-PROPERTIES>)>>

<GLOBAL OTHER-PROPERTIES
"Maintenant vous l'avez fait. Il semble que la brique a d'autres propriétés que le poids, à savoir la capacité de vous souffler à smithereens.">

<ROUTINE FUSE-FCN ()
	<COND (<OR <VERB? BURN>
		   <AND <VERB? LAMP-ON>
			<IN? ,MATCH ,WINNER>
			<FSET? ,MATCH ,ONBIT>>>
	       <TELL "La ficelle commence à brûler." CR>
	       <ENABLE <QUEUE I-FUSE 2>>)>>

<ROUTINE I-FUSE ("AUX" (BRICK-ROOM <LOC ,BRICK>) F)
	 <COND (<IN? ,FUSE ,BRICK>
		<REPEAT ()
			<COND (<NOT .BRICK-ROOM> <RFALSE>)
			      (<IN? .BRICK-ROOM ,ROOMS>
			       <RETURN>)
			      (T
			       <SET BRICK-ROOM <LOC .BRICK-ROOM>>)>>
		<MOVE ,EXPLOSION .BRICK-ROOM>
		<FCLEAR .BRICK-ROOM ,TOUCHBIT>
		<COND (<EQUAL? .BRICK-ROOM ,HERE>
		       <MUNG-ROOM .BRICK-ROOM
			  "Le chemin est bloqué par les débris d'un explosion.">
		       <JIGS-UP ,OTHER-PROPERTIES>)
		      (<EQUAL? .BRICK-ROOM ,SAFE-ROOM>
		       <ENABLE <QUEUE I-SAFE 5>>
		       <SETG MUNGED-ROOM ,SAFE-ROOM>
		       <TELL "Il y a une explosion à proximité." CR>
		       <COND (<IN? ,BRICK ,SLOT>
			      <FSET ,SLOT ,INVISIBLE>
			      <FSET ,SAFE ,OPENBIT>
			      <FCLEAR ,SAFE-ROOM ,TOUCHBIT>
			      <SETG SAFE-FLAG T>)>)
		      (T
		       <TELL "Il y a une explosion à proximité." CR>
		       <ENABLE <QUEUE I-SAFE 5>>
		       <SETG MUNGED-ROOM .BRICK-ROOM>
		       <COND (<SET F <FIRST? .BRICK-ROOM>>
			      <REPEAT ()
				      <COND (<FSET? .F ,TAKEBIT>
					     <FSET .F ,INVISIBLE>)>
				      <COND (<NOT <SET F <NEXT? .F>>>
					     <RETURN>)>>)>)>
		<REMOVE ,BRICK>)
	       (<EQUAL? <LOC ,FUSE> ,WINNER ,HERE>
		<TELL "La chaîne brûle rapidement dans le néant." CR>)>
	 <REMOVE ,FUSE>>

<ROUTINE I-SAFE ()
	<COND (<EQUAL? ,HERE ,MUNGED-ROOM>
	       <JIGS-UP
"La chambre tremble et 5000 tonnes de rocher tombent sur toi, te transformant en crêpe.">)
	      (<NOT ,DEAD>
	       <TELL
"Vous vous souvenez peut-être de cette explosion récente. Probablement à la suite de cela, vous entendez un grondement odieux, comme si une pièce voisine s'était effondrée." CR>
	       <COND (<EQUAL? ,MUNGED-ROOM ,SAFE-ROOM>
		      <ENABLE <QUEUE I-LEDGE 8>>)>)>
	<MUNG-ROOM ,MUNGED-ROOM
		   "Le chemin est bloqué par les débris d'un explosion.">>

<ROUTINE I-LEDGE ("AUX" (RM ,LEDGE-2))
    <COND (<EQUAL? ,HERE ,LEDGE-2>
	   <COND (<IN? ,WINNER ,BALLOON>
		  <COND (,BTIE-FLAG
			 <SETG BLOC ,VOLCANO-BOTTOM>
			 <REMOVE ,BALLOON>
			 <MOVE ,DEAD-BALLOON ,VOLCANO-BOTTOM>
			 <SETG BTIE-FLAG <>>
			 <SETG BINF-FLAG <>>
			 <DISABLE <INT I-BALLOON>>
			 <DISABLE <INT I-BURNUP>>
			 <JIGS-UP
"Le rebord s'effondre, probablement à la suite de l'explosion, et chute au sol bien au-dessous. Malheureusement, vous étiez toujours attaché au rebord.">)
			(T
			 <TELL
"Le rebord s'effondre, vous laissant sans endroit où atterrir." CR>)>)
		 (T
		  <JIGS-UP
"La force de la récente explosion a provoqué l'effondrement du rebord.">)>)
	  (<NOT ,DEAD>
	   <TELL "Le rebord s'effondre. (C'était une échappée belle !)" CR>)>
    <MUNG-ROOM .RM "Le rebord s'est effondré et il est impossible d'atterrir dessus.">>

<ROUTINE LEDGE-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
	   <TELL
"Vous êtes sur un large rebord haut dans le volcan. La bordure du volcan est à environ 200 pieds au-dessus et il ya une goutte précipitée au fond.">
	   <COND (<FSET? ,SAFE-ROOM ,RMUNGBIT>
		  <TELL " Le chemin vers le sud est bloqué par des décombres." CR>)
		 (T <TELL " Une petite porte s'ouvre au sud." CR>)>)>>

;<ROUTINE BLAST () ;"APPARENTLY UNUSED?"
    <COND (<EQUAL? ,HERE ,SAFE-ROOM>)
	  (T
	   <TELL "Vous devez expliquer comment faire cela." CR>)>>

<ROUTINE I-GNOME ()
    <COND (<EQUAL? ,HERE ,LEDGE-1 ,LEDGE-2>
	   <TELL
"Un gnome de volcan semble sortir tout droit du mur et ">
	   <COND (<IN? ,WAND ,WINNER>
		  <TELL
"remarquant la baguette, tout droit. de retour." CR>)
		 (T
		  <TELL
"\"J'ai un rendez-vous chargé et peu de temps à perdre sur les intrus, mais pour un petit prix je vais vous montrer la sortie.\" Vous remarquez le gnome nerveusement regardant à sa montre." CR>
		  <MOVE ,GNOME ,HERE>)>)
	  (T
	   <ENABLE <QUEUE I-GNOME 1>>
	   <RFALSE>)>>

<GLOBAL GNOME-FLAG <>>

<ROUTINE GNOME-FCN ()
    <COND (<VERB? TELL>
	   <SETG P-CONT <>>
	   <SETG QUOTE-FLAG <>>
	   <COND (<NOT ,GNOME-FLAG>
		  <ENABLE <QUEUE I-NERVOUS 5>>)>
	   <SETG GNOME-FLAG T>
	   <TELL
"Le gnome semble de plus en plus nerveux." CR>)
	  (<AND <VERB? GIVE THROW> <EQUAL? ,PRSI ,GNOME>>
	   <COND (<GETPT ,PRSO ,P?VALUE>
		  <TELL
"\"Merci beaucoup pour le " D ,PRSO ". Je ne crois pas avoir jamais vu une aussi belle. Suivez-moi, dit-il, et une porte apparaît à l'extrémité ouest du rebord. Par la porte, vous pouvez voir une cheminée étroite en pente raide vers le bas." CR>
		  <REMOVE ,PRSO>
		  <REMOVE ,GNOME>
		  <SETG GNOME-DOOR-FLAG T>)
		 (<BOMB? ,PRSO>
		  <MOVE ,BRICK ,HERE>
		  <REMOVE ,GNOME>
		  <DISABLE <INT I-GNOME>>
		  <DISABLE <INT I-NERVOUS>>
		  <TELL
"\"Ce n'était certainement pas ce que j'avais en tête\", dit-il, et il disparaît." CR>)
		 (T
		  <REMOVE-CAREFULLY ,PRSO>
		  <TELL
"\"Ce n'était pas tout à fait ce que j'avais en tête\", dit-il," D ,PRSO " dans ses mains dures comme le roc." CR>)>)
	  (T
	   <TELL
"Le gnome semble de plus en plus nerveux." CR>
	   <COND (<NOT ,GNOME-FLAG>
		  <ENABLE <QUEUE I-NERVOUS 5>>)>
	   <SETG GNOME-FLAG T>)>>

<ROUTINE I-NERVOUS ()
	 <COND (<IN? ,GNOME ,HERE>
		<TELL
"Le gnome regarde sa montre. \"Oups. Je suis en retard pour un rendez-vous!\" Il disparaît, vous laissant seul sur le rebord." CR>)>
	 <REMOVE ,GNOME>>

<ROUTINE PURPLE-BOOK-FCN ()
	 <COND (<AND <VERB? READ>
		     <IN? ,STAMP ,PURPLE-BOOK>
		     <NOT <FSET? ,PURPLE-BOOK ,OPENBIT>>>
		<TELL <GETP ,PURPLE-BOOK ,P?TEXT> CR>
		<PERFORM ,V?OPEN ,PURPLE-BOOK>
		<RTRUE>)
	       (T <RANDOM-BOOK>)>>

<ROUTINE RANDOM-BOOK ()
	 <COND (<VERB? TAKE MOVE PUT>
		<FSET ,WHITE-BOOK ,TOUCHBIT>
		<FSET ,PURPLE-BOOK ,TOUCHBIT>
		<FSET ,GREEN-BOOK ,TOUCHBIT>
		<FSET ,BLUE-BOOK ,TOUCHBIT>
		<RFALSE>)>>

; "SUBTITLE TOMB OF THE FLATHEADS"

<ROUTINE HEAD-FCN ()
  <COND (<VERB? HELLO>
	 <TELL "Les Tête-Plate sont morts ; ils ne répondent donc pas." CR>)
	(<VERB? KICK ATTACK RUB OPEN TAKE BURN>
	 <JIGS-UP
"Bien que les Tête-Plate soient morts, ils ont prévu qu'un certain crétin pourrait manipuler leurs restes. Par conséquent, ils ont pris des mesures pour punir de telles actions.">)>>

<ROUTINE CRYPT-ANTEROOM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"L'antichambre est grande et vide. Les bas reliefs en marbre représentent les temps agitants et l'au-delà des Tête-Plates (ce dernier un peu optimiste). La sortie est à l'ouest.">
		<TELL "La porte est ">
		<COND (<FSET? ,CRYPT-DOOR ,OPENBIT>
		       <TELL "ouvert.">)
		      (T <TELL "fermé.">)>
		<TELL
" Au-dessus de la porte figure cette inscription énigmatique : \"N'hésitez pas à toucher\"." CR>)>>

<ROUTINE CRYPT-ROOM-FCN (RARG "AUX" CLIT?)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<FCLEAR ,HERE ,ONBIT>
		<COND (<LIT? ,HERE>
		       <TELL
"La pièce contient les restes terrestres des puissants Tête-Plates, douze têtes quelque peu plates montées en toute sécurité sur des poteaux. Bien que la pièce puisse être censée contenir des urnes funéraires ou d'autres preuves des pratiques rituelles des anciens Zorkers, elle est vide de tous ces objets. Il y a des écrits gravés sur la crypte. La seule sortie apparente est au nord par la porte de l'antichambre.">
		       <COND (<FSET? ,CRYPT-DOOR ,OPENBIT>
			      <TELL "ouvert.">)
			     (T <TELL "fermé.">)>
		       <CRLF>
		       <COND (<NOT <FSET? ,DIM-DOOR ,INVISIBLE>>
			      <TELL
"En regardant de près le mur sud, vous pouvez voir le contour sombre d'une porte secrète étiquetée avec la lettre \"F\"." CR>)>)
		      (T
		       <DIM-DOOR-APPEARS>)>
		<FSET ,HERE ,ONBIT>
		<RTRUE>)
	       (<EQUAL? .RARG ,M-END>
		<SET CLIT? ,CRYPT-LIT?>
		<FCLEAR ,CRYPT-ROOM ,ONBIT>
		<SETG CRYPT-LIT? <LIT? ,CRYPT-ROOM>>
		<COND (<AND .CLIT?
			    <NOT ,CRYPT-LIT?>>
		       <DIM-DOOR-APPEARS>)>
		<FSET ,CRYPT-ROOM ,ONBIT>)>>

<GLOBAL CRYPT-LIT? T>

<ROUTINE DIM-DOOR-APPEARS ()
	 <TELL
"Il est sombre, mais sur le mur sud est un léger contour d'un rectangle, comme si la lumière brillait autour d'une porte. Vous pouvez également faire une lettre peu brillante au centre de cette zone." CR>
	 <FCLEAR ,DIM-DOOR ,INVISIBLE>>

<ROUTINE CRYPT-OBJECT ()
	 <COND (<VERB? OPEN> <TELL "La crypte est scellée pour toujours." CR>)
	       (<VERB? RUB> <TELL "Le marbre est cool." CR>)>>

<ROUTINE CRYPT-DOOR-FCN ()
	 <COND (<VERB? OPEN CLOSE>
		<OPEN-CLOSE ,PRSO
			    "La porte de la crypte grince. ouverte."
			    "La porte de la crypte se ferme en grinçant.">)>>

<ROUTINE TOMB-PSEUDO ()
	 <COND (<VERB? THROUGH>
		<DO-WALK ,P?EAST>
		T)>>

<GLOBAL DIM-DOOR-FLAG <>>

<ROUTINE DIM-DOOR-FCN ()
	 <COND (<VERB? KNOCK> <TELL "Un écho creux répond." CR>)
	       (<VERB? OPEN CLOSE>
		<COND (<VERB? OPEN> <SETG DIM-DOOR-FLAG T>)
		      (T <SETG DIM-DOOR-FLAG <>>)>
		<OPEN-CLOSE ,PRSO
			    "La porte secrète s'ouvre. sans bruit."
			    "La porte secrète se ferme sans bruit.">)>>

<ROUTINE REPELLENT-FCN ()
	 <COND (<VERB? SHAKE>
		<COND (,SPRAY-USED? <TELL "La boîte semble vide." CR>)
		      (T <TELL "Il y a un bruit de clapotis provenant de à l'intérieur." CR>)>)
	       (<AND <VERB? SPRAY PUT> <EQUAL? ,PRSO ,REPELLENT>>
		<COND (,SPRAY-USED?
		       <TELL
"Le répulsif a entièrement disparu." CR>)
		      (<NOT ,PRSI>
		       <SETG SPRAY-USED? T>
		       <TELL
"Le spray pue incroyablement pendant quelques instants, puis s'éloigne." CR>)
		      (T
		       <COND (<EQUAL? ,PRSI ,ME>
			      <ENABLE <QUEUE I-SPRAY 8>>
			      <SETG SPRAYED? T>)>
		       <SETG SPRAY-USED? T>
		       <TELL
"Le spray sent comme un mélange de vieilles chaussettes et de caoutchouc brûlant." CR>)>)>>

<GLOBAL SPRAY-USED? <>>

<ROUTINE I-SPRAY ()
	 <SETG SPRAYED? <>>
	 <TELL "Cette horrible odeur est beaucoup moins âcre maintenant." CR>>

<ROUTINE ZORK3-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Au-delà de la porte se trouve un escalier grossièrement dressé qui descend dans l'obscurité. L'atterrissage sur lequel vous vous tenez est couvert de runes magiques soigneusement dessinées comme celles esquissés sur le banc de travail du Magicien de Frobozz. Ceux-ci ont été recouverts de lignes vertes balayantes d'énormes puissances, qui ondulent en allers et retours à travers l'atterrissage.">
		<COND (<IN? ,WAND ,WINNER>
		       <TELL
"La baguette commence à vibrer en harmonie avec le mouvement des lignes.
Vous vous sentez poussé vers le bas et vous cédez en marchant sur le
escalier. Lorsque vous dépassez les lignes vertes, elles s'éclairent et disparaissent avec un
éclat de lumière, et vous dévalez l'escalier !|
|
Au fond, une vaste salle éclairée en rouge s'étend au loin.
De sinistres statues gardent l'entrée d'une pièce faiblement visible loin devant.
Avec courage et ruse, vous avez conquis le Magicien de Frobozz et
devenir le maître de son domaine, mais le défi final vous attend !|
|
(L'aventure ultime se termine dans \"Zork III : Le Maître du Donjon\".)|
|
" CR>
		<SETG WON-FLAG T>
		<FINISH>)
		      (T
		       <JIGS-UP
"Les courbes vertes commencent à vibrer vers vous, comme si vous cherchiez quelque chose. Un par un vos biens brillent vert vif. Enfin, vous êtes attaqués par ces gardiens magiques, et détruits!">)>)>>

\

;"SUBTITLE A DROP IN THE BUCKET"

<GLOBAL BUCKET-TOP-FLAG <>>

<GLOBAL EVAPORATED <>>

<ROUTINE I-BUCKET ()
	 <COND (<IN? ,WATER ,BUCKET>
		<SETG EVAPORATED T>
		<REMOVE ,WATER>)>
	 <RFALSE>>

<ROUTINE WATER-FCN ("AUX" AV W PI?)
	 #DECL ((AV) <OR OBJECT FALSE> (W) OBJECT (PI?) <OR ATOM FALSE>)
	 <COND (<VERB? SGIVE> <RFALSE>)
	       (<VERB? THROUGH>
		<PERFORM ,V?SWIM ,PRSO>
		<RTRUE>)
	       (<VERB? FILL>	;"fill bottle with water =>"
		<SET W ,PRSI>	   ;"put water in bottle"
		<SETG PRSA ,V?PUT>
		<SETG PRSI ,PRSO>
		<SETG PRSO .W>
		<SET PI? <>>)
	       (<EQUAL? ,PRSO ,GLOBAL-WATER ,WATER>
		<SET W ,PRSO>
		<SET PI? <>>)
	       (,PRSI
		<SET W ,PRSI>
		<SET PI? T>)>
	 <COND (<EQUAL? .W ,GLOBAL-WATER>
		<SET W ,WATER>
		<COND (<VERB? TAKE PUT> <REMOVE .W>)>)>
	 <COND (.PI? <SETG PRSI .W>)
	       (T <SETG PRSO .W>)>
	 <SET AV <LOC ,WINNER>>
	 <COND (<NOT <FSET? .AV ,VEHBIT>> <SET AV <>>)>
	 <COND (<AND <VERB? TAKE PUT> <NOT .PI?>>
		<COND (<AND .AV <EQUAL? .AV ,PRSI>>
		       <PUDDLE .AV>)
		      (<AND .AV <NOT ,PRSI> <NOT <IN? .W .AV>>>
		       <PUDDLE .AV>)
		      (<AND ,PRSI <NOT <EQUAL? ,PRSI ,TEAPOT>>>
		       <TELL "L'eau s'échappe du " D ,PRSI
			     " et s'évapore. immédiatement." CR>
		       <REMOVE .W>)
		      (<IN? ,TEAPOT ,WINNER>
		       <COND (<NOT <FIRST? ,TEAPOT>>
			      <COND (<EQUAL? ,HERE ,POOL-ROOM>
				     <MOVE ,SALTY-WATER ,TEAPOT>)
				    (T 
				     <MOVE ,WATER ,TEAPOT>)>
			      <TELL "La théière est maintenant pleine d'eau." CR>)
			     (T
			      <TELL "La théière n'est pas actuellement vide." CR>
			      <RTRUE>)>)
		      (<AND <IN? ,PRSO ,TEAPOT>
			    <VERB? TAKE>
			    <NOT ,PRSI>>
		       <SETG PRSO ,TEAPOT>
		       <ITAKE>
		       <SETG PRSO .W>)
		      (T
		       <TELL "L'eau glisse à travers votre doigts." CR>)>)
	       (.PI? <TELL "Joli essayez." CR>)
	       (<VERB? DROP GIVE>
		<COND (<AND <EQUAL? ,PRSO ,WATER>
			    <NOT <HELD? ,WATER>>>
		       <TELL "Vous n'avez pas d'eau." CR>
		       <RTRUE>)>
		<REMOVE ,WATER>
		<COND (.AV
		       <PUDDLE .AV>)
		      (T
		       <TELL
"L'eau se répand sur le sol et s'évapore." CR>
		       <REMOVE ,WATER>)>)
	       (<VERB? THROW>
		<TELL
"L'eau éclabousse les parois et s'évapore." CR>
		<REMOVE ,WATER>)>>

<ROUTINE PUDDLE (AV)
	<TELL "Il y a maintenant une flaque d'eau au fond du " D .AV "." CR>
	<MOVE ,PRSO .AV>>

<ROUTINE BUCKET-FCN ("OPTIONAL" (RARG ,M-BEG))
	<COND (<EQUAL? .RARG ,M-BEG>
	       <COND (<AND <VERB? BURN>
			   <EQUAL? ,PRSO ,BUCKET>>
		      <TELL
		       "Le seau est ignifuge et ne brûle pas." CR>)
		     (<AND <VERB? DROP PUT>
			   <EQUAL? ,PRSO ,WATER>
			   <EQUAL? ,PRSI ,BUCKET>
			   <IN? ,BUCKET ,WELL-BOTTOM>
			   <NOT <IN? ,WINNER ,BUCKET>>>
		      <TELL "Le seau monte rapidement et disparaît." CR>
		      <MOVE ,BUCKET ,WELL-TOP>
		      <MOVE ,WATER ,BUCKET>
		      <SETG BUCKET-TOP-FLAG T>
		      <ENABLE <QUEUE I-BUCKET 100>>
		      <RTRUE>)
		     (<VERB? KICK>
		      <JIGS-UP "Si vous insistez.">)>)
	      (<EQUAL? .RARG ,M-END>
	       <COND (<AND <IN? ,WATER ,BUCKET>
			   <NOT ,BUCKET-TOP-FLAG>>
		      <TELL "Le seau se lève et arrive à un s'arrête." CR CR>
		      <SETG BUCKET-TOP-FLAG T>
		      <SETG EVAPORATED <>>
		      <PASS-THE-BUCKET ,WELL-TOP>
		      <ENABLE <QUEUE I-BUCKET 100>>
		      <RTRUE>)
		     (<AND ,BUCKET-TOP-FLAG
			   <NOT <IN? ,WATER ,BUCKET>>>
		      <COND (,EVAPORATED
			     <TELL
"Le reste de l'eau s'évapore et le seau descend." CR CR>)
			    (T
			     <TELL
"Le seau descend et s'arrête." CR CR>)>
		      <SETG BUCKET-TOP-FLAG <>>
		      <PASS-THE-BUCKET ,WELL-BOTTOM>)>)
	      (<VERB? CLIMB-ON>
	       <PERFORM ,V?BOARD ,PRSO>
	       <RTRUE>)>>

<ROUTINE PASS-THE-BUCKET (R)
    #DECL ((R) OBJECT)
    <MOVE ,BUCKET .R>
    <COND (<IN? ,WINNER ,BUCKET>
	   <GOTO .R>)>>

\

;"SUBTITLE CHOMPERS IN WONDERLAND"

<ROUTINE POSTS-ROOM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? TAKE> <FSET? ,PRSO ,NONLANDBIT>>
		       <TELL
"Le " D ,PRSO "Vous n'avez plus d'espoir de le prendre." CR>)>)>>

<ROUTINE EATME-FCN ("AUX" F N)
    <COND (<AND <VERB? EAT>
		<EQUAL? ,PRSO ,EAT-ME-CAKE>
		<EQUAL? ,HERE ,TEA-ROOM>>
	   <TELL
"Soudain, la pièce semble être devenue très grande (bien que tout ce que vous portez semble être sa taille normale)." CR CR>
	   <REMOVE ,EAT-ME-CAKE>
	   <FSET ,ROBOT ,INVISIBLE>
	   <FSET ,ALICE-TABLE ,INVISIBLE>
	   <SET F <FIRST? ,HERE>>
	   <REPEAT ()
		   <COND (<NOT .F> <RETURN>)
			 (T
			  <SET N <NEXT? .F>>
			  <COND (<AND <NOT <EQUAL? .F ,ADVENTURER>>
				      <FSET? .F ,TAKEBIT>>
				 <FSET .F ,NONLANDBIT>
				 <FSET .F ,TRYTAKEBIT>
				 <MOVE .F ,POSTS-ROOM>)>)>
		   <SET F .N>>
	   <GOTO ,POSTS-ROOM>)
	  (T <CAKE-CRUMBLE>)>>

<ROUTINE CAKE-CRUMBLE ("AUX" CAKE)
	 <COND (<FSET? ,PRSO ,FOODBIT> <SET CAKE ,PRSO>)
	       (T <SET CAKE ,PRSI>)>
	 <COND (<OR <EQUAL? ,HERE ,TEA-ROOM ,POSTS-ROOM ,POOL-ROOM>
		    <EQUAL? ,HERE ,MACHINE-ROOM ,MAGNET-ROOM ,CAGE-ROOM>
		    <EQUAL? ,HERE ,WELL-TOP ,IN-CAGE>>
	        <RFALSE>)
	       (T
	        <REMOVE .CAKE>
	        <TELL
"Le " D .CAKE " s'est effondré en poussière." CR>)>>

<ROUTINE CAKE-FCN ("AUX" F N)
	<COND (<VERB? READ>
	       <COND (<FSET? ,PRSO ,NONLANDBIT>
		      <TELL
"Le gâteau est beaucoup trop haut maintenant pour que vous puissiez lire le lettrage." CR>)
		     (,PRSI
		      <COND (<EQUAL? ,PRSI ,PALANTIR-1 ,PALANTIR-2 ,PALANTIR-3>
			     <PERFORM ,V?LOOK-INSIDE ,PRSI>)
			    (<EQUAL? ,PRSI ,FLASK>
			     <TELL "Les lettres, maintenant visibles, disent \"">
			     <COND (<EQUAL? ,PRSO ,RED-ICING>
				    <TELL "Évaporer">)
				   (<EQUAL? ,PRSO ,ORANGE-ICING>
				    <TELL "Exp filon">)
				   (T <TELL "Agrandir">)>
			     <TELL "\"." CR>)
			    (T <TELL "Vous Je ne peux pas voir à travers ça !" CR>)>)
		     (T
		      <TELL
"La première lettre est un E majuscule. Le reste est trop petit pour être lu." CR>)>)
	      (<AND <VERB? EAT>
		    <EQUAL? ,HERE ,TEA-ROOM ,POSTS-ROOM ,POOL-ROOM>>
	       <COND (<EQUAL? ,PRSO ,ORANGE-ICING>
		      <REMOVE ,PRSO>
		      <ICEBOOM>)
		     (<EQUAL? ,PRSO ,RED-ICING>
		      <REMOVE ,PRSO>
		      <JIGS-UP
"C'était délicieux, mais votre mémoire mourante est de se sentir horriblement déshydraté et soif.">)
		     (<EQUAL? ,PRSO ,BLUE-ICING>
		      <REMOVE ,PRSO>
		      <TELL "La pièce autour de vous semble devenir de plus en plus petite."
			    CR CR>
		      <COND (<EQUAL? ,HERE ,POSTS-ROOM>
			     <FCLEAR ,ROBOT ,INVISIBLE>
			     <FCLEAR ,ALICE-TABLE ,INVISIBLE>
			     <FSET ,POSTS ,INVISIBLE>
			     <SET F <FIRST? ,HERE>>
	   		     <REPEAT ()
				<COND (<NOT .F> <RETURN>)
				      (T
				       <SET N <NEXT? .F>>
				       <COND (<AND <NOT <EQUAL? .F ,ADVENTURER>>
						   <FSET? .F ,TAKEBIT>>
					      <FCLEAR .F ,NONLANDBIT>
					      <FCLEAR .F ,TRYTAKEBIT>
					      <MOVE .F ,TEA-ROOM>)>)>
				<SET F .N>>
			     <GOTO ,TEA-ROOM>)
			    (T <JIGS-UP
"La pièce semble être devenue trop petite pour vous tenir. Les murs ne sont pas aussi compressibles que votre corps, qui est démoli." >)>)>)
	      (<AND <VERB? THROW PUT>
		    <EQUAL? ,PRSO ,ORANGE-ICING>
		    <EQUAL? ,HERE ,TEA-ROOM ,POSTS-ROOM ,POOL-ROOM>>
	       <REMOVE ,PRSO>
	       <ICEBOOM>)
	      (<AND <VERB? THROW PUT>
		    <EQUAL? ,PRSO ,RED-ICING ,BLUE-ICING ,ORANGE-ICING>
		    <EQUAL? ,PRSI ,POOL>>
	       <COND (<EQUAL? ,PRSO ,BLUE-ICING ,ORANGE-ICING>
		      <TELL "Le gâteau s'enfonce majestueusement dans la piscine." CR>
		      <REMOVE ,PRSO>
		      <RTRUE>)>
	       <MOVE ,PRSO ,HERE>
	       <REMOVE ,PRSI>
	       <TELL
"La plupart de la piscine s'évapore, révélant un paquet (légèrement humide mais toujours précieux) de bonbons rares. Le gâteau rouge doit être assez fort, car il reste intact!" CR>
	       <FCLEAR ,CANDY ,INVISIBLE>)
	      (T <CAKE-CRUMBLE>)>>

<ROUTINE CANDY-FCN ()
	 <COND (<VERB? EXAMINE READ>
		<FIXED-FONT-ON>
		<TELL
"       Compagnie des confiseries magiques Frobozz|
         >> Assortiment spécial <<|
          Sauterelles confites|
          Fourmis au chocolat|
              Vers glacés|
(Fournisseur attitré de Sa Majesté Nigaud Ier)|
">
		<FIXED-FONT-OFF>
		<RTRUE>)
	       (<VERB? EAT OPEN>
		<TELL
"Une nourriture aussi riche ne serait probablement pas bonne pour vous." CR>)>>

<ROUTINE TOP-ETCHINGS-F ()
	<COND (<VERB? EXAMINE READ>
	       <FIXED-FONT-ON>
	       <TELL
"o o| r z| f M A G I C z| c W E L y| o n| m p a|">
	       <FIXED-FONT-OFF>
	       <RTRUE>)>>

<ROUTINE BOTTOM-ETCHINGS-F ()
	<COND (<VERB? EXAMINE READ>
	       <FIXED-FONT-ON>
	       <TELL
"o b o| | A G I| E L| | m p a|">
	       <FIXED-FONT-OFF>
	       <RTRUE>)>>

<ROUTINE CUBE-F ()
	<COND (<VERB? EXAMINE READ>
	       <FIXED-FONT-ON>
	       <TELL	
"Banque de Zork| VAULT| *722 GUE*| Frobozz Société de la vaillance magique|">
	       <FIXED-FONT-OFF>
	       <RTRUE>)>>

<ROUTINE FIXED-FONT-ON () <PUT 0 8 <BOR <GET 0 8> 2>>>

<ROUTINE FIXED-FONT-OFF() <PUT 0 8 <BAND <GET 0 8> -3>>>

<ROUTINE POOL-FCN ()
	 <COND (<VERB? DRINK>
		<TELL
"L'eau est extrêmement salée." CR>)
	       (<VERB? LOOK-UNDER>
		<TELL
"Vous devrez probablement entrer dans la piscine pour voir ce qu'il y a sous la surface." CR>)
	       (<VERB? THROUGH>
		<JIGS-UP
"Tu entres dans la piscine, tu t'écrases un bon moment, puis tu te noies.">)>>

<ROUTINE FLASK-FCN ()
	 <COND (<VERB? LOOK-INSIDE>
		<TELL
"Vous remarquez que les objets derrière la fiole semblent grossir. Vous pourriez essayer de regarder quelque chose à travers la fiole." CR>)
	       (<AND <VERB? READ> <EQUAL? ,PRSI ,FLASK>>
		<TELL
"Le flacon déforme et agrandit le " D ,PRSO ", montrant des détails non remarqués plus tôt." CR>
		<RFALSE>)
	       (<VERB? OPEN>
		<MUNG-ROOM ,HERE "Des vapeurs nocives empêchent votre entrée.">
		<JIGS-UP ,FATAL-VAPORS>)
	       (<VERB? MUNG THROW>
		<TELL "Le flacon se brise en morceaux." CR>
		<REMOVE ,PRSO>
		<JIGS-UP ,FATAL-VAPORS>)>>

<GLOBAL FATAL-VAPORS
"Pendant que vous vous évanouissez, vous réalisez que les vapeurs du contenu de la fiole sont mortelles.">

<ROUTINE PLEAK ()
    <COND (<VERB? TAKE>
	   <TELL <PICK-ONE ,YUKS> CR>)
	  (<VERB? PLUG>
	   <TELL "La fuite est trop haute au-dessus de vous pour être atteinte." CR>)>>

<ROUTINE ICEBOOM ()
    <MUNG-ROOM ,HERE
"L'entrée est bloquée par des gravats orange collants. Probablement un aventurier insouciant jouait avec des gâteaux à sauter.">
    <JIGS-UP
"Vous avez été réduit en miettes (où qu'ils se trouvent).">>

<ROUTINE MAGNET-ROOM-FCN (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	       <TELL
"Vous êtes dans une pièce circulaire avec un plafond bas. Il y a des sorties à l'est et au sud-est." CR>)
	      (<AND <EQUAL? .RARG ,M-ENTER>
		    ,CAROUSEL-FLIP-FLAG>
	       <COND (,CAROUSEL-ZOOM-FLAG
		      <JIGS-UP <COND (<EQUAL? ,ADVENTURER ,WINNER>
"Selon le Prof. TAA de GUE Tech, les champs magnétiques en évolution rapide dans la pièce sont assez intenses pour vous électrocuter. Je ne sais vraiment pas, mais en tout cas, quelque chose vient de vous tuer." )
				     (T
"Selon le Prof. TAA de GUE Tech, les champs magnétiques dans la pièce sont assez intenses pour faire frire les délicats entrailles du robot. Je ne sais vraiment pas, mais en tout cas, la fumée s'écoule de ses oreilles et elle a cessé de bouger.")>>)
		     (<EQUAL? ,WINNER ,ADVENTURER>
		      <TELL
"Lorsque vous entrez, votre boussole se met à tourner à toute allure." CR>
		      <COND (<NOT ,COMPASS-KLUDGE>
			     <TELL
"Quelle boussole, vous demandez ? Celle qui vous permet de spécifier les directions de la boussole pour le mouvement.">
			     <SETG COMPASS-KLUDGE T>)>
		      <CRLF>)>)>>

<GLOBAL COMPASS-KLUDGE <>>

<ROUTINE MAGNET-ROOM-EXIT ()
	<COND (<AND ,CAROUSEL-FLIP-FLAG <EQUAL? ,WINNER ,ADVENTURER>>
	       <TELL "Vous n'arrivez pas à vous repérer..." CR CR>
	       <COND (<PROB 50>
		      ,MACHINE-ROOM)
		     (T
		      ,TEA-ROOM)>)
	      (<EQUAL? ,PRSO ,P?EAST>
	       ,MACHINE-ROOM)
	      (<OR <EQUAL? ,PRSO ,P?SE>
		   <EQUAL? ,PRSO ,P?OUT>>
	       ,TEA-ROOM)
	      (T
	       <TELL "Vous ne pouvez pas aller jusque là. chemin." CR>
	       <RFALSE>)>>

<GLOBAL CAROUSEL-ZOOM-FLAG <>>

<GLOBAL CAROUSEL-FLIP-FLAG <>>

<ROUTINE BUTTONS ()
	<COND (<VERB? PUSH>
	       <COND (<EQUAL? ,WINNER ,ADVENTURER>
		      <JIGS-UP
"Il y a une étincelle géante et vous êtes grillé.">)
		     (<EQUAL? ,PRSO ,SQUARE-BUTTON>
		      <COND (,CAROUSEL-ZOOM-FLAG
			     <TELL "Rien ne semble " CR>)
			    (ELSE
			     <SETG CAROUSEL-ZOOM-FLAG T>
		      	     <TELL "Le vrombissement augmente en intensité." CR>)>)
		     (<EQUAL? ,PRSO ,ROUND-BUTTON>
		      <COND (,CAROUSEL-ZOOM-FLAG
			     <SETG CAROUSEL-ZOOM-FLAG <>>
		      	     <TELL "Le vrombissement diminue en intensité." CR>)
			    (T
			     <TELL "Rien ne semble " CR>)>)
		     (<EQUAL? ,PRSO ,TRIANGULAR-BUTTON>
		      <SETG CAROUSEL-FLIP-FLAG <NOT ,CAROUSEL-FLIP-FLAG>>
		      <COND (<IN? ,IRON-BOX ,CAROUSEL-ROOM>
			     <TELL
"Un bruit sourd se fait entendre dans le distance." CR>
			     <COND (<FSET? ,IRON-BOX ,INVISIBLE>
				    <FCLEAR ,IRON-BOX ,INVISIBLE>)
				   (T
				    <FSET ,IRON-BOX ,INVISIBLE>)>
			     <COND (<NOT <FSET? ,IRON-BOX ,INVISIBLE>>
				    <FCLEAR ,CAROUSEL-ROOM ,TOUCHBIT>)>
			     T)
			    (T <TELL "Cliquez." CR>)>)>)>>

<GLOBAL CAGE-SOLVE-FLAG <>>

<ROUTINE SPHERE-FCN ("AUX" FL)
	#DECL ((FL) <OR ATOM FALSE>)
	<COND (<AND <NOT ,CAGE-SOLVE-FLAG> <VERB? TAKE MOVE PUT>>
	       <SET FL T>)
	      (T <SET FL <>>)>
	<COND (<AND .FL <EQUAL? ,ADVENTURER ,WINNER>>
	       <TELL
"À mesure que vous atteignez la sphère, une cage en acier solide tombe du plafond pour vous piéger." CR CR>
	       <COND (<IN? ,ROBOT ,HERE>
		      <MOVE ,ROBOT ,IN-CAGE>
		      <FSET ,ROBOT ,NDESCBIT>)>
	       <GOTO ,IN-CAGE>
	       <MOVE ,CAGE ,HERE>
	       <FSET ,CAGE ,NDESCBIT>
	       <FCLEAR ,CAGE ,INVISIBLE>
	       <ENABLE <QUEUE I-SPHERE 6>>
	       T)
	      (.FL
	       <FSET ,PALANTIR-1 ,INVISIBLE>
	       <REMOVE ,ROBOT>
	       <FSET ,PRSO ,INVISIBLE>
	       <MOVE ,CAGE ,CAGE-ROOM>
	       <FCLEAR ,CAGE ,INVISIBLE>
	       <JIGS-UP
"Comme le robot atteint pour la sphère, une cage en acier solide tombe du plafond, le piégeant. Vous pouvez peu entendre ses derniers mots: \"Whirr, buzz, click!\" Un nuage de fumée montant de dessous la cage confirme vos craintes sur le sort de votre brave ami mécanique.">
	       T)
	      (<VERB? LOOK-INSIDE EXAMINE>
	       <PALANTIR>)>>

<ROUTINE I-SPHERE ()
	 <COND (<EQUAL? ,HERE ,CAGE-ROOM ,IN-CAGE>
		<FSET ,PALANTIR-1 ,INVISIBLE>
		<MUNG-ROOM ,CAGE-ROOM
"Vous êtes arrêté par un nuage de gaz toxique.">
		<JIGS-UP
"Le temps passe... et vous mourez d'un obscur empoisonnement.">)>>

<ROUTINE IN-CAGE-FCN (RARG)
    <COND (,CAGE-SOLVE-FLAG <SETG HERE ,CAGE-ROOM>)>>

<ROUTINE ROBOT-FCN ("OPTIONAL" (RARG ,M-OBJECT))
	<COND (<EQUAL? ,WINNER ,ROBOT>
	       <COND (<VERB? SGIVE> <RFALSE>)
		     (<VERB? FOLLOW>
		      <TELL
"\"Mes circuits de mémoire ne sont pas aussi avancés. Je peux bouger comme dirigé, cependant.\"" CR>)
		     (<AND <VERB? RAISE TAKE MOVE> <EQUAL? ,PRSO ,CAGE>>
		      <TELL
"La cage tremble et est jetée à travers la pièce. C'est difficile à dire, mais le robot semble sourire." CR CR>
		      <DISABLE <INT I-SPHERE>>
		      <SETG WINNER ,ADVENTURER>
		      <GOTO ,CAGE-ROOM>
		      <MOVE ,MANGLED-CAGE ,CAGE-ROOM>
		      <FCLEAR ,ROBOT ,NDESCBIT>
		      <FSET ,PALANTIR-1 ,TAKEBIT>
		      <MOVE ,ROBOT ,CAGE-ROOM>
		      <SETG CAGE-SOLVE-FLAG T>)
		     (<VERB? EAT DRINK>
		      <COND (<IN? ,ADVENTURER ,HERE>
			     <TELL
"\"Je suis désolé mais c'est difficile pour un être sans bouche.\"" CR>)>
		      <RTRUE>)
		     (<AND <PROB 2>
			   <EQUAL? <META-LOC ,ADVENTURER> ,HERE>>
		      <TELL
"\"Buzz ! Buzz ! Buzz ! Mes circuits commencent à rouiller. Essayez encore.\"" CR>)
		     (<VERB? READ EXAMINE>
		      <COND (<EQUAL? <META-LOC ,ADVENTURER> ,HERE>
			     <TELL
"\"Ma vision n'est pas suffisamment aiguë pour faire ça.\"" CR>)>
		      <RTRUE>)
		     (<VERB? DROP PUT THROW>
		      <COND (<NOT <EQUAL? <META-LOC ,ADVENTURER> ,HERE>>
			     <RFALSE>)
			    (<IN? ,PRSO ,ROBOT>
			     <TELL "\"Whirr, buzz, click!\"" CR>
			     <RFALSE>)
			    (T
			     <TELL
"\"Cliquez ! ça. Buzz ! Whirr!\"" CR>)>)
		     (<OR <VERB? WALK>
			  <AND <VERB? TAKE PUSH TURN>
			       <NOT <FSET? ,PRSO ,ACTORBIT>>>>
		      <COND (<NOT <EQUAL? <META-LOC ,ADVENTURER> ,HERE>>
			     <RFALSE>)
			    (<PROB 80>
			     <TELL "\"Whirr, buzz, click!\"" CR>)
			    (T
			     <TELL "\"Buzz, clic, whirr!\"" CR>)>
		      <RFALSE>)
		     (T
		      <COND (<EQUAL? <META-LOC ,ADVENTURER> ,HERE>
			     <TELL
"\"Ma programmation est insuffisante pour me permettre d'effectuer cela. tâche.\"" CR>)>
		      <RTRUE>)>)
	      (<VERB? OPEN LOOK-INSIDE CLOSE>
	       <TELL "Il n'y a pas de panneau d'accès ni de porte sur le robot." CR>)
	      (<AND <VERB? GIVE>
		    <EQUAL? ,PRSI ,ROBOT>>
	       <MOVE ,PRSO ,ROBOT>
	       <TELL "Le robot prend volontiers le "
		     D ,PRSO
		     " et hoche la tête avec son appendice en forme de tête en remerciement." CR>)
	      (<VERB? THROW MUNG>
	       <TELL
"Le robot tombe au sol et se désintègre sous vos yeux." CR>
	       <REMOVE <COND (<VERB? THROW> ,PRSI) (,PRSO)>>)>>

\

;"SUBTITLE BANK OF ZORK"

<GLOBAL BANK-SOLVE-FLAG <>>

<ROUTINE BILLS-OBJECT ()
	<SETG BANK-SOLVE-FLAG T>
	<COND (<VERB? BURN>
	       <TELL "Rien de tel que d'avoir de l'argent à dépenser !" CR>
	       <RFALSE>)
	      (<VERB? EAT>
	       <TELL "Parlez de manger des aliments riches !" CR>)>>
	
<ROUTINE BKLEAVEE ("OPTIONAL" (RM ,TELLER-EAST))
    #DECL ((RM) OBJECT)
    <COND (<OR <HELD? ,BILLS> <HELD? ,PORTRAIT>>
	   <TELL
"Une alarme sonne brièvement et un signal invisible forcez les barreaux sur votre chemin." CR>
	   <RFALSE>)
	  (T .RM)>>

<ROUTINE BKLEAVEW ()
    <BKLEAVEE ,TELLER-WEST>>

<GLOBAL SCOL-ROOMS <LTABLE
       P?EAST
       VIEWING-EAST
       P?WEST
       VIEWING-WEST
       P?NORTH
       SMALL-ROOM
       P?SOUTH
       VAULT>>

<GLOBAL SCOL-WALLS <TABLE
       VIEWING-WEST
       SEWL
       VIEWING-WEST
       VIEWING-EAST
       SWWL
       VIEWING-EAST
       SMALL-ROOM
       SSWL
       VAULT
       VAULT
       SNWL
       SMALL-ROOM>>

<GLOBAL SCOL-ROOM VIEWING-WEST>

<ROUTINE DEPOSITORY-FCN (RARG)
	<COND (<EQUAL? .RARG ,M-ENTER>
	       <SETG SCOL-ROOM <LKP ,PRSO ,SCOL-ROOMS>>)>>

<ROUTINE TELLER-ROOM (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
	   <TELL
"Vous êtes dans une petite salle, qui a été utilisée par un agent de banque qui a récupéré des coffres de sécurité pour le client. Du côté nord de la salle est un panneau qui se lit \"Salle de vue\".">
	   <COND (<EQUAL? ,HERE ,TELLER-WEST> <TELL "ouest">)
		 (T <TELL "est">)>
	   <TELL "côté de la pièce, au-dessus d'une porte ouverte, est un panneau de lecture:| | BANQUE PERSONNEL SEULEMENT|" CR>)>>

<ROUTINE SCOL-OBJECT ("OPTIONAL" (OBJ <>))
    <COND (<VERB? PUSH MOVE TAKE RUB>
	   <TELL "Lorsque vous essayez, votre main semble le traverser." CR>)
	  (<AND <VERB? ATTACK> ,PRSI>
	   <TELL "Le " D ,PRSI " le traverse." CR>)
	  (<AND <VERB? THROW OVERBOARD> <EQUAL? ,PRSI ,CURTAIN .OBJ>>
	   <COND (<IN? ,PRSO ,WINNER>
		  <V-THROUGH ,PRSO>)
		 (T <TELL "Vous n'avez pas ça !" CR>)>)>>

<ROUTINE GET-WALL (RM "AUX" W)
    #DECL ((RM) OBJECT)
    <SET W ,SCOL-WALLS>
    <REPEAT ()
	<COND (<EQUAL? <GET .W 0> .RM>
	       <RETURN .W>)
	      (T <SET W <REST .W 6>>)>>>

<ROUTINE SCOLWALL ()
    <COND (<AND <VERB? THROW OVERBOARD PUT>
		<EQUAL? ,HERE ,SCOL-ACTIVE>
		<EQUAL? ,PRSI <GET <GET-WALL ,HERE> 1>>>
	   <SCOL-OBJECT ,PRSI>)>>

<ROUTINE SCOL-GO (OBJ)
	 #DECL ((OBJ) OBJECT)
	 <SETG SCOL-ACTIVE ,SCOL-ROOM>
	 <COND (.OBJ <SCOL-OBJ .OBJ 0 ,SCOL-ROOM>)
	       (T
	        <SCOL-THROUGH 12 ,SCOL-ROOM>)>>

<ROUTINE SCOL-OBJ (OBJ CINT RM)
    #DECL ((OBJ) OBJECT (CINT) FIX (RM) OBJECT)
    <ENABLE <QUEUE I-CURTAIN .CINT>>
    <MOVE .OBJ .RM>
    <COND (<EQUAL? .RM ,DEPOSITORY>
	   <TELL "Le " D .OBJ " traverse le mur et disparaît." CR>)
	  (T
	   <TELL "Le rideau s'assombrit légèrement au passage du "
		 D .OBJ "." CR>
	   <SETG SCOL-ROOM <>>
	   T)>>

<ROUTINE SCOL-THROUGH (CINT RM)
    #DECL ((CINT) FIX (RM) OBJECT)
    <ENABLE <QUEUE I-CURTAIN .CINT>>
    <TELL "Vous vous sentez quelque peu désorienté en passant. à travers..." CR CR>
    <GOTO .RM>>

<GLOBAL SCOL-ACTIVE <>>

<ROUTINE I-CURTAIN ()
    <SETG SCOL-ACTIVE <>>
    <COND (<EQUAL? ,HERE ,VAULT>
	   <JIGS-UP
"Une voix métallique annonce : \"Bonjour, intrus ! Votre présence non autorisée dans la chambre forte de la Banque de Zork a déclenché toutes sortes de mauvaises surprises, dont la plupart sont mortelles. Ce message vous est offert par la Compagnie des chambres fortes magiques Frobozz.\"">)
	  (<EQUAL? ,HERE ,VIEWING-EAST ,VIEWING-WEST ,SMALL-ROOM>
	   <TELL "Vous entendez une voix faible dire \"Porte du rideau fermée.\"" CR>
	   <COND (<EQUAL? ,HERE ,SMALL-ROOM>
	          <COND (,ZGNOME-FLAG <RTRUE>)
		        (T
		         <ENABLE <QUEUE I-ZGNOME 3>>
		         <SETG ZGNOME-FLAG T>)>)>)>>

<GLOBAL ZGNOME-FLAG <>>

<ROUTINE I-ZGNOME ()
         <COND (<EQUAL? ,HERE ,SMALL-ROOM>
		<ENABLE <QUEUE I-ZGNOME-OUT 12>>
		<TELL
"Un gnome épique de Zurich portant un costume en trois pièces et portant un coffre se matérialise dans la pièce.">
		<COND (<IN? ,WAND ,WINNER>
		       <TELL
" Il remarque la baguette et se dématérialise rapidement." CR>)
		      (T
		       <TELL "\"Vous semblez avoir oublié de déposer vos objets de valeur,\" dit-il en tapant le couvercle de la boîte avec impatience. \"Nous n'autorisons généralement pas les clients à utiliser les boîtes ici, mais nous pouvons faire cette exception, je suppose...\" Il vous regarde à la question sur ses bifocals filaires." CR>
		       <MOVE ,GNOME-OF-ZURICH ,HERE>)>)>>

<ROUTINE BOX-F ()
	 <TELL "Le gnome le serre de manière possessive." CR>>

<ROUTINE ZGNOME-FCN ()
    <COND (<VERB? TELL>
	   <SETG P-CONT <>>
	   <SETG QUOTE-FLAG <>>
	   <TELL
"Le gnome apparaît de plus en plus impatient." CR>)
	  (<AND <VERB? GIVE THROW> <EQUAL? ,PRSI ,GNOME-OF-ZURICH>>
	   <COND (<GETPT ,PRSO ,P?VALUE>
		  <TELL
"Le gnome place soigneusement le " D ,PRSO  "\"Laissez-moi vous montrer la sortie,\" dit-il, en indiquant clairement qu'il sera heureux de voir le dernier d'entre vous. Ensuite, vous êtes momentanément désorienté, et quand vous récupérer vous êtes de retour à l'entrée de la banque." CR>
		  <REMOVE ,GNOME-OF-ZURICH>
		  <REMOVE ,PRSO>
		  <DISABLE <INT I-ZGNOME-OUT>>
		  <GOTO ,BANK-ENTRANCE>
		  <RTRUE>)
		 (<BOMB? ,PRSO>
		  <REMOVE ,GNOME-OF-ZURICH>
		  <MOVE ,PRSO ,HERE>
		  <DISABLE <INT I-ZGNOME>>
		  <DISABLE <INT I-ZGNOME-OUT>>
		  <TELL
"« Tu es si gracieuse. Je ne peux vraiment pas accepter. » dit-il. Il disparaît, un sourire crié sur ses lèvres." CR>)
		 (T
		  <TELL
"\"Je ne mettrais pas ça dans un coffre\", remarque le gnome avec dédain, le jetant sur son épaule, où il disparaît avec une \"pop\" sous-estimée." CR>
		  <REMOVE-CAREFULLY ,PRSO>
		  <RTRUE>)>)
	  (<VERB? ATTACK>
	   <TELL
"Le gnome dit \"Eh bien, je n'ai jamais...\" et disparaît avec un coup de doigts, vous laissant seul." CR>
	   <REMOVE ,GNOME-OF-ZURICH>
	   <DISABLE <INT I-ZGNOME-OUT>>)
	  (T
	   <TELL
"Le gnome apparaît de plus en plus impatient." CR>)>>

<ROUTINE I-ZGNOME-OUT ()
         <REMOVE ,GNOME-OF-ZURICH>
	 <COND (<EQUAL? ,HERE ,SMALL-ROOM>
		<TELL
"Le gnome a l'air impatient : « J'ai peut-être un autre client à attendre ; il va falloir se débrouiller, j'ai peur. » Il disparaît, vous laissant seul." CR>)>>

<ROUTINE BOMB? (O)
	<COND (<AND <EQUAL? .O ,BRICK>
	            <IN? ,FUSE ,BRICK>
		    <NOT <0? <GET <INT I-FUSE> ,C-ENABLED?>>>>
	       <RTRUE>)
	      (T <RFALSE>)>>

\

"PALANTIRS, ETC."

<ROUTINE GO&LOOK (RM "AUX" OHERE OLIT (OSEEN <>))
	 #DECL ((RM) OBJECT)
	 <SET OHERE ,HERE>
	 <COND (<FSET? .OHERE ,TOUCHBIT>
		<SET OSEEN T>)>
	 <SET OLIT ,LIT>
	 <SETG HERE .RM>
	 <SETG LIT <LIT? .RM>>
	 <PERFORM ,V?LOOK>
	 <COND (<NOT .OSEEN> <FCLEAR .OHERE ,TOUCHBIT>)>
	 <SETG HERE .OHERE>
	 <SETG LIT .OLIT>
	 T>

<ROUTINE TINY-ROOM-FCN (RARG)
    #DECL ((RARG) <OR FIX FALSE>)
    <COND (<EQUAL? .RARG ,M-LOOK>
	   <TELL
"Il s'agit d'une petite pièce taillée sur le mur du ravin. Il y a une sortie en bas d'une montée précaire.">
	   <P-DOOR "nord" ,LID-1 ,KEYHOLE-1>
	   <RTRUE>)
	  (<NOT <VERB? LOOK>> <PCHECK> <RFALSE>)>>

<ROUTINE DREARY-ROOM-FCN (RARG)
    #DECL ((RARG) <OR FIX FALSE>)
    <COND (<EQUAL? .RARG ,M-LOOK>
	   <TELL
"Il s'agit d'une petite pièce plutôt sinistre, illuminé par une lueur rouge émanant d'une fissure dans un mur. La lumière tombe sur une table en bois poussiéreuse au centre de la pièce.">
	   <P-DOOR "sud" ,LID-2 ,KEYHOLE-2>
		   <RTRUE>)
		          (T <PCHECK> <RFALSE>)>>

<ROUTINE PCHECK ("AUX" (LID <PLID>))
	#DECL ((LID) OBJECT)
	<SETG PLOOK-FLAG <>>
	<COND (<OR <IN? ,KEY ,KEYHOLE-1>
		   <IN? ,KEY ,KEYHOLE-2>>
	       <FSET ,KEY ,NDESCBIT>)
	      (T
	       <FCLEAR ,KEY ,NDESCBIT>)>
	<COND (<HELD? ,PLACE-MAT>
	       <SETG MUD-FLAG <>>)> ;"HUH?"
	<COND (,MUD-FLAG
	       <MOVE ,PLACE-MAT ,HERE>
	       <FSET ,PLACE-MAT ,NDESCBIT>)
	      (T
	       <FCLEAR ,PLACE-MAT ,NDESCBIT>)>>

<ROUTINE P-DOOR (STR LID KEYHOLE "AUX" F)
	#DECL ((STR) STRING (LID KEYHOLE) OBJECT)
	<COND (,PLOOK-FLAG <SETG PLOOK-FLAG <>> <RFALSE>)>
	<TELL "Sur le côté "
	      .STR
	      "côté de la pièce est une porte massive en bois, qui a une petite fenêtre barrée de fer. Un verrou formidable est mis dans le cadre de la porte.">
	<COND (<NOT <FSET? .LID ,OPENBIT>>
	       <TELL "recouvert par un mince couvercle métallique ">)>
	<TELL "se trouve à l'intérieur de la serrure.">
	<COND (<SET F <FIRST? .KEYHOLE>>
	       <TELL " A " D .F
		     " est en place dans le trou de la serrure.">)>
	<COND (,MUD-FLAG
	       <TELL " Le bord d'un set de table est visible sous la porte.">
	       <COND (,MATOBJ
		      <TELL " Allongé sur le set de table se trouve un " D ,MATOBJ ".">)>)>
	<CRLF>>

<ROUTINE PLID ("OPTIONAL" (OBJ1 ,LID-1) (OBJ2 ,LID-2))
    #DECL ((OBJ1 OBJ2) OBJECT)
    <COND (<IN? .OBJ1 ,HERE>
	   .OBJ1)
	  (T .OBJ2)>>

<ROUTINE PKH (KEYHOLE "OPTIONAL" (THIS <>))
    #DECL ((KEYHOLE) OBJECT (THIS) <OR ATOM FALSE>)
    <COND (<AND <EQUAL? .KEYHOLE ,KEYHOLE-1> <NOT .THIS>>
	   ,KEYHOLE-2)
	  (<AND <NOT <EQUAL? .KEYHOLE ,KEYHOLE-1>> .THIS>
	   ,KEYHOLE-2)
	  (T ,KEYHOLE-1)>>

<ROUTINE PKH-FCN ("AUX" OBJ KH)
    #DECL ((OBJ) OBJECT)
    <COND (<VERB? LOOK-INSIDE>
	   <COND (<AND <FSET? ,LID-1 ,OPENBIT>
		       <FSET? ,LID-2 ,OPENBIT>
		       <NOT <FIRST? ,KEYHOLE-1>>
		       <NOT <FIRST? ,KEYHOLE-2>>
		       <LIT? <COND (<EQUAL? ,HERE ,DREARY-ROOM>
				    ,TINY-ROOM)
				   (T ,DREARY-ROOM)>>>
		  <TELL
"Vous pouvez voir une pièce éclairée à l'autre extrémité." CR>)
		 (T
		  <TELL
"Aucune lumière n'est visible à travers le trou de la serrure." CR>)>)
	  (<VERB? PUT>
	   <COND (<FSET? <PLID> ,OPENBIT>
		  <COND (<FIRST? <PKH ,PRSI T>>
			 <TELL "Le trou de la serrure est bloqué." CR>)
			(<EQUAL? ,PRSO ,LETTER-OPENER ,KEY>
			 <COND (<FIRST? <SET KH <PKH ,PRSI>>>
				<TELL
"Il y a un léger bruit de derrière la porte et un petit nuage de poussière s'élève de dessous." CR>
				<SET OBJ <FIRST? .KH>>
				<REMOVE .OBJ>
				<COND (,MUD-FLAG
				       <SETG MATOBJ .OBJ>)>
				<RFALSE>)>)
			(T <TELL "Le " D ,PRSO " ne rentre pas." CR>)>)
		 (T <TELL "Le couvercle gêne." CR>)>)>>

<ROUTINE PLID-FCN ()
    <COND (<VERB? OPEN RAISE MOVE>
	   <COND (<FSET? ,PRSO ,OPENBIT>
		  <TELL <RANDOM-ELEMENT ,DUMMY> CR>)
		 (T <TELL "Le couvercle est maintenant ouvert." CR>)>
	   <FSET ,PRSO ,OPENBIT>)
	  (<VERB? CLOSE LOWER>
	   <COND (<FIRST? <COND (<EQUAL? ,HERE ,DREARY-ROOM>
				 ,KEYHOLE-2)
				(T ,KEYHOLE-1)>>
		  <TELL "Le trou de serrure est occupé." CR>)
		 (T
		  <TELL "Le couvercle recouvre le trou de serrure." CR>
		  <FCLEAR ,PRSO ,OPENBIT>)>)
	  (<VERB? LOOK-BEHIND>
	   <TELL "Il y a un trou de serrure derrière le couvercle." CR>)>>
	
<GLOBAL MUD-FLAG <>>

<GLOBAL MATOBJ <>>

<GLOBAL PUNLOCK-FLAG <>>

<GLOBAL PLOOK-FLAG <>>

<ROUTINE ROOM? (OBJ "AUX" NOBJ)
	 <REPEAT ()
		 <SET NOBJ <LOC .OBJ>>
		 <COND (<NOT .NOBJ> <RFALSE>)
		       (<EQUAL? .NOBJ ,WINNER> <RFALSE>)
		       (<EQUAL? .NOBJ ,ROOMS> <RETURN .OBJ>)>
		 <SET OBJ .NOBJ>>>

<ROUTINE PALANTIR ()
	 <COND (<VERB? LOOK-INSIDE>
		<PALANTIR-LOOK <COND (<EQUAL? ,PRSO ,PALANTIR-1>
				      ,PALANTIR-2)
				     (<EQUAL? ,PRSO ,PALANTIR-2>
				      ,PALANTIR-3)
				     (<EQUAL? ,PRSO ,PALANTIR-3>
				      ,PALANTIR-1)
				     (T ,PALANTIR-4)>>)
	       (<VERB? EXAMINE>
		<TELL
"Il y a quelque chose de brumeux dans la sphère." CR>)
	       (<AND <VERB? TAKE> <==? ,PRSO ,PALANTIR-3>>
		<PUTP ,PRSO ,P?LDESC <>>
		<RFALSE>)>>

<ROUTINE DEAD-PALANTIR (RARG "AUX" P)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Vous êtes à l'intérieur d'une immense sphère cristalline remplie de fines particules "
		<COND (<EQUAL? ,HERE ,DEAD-PALANTIR-1>
		       <SET P ,PALANTIR-1>
		       "rouge")
		      (<EQUAL? ,HERE ,DEAD-PALANTIR-2>
		       <SET P ,PALANTIR-2>
		       "bleu")
		      (T <SET P ,PALANTIR-3> "blanc")>
" brume. La brume devient "
		<COND (<EQUAL? ,HERE ,DEAD-PALANTIR-1> "bleu")
		      (<EQUAL? ,HERE ,DEAD-PALANTIR-2> "blanc")
		      (T "noire")>
" à l'ouest." CR>
		<TELL "Vous vous efforcez de regarder à travers la brume... " CR>
		<COND (<FSET? .P ,TOUCHBIT>
		       <PALANTIR-LOOK .P T>)
		      (<EQUAL? .P ,PALANTIR-1>
		       <TELL
"Vous voyez une petite pièce avec un panneau sur le mur, mais il est trop flou à lire." CR>)
		      (<EQUAL? .P ,PALANTIR-2>
		       <TELL
"Vous regardez dehors dans une grande pièce triste avec une grande porte et une grande table. Il y a une lueur étrange à la brume." CR>)
		      (<EQUAL? .P ,PALANTIR-3>
		       <TELL
"Une étrange pièce floue est à peine visible.">
		       <COND (<AND <IN? ,SERPENT ,AQUARIUM> <PROB 25>>
			      <TELL
" Une étrange ombre sinueuse traverse la brume alors que vous regardez.">)>
		       <CRLF>)>
		<RTRUE>)
	       (<AND <EQUAL? .RARG ,M-ENTER> <EQUAL? ,HERE ,DEAD-PALANTIR-4>>
		<TELL
"Nous suivons un couloir de brouillard noir dans une pièce sphérique à murs noirs.">
		<COND (<IN? ,GENIE ,PENTAGRAM-ROOM>
		       <TELL
"La chambre est vide. Un visage énorme vous regarde de l'extérieur et rit sardoniquement." CR>
		       <FINISH>)>
		<TELL
"Alors que vous entrez, un visage énorme et horrible se matérialise hors de la brume.| | \"Qu'est-ce qui vous amène ici à troubler mon emprisonnement, vagabond?\" il demande." CR>

		<COND (<NOT <L? ,DEATHS 3>>
		       <TELL
"\"Pas toi encore ! Ça devient fastidieux. Tu ne me seras évidemment jamais beaucoup d'aide. Plus de chance la prochaine fois, oh merveilleux aventurier.\" Le visage disparaît et tout devient noir." CR>
		       <FINISH>)
		      (T
		       <TELL
"\"Peut-être que tu me seras utile pour gagner ma liberté de ce lieu. Retourne à ta quête insensée! Je ne te détruirai pas cette fois-ci. Puisses-tu rendre cette faveur en bonté un jour.\" Le visage disparaît et la brume commence à tourner. Quand elle éclaircit, tu es rendu au monde de la vie." CR>
		<SETG DEAD <>>
		<GOTO ,INSIDE-BARROW>
		;<GOTO ,INSIDE-BARROW <>>
		;<TELL CR "À l'intérieur du tumulus" CR>
		<RTRUE>)>)>>

<ROUTINE GLOBAL-PALANTIRS ()
	 <COND (<VERB? LOOK-INSIDE EXAMINE>
		<DEAD-PALANTIR ,M-LOOK>)
	       (<VERB? MUNG> <TELL "La sphère est incassable." CR>)>>

<ROUTINE PALANTIR-LOOK (OBJ "OPTIONAL" (INSIDE? <>) "AUX" RM OHERE)
	 <COND (<EQUAL? .OBJ ,PALANTIR-4>
		<TELL
"Quand vous regardez dans la sphère, une vision étrange prend forme... un visage énorme et redoutable avec des yeux jaunes." CR>
		<RTRUE>)>
	 <SET RM <ROOM? .OBJ>>
	 <COND (<OR <NOT .RM> <NOT <LIT? .RM>>>
		<TELL "Vous ne voyez que l'obscurité." CR>)
	       (<OR <IN? .OBJ .RM> <SEE-INSIDE? <LOC .OBJ>>>
		<SET OHERE ,HERE>
		<COND (.INSIDE?
		       <TELL
"Alors que vous regardez à travers la brume, une vision étrangement colorée d'une grande pièce prend forme..." CR CR>)
		      (T
		       <TELL
"Tandis que vous entrez dans la sphère, une vision étrange prend forme d'une pièce lointaine, qui peut être décrite clairement..." CR CR>)>
		<FSET .OBJ ,INVISIBLE>
		<GO&LOOK .RM>
		<COND (<EQUAL? .OHERE .RM>
		       <TELL
"Un aventurier étonné regarde dans une sphère de cristal." CR>)>
		<FCLEAR .OBJ ,INVISIBLE>
		<COND (<NOT .INSIDE?>
		       <TELL
"La vision s'efface, révélant seulement un cristal ordinaire. " CR>)>)
	       (T
		<TELL "Vous ne voyez que l'obscurité." CR>)>
	 T>

<ROUTINE PWINDOW-FCN ()
    <COND (<VERB? LOOK-INSIDE>
	   <SETG PLOOK-FLAG T>
	   <COND (<FSET? ,PDOOR ,OPENBIT>
		  <TELL "La porte est ouverte, mannequin." CR>)
		 (<EQUAL? ,HERE ,DREARY-ROOM>
		  <GO&LOOK ,TINY-ROOM>)
		 (T <GO&LOOK ,DREARY-ROOM>)>)
	  (<VERB? THROUGH>
	   <TELL "Peut-être que si tu étais coupé en dés...." CR>)>>

<ROUTINE PDOOR-FCN ("AUX" K)
    <COND (<AND <VERB? LOOK-UNDER> ,MUD-FLAG>
	   <TELL "Le set de table est sous la porte." CR>)
	  (<VERB? UNLOCK>
	   <COND (<EQUAL? ,PRSI ,KEY>
		  <COND (<AND <SET K <FIRST? <PLID ,KEYHOLE-1 ,KEYHOLE-2>>>
			      <NOT <EQUAL? .K ,KEY>>>
			 <TELL "Le trou de la serrure est bloqué." CR>)
			(T
			 <TELL "La porte est maintenant déverrouillée." CR>
			 <SETG PUNLOCK-FLAG T>)>)
		 (<EQUAL? ,PRSI ,GOLD-KEY>
		  <TELL "Elle ne rentre pas dans la serrure." CR>)
		 (T <TELL "Elle ne peut pas être déverrouillée avec ça." CR>)>)
	  (<VERB? LOCK>
	   <COND (<EQUAL? ,PRSI ,KEY>
		  <TELL "La porte est verrouillée." CR>
		  <SETG PUNLOCK-FLAG <>>
		  T)
		 (<EQUAL? ,PRSI ,GOLD-KEY>
		  <TELL "Elle ne rentre pas dans la serrure." CR>)
		 (T <TELL "On ne peut pas la verrouiller avec ça." CR>)>)
	  (<VERB? PUT-UNDER>
	   <COND (<EQUAL? ,PRSO ,ROBOT-LABEL>
		  <TELL
"Le papier est très petit et disparaît sous le porte." CR>
		  <MOVE ,PRSO <COND (<EQUAL? ,HERE ,TINY-ROOM> ,DREARY-ROOM)
				    (T ,TINY-ROOM)>>)
		 (<EQUAL? ,PRSO ,NEWSPAPER>
		  <TELL
"Le journal se froisse et ne passe pas sous la porte." CR>)>)
	  (<VERB? OPEN CLOSE>
	   <COND (,PUNLOCK-FLAG
		  <OPEN-CLOSE ,PRSO
		       "La porte est maintenant ouverte."
		       "La porte est maintenant ouverte. fermé.">)
		 (T <TELL "La porte est verrouillée." CR>)>)>>
	
<ROUTINE PKEY-FCN ()
    <COND (<VERB? TURN>
	   <COND (,PUNLOCK-FLAG
		  <PERFORM ,V?LOCK ,PDOOR ,PRSO>)
		 (T
		  <PERFORM ,V?UNLOCK ,PDOOR ,PRSO>)>)>>
		
<ROUTINE PLACE-MAT-FCN ()
    <COND (<VERB? PUT-UNDER>
	   <COND (<EQUAL? ,PRSI ,PDOOR>
	          <TELL "Le set de table se glisse facilement sous la porte." CR>
	          <MOVE ,PRSO ,HERE>
	          <SETG MUD-FLAG T>)
		 (<EQUAL? ,PRSI ,WIZ-DOOR ,RIDDLE-DOOR ,CRYPT-DOOR>
	          <TELL "Il n'y a pas assez de place sous cette porte." CR>)>)
	  (<AND <VERB? TAKE MOVE> ,MATOBJ>
 	   <MOVE ,MATOBJ ,HERE>
	   <TELL "Lorsque le set de table est déplacé, un "
		 D
		 ,MATOBJ
		 " en tombe et tombe sur le sol." CR>
	   <SETG MATOBJ <>>
	   <SETG MUD-FLAG <>>
	   <RTRUE>)>>

<ROUTINE WISH-FCN ()
	 <COND (<VERB? MAKE>
	        <COND (<AND <EQUAL? ,HERE ,WELL-BOTTOM>
			    <IN? ,COIN ,HERE>>
		       <TELL
"Une voix chuchotante répond: \"L'eau fait partir le seau.\" Malheureusement, le désir fait partir la pièce..." CR>
		      <REMOVE ,COIN>)
		      (T
		       <TELL "Personne n'écoute." CR>)>)>>

<ROUTINE WELL-FCN ()
    	<COND (<AND <FSET? ,PRSO ,TAKEBIT> <VERB? THROW PUT DROP>>
	       <TELL "Le " D ,PRSO
		     " est maintenant assis au fond du puits." CR>
	       <MOVE ,PRSO ,WELL-BOTTOM>)
	      (<VERB? CLIMB-UP CLIMB-DOWN CLIMB-FOO>
	       <TELL "Vous ne pouvez pas grimper le puits." CR>)>>

<GLOBAL MATCH-COUNT 6>

<ROUTINE MATCH-FCN ( "AUX" CNT)
	 <COND (<AND <VERB? LAMP-ON BURN> <EQUAL? ,PRSO ,MATCH>>
		<COND (<G? ,MATCH-COUNT 0>
		       <SETG MATCH-COUNT <- ,MATCH-COUNT 1>>)>
		<COND (<NOT <G? ,MATCH-COUNT 0>>
		       <TELL
			"Je crains que vous n'ayez plus d'allumettes." CR>)
		      (T
		       <FSET ,MATCH ,FLAMEBIT>
		       <FSET ,MATCH ,ONBIT>
		       <ENABLE <QUEUE I-MATCH 2>>
		       <TELL "L'un des matchs commence à brûler." CR>)>)
	       (<AND <VERB? LAMP-OFF> <FSET? ,MATCH ,FLAMEBIT>>
		<TELL "Le match est terminé." CR>
		<FCLEAR ,MATCH ,FLAMEBIT>
		<FCLEAR ,MATCH ,ONBIT>
		<QUEUE I-MATCH 0>
		T)
	       (<VERB? COUNT>
		<TELL "Vous avez ">
		<SET CNT <- ,MATCH-COUNT 1>>
		<TELL N .CNT " allumette">
		<COND (<NOT <1? .CNT>> <TELL "es.">) (T <TELL ".">)>
		<CRLF>)
	       (<VERB? EXAMINE>
		<COND (<FSET? ,MATCH ,ONBIT>
		       <TELL "Une allumette brûle.">)
		      (T
		       <TELL "Aucune allumette n'est disponible. brûle.">)>
		<CRLF>)>>

<ROUTINE I-MATCH ()
	 <TELL "L'allumette s'est éteinte." CR>
	 <FCLEAR ,MATCH ,FLAMEBIT>
	 <FCLEAR ,MATCH ,ONBIT>>


<GLOBAL LAMP-TABLE
	<TABLE 300
	       "La lampe apparaît un peu "
	       100
	       "La lampe est définitivement plus faible maintenant."
	       50
	       "La lampe est presque éteinte."
	       0>>

<ROUTINE LANTERN ()
	 <COND (<AND <VERB? THROW> <==? ,PRSO ,LAMP>>
		<TELL
"La lampe s'est écrasée contre le sol et la lumière s'est éteinte. éteint." CR>
		<DISABLE <INT I-LANTERN>>
		<REMOVE ,LAMP>
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
		<COND (<FSET? ,LAMP ,RMUNGBIT>
		       <TELL "La lampe est grillée.">)
		      (<FSET? ,LAMP ,ONBIT>
		       <TELL "La lampe est allumée.">)
		      (T
		       <TELL "La lampe est allumée. éteint.">)>
		<CRLF>)>>

<ROUTINE I-LANTERN ("AUX" TICK (TBL <VALUE LAMP-TABLE>))
	 <ENABLE <QUEUE I-LANTERN <SET TICK <GET .TBL 0>>>>
	 <LIGHT-INT ,LAMP .TBL .TICK>
	 <COND (<NOT <0? .TICK>>
		<SETG LAMP-TABLE <REST .TBL 4>>)>>

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

;<ROUTINE LIGHT-INT (OBJ INTNAM TBLNAM "AUX" (TBL <VALUE .TBLNAM>) TICK)
	 #DECL ((OBJ) OBJECT (TBLNAM INTNAM) ATOM (TBL) <PRIMTYPE VECTOR>
		(TICK) FIX)
	 <ENABLE <QUEUE .INTNAM <SET TICK <GET .TBL 0>>>>
	 <COND (<0? .TICK>
		<FSET .OBJ ,RMUNGBIT>
		<FCLEAR .OBJ ,ONBIT>)>
	 <COND (<OR <HELD? .OBJ> <IN? .OBJ ,HERE>>
		<COND (<0? .TICK>
		       <TELL
"J'espère que vous avez plus de lumière que celle du " D .OBJ "." CR>)
		      (T
		       <TELL <GET .TBL 1> CR>)>)>
	 <COND (<NOT <0? .TICK>>
		<SETG .TBLNAM <REST .TBL 4>>)>
	 <RTRUE>>

;"Riddles"

<ROUTINE RIDDLE-ROOM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"C'est une pièce qui est nue de tous les côtés. Il y a une sortie en bas dans l'angle nord-ouest de la pièce.">
		<COND (<FSET? ,RIDDLE-DOOR ,OPENBIT>
		       <TELL "ouvert">)
		      (T
		       <TELL "fermé">)>
		<TELL "porte en pierre. Au-dessus de la pierre, les mots suivants sont écrits : « Personne ne passera cette porte sans résoudre cette énigme :| | Qu'est-ce qui est grand comme une maison,| rond comme une tasse,| et tous les chevaux du roi| ne peut pas le dessiner ? »|">)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<VERB? ANSWER SAY>
		       <COND (<FSET? ,RIDDLE-DOOR ,OPENBIT>
			      <RFALSE>)
			     (<OR <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?WELL>
				  <EQUAL? <GET ,P-LEXV <+ ,P-CONT 2>> ,W?WELL>>
			      <TELL
"Il y a un coup de tonnerre assourdissant et la porte en pierre s'ouvre tranquillement pour révéler un passage au-delà." CR>
			      <SCORE-UPD 5>
			      <FSET ,RIDDLE-DOOR ,OPENBIT>)
			     (T
			      <TELL
"Un rire creux semble sortir de la porte en pierre." CR>)>
		      <SETG P-CONT <>>
		      <SETG QUOTE-FLAG <>>
		      <RTRUE>)>)>>

<ROUTINE RIDDLE-DOOR-FCN ()
	 <COND (<VERB? OPEN>
		<COND (<FSET? ,RIDDLE-DOOR ,OPENBIT>
		       <TELL "Elle est ouverte !" CR>)
		      (T
		       <TELL
"La porte peut ne peut être ouvert qu'en répondant à l'énigme." CR>)>)
	       (<VERB? CLOSE>
		<COND (<FSET? ,RIDDLE-DOOR ,OPENBIT>
		       <TELL "Pas une chance. La porte pèse plusieurs tonnes." CR>)
		      (T
		       <TELL "Elle est fermée !" CR>)>)>>

<GLOBAL DUMMY
	<LTABLE "Regardez autour."
	       "Vous pensez que non ?"
	       "Je pense que vous l'avez déjà fait cela.">>

<ROUTINE RIDDLE-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL "Utilisez la commande « Regarder »." CR>)>>

<ROUTINE MAGIC-ACTOR ("AUX" V)
	 <COND (,SPELL?
		<COND (<EQUAL? ,SPELL? ,S-FALL>
		       <COND (<OR <VERB? CLIMB-UP CLIMB-DOWN CROSS>
				  <AND <VERB? WALK>
				       <GETPT ,HERE ,P?DOWN>>>
			      <SET V <GETPT ,HERE ,P?GLOBAL>>
			      <COND (<ZMEMQB ,BRIDGE .V <PTSIZE .V>>
				     <JIGS-UP
"Vous vous trouvez attiré vers le bord du pont. Vous regardez sur le côté. Oups, c'était maladroit de vous! Vous avez trébuché sur quelque chose et vous êtes tombé dedans.">)
				    (<PROB 25>
				     <JIGS-UP
"Pour une raison étrange, vous avez trébuché sur vos propres pieds, ou peut-être un cordon invisible étiré sur le chemin. La chute résultante semble vous avoir fait entrer.">)
				   (T
				    <TELL
"Vous avez juste trébuché sur un cordon invisible, ou peut-être vos propres pieds. Mais ce doit être votre jour de chance, car vous avez réussi à retrouver votre équilibre avant ce qui aurait pu être une chute fatale." CR>)>)
			     (<VERB? BOARD>
			      <TELL
"Vous entrez dans le " D ,PRSO "mais tu tombes encore, presque comme si une main invisible l'avait renversé." CR>)>)
		      (<EQUAL? ,SPELL? ,S-FLOAT>
		       <COND (<VERB? DIAGNOSE WAIT> <RFALSE>)
			     (<VERB? WALK>
<TELL "Je suppose que vous prévoyez de le faire en battant des bras ?" CR>)
			     (<VERB? DROP>
			      <MOVE ,PRSO ,HERE>
			      <TELL
"Le " D ,PRSO " tombe au sol." CR>)
			     (<AND <VERB? TAKE> <IN? ,PRSO ,HERE>>
			      <TELL
"Vous je ne peux pas atteindre ça ! Il est au sol." CR>)>)
		      (<EQUAL? ,SPELL? ,S-FREEZE>
		       <COND (<VERB? DIAGNOSE WAIT> <RFALSE>)
			     (T
			      <TELL
"Vous êtes gelé solide, autant attendre, parce que vous ne pouvez rien faire d'autre dans cet état." CR>)>)
		      (<AND <EQUAL? ,SPELL? ,S-FENCE>
			    <VERB? WALK>>
		       <TELL
"Une barrière invisible de force magique vous barre le chemin." CR>
		       <RTRUE>)
		      (<AND <EQUAL? ,SPELL? ,S-FIERCE>
			    <SET V <INFESTED? ,HERE>>>
		       <COND (<VERB? ATTACK MUNG> <RFALSE>)
			     (T
			      <FORCE-FIGHT .V>
			      <RTRUE>)>)
		      (<AND <EQUAL? ,SPELL? ,S-FERMENT>
			    <VERB? WALK>
			    <IN? ,WINNER ,HERE>>
		       <TELL
"Oups, tu sembles un peu instable... je ne suis pas sûr que tu aies trouvé où tu voulais aller." CR CR>
		       <RANDOM-WALK>)
		      (<AND <EQUAL? ,SPELL? ,S-FEAR>
			    <SET V <INFESTED? ,HERE>>>
		       <TELL
"Tout à coup, vous êtes envahi par la peur ! Il y a un " D .V "C'est peut-être après toi !">
		       <COND (<FSET? <LOC ,WINNER> ,VEHBIT>
			      <TELL
"Vous vous blottissez dans un coin, terrifié." CR>)
			     (T
			      <TELL
"Vous fuyez la pièce en courant en hurlant de terreur !" CR CR>
			      <RANDOM-WALK>)>)>)>>

<ROUTINE RANDOM-WALK ("AUX" P TX L S (D <>))
	 <SET P 0>
	 <REPEAT ()
		 <COND (<L? <SET P <NEXTP ,HERE .P>> ,LOW-DIRECTION>
			<COND (.D
			       <SET S ,SPELL?>
			       <SETG SPELL? <>>
			       <SETG WINNER ,ADVENTURER>
			       <MOVE ,WINNER ,HERE>
			       <DO-WALK .D>
			       <SETG SPELL? .S>)>
			<RETURN>)
		       (T
			<SET TX <GETPT ,HERE .P>>
			<SET L <PTSIZE .TX>>
			<COND (<OR <EQUAL? .L ,UEXIT>
				   <AND <EQUAL? .L ,CEXIT>
					<VALUE <GETB .TX ,CEXITFLAG>>>
				   <AND <EQUAL? .L ,DEXIT>
					<FSET? <GETB .TX ,DEXITOBJ> ,OPENBIT>>>
			       <COND (<NOT .D> <SET D .P>)
				     (<PROB 50> <SET D .P>)>)>)>>>

<ROUTINE FORCE-FIGHT (V "AUX" W)
	 <COND (<NOT <SET W <FIND-IN ,ADVENTURER ,WEAPONBIT>>>
		<SET W ,HANDS>)>
	 <TELL
"Vous êtes rendu fou par une férocité écrasante et attaquez le "
D .V " à la place." CR>
	 <PERFORM ,V?ATTACK .V .W>>

\

"SUBTITLE DIAMOND MAZE"

<GLOBAL DIAMOND-SOLVE <>> ;"T if solved"

<GLOBAL DIAMOND-COUNT 0>  ;"count of current progress"
<GLOBAL DIAMOND-MOVES 0>  ;"count of moves since progressed"
<GLOBAL DIAMOND-BASE 0>	  ;"count of maximum progress ever"

<GLOBAL DWDESCS
	<TABLE "sombre"
	       "scintille faiblement"
	       "faiblement brillant"
	       "brillant"
	       "brillant de mille feux">>

<ROUTINE DWINDOW-DESC ()
	 <TELL
"Au sol se trouve une très petite fenêtre en forme de losange qui est ">
	 <COND (,DIAMOND-SOLVE <TELL "brillant sereinement">)
	       (T <TELL <GET ,DWDESCS ,DIAMOND-COUNT>>)>
	 <TELL "." CR>>

<ROUTINE DWINDOW-FCN ()
	 <COND (<VERB? TAKE>
		<TELL
"La fenêtre fait partie intégrante du sol." CR>)
	       (<VERB? MUNG>
		<TELL
"La fenêtre est dure comme du diamant et ne peut pas être cassé." CR>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<DWINDOW-DESC>)>>

<ROUTINE DIAMOND-MOTION (RARG "AUX" DC DIR RM)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"C'est une pièce avec des murs et des passages étrangement inclinés dans toutes les directions. Les murs sont faits d'une substance vitreuse." CR>
		<COND (<EQUAL? ,HERE ,DIAMOND-5>
		       <TELL
"Un escalier en marbre mène vers le haut.">
		       <COND (,DIAMOND-SOLVE
			      <TELL
"Le sol s'est effondré au bout de l'escalier pour révéler un passage secret qui descend dans l'obscurité.">)>
		       <CRLF>)
		      (T <DWINDOW-DESC>)>
		<RTRUE>)
	       (<EQUAL? .RARG ,M-FLASH> <DWINDOW-DESC> <RTRUE>)
	       (<AND <EQUAL? .RARG ,M-BEG>
		     <VERB? WALK>
		     <NOT ,DIAMOND-SOLVE>>
		<COND (<OR <EQUAL? ,HERE ,DIAMOND-2 ,DIAMOND-4>
			   <EQUAL? ,HERE ,DIAMOND-6 ,DIAMOND-8>>
		       <SET DIR <GET ,DIDIRS <- ,DIAMOND-COUNT 1>>>
		       <COND (<EQUAL? ,PRSO .DIR>
			      <SETG DIAMOND-COUNT <+ ,DIAMOND-COUNT 1>>
			      <COND (<G? ,DIAMOND-COUNT ,DIAMOND-BASE>
				     <SETG DIAMOND-BASE ,DIAMOND-COUNT>
				     <SETG DIAMOND-MOVES 0>)>
			      <COND (<EQUAL? ,DIAMOND-COUNT 5>
				     <TELL
"Vous entendez un étrange cri rouillé résonnant au loin." CR>
				     <FCLEAR ,DIAMOND-5 ,TOUCHBIT>
				     <SCORE-UPD 5>
				     <SETG DIAMOND-SOLVE T>)>
			      <COND (<EQUAL? ,HERE ,DIAMOND-2>
				     <SET DIR ,DIAMOND-4>)
				    (<EQUAL? ,HERE ,DIAMOND-4>
				     <SET DIR ,DIAMOND-8>)
				    (<EQUAL? ,HERE ,DIAMOND-8>
				     <SET DIR ,DIAMOND-6>)
				    (<EQUAL? ,HERE ,DIAMOND-6>
				     <SET DIR ,DIAMOND-2>)>
			      <GOTO .DIR>)
			     (T
			      <DIAMOND-LOSS>)>
		       <RTRUE>)
		      (<AND <EQUAL? ,HERE ,DIAMOND-5>
			    <EQUAL? ,PRSO ,P?UP>>
		       <RFALSE>)
		      (T
		       <SETG DIAMOND-COUNT 0>
		       <COND (<PROB 33>
			      <TELL
"Il n'y a aucun moyen d'y entrer. direction." CR>
			      <RTRUE>)
			     (<PROB 25>
			      <DIAMOND-LOSS>
			      <RTRUE>)
			     (T
			      <SETG DIAMOND-COUNT 1>
			      <COND (<G? ,DIAMOND-COUNT ,DIAMOND-BASE>
				     <SETG DIAMOND-BASE ,DIAMOND-COUNT>
				     <SETG DIAMOND-MOVES 0>)>
			      <SET RM <GET ,DIAMOND-ROOMS
					   <- <RANDOM 4> 1>>>
			      <COND (<FSET? ,BAT ,INVISIBLE>
				     <FCLEAR ,BAT ,INVISIBLE>
				     <MOVE ,BAT .RM>)>
			      <GOTO .RM>
			      <RTRUE>)>)>)>>

<ROUTINE DIAMOND-LOSS ()
	 <SETG DIAMOND-MOVES <+ ,DIAMOND-MOVES 1>>
	 <COND (<EQUAL? ,DIAMOND-MOVES 20>
		<TELL
"Tandis que vous vous battez dans le labyrinthe, la voix miraculeuse du Magicien vous met à l'aise : « Fou ! Vous ne passerez jamais">
		<TELL <GET ,BASES ,DIAMOND-BASE>>
		<TELL " à ce moment-là. taux!\"" CR>)>
	 <GOTO <GET ,DIAMOND-ROOMS <+ 3 <RANDOM 5>>>>>

<GLOBAL BASES <TABLE "premier" "premier" "premier" "seconde" "troisième" "domicile">>

<GLOBAL DIAMOND-ROOMS
	<TABLE DIAMOND-2 DIAMOND-4 DIAMOND-6 DIAMOND-8
	       DIAMOND-1 DIAMOND-3 DIAMOND-5 DIAMOND-7 DIAMOND-9>>

<GLOBAL DIDIRS <TABLE P?SE P?NE P?NW P?SW>>

\

"SOUS-TITRE CERBERUS"

<GLOBAL CERBERUS-LEASHED <>>

<ROUTINE CERBERUS-FCN ()
	 <COND (<AND <VERB? WAVE RUB RAISE> <EQUAL? ,PRSO ,WAND>>
		<TELL "Le chien a l'air perplexe." CR>
		<RFALSE>)
	       (<AND ,WAND-ON <VERB? SAY INCANT>> <RFALSE>)
	       (<HELLO? ,CERBERUS>
		<COND (,CERBERUS-LEASHED <TELL "\"Arf ! Arf ! Arf!\"" CR>)
		      (T <TELL "\"Grrrr!\"" CR>)>)
	       (<VERB? ATTACK MUNG STAB>
		<COND (,CERBERUS-LEASHED
		       <REMOVE ,CERBERUS>
		       <TELL
"Avec une écorce tranquille de déception, la créature expire. Ses six yeux vous regardent avec reproche. Comme elle meurt, elle s'effondre dans un petit tas de poussière qui souffle dans rien." CR>)
		      (<PROB 50>
		       <JIGS-UP
"Votre tête, semble-t-il, n'est qu'une petite bouche pour le pauvre animal, qui a tout aussi faim par la suite.">)
		      (T
		       <TELL
"Le truc de chien enragé se jette violemment sur vous." CR>)>)
	       (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSO ,COLLAR>>
		<MOVE ,COLLAR ,CERBERUS>
		<FSET ,COLLAR ,NDESCBIT>
		<FSET ,COLLAR ,TRYTAKEBIT>
		<PUTP ,CERBERUS ,P?LDESC
"Un chien à trois têtes qui sourit insipidement se branle la queue ici. Il porte un énorme collier de chien.">
		<SETG CERBERUS-LEASHED T>
		<TELL
"La créature gémit heureux, puis la tête centrale lèche votre visage (qui est à peu près comme l'expérience d'un lavoir de papier de sable). Les deux autres têtes regardent, comme si le monstre ressentit un besoin soudain de trouver une paire de pantoufles quelque part. Sa queue énorme se remue avec enthousiasme, frappant de petits rochers autour et presque vous soufflant de la brise qu'il crée." CR>)
	       (<VERB? ENCHANT>
		<COND (<EQUAL? ,SPELL-USED ,W?FLOAT>
		       <SETG SPELL-HANDLED? T>
		       <TELL
"L'énorme chien s'élève à environ un pouce du sol, pendant un instant." CR>)
		      (<EQUAL? ,SPELL-USED ,W?FIERCE>
		       <SETG SPELL-HANDLED? T>
		       <JIGS-UP
"Cerbère vous déchire membre par membre ! Quelle férocité !">)
		      (<EQUAL? ,SPELL-USED ,W?FEEBLE>
		       <TELL
"Il a maintenant la force d'un seul éléphant, plutôt que de dix !" CR>)>)
	       (<NOT ,CERBERUS-LEASHED>
		<TELL "Le chien à trois têtes se moque vicieusement de vous !" CR>)
	       (<AND ,CERBERUS-LEASHED <VERB? RUB>>
		<TELL
"Le chien est maintenant follement heureux, slobbing partout dans l'endroit et pleurnicher avec une joie doggish non contenue." CR>)>>

<ROUTINE COLLAR-FCN ()
	 <COND (<AND <VERB? TAKE> ,CERBERUS-LEASHED>
		<JIGS-UP
"Ce n'était pas une bonne idée. La créature aimait être votre animal de compagnie. Quand vous décrochez le collier, le chien monstre déçu commence à gronder, et puis ses trois bouches à camouflage vous plongent dans des petits biscuits en levrette.">)
	       (<AND <VERB? ENCHANT> <EQUAL? ,SPELL-USED ,W?FLOAT>>
		<PERFORM ,V?ENCHANT ,CERBERUS>
		<RTRUE>)>>

\

"SOUS-TITRE DRAGON ET GLACIER"

<GLOBAL ICE-MELTED <>>

<ROUTINE GLACIER-FCN ()
	 <COND (<VERB? MELT>
		<TELL
"C'est un grand glacier ; vous aurez besoin de beaucoup de chaleur." CR>)>>

<ROUTINE GLACIER-ROOM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"C'est un grand hall de lave ancienne, depuis porté lisse par le mouvement d'un glacier. Un grand passage sort à l'est et un tube de lave vers le haut est au sommet d'un jumble de roches tombées." CR>
		<COND (,ICE-MELTED
		       <TELL
"Un passage humide et brûlé mène à l'ouest. Il est encore en partie plein de vapeur." CR>)>
		<RTRUE>)>>

<ROUTINE DRAGON-FCN ()
	 <ENABLE <QUEUE I-DRAGON -1>>
	 <COND (<HELLO? ,DRAGON>
		<TELL
"Le dragon semble amusé. Il parle d'une voix si profonde que vous le sentez plutôt que de l'entendre, mais la langue vous est inconnue. Vous vous trouvez presque hypnotisée." CR>
		<SETG DRAGON-ANGER <+ ,DRAGON-ANGER 2>>)
	       (<VERB? EXAMINE>
		<TELL
"Il se retourne et te regarde, les yeux de son chat sont jaunes dans l'obscurité." CR>
		<SETG DRAGON-ANGER <+ ,DRAGON-ANGER 1>>)
	       (<VERB? ATTACK MUNG KICK LAMP-ON>
		<COND (<OR <VERB? LAMP-ON>
			   <AND <VERB? ATTACK> <NOT ,PRSI>>>
		       <TELL
"À mains nues ? Je doute que le dragon l'ait même remarqué." CR>)
		      (T
		<TELL <RANDOM-ELEMENT ,DRAGON-ATTACKS> CR>)>
		<SETG DRAGON-ANGER <+ ,DRAGON-ANGER 4>>)
	       (<AND <VERB? GIVE> <EQUAL? ,PRSI ,DRAGON>>
		<SETG DRAGON-ANGER <+ ,DRAGON-ANGER 1>>
		<COND (<GETPT ,PRSO ,P?VALUE>
		       <MOVE ,PRSO ,CHEST>
		       <TELL
"Le dragon est satisfait de votre don, s'excuse un instant, et revient sans lui." CR>)
		      (<BOMB? ,PRSO>
		       <SETG DRAGON-ANGER <+ ,DRAGON-ANGER 2>>
		       <REMOVE ,BRICK>
		       <TELL
"Le dragon serpente sa longue langue rouge autour de la bombe et l'avale poliment. Quelques instants plus tard, il souffle et fume des boucles de ses narines." CR>)
		      (T
		       <TELL "Le dragon refuse votre cadeau." CR>)>)
	       (<AND <VERB? WALK>
		     <EQUAL? ,HERE ,DRAGON-ROOM>
		     <EQUAL? ,PRSO ,P?NORTH>>
		<SETG DRAGON-ANGER <+ ,DRAGON-ANGER 3>>
		<TELL
"Le dragon met une griffe, des grimaces (toutes ses dents sabres qui brillent dans la lumière), et bloque votre chemin." CR>)>>

<GLOBAL DRAGON-ANGER 0>

<GLOBAL DRAGON-ATTACKS
        <LTABLE
"La peau de Dragon est dure comme de l'acier, mais vous avez réussi à l'ennuyer un peu."
"Cela a suscité son intérêt. Il vous regarde d'un air sinistre."
"Le dragon est surpris et intéressé (pour le moment)."
"Vous l'avez plutôt mis en colère. Vous feriez mieux d'être très prudent maintenant."
"Ça n'a pas endommagé, mais il tourne ses yeux jaunes fumés dans votre direction et soupirs.">>

<ROUTINE HELLO? (WHO)
	 <COND (<OR <EQUAL? ,WINNER .WHO>
		    <VERB? TELL ANSWER REPLY SAY HELLO INCANT>>
		<COND (<VERB? TELL ANSWER SAY INCANT REPLY>
		       <SETG P-CONT <>>
		       <SETG QUOTE-FLAG <>>)>
		<RTRUE>)>>

<ROUTINE FIND-TARGET (TARGET "AUX" P TX L ROOM)
	 <COND (<IN? .TARGET ,HERE> ,HERE)
	       (T
		<SET P 0>
		<REPEAT ()
			<COND (<0? <SET P <NEXTP ,HERE .P>>>
			       <RETURN <>>)
			      (<NOT <L? .P ,LOW-DIRECTION>>
			       <SET TX <GETPT ,HERE .P>>
			       <SET L <PTSIZE .TX>>
			       <COND (<EQUAL? .L ,UEXIT ,CEXIT ,DEXIT>
				      <SET ROOM <GETB .TX 0>>
				      <COND (<IN? .TARGET .ROOM>
					     <RETURN .ROOM>)>)>)>>)>>

<GLOBAL OLD-HERE DRAGON-ROOM>

<ROUTINE I-DRAGON ("AUX" ROOM)
	 <COND (<G? ,DRAGON-ANGER 6>
		<TELL
"Les pneus de dragon de ce jeu. Avec un bâillement presque ennuyeux, il ouvre sa bouche et">
		<COND (<EQUAL? ,SPELL? ,S-FIREPROOF>
		       <TELL
"Ça vous explose d'une grande goutte de feu, mais ça vous lave inoffensifment." CR>)
		      (T
		       <DRAGON-LEAVES>
		       <JIGS-UP
"vous incinère dans une explosion de feu de dragon chauffé à blanc.">)>)
	       (<AND <IN? ,WINNER ,DRAGON-ROOM>
		     <NOT <IN? ,DRAGON ,DRAGON-ROOM>>>
		<MOVE ,DRAGON ,DRAGON-ROOM>
		<TELL
"Le dragon double et charge dans la pièce, en colère par votre tentative de se faufiler devant lui. Ses yeux brillent d'une chaleur blanche de colère." CR>
		<COND (<EQUAL? ,SPELL? ,S-FIREPROOF>
		       <JIGS-UP
"Une énorme boule de flamme vous enveloppe, mais vous ne sentez même pas la chaleur. Le dragon est perplexe, mais pas trop perplexe pour vous écraser dans ses mâchoires.">)
		      (T
		       <JIGS-UP
"Pire pour vous, sa bouche s'ouvre et une grande goutte de flamme souffle et vous consume sur place.">)>)
	       (<NOT <G? ,DRAGON-ANGER 0>>
		<COND (<AND <PROB 50>
			    <IN? ,DRAGON ,HERE>>
		       <TELL "Le dragon a l'air de s'ennuyer." CR>)
		      (T
		       <DRAGON-LEAVES>
		       <COND (<EQUAL? ,HERE ,GLACIER-ROOM>
			      <TELL
"Le dragon n'est plus là. Il a dû s'ennuyer de vous." CR>)
			     (<EQUAL? ,HERE ,OLD-HERE>
			      <TELL
"Le dragon semble s'être désintéressé de vous.">
			      <COND (<EQUAL? ,OLD-HERE ,DRAGON-ROOM> <CRLF>)
				    (T <TELL " Il s'éloigne." CR>)>)>)>)
	       (T
		<SET ROOM <FIND-TARGET ,WINNER>>
		<COND (<NOT .ROOM>
		       <COND (<PROB 25> <DRAGON-LEAVES>)>)
		      (<OR <EQUAL? .ROOM ,CAROUSEL-ROOM ,TINY-ROOM>
			   <EQUAL? .ROOM ,RAVINE-LEDGE ,FRESCO-ROOM>>
		       <COND (<PROB 25> <DRAGON-LEAVES>)>
		       <TELL "Le dragon ne vous suivra pas. plus loin." CR>)
		      (<EQUAL? .ROOM ,GLACIER-ROOM>
		       <TELL CR
"Alors que le dragon entre, il voit sa réflexion sur la surface glaciale du glacier à son extrémité ouest. Il devient enragé: Il y a un autre dragon ici, derrière ce verre, il pense! Les dragons sont intelligents, mais parfois naïfs, et celui-ci n'a jamais vu de glace auparavant. Il s'élève jusqu'à sa pleine hauteur pour défier cet intrus dans son territoire. Il rugit un défi! L'intrus répond! Le dragon respire profondément, et sort de sa bouche verse une énorme goutte de flamme. Il se lave sur la glace, qui fond rapidement, envoyant des torrents d'eau et un énorme nuage de vapeur! Vous arrivez à palpiter jusqu'à une petite étagère, mais le dragon est terrifié! Une énorme éclaboussée descend dans sa gorge! Il y a une explosion étouffée et le dragon, une expression perplexe sur son visage, meurt. Il est emporté par l'eau.| | Quand l'inondation recule gentiment vers le bas." CR>
		       <REMOVE ,DRAGON>
		       <REMOVE ,ICE>
		       <MOVE ,DEAD-DRAGON ,DEEP-FORD>
		       <DISABLE <INT I-DRAGON>>
		       <SCORE-UPD 5>
		       <SETG ICE-MELTED T>)
		      (T
		       <COND (<NOT <EQUAL? .ROOM ,OLD-HERE>>
			      <MOVE ,DRAGON .ROOM>
			      <TELL
"Le dragon vous suit, par curiosité et colère mêlées." CR>)
			     (T
			      <TELL
"Le dragon continue de vous observer attentivement." CR>)>
		       <COND (<NOT <G? ,DRAGON-ANGER 0>>
			      <SETG DRAGON-ANGER 0>
			      <DISABLE <INT I-DRAGON>>)>)>)>
	 <SETG OLD-HERE <LOC ,DRAGON>>
	 <SETG DRAGON-ANGER <- ,DRAGON-ANGER 2>>
	 <COND (<L? ,DRAGON-ANGER 0> <SETG DRAGON-ANGER 0>)>
	 T>

<ROUTINE DRAGON-LEAVES ()
	 <COND (<NOT <LOC ,DEAD-DRAGON>>
		<MOVE ,DRAGON ,DRAGON-ROOM>
		<SETG DRAGON-ANGER 0>
		<DISABLE <INT I-DRAGON>>)>>

<ROUTINE I-GARDEN ()
	 <COND (<OR <EQUAL? ,HERE ,GARDEN-NORTH ,GAZEBO-ROOM>
		    <EQUAL? ,HERE ,TOPIARY-ROOM ,FORMAL-GARDEN>>
		<COND (<AND <IN? ,UNICORN ,GARDEN-NORTH>
			    <PROB 33>>
		       <REMOVE ,UNICORN>
		       <COND (<NOT <EQUAL? ,HERE ,TOPIARY-ROOM>>
			      <TELL "La licorne bondit légèrement loin." CR>)>)
		      (<AND <IN? ,PRINCESS ,DRAGON-LAIR>
			    <NOT <IN? ,UNICORN ,GARDEN-NORTH>>
			    <PROB 25>
			    <NOT <EQUAL? ,HERE ,TOPIARY-ROOM>>>
		       <COND (,UNICORN-FRIGHTENED
			      <SETG UNICORN-FRIGHTENED <>>
			      <RFALSE>)>
		       <MOVE ,UNICORN ,GARDEN-NORTH>
		       <COND (<EQUAL? ,HERE ,GARDEN-NORTH>
			      <TELL <RANDOM-ELEMENT ,UNICORN-MSGS> CR>)
			     (T <TELL
"Une licorne cultive paisiblement de l'herbe à l'extrémité nord du jardin. Il y a quelque chose autour de son cou." CR>)>)
		      (<EQUAL? ,HERE ,TOPIARY-ROOM>
		       <COND (<AND <NOT ,TOPIARY-MOVED> <PROB 12>>
			      <SETG TOPIARY-MOVED T>
			      <TELL
"Vous regardez autour, et étrangement, les animaux topiaires semblent avoir légèrement changé de position." CR>)
			     (<AND ,TOPIARY-MOVED
				   <NOT ,TOPIARY-NEAR>
				   <PROB 8>>
			      <SETG TOPIARY-NEAR T>
			      <TELL
"Les animaux topiaires semblent se refermer sur vous. Vous vous retournez et ils sont très proches." CR>)
			     (<AND ,TOPIARY-NEAR <PROB 4>>
			      <SETG TOPIARY-MOVED <>>
			      <SETG TOPIARY-NEAR <>>
			      <JIGS-UP
"Vous êtes écrasés par leurs branches et griffés par leurs épines.">)>)>)
	       (T
		<REMOVE ,UNICORN>
		<DISABLE <INT I-GARDEN>>
		<RFALSE>)>>

<GLOBAL TOPIARY-MOVED <>>
<GLOBAL TOPIARY-NEAR <>>

<GLOBAL UNICORN-MSGS
	<LTABLE
	 "Il y a un grand animal blanc en partie caché derrière des arbres."
	 "Vous apercevez quelque chose de blanc entre deux haies."
	 "Une licorne cultive de l'herbe de l'autre côté de la pièce. Une clé en or est accrochée à un ruban autour de son cou."
	 "Il y a une belle licorne mangeant des roses ici. Autour de son cou est un ruban de satin rouge sur lequel est attaché une petite clé.">>

<ROUTINE GARDEN-ROOM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<ENABLE <QUEUE I-GARDEN -1>>)>>

<ROUTINE GLOBAL-UNICORN-FCN ()
	 <COND (<IN? ,UNICORN ,GARDEN-NORTH>
		<TELL
"La licorne est tout en haut, à l'extrémité nord du jardin." CR>)
	       (<VERB? FIND FOLLOW>
		<COND (<FSET? ,UNICORN ,TOUCHBIT>
		       <TELL "Je ne sais pas où elle est maintenant." CR>)
		      (T <TELL
"La licorne est une bête mythique." CR>)>)
	       (T
		<TELL
"Licorne ? Quelle licorne ?" CR>)>>

<ROUTINE UNICORN-FCN ()
	 <COND (<HELLO? ,UNICORN>
		<TELL
"La licorne écoute distraitement, puis retourne couper l'herbe." CR>)
	       (<VERB? FOLLOW>
		<TELL
"La licorne s'éloigne lorsque vous approchez." CR>)
	       (<AND <VERB? EXAMINE> <EQUAL? ,PRSO ,UNICORN>>
		<TELL
"La licorne s'éloigne lorsque vous approchez pour un regard plus proche, mais vous remarquez une minuscule clé d'or accrochée à un ruban de satin rouge enroulé autour du cou de l'animal." CR>)
	       (<VERB? EXAMINE>
		<TELL "La licorne s'éloigne lorsque vous approchez." CR>)
	       (<VERB? TAKE PUT RUB MUNG ATTACK>
		<REMOVE ,UNICORN>
		<SETG UNICORN-FRIGHTENED T>
		<TELL
"La licorne, surprise par cette preuve que vous êtes en effet la sorte de vagabond incoudée qu'elle soupçonnait, fond dans les haies et est partie." CR>)>>

<GLOBAL UNICORN-FRIGHTENED <>>

<ROUTINE GAZEBO-FCN ()
	 <COND (<AND <EQUAL? ,HERE ,GARDEN-NORTH> <VERB? THROUGH>>
		<DO-WALK ,P?IN> <RTRUE>)
	       (<AND <EQUAL? ,HERE ,GAZEBO-ROOM>
		     <VERB? THROUGH>>
		<TELL "Vous y êtes déjà." CR>)
	       (<AND <EQUAL? ,HERE ,GAZEBO-ROOM> <VERB? LEAVE EXIT>>
		<DO-WALK ,P?OUT> <RTRUE>)>>

<ROUTINE CHEST-FCN ()
	 <COND (<VERB? OPEN>
		<COND (<PROB 25>
		       <V-OPEN>
		       <COND (<AND <IN? ,PRINCESS ,HERE>
				   <NOT ,PRINCESS-AWAKE>>
			      <TELL
"L'ouverture du couvercle qui grince fait sursauter la jeune femme." CR>)>)
		      (T
		       <TELL
"Les charnières sont très rouillées, mais elles semblent commencer à donner. Vous pouvez probablement l'ouvrir si vous essayez à nouveau. Il y a quelque chose qui gronde à l'intérieur.">
		       <COND (<AND <IN? ,PRINCESS ,HERE>
				   <NOT ,PRINCESS-AWAKE>>
			      <TELL
"Toute cette rumeur a surpris la jeune femme.">)>
		       <CRLF>)>
		<PUTP ,CHEST ,P?ACTION 0>
		<COND (<AND <IN? ,PRINCESS ,HERE>
			    <NOT ,PRINCESS-AWAKE>>
		       <PERFORM ,V?ALARM ,PRINCESS>)>
		T)>>

<GLOBAL PRINCESS-AWAKE <>>

<ROUTINE PRINCESS-FCN ("AUX" (DEM <INT I-PRINCESS>))
	 <COND (<VERB? FOLLOW>
		<COND (<IN? ,PRINCESS ,HERE>
		       <TELL
"Vous ne pouvez pas la suivre jusqu'à ce qu'elle parte..." CR>)
		      (,PRFOLLOW
		       <DO-WALK ,PRFOLLOW>)
		      (T
		       <TELL "Il me semble avoir perdu sa trace." CR>)>
		<RTRUE>)
	       (<NOT <IN? ,PRINCESS ,HERE>>
		<TELL "Il n'y a pas de princesse ici." CR>)
	       (<VERB? ATTACK MUNG RAPE>
		<REMOVE ,PRINCESS>
		<TELL
"La princesse crie à l'approche. \"N'est-ce pas quelqu'un qui me délivrera de ce terrible destin ?\" elle pleure.">
		<COND (<IN? ,WIZARD ,HERE>
		       <TELL
"Choqué, le Magicien de Frobozz se tourne vers vous.">)
		      (ELSE
		       <TELL "Juste à temps, le Magicien de Frobozz apparaît, semblant se détacher de rien comme une ombre de fenêtre.">)>
		<TELL
"\"Fais-le!\" il s'insinue, et un énorme éclair te réduit à un tas de cendres fumantes.">
		<JIGS-UP>)
	       (<OR <HELLO? ,PRINCESS> <VERB? ALARM KISS EXAMINE RUB>>
		<COND (<AND <IN? ,PRINCESS ,DRAGON-LAIR>
			    <EQUAL? <GET .DEM ,C-ENABLED?> 0>>
		       <PUTP ,PRINCESS ,P?LDESC
"Il y a ici une princesse échevelée et légèrement négligée.">
		       <ENABLE <QUEUE I-PRINCESS 2>>
		       <SETG PRINCESS-AWAKE T>
		       <TELL
"La princesse (car elle est évidemment une) se réveille, puis vous remarque pour la première fois. Elle sourit. « Merci de m'avoir sauvé de ce ver horrible », dit-elle. « Je dois partir. Mes parents seront inquiets pour moi. » Avec cela, elle se lève, regardant délibérément hors de la tanière." CR>)
		      (T
		       <TELL
"La princesse t'ignore, elle regarde la pièce, mais ses yeux s'arrangent sur la">
		       <COND (<EQUAL? ,HERE ,GAZEBO-ROOM>
			      <TELL "jardin extérieur">)
			     (<EQUAL? ,HERE ,GARDEN-NORTH>
			      <TELL "belvédère">)
			     (<EQUAL? ,HERE ,RAVINE-LEDGE>
			      <TELL "rebord">)
			     (T
			      <TELL <GET ,PRDIRS <* ,PRCOUNT 4>>>)>
		       <TELL "." CR>)>)
	       (<NOT ,PRINCESS-AWAKE>
		<TELL "Elle est dans un transe !" CR>)>>

<GLOBAL PRCOUNT 0>

<GLOBAL PRFOLLOW <>>

<GLOBAL PRDIRS
	<TABLE "sud" DRAGON-ROOM "nord" P?SOUTH
	       "est" LEDGE-TUNNEL "ouest" P?EAST
	       "est" RAVINE-LEDGE "ouest" P?EAST
	       "vers le bas" DEEP-FORD "vers le haut" P?DOWN
	       "sud" MARBLE-HALL "nord" P?SOUTH
	       "est" STREAM-PATH "ouest" P?EAST
	       "est" FORMAL-GARDEN "ouest" P?EAST
	       "nord" GARDEN-NORTH "sud" P?NORTH
	       "dans" GAZEBO-ROOM "sortie" P?IN>>

<ROUTINE I-PRINCESS ("AUX" (DEM <INT I-PRINCESS>) (OLDP <LOC ,PRINCESS>)
		     (PC <* ,PRCOUNT 4>))
	 <MOVE ,PRINCESS <GET ,PRDIRS <+ .PC 1>>>
	 <SETG PRFOLLOW <>>
	 <COND (<AND <IN? ,PRINCESS ,STREAM-PATH>
		     <IN? ,WINNER ,MARBLE-HALL>>
		<TELL
"La princesse presse un morceau de marbre dans le mur et une grande partie du mur glisse, révélant un passage à l'est. Elle entre." CR>
		<COND (<IN? ,WINNER .OLDP>
		       <SETG PRFOLLOW <GET ,PRDIRS <+ .PC 3>>>)>
		<SETG SECRET-DOOR T>)
	       (<AND <IN? ,PRINCESS ,STREAM-PATH>
		     <IN? ,WINNER ,STREAM-PATH>>
		<SETG SECRET-DOOR T>
		<TELL
"La princesse apparaît derrière des rochers, comme si elle avait traversé un mur." CR>)
	       (<IN? ,WINNER .OLDP>
		<SETG PRFOLLOW <GET ,PRDIRS <+ .PC 3>>>
	        <COND (<EQUAL? .OLDP ,GARDEN-NORTH>
		       <TELL "La princesse entre dans le belvédère">
		       <COND (<FSET? ,GAZEBO-ROOM ,RMUNGBIT>
			      <TELL "Elle doit être protégée par magie.">)>
		       <TELL "." CR>)
		      (<EQUAL? .OLDP ,RAVINE-LEDGE>
		       <TELL
"La princesse grimpe délicatement le long de la paroi rocheuse." CR>)
		      (T
		       <TELL "La princesse marche ">
		       <TELL <GET ,PRDIRS .PC>>
		       <TELL ". Elle vous regarde pendant qu'elle avance." CR>)>)
	       (<IN? ,PRINCESS ,HERE>
		<COND (<EQUAL? ,HERE ,GAZEBO-ROOM>
		       <TELL "La princesse vous rejoint dans le belvédère." CR>)
		      (<EQUAL? ,HERE ,DEEP-FORD>
		       <TELL "La princesse descend la paroi rocheuse jusqu'au plage." CR>)
		      (T
		       <TELL "La princesse entre par le ">
		       <TELL <GET ,PRDIRS <+ 2 .PC>>>
		       <TELL ". Elle semble surprise de vous voir." CR>)>)>
	 <COND (<IN? ,PRINCESS ,GAZEBO-ROOM>
		<DISABLE .DEM>
		<ENABLE <QUEUE I-UNICORN 6>>)
	       (T
		<SETG PRCOUNT <+ ,PRCOUNT 1>>
		<ENABLE <QUEUE I-PRINCESS
			       <COND (<PROB 75> 1)(T 2)>>>)>
	 <RTRUE>>

<ROUTINE I-UNICORN ()
	 <COND (<EQUAL? ,HERE ,GAZEBO-ROOM ,GARDEN-NORTH>
		<MOVE ,ROSE ,WINNER>
		<FCLEAR ,GOLD-KEY ,NDESCBIT>
		<MOVE ,GOLD-KEY ,WINNER>
		<SCORE-OBJ ,GOLD-KEY>
		<PUTP ,GOLD-KEY ,P?ACTION 0>
		<TELL
"Elle s'approche d'elle et s'incline la tête comme si elle était courbée. Autour de son cou est un ruban de satin rouge sur lequel est portée une délicate clé d'or. La princesse prend le ruban et l'utilise pour attacher ses cheveux. Elle vous regarde et puis, souriant, vous donne la clé et une rose fraîche qu'elle arrache de l'arboreau. \"Vous avez peut-être utilisé une telle chose,\" dit-elle. \"C'est le moins que je puisse faire pour celui qui m'a sauvé d'un destin que je n'ose pas contempler.\"" CR>
		<REMOVE ,PRINCESS>)
	       (T
		<REMOVE ,PRINCESS>
		<MOVE ,ROSE ,GAZEBO-ROOM>
		<RFALSE>)>>

\

"ATELIER DE SOUS-TITRE ET ENVIRONS"

<ROUTINE MENHIR-ROOM-FCN (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-FLASH> ,MENHIR-POSITION>
		<DESCRIBE-MENHIR>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Il s'agit d'une grande pièce qui a été manifestement utilisée une fois comme carrière. Beaucoup de grands morceaux de calcaire se trouvent héliter-skelter autour de la pièce. Certains sont rugueux et non travaillés, d'autres lisses et bien finis. Un côté de la pièce semble avoir été utilisé pour les blocs de construction de carrière, l'autre pour produire des menhirs (pierres debout)." CR>
		<COND (<IN? ,MENHIR ,LOCAL-GLOBALS>
		       <DESCRIBE-MENHIR>)>
		T)>>

<ROUTINE DESCRIBE-MENHIR ()
	 <COND (<EQUAL? ,HERE ,MENHIR-ROOM>
		<COND (<EQUAL? ,MENHIR-POSITION <>>
		       <TELL
"Un menhir particulièrement grand, d'au moins vingt pieds de haut et huit pieds d'épaisseur, est penché contre le mur bloquant une ouverture sombre menant au sud-ouest. De ce côté du menhir est sculpté une lettre ornée \"F\"." CR>)
		      (<EQUAL? ,MENHIR-POSITION 1>
		       <TELL
"Il y a un énorme menhir posé sur le sol près d'un passage sud-ouest." CR>)
		      (<EQUAL? ,MENHIR-POSITION 2>
		       <TELL
"Une ouverture sombre mène sud-ouest." CR>)
		      (<EQUAL? ,MENHIR-POSITION 3>
		       <TELL "Il y a un énorme menhir ici." CR>)
		      (T
		       <TELL
"Il y a ici un énorme menhir flottant comme une plume au milieu de l'air." CR>)>
		<COND (<EQUAL? ,HERE ,MUNGED-ROOM>
		       <TELL
"L'explosion semble n'avoir eu aucun effet sur le menhir." CR>)>
		<RTRUE>)
	       (T <TELL "Une ouverture sombre mène sud-ouest." CR>)>>

<GLOBAL MENHIR-POSITION <>>

<ROUTINE MENHIR-FCN ()
	 <COND (<VERB? LOOK-UNDER LOOK-BEHIND>
		<COND (,MENHIR-POSITION
		       <TELL
"Derrière le menhir se trouvent un peu d'air puis un mur." CR>)
		      (T
		       <TELL
"L'écart entre le menhir et le mur est très étroit, mais il est clair qu'il y a une grande pièce là-dedans. Votre lumière ne révèle qu'une partie du mur lointain." CR>)>)
	       (<VERB? TAKE MOVE TURN>
		<TELL
"Le menhir pèse beaucoup de tonnes et mesure huit pieds de large. Vous ne pouvez même pas obtenir une prise sur elle, beaucoup moins le déplacer." CR>)
	       (<VERB? READ> <TELL "\"F\"" CR>)
	       (<VERB? EXAMINE>
		<TELL
"Il est bien fini, et la lettre « F » sur elle est particulièrement bien sculptée." CR>)
	       (<AND <VERB? ENCHANT> <EQUAL? ,SPELL-USED ,W?FLOAT>>
		<TELL
"Le menhir flotte majestueusement dans l'air, s'élevant à environ dix pieds. Le passage au-dessous s'annonce accueillant." CR>
		<SETG MENHIR-POSITION 3>)
	       (<AND <VERB? DISENCHANT>
		     <EQUAL? ,SPELL-USED ,W?FLOAT>>
		<SETG MENHIR-POSITION <>>
		<COND (<EQUAL? ,HERE ,MENHIR-ROOM ,KENNEL>
		       <TELL
"Le menhir s'enfonce jusqu'au sol." CR>)>)>>

<GLOBAL GUARDIAN-FED <>>

<ROUTINE DOOR-KEEPER-FCN ()
	 <COND (<AND <VERB? ALARM> ,GUARDIAN-FED>
		<TELL "Essayez comme vous le pouvez, vous ne pouvez pas vous réveiller. " CR>)
	       (<AND <VERB? GIVE> <EQUAL? ,PRSI ,DOOR-KEEPER>>
		<COND (,GUARDIAN-FED
		       <TELL
"Il dort, du moins pour le moment." CR>)
		      (<EQUAL? ,PRSO ,CANDY>
		       <SETG GUARDIAN-FED T>
		       <REMOVE ,CANDY>
		       <TELL
"Le gardien loupe avidement les bonbons, y compris le paquet. (Il semblait apprécier les sauterelles particulièrement.) Il devient alors calme et ses yeux proches. (Les lézards sont connus pour dormir longtemps tout en digérant leurs repas.)" CR>)
		      (<EQUAL? ,PRSO ,FLASK>
		       <TELL
"Le lézard le renifle expérimentalement, puis vous regarde en colère, sifflant et se cassant." CR>)
		      (<BOMB? ,PRSO>
		       <REMOVE ,PRSO>
		       <TELL
"Au bout d'un moment, vous entendez une petite pop et les yeux du gardien s'évanouissent. Il siffle sur vous." CR>)
		      (<EQUAL? ,PRSO ,PALANTIR-1 ,PALANTIR-2 ,PALANTIR-3>
		       <TELL
"Le gardien agite avidement la sphère, mais la trouve intransigeante. Il essaie ensuite à plusieurs reprises de l'avaler, avec des résultats décevants. Enfin, il la crache sur le sol." CR>
		       <MOVE ,PRSO ,HERE>)
		      (T
		       <REMOVE ,PRSO>
		       <TELL
"Le lézard engloutit le " D ,PRSO " en croquant goulûment." CR>)>)
	       (<VERB? ATTACK MUNG>
		<TELL
"Le gardien semble imperméable à votre attaque." CR>)>>

<GLOBAL WIZ-DOOR-FLAG <>>

<ROUTINE WIZ-DOOR-FCN ()
	 <COND (<NOT ,GUARDIAN-FED>
		<COND (<VERB? OPEN>
		       <TELL
"Le lézard prend vie et s'en prend à vous quand vous atteignez la poignée." CR>)
		      (<VERB? UNLOCK>
		       <TELL
"Le gardien de porte de lézard vient éveillé et mord à la main.">
		       <COND (<AND <EQUAL? ,PRSI ,GOLD-KEY> <PROB 5>>
			      <REMOVE ,GOLD-KEY>
			      <TELL "Le gardien a la clé, mais ça grince maniaque." CR>)
			     (<PROB 20>
			      <MOVE ,GOLD-KEY ,HERE>
			      <TELL " Mais vous laissez tomber la clé." CR>)
			     (T <CRLF>)>)>)
	       (<VERB? UNLOCK>
		<COND (,WIZ-DOOR-FLAG
		       <TELL "C'est déjà le cas !" CR>)
		      (<EQUAL? ,PRSI ,GOLD-KEY>
		       <SETG WIZ-DOOR-FLAG T>
		       <TELL
"La clé tourne et le pêne clique. La porte est déverrouillée." CR>)
		      (T
		       <SETG WIZ-DOOR-FLAG <>>
		       <TELL "Cela ne la déverrouillera pas." CR>)>)
	       (<VERB? LOCK>
		<COND (<NOT ,WIZ-DOOR-FLAG>
		       <TELL "Elle est déjà verrouillée." CR>)
		      (<EQUAL? ,PRSI ,GOLD-KEY>
		       <TELL "La porte est désormais verrouillée." CR>
		       <SETG WIZ-DOOR-FLAG <>>
		       <RTRUE>)
		      (T <TELL "Cela ne le verrouillera pas." CR>)>)
	       (<VERB? OPEN CLOSE>
		<COND (,WIZ-DOOR-FLAG
		       <OPEN-CLOSE ,PRSO
				   "La porte s'ouvre en grinçant."
				   "La porte s'ouvre à contrecœur. ferme.">)
		      (<VERB? OPEN>
		       <TELL "La porte est verrouillée !" CR>)>)>>

<ROUTINE GUARDIAN-ROOM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Cette pièce est cobwebby et musty, mais les traces dans la poussière montrent qu'elle a vu des visiteurs récemment. À l'extrémité sud de la pièce est une porte tachée et battue (mais très forte) . Au nord, un couloir sort." CR>
		<COND (<FSET? ,WIZ-DOOR ,OPENBIT>
		       <TELL "La porte est ouverte." CR>)>
		<COND (<NOT ,GUARDIAN-FED>
		       <TELL
"Imbécile dans la porte est une sale tête de lézard, avec des dents pointues et des yeux perlés.">
		       <COND (<IN? ,CANDY ,WINNER>
			      <TELL "Le lézard vous renifle." CR>)
			     (T
			      <TELL
"Les yeux bougent pour vous regarder approcher." CR>)>)
		      (T
		       <TELL
"Une tête de lézard à l'air endormi est montée sur le porte." CR>)>)>>

<ROUTINE WORKSHOP-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Vous êtes debout dans le hall d'entrée de l'atelier du Magicien. Des couloirs sombres mènent à l'ouest et au sud d'ici. Le couloir à l'ouest sent légèrement de l'encens ou de la fumée de bougie.">
		<COND (<FSET? ,WIZ-DOOR ,OPENBIT>
		       <TELL " La porte de l'atelier est ouverte.">)>
		<CRLF>
		<RTRUE>)>>

<ROUTINE ARCANA-PSEUDO ()
	 <COND (<VERB? TAKE>
		<TELL
"Les trucs sur le banc semblent être tellement de merde, et vous décidez qu'il ne serait sur votre chemin que si vous l'avez pris." CR>)>>

<ROUTINE TROPHY-PSEUDO ()
	 <COND (<VERB? READ> <RFALSE>)
	       (<VERB? TAKE RUB>
		<TELL
"Comme vos doigts s'approchent, vous obtenez un choc méchant (mais heureusement pas fatal)." CR>)>>

<ROUTINE STAND-FCN ()
	 <COND (<VERB? TAKE>
		<TELL "Le " D ,PRSO " est fermement fixé au banc." CR>)
	       (<AND <VERB? PUT PUT-ON>
		     <EQUAL? ,PRSO ,PALANTIR-1 ,PALANTIR-2 ,PALANTIR-3>
		     <EQUAL? ,PRSI ,STAND-1 ,STAND-2 ,STAND-3>>
		<V-PUT>
		<COND (<AND <IN? ,PALANTIR-1 ,STAND-1>
			    <IN? ,PALANTIR-2 ,STAND-2>
			    <IN? ,PALANTIR-3 ,STAND-3>>
		       <REMOVE ,PALANTIR-1>
		       <REMOVE ,PALANTIR-2>
		       <REMOVE ,PALANTIR-3>
		       <MOVE ,STAND-4 ,WORKBENCH>
		       <TELL
"Lorsque vous placez le " D ,PRSO " dans le " D ,PRSI "Les trois sphères commencent à vibrer, de plus en plus vite, lorsque le bruit devient de plus en plus aiguisé. Trois bouffées de fumée, un rouge, un bleu, un blanc, s'élèvent des peuplements vides. Les sphères sont parties! Mais au centre du triangle formé par les peuplements est maintenant un peuplement noir d'obsidienne dans lequel repose une étrange sphère noire." CR>)>
		T)>>

<ROUTINE IN-AQUARIUM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Il y a un sol sablonneux ici, et votre vision semble floue et floue. Le mur que vous regardez est joliment habillé en pierre." CR>
		<COND (<IN? ,SERPENT ,AQUARIUM>
		       <COND (<PROB 25>
			      <TELL
"Pendant que vous regardez, une ombre semble passer au-dessus de votre tête." CR>)
			     (<PROB 5>
			      <TELL
"La tête d'un serpent horrible se jette en vue, ses yeux verts perlés semblaient presque vous voir." CR>)>)>
		<RTRUE>)
	       (<EQUAL? .RARG ,M-ENTER>
		<COND (<IN? ,SERPENT ,AQUARIUM>
		       <JIGS-UP
"Vous tombez dans l'aquarium avec une éclaboussure (qui attire le serpent). Il vous mange avidement. Il n'est qu'un bébé, après tout, et a besoin de toute la nourriture qu'il peut avoir.">)
		      (T <JIGS-UP
"Tu t'es sérieusement coupé sur le verre cassé.">)>)>>

<ROUTINE AQUARIUM-FCN ("AUX" OBJ)
	 <COND (<VERB? BOARD THROUGH> <DO-WALK ,P?IN> <RTRUE>)
	       (<AND <VERB? LOOK-INSIDE>
		     <IN? ,SERPENT ,AQUARIUM>>
		<TELL
"Dans l'aquarium est un bébé serpent de mer qui vous regarde suspectement. Son corps écailleux s'agite dans l'énorme réservoir." CR>)
	       (<OR <AND <VERB? MUNG ATTACK> <EQUAL? ,PRSO ,AQUARIUM>>
		    <AND <VERB? THROW> <EQUAL? ,PRSI ,AQUARIUM>>>
		<COND (<EQUAL? ,PRSO ,AQUARIUM>
		       <COND (<NOT ,PRSI> <RFALSE>)
			     (T <SET OBJ ,PRSI>)>)
		      (T <SET OBJ ,PRSO>)>
		<MOVE .OBJ ,HERE>
		<COND (<IN? ,DEAD-SERPENT ,HERE>
		       <TELL
"L'aquarium est déjà cassé !" CR>
		       <RTRUE>)
		      (<EQUAL? .OBJ ,FLASK>
		       <JIGS-UP
"Le flacon se brise et un gaz toxique remplit le réservoir. pièce !">
		       <RTRUE>)
		      (<BOMB? .OBJ>
		       <DISABLE <INT I-FUSE>>)
		      (<OR <FSET? .OBJ ,WEAPONBIT>
			   <G? <GETP .OBJ ,P?SIZE> 10>>
		<REMOVE ,SERPENT>
		<MOVE ,PALANTIR-3 ,AQUARIUM>
		<FCLEAR ,PALANTIR-3 ,NDESCBIT>
		<PUTP ,AQUARIUM ,P?LDESC
"Un aquarium brisé remplit la moitié nord de la pièce.">
		<MOVE ,DEAD-SERPENT ,HERE>
		<TELL
"Le " D .OBJ "brise le mur de verre de l'aquarium, déversant une quantité impressionnante d'eau salée et de sable humide. Il déverse également un serpent de mer extrêmement ennuyé qui mord en colère au" D .OBJ "Il a du mal à respirer, et il semble vous tenir responsable de son problème actuel.">
		<COND (<VERB? MUNG>
		       <TELL
"Il parvient à vous rabattre avant qu'il ne se noie dans l'air." CR>
		       <JIGS-UP "Je suppose que vous avez été trop négligent.">)
		      (T
		       <TELL
"Il essaie de glisser sur le sol de pierre vers vous. Heureusement, il expire à quelques centimètres de votre pied. Une sphère cristalline claire se trouve au milieu du sable et du verre cassé sur le fond de l'aquarium." CR>)>)
		      (T
		       <TELL
"Le " D .OBJ " rebondit sans danger sur le verre." CR>)>)>>

<ROUTINE SERPENT-FCN ()
	 <COND (<EQUAL? ,SERPENT ,WINNER>
		<TELL
"Le serpent ne fait que vous regarder avec avidité." CR>)
	       (<VERB? ATTACK MUNG>
		<TELL
"Il nage vers vous avec un coup puissant de ses palmes, des dents comme un poignard qui coule. Heureusement, il ne veut pas s'écraser dans le mur de l'aquarium, et se contente de vous éclabousser avec de l'eau." CR>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,PRSO ,SERPENT>>
		<TELL "Impossible pour de nombreuses raisons." CR>)
	       (<VERB? TAKE GIVE>
		<JIGS-UP
"Il vous emmène à la place. *Uurrp !*">)>>

<ROUTINE DEAD-SERPENT-FCN ()
	 <COND (<VERB? TAKE>
		<TELL
"Ce n'est peut-être qu'un bébé serpent de mer, mais il est aussi gros qu'une petite baleine." CR>)>>

<ROUTINE GENIE-FCN ("OPTIONAL" (RARG ,M-OBJECT) "AUX" V HOARD)
	<COND (<VERB? HELLO>
	       <TELL
"Le génie sourit démoniaquement, mais ne dit rien." CR>)
	      (<EQUAL? ,WINNER ,GENIE>
	       <COND (<NOT ,GENIE-READY?>
		      <TELL
"« Mes honoraires ne sont pas payés ! Je n'accomplis aucune tâche gratuitement ! Nous, les démons, avons une forte union de nos jours. »" CR>
		      <RFATAL>)
		     (<VERB? SGIVE> <RFALSE>)
		     (<OR <G? <GET ,P-PRSO 0> 1>
			  <G? <GET ,P-PRSI 0> 1>>
		      <TELL
"\"Je ne ferai qu'une chose, oh gracieux maître !\"" CR>
		      <RFATAL>)
		     (<AND <VERB? MOVE> <EQUAL? ,PRSO ,GLOBAL-MENHIR>>
		      <SETG MENHIR-POSITION 1>
		      <TELL
"Le démon est parti pour un moment. \"Un petit doigt suffit.\"" CR>
		      <GENIE-LEAVES>)
		     (<VERB? TAKE>
		      <COND (<EQUAL? ,PRSO ,GLOBAL-MENHIR>
			     <REMOVE ,MENHIR>
			     <SETG MENHIR-POSITION 2>
			     <TELL
"\"J'ai peu d'utilité pour une telle chose, mais peut-être comme une porte d'arrêt...\"" CR>
			     <GENIE-LEAVES>)
			    (<EQUAL? ,PRSO ,WAND>
			     <TELL
"«Ceci je le fais volontiers, oh idiot!» frappe le démon avec joie. Il étend une main énorme vers la baguette et le prend comme un cure-dent (ceci est un grand démon), le pointe à lui-même. «libre!» il commande, et le démon et sa baguette disparaissent pour toujours." CR>
			     <GENIE-LEAVES <>>
			     <REMOVE ,WAND>)
			    (<FSET? ,PRSO ,TAKEBIT>
			     <GENIE-LEAVES <>>
			     <REMOVE ,PRSO>
			     <TELL
"Le démon claque des doigts, le " D ,PRSO "tourne sauvagement dans l'air devant lui, puis lui et lui partent." CR>)
			    (T
			     <TELL
"\"Je crains de ne pas pouvoir prendre une telle chose.\"" CR>)>)
		     (<AND <VERB? GIVE> <EQUAL? ,PRSI ,ME>>
		      <COND (<EQUAL? ,PRSO ,WAND>
			     <TELL
"«J'entends et j'obéis!» dit le démon. Il étend une main énorme vers la baguette. Le Magicien n'est pas sûr de ce qu'il doit faire, le pointant menaçant sur le démon, puis sur vous. «Fudge!» il pleure, mais, à part une forte odeur de chocolat dans l'air, il n'y a pas d'effet." CR>
			     <REMOVE ,WIZARD>
			     <GENIE-LEAVES <>>
			     <FCLEAR ,WAND ,NDESCBIT>
			     <MOVE ,WAND ,HERE>)
			    (<EQUAL? ,PRSO ,GLOBAL-MENHIR>
			     <MOVE ,MENHIR ,PENTAGRAM-ROOM>
			     <FCLEAR ,MENHIR ,NDESCBIT>
			     <FCLEAR ,MENHIR ,TAKEBIT>
			     <SETG MENHIR-POSITION 3>
			     <TELL
"Il agite ses mains et le menhir tombe doucement à vos pieds." CR>
			     <GENIE-LEAVES>)
			    (<FSET? ,PRSO ,TAKEBIT>
			     <MOVE ,PRSO ,PENTAGRAM-ROOM>
			     <TELL
"Le " D ,PRSO " apparaît devant vous et s'installe devant vous. sol." CR>
			     <GENIE-LEAVES>)
			    (T
			     <TELL
"\"Si c'était possible, ce serait mon souhait le plus cher, mais hélas...\"" CR>)>)
		     (<VERB? ATTACK>
		      <COND (<EQUAL? ,PRSO ,GLOBAL-CERBERUS>
			     <TELL
"Le démon disparaît un instant, puis réapparaît. Il a l'air plutôt griffé et griffé. Il treuils. \" Trop pour moi. Chien chiot, en effet. Vous êtes le bienvenu pour lui. Jamais aimé les chiens de toute façon... aucun autre ordre, oh beneficent un?\"" CR>)
			    (<EQUAL? ,PRSO ,WIZARD>
			     <TELL
"\"C'est mon désir depuis que ce charlatan m'a plié à son service. J'accomplis cet acte avec plaisir!\" Le démon se forme de nouveau dans un nuage de fumée grasse. Le nuage enveloppe le Magicien, qui agite sans succès sa baguette, murmurant diverses phrases qui commencent par \"F\". Un cri horrible est entendu, et la fumée commence à s'éclaircir." CR>
			     <REMOVE ,WIZARD>
			     <FCLEAR ,WAND ,NDESCBIT>
			     <MOVE ,WAND ,HERE>
			     <GENIE-LEAVES>)
			    (<EQUAL? ,PRSO ,ME>
			     <GENIE-LEAVES <>>
			     <SETG WINNER ,ADVENTURER>
			     <JIGS-UP
"Le démon vous écrase d'un coup de sa main énorme.">)
			    (T
			     <TELL 
"\"Je ne connais aucun moyen de tuer un " D ,PRSO ".\"" CR>)>)
		     (<VERB? FIND EXAMINE>
		      <TELL
"\"Je n'ai pas le droit de ">
		      <COND (<VERB? FIND>
			     <TELL "réponse questions">)
			    (T <TELL "effectuer de telles tâches subalternes">)>
		      <TELL ". Les termes de mon contrat sont explicites sur cette question, apprise. Certainement vous ne voudriez pas violer mon contrat?\" Il lèche ses lèvres avec une langue fourchue comme un serpent. \"Les clauses de pénalité sont ... hmm ... diable.\"" CR>)
		     (T
		      <TELL
"-- Excuses, oh maître, mais même pour une telle chose que je ne suis pas possible." CR>
		      <RTRUE>)>)
	      (<VERB? EXORCISE ATTACK MUNG>
	       <TELL
"Le démon rit aux éclats." CR>)
	      (<AND <VERB? GIVE> <EQUAL? ,PRSI ,GENIE>>
	       <COND (<AND <EQUAL? ,PRSO ,IRON-BOX>
			   <IN? ,VIOLIN ,PRSO>>
		      <TELL
"Le génie fronce brièvement les sourcils, puis ">
		      <COND (<FSET? ,PRSO ,OPENBIT> <TELL "regarde à l'intérieur">)
			    (ELSE <TELL "ouvre">)>
		      <TELL " la boîte. Il sourit horriblement." CR>
		      <REMOVE-CAREFULLY ,IRON-BOX>
		      <SETG PRSO ,VIOLIN>)>
	       <COND (<AND <GETPT ,PRSO ,P?VALUE>
			   <NOT <EQUAL? ,PRSO ,SWORD>>>
		      <REMOVE-CAREFULLY ,PRSO>
		      <SETG GENIE-HOARD <+ ,GENIE-HOARD 1>>
		      <SCORE-UPD 2>
		      <SET HOARD <+ ,GENIE-HOARD <CASE-WORTH>>>
		      <COND (<NOT <L? .HOARD ,TREASURES-MAX>>
			     <SETG GENIE-READY? T>
			     <PUTP ,WIZARD ,P?LDESC
"Un sorcier abattu et craintif regarde depuis le coin.">
			     <TELL
"\"C'est un petit service, mais comme tu m'as rendu un petit service en me perdant de ce magicien, ça suffira.\"" CR>)
			    (T
			     <TELL
"\"" <GET ,GENIE-THANKS .HOARD> "\"" CR>
			     <COND (<EQUAL? .HOARD 8>
				    <TELL
"Le Magicien te regarde comme un fou, il déchire sa barbe et te regarde avec peur." CR>)>
			     <RTRUE>)>)
		     (<BOMB? ,PRSO>
		      <GENIE-LEAVES <>>
		      <TELL
"\"Je crains que cela viole mon contrat, oh stupide. Ainsi, je suis libre de partir.\"" CR>)
		     (T
		      <REMOVE-CAREFULLY ,PRSO>
		      <TELL
"Le démon prend volontiers le " D ,PRSO "et sourit avec audace, révélant d'énormes crocs." CR>)>)>>

<ROUTINE GENIE-LEAVES ("OPTIONAL" (NOISY? T))
	 <FSET ,GENIE ,INVISIBLE>
	 <COND (.NOISY?
		<TELL "Le génie s'en va, son accord rempli." CR>)>
	 <SETG P-CONT <>>
	 <RFATAL>>

<GLOBAL GENIE-READY? <>>
<GLOBAL GENIE-HOARD 0>
<CONSTANT TREASURES-MAX 10>	;"all treasures but palantirs(4),
				  candy, collar, wand."

<GLOBAL GENIE-THANKS <LTABLE
"Mais ce n'est pas assez. Je vais faire un grand service, et ne sont pas de grands services achetés à grand prix?"
"Très sympa, mais pas assez !"
"Ah, vraiment magnifique ! Continuez à les faire venir."
"Presque à mi-chemin, oh digne !"
"Oh, quelle beauté ! Votre générosité m'accable presque !"
"En vérité, je te rendrai un merveilleux service quand tu auras fini !"
"Vraiment tu es très généreux ! Mais cela ne suffit pas encore."
"Un beau cadeau, puissant, vous avez presque atteint mes honoraires."
"Merveilleux bien, maître ! Mais un trésor reste encore à donner !">>

<ROUTINE CASE-WORTH ("AUX" F (W 0))
	 <SET F <FIRST? ,WIZARD-CASE>>
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN .W>)>
		 <COND (<GETPT .F ,P?VALUE>
			<SET W <+ .W 1>>)>
		 <SET F <NEXT? .F>>>>

<ROUTINE PENTAGRAM-FCN ("OPTIONAL" (RARG ,M-BEG))
	 <COND (<EQUAL? .RARG ,M-BEG>
		<COND (<VERB? THROUGH BOARD>
		       <TELL
"Vous essayez d'entrer dans le pentagramme, mais sont contraints de revenir par une puissance invisible." CR>)
	              (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSO ,PALANTIR-4>>
		       <REMOVE ,PALANTIR-4>
		       <FCLEAR ,GENIE ,INVISIBLE>
		       <MOVE ,GENIE ,PENTAGRAM-ROOM>
		       <TELL
"Un vent froid souffle vers l'extérieur de la sphère. Les bougies scintillent, et un gémissement bas, presque inaudible, est entendu. Il se lève en volume et pitch jusqu'à ce qu'il devienne un aiguillage élevé. Une forme sombre devient visible dans l'air au-dessus de la sphère. La forme se résout en un grand démon regardant quelque peu redoutable. Il regarde autour, teste les murs du pentagramme expérimentalement, puis vous voit! \"Hmm, un nouveau maître...\" dit-il sous son souffle. \"Greetings, oh maître! Voudrait-il un service, comme notre état contractuel? Pour une certaine pitance de richesse, un peu de trifle, je vais gratifier vos désirs à la plus grande limite de mes pouvoirs, et ils ne sont pas inconsidérés.\" Il fait un passage avec ses bras massifs et les murs commencent à secouer un peu. Un autre passage et les secousses s'arrêtent." CR>)>)>>

<ROUTINE WIZARD-FCN ("OPTIONAL" (RARG ,M-OBJECT) "AUX" OLIT)
	 <COND (<EQUAL? ,WINNER ,WIZARD>
		<COND (<VERB? GIVE> <TELL
"Le sorcier répond « Folishment ! »" CR>)
		      (T
		       <TELL
"Le Magicien considère votre déclaration avec soin." CR>)>)
	       (<AND <VERB? GIVE> <EQUAL? ,PRSI ,WIZARD>>
		<SET OLIT ,LIT>
		<REMOVE-CAREFULLY ,PRSO>
		<COND (<BOMB? ,PRSO>
		       <COND (<IN? ,GENIE ,PENTAGRAM-ROOM>
			      <MOVE ,PRSO ,HERE>
			      <TELL
"Le sorcier accepte cette dernière folie avec résignation." CR>)
			     (T
			      <REMOVE ,WIZARD>
			      <TELL
"\"Hmm...\" Le Magicien mutte quelque chose, puis fait passer sa baguette sur la bombe. Il se transforme en bouquet de fleurs. Le Magicien et les fleurs disparaissent." CR>)>)
		      (<AND .OLIT <NOT ,LIT>>
		       <TELL
"\"Merci.\" Lorsque l'assistant place le " D ,PRSO "sous sa robe, la pièce devient sombre." CR>)
		      (T
		       <TELL "\"Merci.\"" CR>)>)
	       (<HELLO? ,WIZARD>
		<TELL
"Le sorcier semble surpris, tout comme vous pourriez l'être si un chien parlait." CR>)
	       (<VERB? ATTACK MUNG>
		<REMOVE ,WIZARD>
		<COND (<IN? ,WAND ,WIZARD>
		       <TELL
"Le magicien se retire, agitant sa baguette et chantant. Il dit «Peur!»">)
		      (T
		       <TELL
"Le Magicien essaie de jeter le sort \"Peur!\", mais sans sa baguette !">)>
		<COND (<NOT <FSET? ,GENIE ,INVISIBLE>>
		       <TELL
"Avec un regard terrifié sur le démon, le magicien passe devant vous et sort de la pièce." CR>)
		      (T
		       <TELL
"Vous êtes soudainement terrifié. Le Magicien semble énorme et terrible, se profilant sur vous." CR CR>
		       <SETG SPELL? ,S-FEAR>
		       <PUTP ,ADVENTURER ,P?ACTION MAGIC-ACTOR>
		       <ENABLE <QUEUE I-WIZARD 10>>
		       <RANDOM-WALK>)>)>>

<ROUTINE I-WIZARD ("AUX" CAST-PROB (PCNT 0) F (WLOC <LOC ,WINNER>))
	 <ENABLE <QUEUE I-WIZARD 4>>
	 <COND (,DEAD <RFALSE>)
	       (,SPELL?
		<COND (<EQUAL? ,SPELL? ,S-FLOAT>
		       <COND (<EQUAL? ,HERE ,WELL-TOP>
			      <JIGS-UP
"Vous plongez au fond du puits alors que le sort se dissipe.">
			      <RTRUE>)
			     (<AND <FSET? ,HERE ,NONLANDBIT>
				   <NOT <EQUAL? ,HERE ,WELL-BOTTOM
						,VOLCANO-BOTTOM>>>
			      <JIGS-UP
"Au fur et à mesure que le sort s'éteint, on se retrouve en train de faire un demi-gainer vers le fond du volcan.">
			      <RTRUE>)>)
		      (<EQUAL? ,SPELL? ,S-FEEBLE>
		       <SETG LOAD-ALLOWED ,LOAD-MAX>)
		      (<EQUAL? ,SPELL? ,S-FIERCE>
		       <SETG SWORD-GLOW 0>)
		      (<EQUAL? ,SPELL? ,S-FUMBLE>
		       <SETG FUMBLE-NUMBER 7>
		       <SETG FUMBLE-PROB 8>)>
		<COND (<GET ,SPELL-STOPS ,SPELL?>
		       <TELL <GET ,SPELL-STOPS ,SPELL?> CR>)>
		<PUTP ,ADVENTURER ,P?ACTION 0>
		<SETG SPELL? <>>
		<RTRUE>)>
	 <COND (<IN? ,GENIE ,PENTAGRAM-ROOM>
		<DISABLE <INT I-WIZARD>> 
		<COND (<NOT <IN? ,WIZARD ,PENTAGRAM-ROOM>>
		       <MOVE ,WIZARD ,PENTAGRAM-ROOM>
		       <COND (<IN? ,WINNER ,PENTAGRAM-ROOM>
			      <TELL

"Soudain le Magicien se matérialise dans la pièce. Il est étonné de ce qu'il voit : son serviteur en conversation profonde avec un aventurier commun ! Il tire sa baguette, la fait flotter frénétiquement, et incante « Frobizz ! Frobozzle ! Frobnoid ! » Le démon rit de bon cœur. « Vous ne contrôlez plus le cristal noir, le bizard de haie ! Votre baguette est impuissante ! Votre doom est scellé ! » Le démon se tourne vers vous, attendument." CR>)>)>
		<RTRUE>)>
	 <COND (<AND <NOT ,LIT>
		     <FSET? ,LAMP ,RMUNGBIT>
		     <G? ,SCORE 200>>
		<SETG ALWAYS-LIT T>
		<SETG LIT T>
		<TELL
"Dans l'obscurité, vous entendez la voix du Magicien. \"Cher moi, vous semblez être entré dans un sacré cornichon.\"" CR>
		<RTRUE>)>
	 <COND (<AND <LOC ,WIZARD> <PROB 80>>
		<COND (<AND ,LIT <IN? ,WIZARD ,HERE>>
		       <TELL "Le sorcier disparaît." CR>)>
		<REMOVE ,WIZARD>
		<RTRUE>)>
	 <COND (<PROB 10>
		<COND (<NOT ,LIT>
		       <TELL
"Vous ressentez un léger souffle d'air alors que quelque chose bouge à proximité." CR>)
		      (<EQUAL? ,HERE ,POSTS-ROOM ,POOL-ROOM>
		       <TELL
"Un sorcier énorme et terrible apparaît devant vous, aussi grand que le plus grand arbre! Il vous regarde comme vous regarderiez un gneau!" CR>)
		      (<FSET? ,HERE ,NONLANDBIT>
		       <TELL
"Le Magicien apparaît, flottant inconsidérément dans l'air à côté de vous." CR>)
		      (T
		       <TELL
"Un étrange petit homme vêtu d'une longue cape apparaît soudain dans la pièce. Il porte un haut chapeau pointu brodé de signes astrologiques. Sa barbe est longue, filasse et négligée." CR>)>
		<COND (<IN? ,PALANTIR-4 ,ADVENTURER>
		       <COND (,LIT
			      <TELL
"Le Magicien remarque que vous portez le cristal noir, et avec une hâte insoupçonnée, il disparaît." CR>)
			     (ELSE
			      <TELL
"Vous ressentez un soudain afflux d'air comme si quelque chose avait disparu." CR>)>
		       <REMOVE ,WIZARD>
		       <RTRUE>)
		      (<PROB 20>
		       <COND (,LIT
			      <TELL
"Il mute quelque chose (soufflé par sa barbe) et disparaît aussi soudainement qu'il est venu." CR>)
			     (ELSE
			      <TELL
"Vous entendez des murmures sourds et confus." CR>)>
		       <REMOVE ,WIZARD>
		       <RTRUE>)>
		<COND (<IN? ,PALANTIR-1 ,ADVENTURER>
		       <SET PCNT <+ .PCNT 1>>)>
		<COND (<IN? ,PALANTIR-2 ,ADVENTURER>
		       <SET PCNT <+ .PCNT 1>>)>
		<COND (<IN? ,PALANTIR-3 ,ADVENTURER>
		       <SET PCNT <+ .PCNT 1>>)>
		<SET CAST-PROB <- 80 <* .PCNT 20>>>
		<COND (,LIT
		       <TELL
"Le Magicien sort sa baguette et la brandit dans votre direction. Elle se met à émettre une faible lueur bleue." CR>)
		      (ELSE
		       <TELL
"Soudain, illuminé par la lueur bleu pâle d'une baguette magique pointée dans votre direction, vous voyez le Magicien !" CR>)>
		<COND (<PROB .CAST-PROB>
		       <MOVE ,WIZARD ,HERE>
		       <SETG SPELL? <RANDOM ,SPELLS>>
		       <PUTP ,ADVENTURER ,P?ACTION MAGIC-ACTOR>
		       <ENABLE <QUEUE I-WIZARD 
				      <+ 5
					 <RANDOM <- 30 <* 5 .PCNT>>>>>>
		       <COND (<PROB 75>
			      <TELL
"Le Sorcier, d'une voix grave et résonante, prononce le mot \""
<GET ,SPELL-NAMES ,SPELL?> " !\" Il disparaît ensuite en ricanant joyeusement." CR>)
			     (T
			      <TELL
"Le Magicien, presque inaudiblement, murmure un mot commençant par \"F\", puis disparaît, gloussant nastily." CR>)>
		       <REMOVE ,WIZARD>
		       <COND (<GET ,SPELL-HINTS ,SPELL?>
			      <TELL <GET ,SPELL-HINTS ,SPELL?> CR>)>
		       <COND (<EQUAL? ,SPELL? ,S-FALL>
			      <COND (<FSET? .WLOC ,VEHBIT>
				     <TELL
"Vous tombez soudainement hors du " D .WLOC "Comme si quelqu'un l'avait retourné." CR>
				     <COND (<EQUAL? ,HERE ,WELL-TOP>
					    <JIGS-UP
"Vous plongez jusqu'au fond du puits.">)
					   (<AND <FSET? ,HERE ,NONLANDBIT>
						 <NOT <EQUAL? ,HERE
							      ,VOLCANO-BOTTOM
							      ,WELL-BOTTOM>>>
					    <JIGS-UP
"Vous faites un plongeon du cygne plutôt désordonné au fond du puits.<<<ZX002695E>>><<<ZX002696S>>> volcan.">)
					   (ELSE <MOVE ,WINNER ,HERE>)>)>)
			     (<EQUAL? ,SPELL? ,S-FLOAT>
			      <COND (<FSET? .WLOC ,VEHBIT>
				     <TELL
" Vous vous élevez majestueusement du " D .WLOC ", s'arrêtant à environ cinq pieds au-dessus et d'un côté." CR>
				     <MOVE ,WINNER ,HERE>)
				    (T
				     <TELL
"Lentement, vous et tous vos effets s'élèvent dans l'air, s'arrêtant après environ cinq pieds." CR>)>)
			     (<EQUAL? ,SPELL? ,S-FEEBLE>
			      <SETG LOAD-ALLOWED 50>
			      <COND (<SET F <FIRST? ,WINNER>>
				     <TELL
"En fait, vous vous sentez si faible que vous laissez tomber le " D .F "." CR>
				     <MOVE .F .WLOC>)>)
			     (<EQUAL? ,SPELL? ,S-FEAR>
			      <COND (<FSET? .WLOC ,VEHBIT>
				     <TELL
"Vous vous recroquevillez dans le coin du " D .WLOC "J'espère que le magicien ne te verra pas." CR>)
				    (T
				     <CRLF>
				     <RANDOM-WALK>)>)
			     (<EQUAL? ,SPELL? ,S-FUMBLE>
			      <SETG FUMBLE-NUMBER 3>
			      <SETG FUMBLE-PROB 25>
			      <COND (<SET F <FIRST? ,ADVENTURER>>
				     <TELL
"Oups ! Vous avez fait tomber le " D .F "." CR>
				     <MOVE .F .WLOC>)>)
			     (<EQUAL? ,SPELL? ,S-FILCH>
			      <COND (<ROB ,WINNER ,WIZARD-CASE>
				     <TELL
"Quelque chose que vous transportiez a disparu !" CR>)>)
			     (<EQUAL? ,SPELL? ,S-FIERCE>
			      <TELL
"Le Magicien murmure quelque chose sous son souffle, et juste avant de l'atteindre, il disparaît." CR>)>
		       <RTRUE>)
		      (<PROB 50>
		       <REMOVE ,WIZARD>
		       <TELL
"Il y a un fort bruit crépitant. La fumée bleue sort de la manche du Magicien. Il soupire et disparaît." CR>)
		      (<PROB 50>
		       <REMOVE ,WIZARD>
		       <TELL
"Le Sorcier incante \"" <RANDOM-ELEMENT ,SPELL-NAMES> "Mais rien ne se passe. Il secoue la baguette. Rien ne se passe." CR>)
		      (T
		       <MOVE ,WIZARD ,HERE>
		       <TELL
"Le Magicien semble sur le point de parler, puis se ravise et vous observe sous ses sourcils broussailleux." CR>)>)>>

<GLOBAL SPELL? <>>

<CONSTANT SPELLS 12>
<CONSTANT S-FEEBLE 1>
<CONSTANT S-FUMBLE 2>
<CONSTANT S-FEAR 3>
<CONSTANT S-FILCH 4>
<CONSTANT S-FREEZE 5>
<CONSTANT S-FALL 6>
<CONSTANT S-FERMENT 7>
<CONSTANT S-FIERCE 8>
<CONSTANT S-FLOAT 9>
<CONSTANT S-FIREPROOF 10>
<CONSTANT S-FENCE 11>
<CONSTANT S-FANTASIZE 12>

<GLOBAL SPELL-NAMES
	<LTABLE "Faible" "Fumble" "Peur" "Rusard" "Gel"
		"Fal l" "Ferment" "Féroce" "Flotteur" "Ignifuge"
		"Clôture" "Fantastique">>

<GLOBAL SPELL-HINTS
	<LTABLE
"Tout d'un coup, vous vous sentez très fatigué."
<>
"Tu regardes le Magicien dans la terreur, tu t'éloignes, tu essayes de t'éloigner de lui."
<>
"Vos membres ont soudain l'impression qu'ils se sont tournés vers la pierre."
<>
"Vous commencez à vous sentir étourdi."
"Vous vous précipitez sur le sorcier, avec l'intention de le déchirer membre par membre."
<>
<>
<>
<>>>

<GLOBAL SPELL-STOPS
	<LTABLE
"Vous vous sentez plus énergique maintenant."
<>
"Vous décidez soudainement que le sorcier n'est pas si terrifiant..."
<>
"Votre petit doigt commence à tordre, puis tout votre corps est à nouveau libre."
<>
"Votre tête est plus claire maintenant."
"Vous vous sentez plus frais et moins en colère maintenant."
"Vous vous enfoncez tranquillement. encore une fois."
<>
<>
<>>>

<ROUTINE ROB (WHO WHERE "AUX" N X (ROBBED? <>))
	 <SET X <FIRST? .WHO>>
	 <REPEAT ()
		 <COND (<NOT .X> <RETURN .ROBBED?>)>
		 <SET N <NEXT? .X>>
		 <COND (<RIPOFF .X .WHERE> <SET ROBBED? T>)>
		 <SET X .N>>>

<ROUTINE RIPOFF (X WHERE)
	 <COND (<AND <NOT <FSET? .X ,INVISIBLE>>
		     <GETPT .X ,P?VALUE>
		     <NOT <EQUAL? .X ,PALANTIR-1>>
		     <NOT <EQUAL? .X ,PALANTIR-2>>
		     <NOT <EQUAL? .X ,PALANTIR-3>>
		     <NOT <EQUAL? .X ,GOLD-KEY>>
		     <NOT <EQUAL? .X ,CANDY>>>
		<MOVE .X .WHERE>
		<FSET .X ,TOUCHBIT>
		<RTRUE>)>>

<ROUTINE WIZARD-CASE-FCN ()
	 <COND (<EQUAL? ,WINNER ,GENIE>
		<COND (<VERB? MUNG OPEN>
		       <REMOVE ,WIZARD-CASE>
		       <MOVE ,BROKEN-CASE ,TROPHY-ROOM>
		       <TELL
"Le démon écrase l'affaire en smithereens." CR>)>)
	       (<AND <VERB? ENCHANT> <EQUAL? ,SPELL-USED ,W?FILCH>>
		<ROB ,WIZARD-CASE ,HERE>
		<SETG SPELL-HANDLED? T>
		<TELL
"Le contenu de la mallette est disposé à vos pieds." CR>)
	       (<VERB? OPEN MUNG CLOSE TAKE>
		<TELL
"L'affaire est protégée par un sort effrayant." CR>)>>

<GLOBAL SPELL-HANDLED? <>>	;"T if handled before I-SPELL runs"
<GLOBAL WAND-ON <>>
<GLOBAL SPELL-USED <>>
<GLOBAL SPELL-VICTIM <>>

<ROUTINE WAND-FCN ()
	 <COND (<AND <VERB? TAKE PUT GIVE> <IN? ,WAND ,WIZARD>>
		<COND (<EQUAL? ,WINNER ,ADVENTURER>
		       <TELL "Le magicien l'enlève." CR>)
		      (<EQUAL? ,WINNER ,ROBOT>
		       <JIGS-UP
"Le Magicien arrache la baguette, murmurant le mot \"Float\" au robot. Malheureusement, il n'a pas de processeur flottant et meurt dans une tentative vaine de diviser 4,85 par 3,62.">)>)
	       (<AND <VERB? WAVE>
		     <EQUAL? ,PRSI ,GRUE>>
	        <TELL
"Il n'y a pas de bruit en vue, mais un bruit sifflant sort des ténèbres." CR>)
	       (<VERB? WAVE RUB RAISE>
		<COND (<AND <EQUAL? ,PRSO ,WAND>
			    <NOT <IN? ,WAND ,WINNER>>>
		       <TELL "Vous n'avez pas la baguette !" CR>
		       <RTRUE>)
		      (<OR ,WAND-ON ,SPELL-USED ,SPELL-VICTIM>
		       <COND (<PROB 5>
			      <JIGS-UP
"La baguette était encore en train de se recharger de sa dernière utilisation. Elle décharge la magie sur tout. Tu te transformes en crapaud, la pièce se remplit d'une odeur fétide, et toutes sortes d'autres choses affreuses se produisent.">)
			     (T
			      <TELL
"Beaucoup de choses que vous connaissez sur la magie ! Une baguette magique prend un certain temps pour se recharger après l'utilisation !" CR>)>
		       <RTRUE>)
		      (<VERB? WAVE>
		       <COND (<AND <EQUAL? ,PRSO ,WAND> ,PRSI>
			      <SETG WAND-ON ,PRSI>
			      <SETG WAND-ON-LOC ,HERE>)
			     (T <TELL "À quoi ?" CR> <RTRUE>)>)
		      (<VERB? RUB>
		       <COND (<AND <EQUAL? ,PRSI ,WAND> ,PRSO>
			      <SETG WAND-ON ,PRSO>)
			     (T <TELL "Toucher quoi ?" CR> <RTRUE>)>)
		      (<VERB? RAISE>
		       <TELL "La baguette devient chaude et semble vibrer." CR>
		       <RTRUE>)>
		<COND (,WAND-ON
		       <SETG SPELL-USED <>>
		       <SETG SPELL-VICTIM <>>
		       <COND (<EQUAL? ,WAND-ON ,ME ,WAND>
			      <SETG WAND-ON <>>
			      <TELL
"Heureusement, un verrouillage de sécurité empêche la boucle de rétroaction fatale que cela provoquerait." CR>)
			     (T
			      <TELL
"La baguette devient chaude, le " D ,WAND-ON "semble briller avec des essences magiques, et vous vous sentez étouffé de pouvoir." CR>)>
		       <ENABLE <QUEUE I-WAND 2>>)>
		T)>>

<GLOBAL WAND-ON-LOC <>>

<ROUTINE I-WAND ()
	 <COND (<AND ,WAND-ON
		     <OR <EQUAL? ,WAND-ON-LOC ,HERE>
			 <IN? ,WAND-ON ,WINNER>>>
		<TELL
"Le " D ,WAND-ON " cesse de briller et le pouvoir en vous s'affaiblit." CR>
		<SETG WAND-ON <>>
		<RTRUE>)
	       (T
		<SETG WAND-ON <>>
		<RFALSE>)>>

<ROUTINE WIZARD-QUARTERS-FCN (RARG "AUX" PICK L)
	 <COND (<EQUAL? .RARG ,M-LOOK ,M-FLASH>
		<TELL
"C'est là que vit le Magicien de Frobozz. La pièce est ">
		<SET L <GET ,WIZQDESCS 0>>
		<SET PICK <RANDOM .L>>
		<COND (<EQUAL? .PICK ,WIZQLAST>
		       <COND (<EQUAL? .PICK .L>
			      <SET PICK <- .PICK 1>>)
			     (T
			      <SET PICK <+ .PICK 1>>)>)>
		<SETG WIZQLAST .PICK>
		<TELL <GET ,WIZQDESCS .PICK> CR>)>>

<GLOBAL WIZQLAST 0>

<GLOBAL WIZQDESCS
	<LTABLE
"peu meublée et presque monacale dans son austérité."
"un sérail opulentement meublé sorti d'un style arabe. conte populaire."
"décoré dans le style Louis XIV."
"surplombé de palmiers et de lianes. Le seul meuble est un hamac."
"construit à partir de nuages délicats et vaporeux."
"meublé en plastique et en métal et ressemble au pont de commande d'un vaisseau spatial."
"une chambre de banlieue datant des années 1950, dotée de lits superposés."
"une grotte sombre et faiblement éclairée, au sol rempli de fourrures et de vieilles os.">>

<ROUTINE BRIDGE-FCN ()
	 <COND (<VERB? CROSS>
		<DO-WALK ,P?CROSS>)
	       (<VERB? LEAP>
		<JIGS-UP
"Vous exécutez un plongeon du cygne parfait dans les profondeurs en contrebas.">)>>

;"misc. routines"

<ROUTINE STREAM-FCN ()
	 <COND (<VERB? SWIM THROUGH>
		<TELL "Vous ne pouvez pas nager dans le ruisseau." CR>)
	       (<VERB? CROSS>
		<TELL "Vous devrez trouver un gué ou un pont." CR>)>>

<ROUTINE CHASM-FCN ()
	 <COND (<OR <VERB? LEAP>
		    <AND <VERB? PUT> <EQUAL? ,PRSO ,ME>>>
		<TELL
"Pour changer, vous regardez avant de sauter." CR>)
	       (<VERB? CROSS>
		<TELL "Vous devrez trouver un pont." CR>)
	       (<AND <VERB? PUT> <EQUAL? ,PRSI ,PSEUDO-OBJECT>>
		<TELL
"Le " D ,PRSO " tombe hors de vue dans le gouffre." CR>
		<REMOVE ,PRSO>)>>

<ROUTINE TUNNEL-OBJECT ()
	 <COND (<AND <VERB? THROUGH> <GETPT ,HERE ,P?IN>>
		<DO-WALK ,P?IN> <RTRUE>)
	       (T <PATH-OBJECT>)>>

<ROUTINE STALA-PSEUDO ()
	 <COND (<VERB? TAKE MUNG>
		<TELL
"Les seuls que vous pouvez atteindre sont trop grands pour réussir à les rompre." CR>)>>

<ROUTINE MOSS-FCN ()
	 <COND (<VERB? TAKE RUB>
		<TELL
"Une partie de la mousse se frotte sur vous, mais elle cesse de briller très rapidement une fois arraché de son environnement." CR>)>>

<ROUTINE ROSE-BUSH-FCN ()
	 <COND (<VERB? TAKE>
		<TELL
"Tu piques ton doigt en essayant de prendre une rose, et tu sautes en colère." CR>)>>

<ROUTINE I-SPELL ()
	 <COND (<AND <NOT ,SPELL-HANDLED?> ,SPELL-VICTIM>
		<PERFORM ,V?DISENCHANT ,SPELL-VICTIM>)>
	 <SETG SPELL-HANDLED? <>>
	 <SETG WAND-ON <>>
	 <SETG SPELL-USED <>>
	 <SETG SPELL-VICTIM <>>>

<GLOBAL FANTASIES
	<LTABLE "tas de bijoux" "or lingot" "basilic"
		"poitrine bombée" "sphère jaune" "grue"
		"convention des sorciers" "copie de ZORK Je">>

^/L

;"special-cased routines"

<ROUTINE V-DIAGNOSE ()
	 <COND (,DEAD <TELL "Vous êtes mort.">)
	       (<EQUAL? ,SPELL? ,S-FERMENT>
		<TELL "Vous êtes ivre.">)
	       (<EQUAL? ,SPELL? ,S-FEEBLE>
		<TELL "Vous semblez inhabituellement faible en ce moment.">)
	       (<EQUAL? ,SPELL? ,S-FLOAT>
		<TELL "Vous semblez quelque peu lumière.">)
	       (<EQUAL? ,SPELL? ,S-FREEZE>
		<TELL "Vous êtes gelé raide.">)
	       (ELSE <TELL "Vous êtes en parfait santé.">)>
	 <CRLF>
	 <COND (<NOT <0? ,DEATHS>>
		<TELL "Vous avez été tué ">
		<COND (<1? ,DEATHS> <TELL "une fois.">)
		      (<EQUAL? ,DEATHS 2> <TELL "deux fois.">)
		      (T <TELL "un horrible lot.">)>
		<CRLF>)>>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
	 #DECL ((ASK?) <OR ATOM FALSE>)
	 <TELL "Score ">
	 <COND (.ASK? <TELL ": ">) (ELSE <TELL ": ">)>
	 <TELL N ,SCORE>
	 <TELL " sur 400, après ">
	 <TELL N ,MOVES>
	 <COND (<1? ,MOVES> <TELL " coup.">) (ELSE <TELL " coups.">)>
	 <CRLF>
	 <TELL "Ce score vous donne le rang de ">
	 <COND (<EQUAL? ,SCORE 400> <TELL "Maître Aventurier">
		<COND (<NOT ,WON-FLAG>
		       <TELL ", mais d'une manière ou d'une autre, vous ne vous sentez pas terminé">)>)
	       (<G? ,SCORE 360> <TELL "Assistant">)
	       (<G? ,SCORE 320> <TELL "Mas ter">)
	       (<G? ,SCORE 240> <TELL "Aventurier">)
	       (<G? ,SCORE 160> <TELL "Junior Aventurier">)
	       (<G? ,SCORE 80> <TELL "Aventurier novice">)
	       (<G? ,SCORE 40> <TELL "Amateur Aventurier">)
	       (T <TELL "Débutant">)>
	 <TELL "." CR>
	 ,SCORE>

<ROUTINE JIGS-UP ("OPTIONAL" (DESC <>) (PLAYER? <>))
 	 #DECL ((PLAYER?) <OR ATOM FALSE>)
 	 <COND (.DESC <TELL .DESC CR>)>
	 <COND (<NOT <EQUAL? ,ADVENTURER ,WINNER>>
		<TELL "
| **** Le " D ,WINNER "est mort **** | |">
		<REMOVE ,WINNER>
		<SETG WINNER ,ADVENTURER>
		<SETG HERE <LOC ,WINNER>>
		<RFATAL>)>
	 <PROG ()
	       <SCORE-UPD -10>
	       <TELL "| **** Vous êtes mort **** | |">
	       <SETG DEAD T>
		 <SETG SPELL? <>>
		 <PUTP ,ADVENTURER ,P?ACTION 0>
		 <SETG DEATHS <+ ,DEATHS 1>>
		 <MOVE ,WINNER ,HERE>
		 <TELL
"Je vais jeter un coup d'œil... vous méritez probablement une autre chance." CR CR>
		 <FCLEAR ,DEAD-PALANTIR-1 ,TOUCHBIT>
		 <FCLEAR ,DEAD-PALANTIR-2 ,TOUCHBIT>
		 <FCLEAR ,DEAD-PALANTIR-3 ,TOUCHBIT>
		 <RANDOMIZE-OBJECTS>
		 <GOTO ,DEAD-PALANTIR-1>
		 <SETG P-CONT <>>
		 <KILL-INTERRUPTS>
		 <RFATAL>>>

<ROUTINE RANDOMIZE-OBJECTS ("AUX" (R <>) F N L)
	 <COND (<IN? ,LAMP ,WINNER>
		<MOVE ,LAMP ,INSIDE-BARROW>)>
	 <SET N <FIRST? ,WINNER>>
	 <REPEAT ()
		 <SET F .N>
		 <COND (<NOT .F> <RETURN>)>
		 <SET N <NEXT? .F>>
		 <COND (<AND <EQUAL? .F ,BILLS ,PORTRAIT>
			     <OR <EQUAL? ,HERE ,VAULT ,DEPOSITORY ,OFFICE>
				 <EQUAL? ,HERE ,SMALL-ROOM>>>
			<MOVE .F ,HERE>)
		       (<OR <EQUAL? .F ,GOLD-KEY>
			    <EQUAL? .F ,CANDY>
			    <EQUAL? .F ,PALANTIR-1>
			    <EQUAL? .F ,PALANTIR-2>
			    <EQUAL? .F ,PALANTIR-3>>
			<MOVE .F ,CAROUSEL-ROOM>)
		       (<FSET? .F ,STAGGERED>
			<MOVE .F ,WIZARD-CASE>)
		       (ELSE
			<MOVE .F ,GAZEBO-ROOM>)>>>

<ROUTINE KILL-INTERRUPTS ()
	 <DISABLE <INT I-GNOME>>
	 <DISABLE <INT I-LEDGE>>
	 <DISABLE <INT I-NERVOUS>>
	 <DISABLE <INT I-ZGNOME-OUT>>
	 <DISABLE <INT I-ZGNOME>>
	 <DRAGON-LEAVES>
	 <DISABLE <INT I-MATCH>>
	 <RTRUE>>

<ROUTINE FIND-WEAPON (O "AUX" W)
	 <SET W <FIRST? .O>>
	 <COND (<NOT .W>
		<RFALSE>)>
	 <REPEAT ()
		 <COND (<EQUAL? .W ,SWORD>
			<RETURN .W>)
		       (<NOT <SET W <NEXT? .W>>> <RFALSE>)>>>

<ROUTINE BUCKET-CONT ()
	 <COND (<AND <VERB? TAKE> <NOT <IN? ,WINNER ,BUCKET>>>
	        <TELL "Vous devrez entrer dans le seau pour l'atteindre." CR>)>>
