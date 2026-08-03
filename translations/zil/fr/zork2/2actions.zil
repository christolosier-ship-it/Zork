"ACTIONS2 pour Zork II : Le Magicien de Frobozz
(c) Copyright 1981, 1983 Infocom, Inc. Tous droits réservés."

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
		       <TELL "Votre épée émet une faible lueur bleue."
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
"Vous êtes dans une vaste salle circulaire dont la haute voûte se perd dans l'obscurité. Huit passages identiques en partent." CR>
		<COND (<NOT ,CAROUSEL-FLIP-FLAG>
		       <TELL
"Un puissant vrombissement vous entoure et vous éprouvez ici une étrange désorientation." CR>)>
		<RTRUE>)
	       (<AND <NOT ,CAROUSEL-FLIP-FLAG>
		     <EQUAL? .RARG ,M-BEG>
		     <VERB? WALK>>
		<COND (<EQUAL? ,PRSO ,P?UP ,P?DOWN>
		       <RFALSE>)>
		<COND (<EQUAL? ,PRSO ,P?OUT>
		       <TELL
"Étourdi, vous choisissez une direction au hasard." CR CR>
		       <SETG PRSO ,P?EAST>)
		      (T
		       <TELL
"Vous ne parvenez plus à distinguer les directions ; cette salle est profondément désorientante." CR CR>)>
		<COND (<OR <EQUAL? ,PRSO ,P?WEST> <PROB 80>>
		       <SETG PRSO <GET ,EIGHT-DIRECTIONS <- <RANDOM 7> 1>>>)>
		<V-WALK>
		<RTRUE>)>>

<ROUTINE VIOLIN-FCN ()
	 <COND (<AND <VERB? PLAY>
		     <EQUAL? ,PRSO ,VIOLIN>>
	        <TELL
"Le violon produit un son d'une effroyable laideur." CR>)>>

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
		       <TELL "Le sac de toile est gonflé et ">
		       <COND (<FSET? ,RECEPTACLE ,OPENBIT>
			      <TELL
"il y a un " D ,BINF-FLAG " brûle dans le récipient.">)
			     (T
			      <TELL
"de la fumée s'échappe du récipient fermé.">)>)
		      (T
		       <TELL "Le sac de toile pend par-dessus le bord de la nacelle. En son centre est fixé un réceptacle métallique qui est ">
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
" Le ballon est amarré à un crochet par le fil métallique tressé." CR>)
		      (T
		       <TELL
" Un fil métallique tressé pend par-dessus le bord de la nacelle." CR>)>
		<RTRUE>)
	       (<EQUAL? .RARG ,M-OBJDESC>
		<TELL
"Une vaste nacelle d'osier, extrêmement lourde, se trouve ici. Un immense sac de toile ">
		<COND (,BINF-FLAG
		       <TELL
"fixé à la nacelle est gonflé. Un réceptacle métallique est arrimé au centre de la nacelle. ">
		       <COND (<FSET? ,RECEPTACLE ,OPENBIT>
			      <TELL "À l'intérieur brûle l'objet suivant : " D ,BINF-FLAG>)
			     (T
			      <TELL
"De la fumée s'échappe autour du couvercle fermé">)>)
		      (T
		       <TELL
"pend par-dessus le bord et reste solidement attaché à la nacelle. Un réceptacle métallique est fixé en son centre">)>
		<COND (,BTIE-FLAG
		       <TELL
". Un morceau de fil attaché à un crochet maintient le ballon en place." CR>)
		      (T
		       <TELL
". Un morceau de fil métallique tressé pend de la nacelle." CR>)>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<VERB? WALK>
		       <COND (<SET M <GETPT ,HERE ,PRSO>>
			      <COND (,BTIE-FLAG
				     <TELL "Vous êtes amarré à la corniche." CR>
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
"Vous ne pouvez pas diriger le ballon de cette manière." CR>
			      <RTRUE>)>)
		      (<AND <VERB? OPEN>
			    ,BINF-FLAG
			    <EQUAL? ,PRSO ,RECEPTACLE>
			    <FIRST? ,RECEPTACLE>>
		       <TELL "En l'ouvrant, vous découvrez l'objet en feu suivant : "
			     D ,BINF-FLAG "." CR>
		       <FSET ,RECEPTACLE ,OPENBIT>
		       <RTRUE>)
		      (<AND <VERB? TAKE>
			    <EQUAL? ,BINF-FLAG ,PRSO>>
		       <TELL "Vous ne souhaitez tout de même pas prendre cet objet en feu : "
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
		"Le sac de toile se gonfle à mesure qu'il se remplit d'air chaud." CR>
	       <COND (<NOT ,BLAB-FLAG>
		      <TELL
"Une petite étiquette tombe du sac dans la nacelle." CR>
		      <MOVE ,BALLOON-LABEL ,BALLOON>)>
	       <SETG BLAB-FLAG T>
	       <SETG BINF-FLAG ,PRSO>
	       <ENABLE <QUEUE I-BALLOON 3>>)>>

<ROUTINE PUT-BALLOON (THERE STR)
	#DECL ((THERE) OBJECT (STR) STRING)
	<COND (<EQUAL? ,HERE ,LEDGE-1 ,LEDGE-2 ,VOLCANO-BOTTOM>
	       <TELL "Sous vos yeux, le ballon " .STR CR>)>
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
"Le ballon s'élève majestueusement hors du volcan, révélant une vallée boisée d'une beauté à couper le souffle, traversée par une rivière et cernée de montagnes infranchissables. Une maison blanche se dresse dans une clairière. Des vents violents vous emportent alors vers les sommets enneigés. Oh non ! Vous vous écrasez contre les falaises acérées des monts Tête-Plate !">)
		     (<EQUAL? ,HERE ,LEDGE-1 ,LEDGE-2 ,VOLCANO-BOTTOM>
		      <TELL
"Vous regardez le ballon franchir le rebord du cratère et s'éloigner au gré du vent." CR>)>
	       <SETG BLOC ,VOLCANO-BOTTOM>)
	      (<SET R <LKP ,BLOC ,BALLOON-UPS>>
	       <COND (.IN
		      <TELL "Le ballon monte." CR CR>
		      <SETG BLOC .R>
		      <GOTO .R>)
		     (T
		      <PUT-BALLOON .R "monte lentement.">)>)
	      (<SET R <LKP ,BLOC ,BALLOON-FLOATS>>
	       <COND (.IN
		      <TELL "Le ballon quitte la corniche." CR CR>
		      <SETG BLOC .R>
		      <GOTO .R>)
		     (T
		      <ENABLE <QUEUE I-GNOME 10>>
		      <PUT-BALLOON .R
"dérive au loin. Délesté, il semble continuer à monter.">
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
			 <TELL "Le ballon a atterri." CR CR>
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
		 (T <PUT-BALLOON ,VOLCANO-BOTTOM "se pose lentement.">)>)
	   (<SET R <LKP ,BLOC ,BALLOON-DOWNS>>
	    <COND (.IN
		   <TELL "Le ballon descend." CR CR>
		   <SETG BLOC .R>
		   <GOTO .R>)
		  (T <PUT-BALLOON .R "descend lentement.">)>)>>

<ROUTINE BCONTENTS ()
	 <COND (<VERB? TAKE>
		<TELL
"Le " D ,PRSO " fait partie intégrante de la nacelle et ne peut en être retiré.">
		<COND (<EQUAL? ,PRSO ,BRAIDED-WIRE>
		       <TELL " Le fil pourrait toutefois servir à amarrer la nacelle.">)>
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
"Le " D ,PRSO " fait partie de la nacelle. Vous pouvez le manipuler à l'intérieur, mais pas le retirer." CR>)>>

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
		     (T <TELL "Le fil n'est attaché à rien." CR>)>)>>

<ROUTINE I-BURNUP ("AUX" (OBJ <FIRST? ,RECEPTACLE>))
    #DECL ((OBJ) OBJECT)
    <COND (<EQUAL? ,HERE ,BLOC>
	   <TELL
"Le " D .OBJ " s'est consumé, et le sac de toile commence à se dégonfler." CR>)>
    <REMOVE .OBJ>
    <SETG BINF-FLAG <>>
    T>

<ROUTINE SAFE-ROOM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Vous êtes dans une vieille salle poussiéreuse, sans rien de remarquable hormis une sortie au nord." CR>
		<COND (<NOT ,SAFE-FLAG>
		       <TELL
"Un coffre rouillé est encastré dans le mur opposé. Il paraît endommagé : un trou oblong a été taillé dans sa façade." CR>)
		      (T
		       <TELL
"Un coffre rouillé, dont la porte a été arrachée, est encastré dans le mur opposé." CR>)>)>>

<ROUTINE SAFE-FCN ()
	<COND (<AND <VERB? TAKE> <EQUAL? ,PRSO ,SAFE>>
	       <TELL "Le coffre est encastré dans le mur." CR>)
	      (<VERB? OPEN>
	       <COND (,SAFE-FLAG <TELL "Le coffre n'a plus de porte !" CR>)
		     (T <TELL "Le coffre est rouillé et refuse de s'ouvrir." CR>)>)
	      (<VERB? CLOSE>
	       <COND (,SAFE-FLAG <TELL "Le coffre n'a plus de porte !" CR>)
		     (T <TELL "Le coffre n'est pas ouvert !" CR>)>)>>

<ROUTINE BRICK-FCN ()
	 <COND (<VERB? BURN>
		<REMOVE ,BRICK>
		<JIGS-UP ,OTHER-PROPERTIES>)>>

<GLOBAL OTHER-PROPERTIES
"Cette fois, vous l'avez bien cherché. La brique ne se distingue pas seulement par son poids : elle possède aussi la faculté de vous pulvériser.">

<ROUTINE FUSE-FCN ()
	<COND (<OR <VERB? BURN>
		   <AND <VERB? LAMP-ON>
			<IN? ,MATCH ,WINNER>
			<FSET? ,MATCH ,ONBIT>>>
	       <TELL "Le cordon commence à brûler." CR>
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
			  "Le chemin est obstrué par les débris d'une explosion.">
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
		<TELL "Le cordon se consume rapidement jusqu'à disparaître." CR>)>
	 <REMOVE ,FUSE>>

<ROUTINE I-SAFE ()
	<COND (<EQUAL? ,HERE ,MUNGED-ROOM>
	       <JIGS-UP
"La salle tremble et cinq mille tonnes de roche s'abattent sur vous, vous réduisant à l'épaisseur d'une crêpe.">)
	      (<NOT ,DEAD>
	       <TELL
"Vous vous souvenez sans doute de la récente explosion. Elle est probablement à l'origine du grondement de mauvais augure que vous entendez, comme si une salle voisine venait de s'effondrer." CR>
	       <COND (<EQUAL? ,MUNGED-ROOM ,SAFE-ROOM>
		      <ENABLE <QUEUE I-LEDGE 8>>)>)>
	<MUNG-ROOM ,MUNGED-ROOM
		   "Le chemin est obstrué par les débris d'une explosion.">>

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
"Sans doute fragilisée par l'explosion, la corniche s'effondre et chute très loin en contrebas. Hélas, vous y étiez encore attaché.">)
			(T
			 <TELL
"La corniche s'effondre, ne vous laissant aucun endroit où atterrir." CR>)>)
		 (T
		  <JIGS-UP
"La récente explosion a provoqué l'effondrement de la corniche.">)>)
	  (<NOT ,DEAD>
	   <TELL "La corniche s'effondre. (Vous l'avez échappé belle !)" CR>)>
    <MUNG-ROOM .RM "La corniche s'est effondrée : impossible d'y atterrir.">>

<ROUTINE LEDGE-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
	   <TELL
"Vous êtes sur une large corniche, très haut dans le volcan. Le rebord du cratère se trouve environ deux cents pieds au-dessus ; en dessous, la paroi plonge à pic jusqu'au fond.">
	   <COND (<FSET? ,SAFE-ROOM ,RMUNGBIT>
		  <TELL " Des décombres obstruent le passage vers le sud." CR>)
		 (T <TELL " Une petite porte s'ouvre au sud." CR>)>)>>

;<ROUTINE BLAST () ;"APPARENTLY UNUSED?"
    <COND (<EQUAL? ,HERE ,SAFE-ROOM>)
	  (T
	   <TELL "Vous devez préciser comment procéder." CR>)>>

<ROUTINE I-GNOME ()
    <COND (<EQUAL? ,HERE ,LEDGE-1 ,LEDGE-2>
	   <TELL
"Un Gnome du volcan semble surgir tout droit du mur et ">
	   <COND (<IN? ,WAND ,WINNER>
		  <TELL
" puis, apercevant la baguette, y retourne aussitôt." CR>)
		 (T
		  <TELL
"déclare : « Mon emploi du temps est chargé et je n'ai guère de temps à perdre avec les intrus. Moyennant une petite rétribution, je vous montrerai toutefois la sortie. » Le gnome jette des regards nerveux à sa montre." CR>
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
"« Merci infiniment pour le " D ,PRSO ". Je crois n'en avoir jamais vu d'aussi belle. Suivez-moi. » Une porte apparaît alors à l'extrémité ouest de la corniche. Au-delà, une étroite cheminée plonge selon une pente abrupte. Le gnome s'y engage rapidement et disparaît de votre vue." CR>
		  <REMOVE ,PRSO>
		  <REMOVE ,GNOME>
		  <SETG GNOME-DOOR-FLAG T>)
		 (<BOMB? ,PRSO>
		  <MOVE ,BRICK ,HERE>
		  <REMOVE ,GNOME>
		  <DISABLE <INT I-GNOME>>
		  <DISABLE <INT I-NERVOUS>>
		  <TELL
"« Ce n'est vraiment pas ce que j'avais en tête », dit-il avant de disparaître." CR>)
		 (T
		  <REMOVE-CAREFULLY ,PRSO>
		  <TELL
"« Ce n'est pas exactement ce que j'avais en tête », dit-il en broyant le " D ,PRSO " dans ses mains dures comme le roc." CR>)>)
	  (T
	   <TELL
"Le gnome semble de plus en plus nerveux." CR>
	   <COND (<NOT ,GNOME-FLAG>
		  <ENABLE <QUEUE I-NERVOUS 5>>)>
	   <SETG GNOME-FLAG T>)>>

<ROUTINE I-NERVOUS ()
	 <COND (<IN? ,GNOME ,HERE>
		<TELL
"Le gnome consulte sa montre. « Oups ! Je suis en retard à un rendez-vous ! » Il disparaît, vous laissant seul sur la corniche." CR>)>
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
"Bien que morts, les Tête-Plate avaient prévu qu'un crétin tenterait un jour de profaner leurs restes. Ils ont donc pris leurs dispositions pour châtier pareil outrage.">)>>

<ROUTINE CRYPT-ANTEROOM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"L'antichambre est vaste et vide. Des bas-reliefs de marbre retracent les heures glorieuses des Tête-Plate et leur vie après la mort -- cette dernière avec un certain optimisme. La sortie mène à l'ouest. Une immense porte de marbre se dresse au sud. ">
		<COND (<FSET? ,CRYPT-DOOR ,OPENBIT>
		       <TELL "La porte est ouverte.">)
		      (T <TELL "La porte est fermée.">)>
		<TELL
" Au-dessus de la porte figure cette inscription énigmatique : « Touchez sans crainte »." CR>)>>

<ROUTINE CRYPT-ROOM-FCN (RARG "AUX" CLIT?)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<FCLEAR ,HERE ,ONBIT>
		<COND (<LIT? ,HERE>
		       <TELL
"Cette salle contient les dépouilles terrestres des puissants Tête-Plate : douze têtes -- assez plates, il faut l'avouer -- solidement fichées sur des piques. On pourrait s'attendre à y trouver des urnes funéraires ou d'autres témoignages des rites des anciens Zorkiens, mais rien de tel ne subsiste. Une inscription est gravée sur la crypte. L'unique sortie apparente mène au nord, par la porte de l'antichambre. Cette porte est ">
		       <COND (<FSET? ,CRYPT-DOOR ,OPENBIT>
			      <TELL "ouverte.">)
			     (T <TELL "fermée.">)>
		       <CRLF>
		       <COND (<NOT <FSET? ,DIM-DOOR ,INVISIBLE>>
			      <TELL
"En examinant attentivement le mur sud, vous distinguez le faible contour d'une porte secrète marquée de la lettre « F »." CR>)>)
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
"Il fait sombre, mais un faible rectangle se dessine sur le mur sud, comme si une lumière filtrait autour d'une porte. En son centre luit vaguement une lettre qui pourrait être un « F »." CR>
	 <FCLEAR ,DIM-DOOR ,INVISIBLE>>

<ROUTINE CRYPT-OBJECT ()
	 <COND (<VERB? OPEN> <TELL "La crypte est scellée pour toujours." CR>)
	       (<VERB? RUB> <TELL "Le marbre est froid." CR>)>>

<ROUTINE CRYPT-DOOR-FCN ()
	 <COND (<VERB? OPEN CLOSE>
		<OPEN-CLOSE ,PRSO
			    "La porte de la crypte s'ouvre en grinçant."
			    "La porte de la crypte se ferme en grinçant.">)>>

<ROUTINE TOMB-PSEUDO ()
	 <COND (<VERB? THROUGH>
		<DO-WALK ,P?EAST>
		T)>>

<GLOBAL DIM-DOOR-FLAG <>>

<ROUTINE DIM-DOOR-FCN ()
	 <COND (<VERB? KNOCK> <TELL "Seul un écho caverneux vous répond." CR>)
	       (<VERB? OPEN CLOSE>
		<COND (<VERB? OPEN> <SETG DIM-DOOR-FLAG T>)
		      (T <SETG DIM-DOOR-FLAG <>>)>
		<OPEN-CLOSE ,PRSO
			    "La porte secrète s'ouvre sans bruit."
			    "La porte secrète se ferme sans bruit.">)>>

<ROUTINE REPELLENT-FCN ()
	 <COND (<VERB? SHAKE>
		<COND (,SPRAY-USED? <TELL "La bombe aérosol semble vide." CR>)
		      (T <TELL "Un clapotis provient de l'intérieur." CR>)>)
	       (<AND <VERB? SPRAY PUT> <EQUAL? ,PRSO ,REPELLENT>>
		<COND (,SPRAY-USED?
		       <TELL
"Il ne reste plus de répulsif." CR>)
		      (<NOT ,PRSI>
		       <SETG SPRAY-USED? T>
		       <TELL
"Le produit dégage quelques instants une puanteur stupéfiante, puis se dissipe." CR>)
		      (T
		       <COND (<EQUAL? ,PRSI ,ME>
			      <ENABLE <QUEUE I-SPRAY 8>>
			      <SETG SPRAYED? T>)>
		       <SETG SPRAY-USED? T>
		       <TELL
"L'aérosol sent le mélange de vieilles chaussettes et de caoutchouc brûlé. Si j'étais une grue, je m'en tiendrais assurément éloignée !" CR>)>)>>

<GLOBAL SPRAY-USED? <>>

<ROUTINE I-SPRAY ()
	 <SETG SPRAYED? <>>
	 <TELL "Cette horrible odeur est beaucoup moins âcre maintenant." CR>>

<ROUTINE ZORK3-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Au-delà de la porte, un escalier grossièrement taillé descend dans les ténèbres. Le palier sur lequel vous vous tenez est couvert de runes magiques soigneusement tracées, semblables à celles griffonnées sur l'établi du Magicien de Frobozz. De puissantes lignes vertes les recouvrent et ondulent d'un côté à l'autre du palier.">
		<COND (<IN? ,WAND ,WINNER>
		       <TELL
"La baguette se met à vibrer au rythme des lignes mouvantes. Une force irrésistible vous attire vers le bas ; vous cédez et posez le pied sur l'escalier. À votre passage, les lignes vertes s'embrasent puis disparaissent dans un éclair, et vous dévalez les marches !| |Tout en bas s'étend une immense galerie baignée de lumière rouge. De sinistres statues gardent l'entrée d'une salle à peine visible au loin. Par votre courage et votre ruse, vous avez vaincu le Magicien de Frobozz et êtes devenu maître de son domaine. Mais l'ultime épreuve vous attend !| |(L'aventure s'achève dans « Zork III : Le Maître du Donjon ».)| |" CR>
		<SETG WON-FLAG T>
		<FINISH>)
		      (T
		       <JIGS-UP
"Les lignes vertes se mettent à vibrer dans votre direction, comme si elles cherchaient quelque chose. L'une après l'autre, vos possessions brillent d'un vert éclatant. Puis ces gardiennes magiques se ruent sur vous et vous anéantissent !">)>)>>

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
			     " et s'évapore aussitôt." CR>
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
		       <TELL "L'eau vous glisse entre les doigts." CR>)>)
	       (.PI? <TELL "Bien essayé." CR>)
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
		      <TELL "Le seau remonte, puis s'immobilise." CR CR>
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
"Le " D ,PRSO " est désormais bien plus grand que vous. Impossible de l'emporter." CR>)>)>>

<ROUTINE EATME-FCN ("AUX" F N)
    <COND (<AND <VERB? EAT>
		<EQUAL? ,PRSO ,EAT-ME-CAKE>
		<EQUAL? ,HERE ,TEA-ROOM>>
	   <TELL
"Soudain, la salle paraît devenue gigantesque -- bien que tout ce que vous transportez ait conservé sa taille normale." CR CR>
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
"Le gâteau est maintenant bien trop grand pour que vous puissiez lire l'inscription." CR>)
		     (,PRSI
		      <COND (<EQUAL? ,PRSI ,PALANTIR-1 ,PALANTIR-2 ,PALANTIR-3>
			     <PERFORM ,V?LOOK-INSIDE ,PRSI>)
			    (<EQUAL? ,PRSI ,FLASK>
			     <TELL "Les lettres, désormais visibles, indiquent \"">
			     <COND (<EQUAL? ,PRSO ,RED-ICING>
				    <TELL "Évaporer">)
				   (<EQUAL? ,PRSO ,ORANGE-ICING>
				    <TELL "Exploser">)
				   (T <TELL "Élargir">)>
			     <TELL "\"." CR>)
			    (T <TELL "Vous ne pouvez pas voir au travers !" CR>)>)
		     (T
		      <TELL
"La première lettre est un E majuscule. Les autres caractères sont trop petits pour être lus." CR>)>)
	      (<AND <VERB? EAT>
		    <EQUAL? ,HERE ,TEA-ROOM ,POSTS-ROOM ,POOL-ROOM>>
	       <COND (<EQUAL? ,PRSO ,ORANGE-ICING>
		      <REMOVE ,PRSO>
		      <ICEBOOM>)
		     (<EQUAL? ,PRSO ,RED-ICING>
		      <REMOVE ,PRSO>
		      <JIGS-UP
"C'était délicieux. Votre dernier souvenir est toutefois celui d'une soif atroce et d'une déshydratation mortelle.">)
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
"La salle semble soudain trop petite pour vous contenir. Ses murs étant moins compressibles que votre corps, c'est ce dernier qui cède." >)>)>)
	      (<AND <VERB? THROW PUT>
		    <EQUAL? ,PRSO ,ORANGE-ICING>
		    <EQUAL? ,HERE ,TEA-ROOM ,POSTS-ROOM ,POOL-ROOM>>
	       <REMOVE ,PRSO>
	       <ICEBOOM>)
	      (<AND <VERB? THROW PUT>
		    <EQUAL? ,PRSO ,RED-ICING ,BLUE-ICING ,ORANGE-ICING>
		    <EQUAL? ,PRSI ,POOL>>
	       <COND (<EQUAL? ,PRSO ,BLUE-ICING ,ORANGE-ICING>
		      <TELL "Le gâteau s'enfonce majestueusement dans le bassin." CR>
		      <REMOVE ,PRSO>
		      <RTRUE>)>
	       <MOVE ,PRSO ,HERE>
	       <REMOVE ,PRSI>
	       <TELL
"La majeure partie de la mare s'évapore, révélant un paquet de friandises rares -- légèrement humide, mais toujours précieux. Le gâteau rouge doit être particulièrement coriace : il est resté intact !" CR>
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
"       o  b  o|
   r                 z|
f    M A G I Q U E      z|
c       P U I T S      y|
   o                 n|
       m  p  a|
">
	       <FIXED-FONT-OFF>
	       <RTRUE>)>>

<ROUTINE BOTTOM-ETCHINGS-F ()
	<COND (<VERB? EXAMINE READ>
	       <FIXED-FONT-ON>
	       <TELL
"       o  b  o|
|
       A G I Q|
        U I T|
|
       m  p  a|
">
	       <FIXED-FONT-OFF>
	       <RTRUE>)>>

<ROUTINE CUBE-F ()
	<COND (<VERB? EXAMINE READ>
	       <FIXED-FONT-ON>
	       <TELL	
"              Banque de Zork|                   CHAMBRE FORTE|                    *722 GES*|       Compagnie des chambres fortes|              magiques Frobozz|">
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
"Vous devrez probablement entrer dans le bassin pour voir ce qui se cache sous la surface." CR>)
	       (<VERB? THROUGH>
		<JIGS-UP
"Vous entrez dans le bassin, vous débattez un bon moment, puis vous vous noyez. Triste, mais vrai.">)>>

<ROUTINE FLASK-FCN ()
	 <COND (<VERB? LOOK-INSIDE>
		<TELL
"Vous remarquez que les objets placés derrière le flacon paraissent grossis. Vous pourriez essayer de regarder quelque chose à travers lui." CR>)
	       (<AND <VERB? READ> <EQUAL? ,PRSI ,FLASK>>
		<TELL
"Le flacon déforme et agrandit le " D ,PRSO ", révélant des détails qui vous avaient échappé." CR>
		<RFALSE>)
	       (<VERB? OPEN>
		<MUNG-ROOM ,HERE "Des vapeurs nocives vous empêchent d'entrer.">
		<JIGS-UP ,FATAL-VAPORS>)
	       (<VERB? MUNG THROW>
		<TELL "Le flacon se brise en morceaux." CR>
		<REMOVE ,PRSO>
		<JIGS-UP ,FATAL-VAPORS>)>>

<GLOBAL FATAL-VAPORS
"En perdant connaissance, vous comprenez que les vapeurs du flacon sont mortelles.">

<ROUTINE PLEAK ()
    <COND (<VERB? TAKE>
	   <TELL <PICK-ONE ,YUKS> CR>)
	  (<VERB? PLUG>
	   <TELL "La fuite est trop haute pour que vous puissiez l'atteindre." CR>)>>

<ROUTINE ICEBOOM ()
    <MUNG-ROOM ,HERE
"L'entrée est obstruée par des décombres orange et collants. Sans doute un aventurier imprudent s'est-il amusé avec des gâteaux explosifs.">
    <JIGS-UP
"Vous avez été réduit en miettes -- où qu'elles puissent bien se trouver.">>

<ROUTINE MAGNET-ROOM-FCN (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	       <TELL
"Vous êtes dans une salle circulaire au plafond bas. Des sorties mènent à l'est et au sud-est." CR>)
	      (<AND <EQUAL? .RARG ,M-ENTER>
		    ,CAROUSEL-FLIP-FLAG>
	       <COND (,CAROUSEL-ZOOM-FLAG
		      <JIGS-UP <COND (<EQUAL? ,ADVENTURER ,WINNER>
"D'après le professeur TAA de l'Institut technologique du GES, les rapides variations du champ magnétique de cette salle suffisent à vous électrocuter. Je ne saurais le confirmer, mais quoi qu'il en soit, quelque chose vient de vous tuer." )
				     (T
"D'après le professeur TAA de l'Institut technologique du GES, les champs magnétiques de cette salle sont assez intenses pour griller les délicats circuits internes du robot. Je n'en sais rien, mais de la fumée s'échappe de ses oreilles et il ne bouge plus.")>>)
		     (<EQUAL? ,WINNER ,ADVENTURER>
		      <TELL
"Lorsque vous entrez, votre boussole se met à tourner à toute allure." CR>
		      <COND (<NOT ,COMPASS-KLUDGE>
			     <TELL
"Quelle boussole ? Celle qui vous permet d'indiquer les points cardinaux pour vous déplacer.">
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
	       <TELL "Vous ne pouvez pas aller par là." CR>
	       <RFALSE>)>>

<GLOBAL CAROUSEL-ZOOM-FLAG <>>

<GLOBAL CAROUSEL-FLIP-FLAG <>>

<ROUTINE BUTTONS ()
	<COND (<VERB? PUSH>
	       <COND (<EQUAL? ,WINNER ,ADVENTURER>
		      <JIGS-UP
"Une gigantesque étincelle jaillit et vous carbonise.">)
		     (<EQUAL? ,PRSO ,SQUARE-BUTTON>
		      <COND (,CAROUSEL-ZOOM-FLAG
			     <TELL "Rien ne semble se produire." CR>)
			    (ELSE
			     <SETG CAROUSEL-ZOOM-FLAG T>
			     <TELL "Le vrombissement s'intensifie." CR>)>)
		     (<EQUAL? ,PRSO ,ROUND-BUTTON>
		      <COND (,CAROUSEL-ZOOM-FLAG
			     <SETG CAROUSEL-ZOOM-FLAG <>>
			     <TELL "Le vrombissement faiblit." CR>)
			    (T
			     <TELL "Rien ne semble se produire." CR>)>)
		     (<EQUAL? ,PRSO ,TRIANGULAR-BUTTON>
		      <SETG CAROUSEL-FLIP-FLAG <NOT ,CAROUSEL-FLIP-FLAG>>
		      <COND (<IN? ,IRON-BOX ,CAROUSEL-ROOM>
			     <TELL
"Un bruit sourd retentit au loin." CR>
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
"Au moment où vous tendez la main vers la sphère, une cage en acier massif tombe du plafond et vous emprisonne. Comme si cela ne suffisait pas, un gaz toxique commence à envahir la salle." CR CR>
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
"Au moment où le robot tend la main vers la sphère, une cage en acier massif tombe du plafond et l'emprisonne. Vous percevez à peine ses dernières paroles : « Vrrr, bzzz, clic ! » Un nuage de fumée s'élevant sous la cage confirme vos craintes quant au sort de votre courageux compagnon mécanique.">
	       T)
	      (<VERB? LOOK-INSIDE EXAMINE>
	       <PALANTIR>)>>

<ROUTINE I-SPHERE ()
	 <COND (<EQUAL? ,HERE ,CAGE-ROOM ,IN-CAGE>
		<FSET ,PALANTIR-1 ,INVISIBLE>
		<MUNG-ROOM ,CAGE-ROOM
"Un nuage de gaz toxique vous barre le passage.">
		<JIGS-UP
"Le temps passe... puis vous succombez à un mystérieux empoisonnement.">)>>

<ROUTINE IN-CAGE-FCN (RARG)
    <COND (,CAGE-SOLVE-FLAG <SETG HERE ,CAGE-ROOM>)>>

<ROUTINE ROBOT-FCN ("OPTIONAL" (RARG ,M-OBJECT))
	<COND (<EQUAL? ,WINNER ,ROBOT>
	       <COND (<VERB? SGIVE> <RFALSE>)
		     (<VERB? FOLLOW>
		      <TELL
"« Mes circuits mémoriels ne sont pas si perfectionnés. Je peux néanmoins me déplacer sur ordre. »" CR>)
		     (<AND <VERB? RAISE TAKE MOVE> <EQUAL? ,PRSO ,CAGE>>
		      <TELL
"La cage tremble, puis traverse la salle en volant. Difficile d'en être certain, mais le robot paraît sourire." CR CR>
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
"« Je regrette, mais cela s'avère difficile pour un être dépourvu de bouche. »" CR>)>
		      <RTRUE>)
		     (<AND <PROB 2>
			   <EQUAL? <META-LOC ,ADVENTURER> ,HERE>>
		      <TELL
"« Bzzz ! Bzzz ! Bzzz ! Mes circuits commencent à rouiller. Réessayez. »" CR>)
		     (<VERB? READ EXAMINE>
		      <COND (<EQUAL? <META-LOC ,ADVENTURER> ,HERE>
			     <TELL
"« Mon acuité visuelle est insuffisante pour cela. »" CR>)>
		      <RTRUE>)
		     (<VERB? DROP PUT THROW>
		      <COND (<NOT <EQUAL? <META-LOC ,ADVENTURER> ,HERE>>
			     <RFALSE>)
			    (<IN? ,PRSO ,ROBOT>
			     <TELL "« Vrrr, bzzz, clic ! »" CR>
			     <RFALSE>)
			    (T
			     <TELL
"« Clic ! Je ne possède pas cet objet. Bzzz ! Vrrr ! »" CR>)>)
		     (<OR <VERB? WALK>
			  <AND <VERB? TAKE PUSH TURN>
			       <NOT <FSET? ,PRSO ,ACTORBIT>>>>
		      <COND (<NOT <EQUAL? <META-LOC ,ADVENTURER> ,HERE>>
			     <RFALSE>)
			    (<PROB 80>
			     <TELL "« Vrrr, bzzz, clic ! »" CR>)
			    (T
			     <TELL "« Bzzz, clic, vrrr ! »" CR>)>
		      <RFALSE>)
		     (T
		      <COND (<EQUAL? <META-LOC ,ADVENTURER> ,HERE>
			     <TELL
"« Ma programmation ne me permet pas d'accomplir cette tâche. »" CR>)>
		      <RTRUE>)>)
	      (<VERB? OPEN LOOK-INSIDE CLOSE>
	       <TELL "Il n'y a pas de panneau d'accès ni de porte sur le robot." CR>)
	      (<AND <VERB? GIVE>
		    <EQUAL? ,PRSI ,ROBOT>>
	       <MOVE ,PRSO ,ROBOT>
	       <TELL "Le robot accepte volontiers l'objet nommé « "
		     D ,PRSO
		     " » et incline en remerciement son appendice en forme de tête." CR>)
	      (<VERB? THROW MUNG>
	       <TELL
"Le robot tombe au sol et, sa fabrication laissant à désirer, se désintègre sous vos yeux." CR>
	       <REMOVE <COND (<VERB? THROW> ,PRSI) (,PRSO)>>)>>

\

;"SUBTITLE BANK OF ZORK"

<GLOBAL BANK-SOLVE-FLAG <>>

<ROUTINE BILLS-OBJECT ()
	<SETG BANK-SOLVE-FLAG T>
	<COND (<VERB? BURN>
	       <TELL "Rien de tel que d'avoir de l'argent à brûler !" CR>
	       <RFALSE>)
	      (<VERB? EAT>
	       <TELL "Voilà ce qui s'appelle manger riche !" CR>)>>
	
<ROUTINE BKLEAVEE ("OPTIONAL" (RM ,TELLER-EAST))
    #DECL ((RM) OBJECT)
    <COND (<OR <HELD? ,BILLS> <HELD? ,PORTRAIT>>
	   <TELL
"Une alarme retentit brièvement, puis une force invisible vous barre le passage." CR>
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
	   <TELL "Vous êtes dans une petite salle autrefois utilisée par le préposé chargé d'apporter les coffres de dépôt aux clients. Sur le mur nord, un panneau indique \"Salle de consultation\". Du côté ">
	   <COND (<EQUAL? ,HERE ,TELLER-WEST> <TELL "ouest">)
		 (T <TELL "est">)>
	   <TELL " de la salle, au-dessus d'une porte ouverte, un panneau indique :|
|
          RÉSERVÉ AU PERSONNEL|
          DE LA BANQUE|
" CR>)>>

<ROUTINE SCOL-OBJECT ("OPTIONAL" (OBJ <>))
    <COND (<VERB? PUSH MOVE TAKE RUB>
	   <TELL "Lorsque vous essayez, votre main semble passer au travers." CR>)
	  (<AND <VERB? ATTACK> ,PRSI>
	   <TELL "Le " D ,PRSI " passe au travers." CR>)
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
	   <TELL "Le rideau pâlit légèrement tandis que l'objet désigné -- "
		 D .OBJ " -- le traverse." CR>
	   <SETG SCOL-ROOM <>>
	   T)>>

<ROUTINE SCOL-THROUGH (CINT RM)
    #DECL ((CINT) FIX (RM) OBJECT)
    <ENABLE <QUEUE I-CURTAIN .CINT>>
    <TELL "Vous vous sentez quelque peu désorienté en passant au travers..." CR CR>
    <GOTO .RM>>

<GLOBAL SCOL-ACTIVE <>>

<ROUTINE I-CURTAIN ()
    <SETG SCOL-ACTIVE <>>
    <COND (<EQUAL? ,HERE ,VAULT>
	   <JIGS-UP
"Une voix métallique annonce : « Bonjour, intrus ! Votre présence non autorisée dans la chambre forte de la Banque de Zork a déclenché toutes sortes de mauvaises surprises, dont la plupart sont mortelles. Ce message vous est offert par la Compagnie des chambres fortes magiques Frobozz. »">)
	  (<EQUAL? ,HERE ,VIEWING-EAST ,VIEWING-WEST ,SMALL-ROOM>
	   <TELL "Une voix lointaine annonce : « Porte-rideau fermée. »" CR>
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
"Un Gnome de Zurich au sexe indéterminé, vêtu d'un costume trois-pièces et portant un coffre de dépôt, se matérialise dans la salle.">
		<COND (<IN? ,WAND ,WINNER>
		       <TELL
" Il remarque la baguette et se dématérialise rapidement." CR>)
		      (T
		       <TELL " « Vous semblez avoir oublié de déposer vos objets de valeur », dit-il en tapotant nerveusement le couvercle du coffre. « Nous n'autorisons normalement pas nos clients à utiliser les coffres ici, mais j'imagine que nous pouvons faire UNE exception... » Il vous dévisage par-dessus ses petites lunettes cerclées de métal." CR>
		       <MOVE ,GNOME-OF-ZURICH ,HERE>)>)>>

<ROUTINE BOX-F ()
	 <TELL "Le gnome le serre jalousement contre lui." CR>>

<ROUTINE ZGNOME-FCN ()
    <COND (<VERB? TELL>
	   <SETG P-CONT <>>
	   <SETG QUOTE-FLAG <>>
	   <TELL
"Le gnome semble de plus en plus impatient." CR>)
	  (<AND <VERB? GIVE THROW> <EQUAL? ,PRSI ,GNOME-OF-ZURICH>>
	   <COND (<GETPT ,PRSO ,P?VALUE>
		  <TELL
"Le gnome dépose soigneusement l'objet suivant -- " D ,PRSO  " -- dans le coffre de dépôt. « Laissez-moi vous raccompagner », dit-il, faisant clairement comprendre qu'il sera ravi de vous voir partir. Vous perdez un instant vos repères et, lorsque vos esprits vous reviennent, vous êtes de nouveau à l'entrée de la banque." CR>
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
"« Vous êtes beaucoup trop généreux. Je ne peux vraiment pas accepter. » Il disparaît, un sourire ironique aux lèvres." CR>)
		 (T
		  <TELL
"« Je ne mettrais certainement pas ÇA dans un coffre de dépôt », remarque le gnome avec dédain. Il le lance par-dessus son épaule, où l'objet disparaît dans un discret « pop »." CR>
		  <REMOVE-CAREFULLY ,PRSO>
		  <RTRUE>)>)
	  (<VERB? ATTACK>
	   <TELL
"« Eh bien, je n'ai jamais... » s'offusque le gnome avant de disparaître d'un claquement de doigts, vous laissant seul." CR>
	   <REMOVE ,GNOME-OF-ZURICH>
	   <DISABLE <INT I-ZGNOME-OUT>>)
	  (T
	   <TELL
"Le gnome semble de plus en plus impatient." CR>)>>

<ROUTINE I-ZGNOME-OUT ()
         <REMOVE ,GNOME-OF-ZURICH>
	 <COND (<EQUAL? ,HERE ,SMALL-ROOM>
		<TELL
"Le gnome s'impatiente. « Un autre client m'attend peut-être ; vous devrez vous débrouiller seul, j'en ai peur. » Il disparaît et vous laisse livré à vous-même." CR>)>>

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
"Cette minuscule salle a été creusée dans la paroi du ravin. Une escalade périlleuse permet d'en descendre. ">
	   <P-DOOR "nord" ,LID-1 ,KEYHOLE-1>
	   <RTRUE>)
	  (<NOT <VERB? LOOK>> <PCHECK> <RFALSE>)>>

<ROUTINE DREARY-ROOM-FCN (RARG)
    #DECL ((RARG) <OR FIX FALSE>)
    <COND (<EQUAL? .RARG ,M-LOOK>
	   <TELL
"C'est une petite salle plutôt morne, éclairée de façon inquiétante par une lueur rouge qui s'échappe d'une fissure. La lumière tombe sur une table de bois poussiéreuse au centre de la pièce. ">
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
	<TELL "Du côté "
	      .STR
	      " de la salle se dresse une porte massive en bois, percée d'une petite fenêtre à barreaux. Un redoutable verrou est encastré dans le chambranle. Un trou de serrure ">
	<COND (<NOT <FSET? .LID ,OPENBIT>>
	       <TELL "recouvert par un mince couvercle métallique ">)>
	<TELL "se trouve à l'intérieur de la serrure.">
	<COND (<SET F <FIRST? .KEYHOLE>>
	       <TELL " A " D .F
		     " est en place dans le trou de la serrure.">)>
	<COND (,MUD-FLAG
	       <TELL " Le bord d'un set de table est visible sous la porte.">
	       <COND (,MATOBJ
		      <TELL " Sur le set de table repose un " D ,MATOBJ ".">)>)>
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
"Un faible bruit provient de derrière la porte, tandis qu'un petit nuage de poussière s'élève sous celle-ci." CR>
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
"Une forme brumeuse flotte dans la sphère. Peut-être devriez-vous regarder à l'intérieur..." CR>)
	       (<AND <VERB? TAKE> <==? ,PRSO ,PALANTIR-3>>
		<PUTP ,PRSO ,P?LDESC <>>
		<RFALSE>)>>

<ROUTINE DEAD-PALANTIR (RARG "AUX" P)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Vous êtes dans une immense sphère cristalline emplie d'une fine brume "
		<COND (<EQUAL? ,HERE ,DEAD-PALANTIR-1>
		       <SET P ,PALANTIR-1>
		       "rouge")
		      (<EQUAL? ,HERE ,DEAD-PALANTIR-2>
		       <SET P ,PALANTIR-2>
		       "bleue")
		      (T <SET P ,PALANTIR-3> "blanche")>
". La brume devient "
		<COND (<EQUAL? ,HERE ,DEAD-PALANTIR-1> "bleue")
		      (<EQUAL? ,HERE ,DEAD-PALANTIR-2> "blanche")
		      (T "noire")>
" vers l'ouest." CR>
		<TELL "Vous vous efforcez de regarder à travers la brume... " CR>
		<COND (<FSET? .P ,TOUCHBIT>
		       <PALANTIR-LOOK .P T>)
		      (<EQUAL? .P ,PALANTIR-1>
		       <TELL
"Vous apercevez une petite salle et un panneau au mur, mais l'image est trop floue pour le lire." CR>)
		      (<EQUAL? .P ,PALANTIR-2>
		       <TELL
"Vous contemplez une vaste salle morne, occupée par une porte monumentale et une table gigantesque. Une étrange lueur baigne la brume." CR>)
		      (<EQUAL? .P ,PALANTIR-3>
		       <TELL
"On distingue à peine une étrange salle aux contours flous.">
		       <COND (<AND <IN? ,SERPENT ,AQUARIUM> <PROB 25>>
			      <TELL
" Une étrange ombre sinueuse traverse la brume alors que vous regardez.">)>
		       <CRLF>)>
		<RTRUE>)
	       (<AND <EQUAL? .RARG ,M-ENTER> <EQUAL? ,HERE ,DEAD-PALANTIR-4>>
		<TELL
"Vous suivez un couloir de brume noire jusqu'à une salle sphérique aux parois noires.">
		<COND (<IN? ,GENIE ,PENTAGRAM-ROOM>
		       <TELL
" La salle est vide. De l'extérieur, un visage immense vous contemple et éclate d'un rire sardonique. Vous ne semblez pas près de vous tirer de ce mauvais pas !" CR>
		       <FINISH>)>
		<TELL
" À votre arrivée, un visage immense et terrifiant se matérialise dans la brume.| |« Qu'est-ce qui vous amène troubler ma captivité, voyageur ? » demande-t-il. Faute de réponse immédiate, il vous examine un instant." CR>

		<COND (<NOT <L? ,DEATHS 3>>
		       <TELL
"« Encore vous ! Cela devient lassant. De toute évidence, vous ne me serez jamais d'une grande aide. Bonne chance pour la prochaine fois, ô merveilleux aventurier. » Le visage disparaît et tout devient noir." CR>
		       <FINISH>)
		      (T
		       <TELL
"« Peut-être pourrez-vous m'aider à recouvrer ma liberté. Retournez donc à votre quête insensée ! Cette fois, je vous épargne. Puissiez-vous un jour me rendre la pareille. » Le visage disparaît et la brume se met à tourbillonner. Lorsqu'elle se dissipe, vous êtes revenu dans le monde des vivants." CR>
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
"Tandis que vous contemplez la sphère, une étrange vision prend forme : un visage immense et terrifiant, aux yeux jaunes, vous observe dans l'attente." CR>
		<RTRUE>)>
	 <SET RM <ROOM? .OBJ>>
	 <COND (<OR <NOT .RM> <NOT <LIT? .RM>>>
		<TELL "Vous ne voyez que l'obscurité." CR>)
	       (<OR <IN? .OBJ .RM> <SEE-INSIDE? <LOC .OBJ>>>
		<SET OHERE ,HERE>
		<COND (.INSIDE?
		       <TELL
"À travers la brume se dessine une vision aux couleurs étranges : une salle immense..." CR CR>)
		      (T
		       <TELL
"Tandis que vous contemplez la sphère, la vision d'une salle lointaine se précise peu à peu..." CR CR>)>
		<FSET .OBJ ,INVISIBLE>
		<GO&LOOK .RM>
		<COND (<EQUAL? .OHERE .RM>
		       <TELL
"Un aventurier éberlué contemple une sphère de cristal." CR>)>
		<FCLEAR .OBJ ,INVISIBLE>
		<COND (<NOT .INSIDE?>
		       <TELL
"La vision s'efface, ne laissant voir qu'une banale sphère de cristal." CR>)>)
	       (T
		<TELL "Vous ne voyez que l'obscurité." CR>)>
	 T>

<ROUTINE PWINDOW-FCN ()
    <COND (<VERB? LOOK-INSIDE>
	   <SETG PLOOK-FLAG T>
	   <COND (<FSET? ,PDOOR ,OPENBIT>
		  <TELL "La porte est ouverte, imbécile." CR>)
		 (<EQUAL? ,HERE ,DREARY-ROOM>
		  <GO&LOOK ,TINY-ROOM>)
		 (T <GO&LOOK ,DREARY-ROOM>)>)
	  (<VERB? THROUGH>
	   <TELL "Peut-être si vous étiez découpé en dés..." CR>)>>

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
"Le papier est minuscule et disparaît sous la porte." CR>
		  <MOVE ,PRSO <COND (<EQUAL? ,HERE ,TINY-ROOM> ,DREARY-ROOM)
				    (T ,TINY-ROOM)>>)
		 (<EQUAL? ,PRSO ,NEWSPAPER>
		  <TELL
"Le journal se froisse et ne passe pas sous la porte." CR>)>)
	  (<VERB? OPEN CLOSE>
	   <COND (,PUNLOCK-FLAG
		  <OPEN-CLOSE ,PRSO
		       "La porte est maintenant ouverte."
		       "La porte est maintenant fermée.">)
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
		 " s'en détache et tombe au sol." CR>
	   <SETG MATOBJ <>>
	   <SETG MUD-FLAG <>>
	   <RTRUE>)>>

<ROUTINE WISH-FCN ()
	 <COND (<VERB? MAKE>
	        <COND (<AND <EQUAL? ,HERE ,WELL-BOTTOM>
			    <IN? ,COIN ,HERE>>
		       <TELL
"Une voix chuchote : « L'eau fait monter le seau. » Malheureusement, votre voeu fait disparaître la pièce..." CR>
		      <REMOVE ,COIN>)
		      (T
		       <TELL "Personne n'écoute." CR>)>)>>

<ROUTINE WELL-FCN ()
    	<COND (<AND <FSET? ,PRSO ,TAKEBIT> <VERB? THROW PUT DROP>>
	       <TELL "Le " D ,PRSO
		     " repose désormais au fond du puits." CR>
	       <MOVE ,PRSO ,WELL-BOTTOM>)
	      (<VERB? CLIMB-UP CLIMB-DOWN CLIMB-FOO>
	       <TELL "Vous ne pouvez pas escalader les parois du puits." CR>)>>

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
		<TELL "L'allumette est éteinte." CR>
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
		       <TELL "Aucune allumette ne brûle.">)>
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
		       <TELL "La lampe s'est consumée.">)
		      (<FSET? ,LAMP ,ONBIT>
		       <TELL "La lampe est allumée.">)
		      (T
		       <TELL "La lampe est maintenant éteinte.">)>
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
"Il vous faudrait une meilleure lumière que celle du " D .OBJ "." CR>)
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
		<TELL "Cette salle est entièrement nue. Dans l'angle nord-ouest, une issue descend vers le bas. À l'est se dresse une grande porte de pierre ">
		<COND (<FSET? ,RIDDLE-DOOR ,OPENBIT>
		       <TELL "ouverte">)
		      (T <TELL "fermée">)>
		<TELL ". Au-dessus sont gravés ces mots : \"Nul ne franchira cette porte sans résoudre l'énigme :|
|
    Qu'est-ce qui est haut comme une maison,|
      rond comme une coupe,|
        et que tous les chevaux du roi|
          ne sauraient faire remonter ?\"|
">)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<VERB? ANSWER SAY>
		       <COND (<FSET? ,RIDDLE-DOOR ,OPENBIT>
			      <RFALSE>)
			     (<OR <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?WELL>
				  <EQUAL? <GET ,P-LEXV <+ ,P-CONT 2>> ,W?WELL>>
			      <TELL
"Un coup de tonnerre assourdissant retentit ; la porte de pierre pivote silencieusement et découvre un passage." CR>
			      <SCORE-UPD 5>
			      <FSET ,RIDDLE-DOOR ,OPENBIT>)
			     (T
			      <TELL
"Un rire caverneux semble provenir de la porte de pierre." CR>)>
		      <SETG P-CONT <>>
		      <SETG QUOTE-FLAG <>>
		      <RTRUE>)>)>>

<ROUTINE RIDDLE-DOOR-FCN ()
	 <COND (<VERB? OPEN>
		<COND (<FSET? ,RIDDLE-DOOR ,OPENBIT>
		       <TELL "Elle est ouverte !" CR>)
		      (T
		       <TELL
"La porte ne peut s'ouvrir qu'en résolvant l'énigme." CR>)>)
	       (<VERB? CLOSE>
		<COND (<FSET? ,RIDDLE-DOOR ,OPENBIT>
		       <TELL "Impossible : la porte pèse plusieurs tonnes." CR>)
		      (T
		       <TELL "Elle est fermée !" CR>)>)>>

<GLOBAL DUMMY
	<LTABLE "Regardez autour de vous."
	       "Vous pensez que non ?"
	       "Il me semble que vous l'avez déjà fait.">>

<ROUTINE RIDDLE-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL "Utilisez la commande « OBSERVER »." CR>)>>

<ROUTINE MAGIC-ACTOR ("AUX" V)
	 <COND (,SPELL?
		<COND (<EQUAL? ,SPELL? ,S-FALL>
		       <COND (<OR <VERB? CLIMB-UP CLIMB-DOWN CROSS>
				  <AND <VERB? WALK>
				       <GETPT ,HERE ,P?DOWN>>>
			      <SET V <GETPT ,HERE ,P?GLOBAL>>
			      <COND (<ZMEMQB ,BRIDGE .V <PTSIZE .V>>
				     <JIGS-UP
"Vous vous sentez attiré vers le bord du pont et vous penchez pour regarder en contrebas. Oups, quelle maladresse ! Vous trébuchez sur quelque chose et basculez dans le vide. Dommage.">)
				    (<PROB 25>
				     <JIGS-UP
"Pour une raison mystérieuse, vous avez trébuché sur vos propres pieds -- ou peut-être sur un cordon invisible tendu en travers du chemin. La chute vous est fatale.">)
				   (T
				    <TELL
"Vous venez de trébucher sur un cordon invisible -- ou peut-être sur vos propres pieds. Ce doit être votre jour de chance : vous retrouvez l'équilibre avant qu'une chute potentiellement mortelle ne vous emporte." CR>)>)
			     (<VERB? BOARD>
			      <TELL
"Vous entrez dans le " D ,PRSO " mais vous en retombez aussitôt, comme si une main invisible l'avait renversé." CR>)>)
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
"Vous ne pouvez pas l'atteindre : cet objet est au sol." CR>)>)
		      (<EQUAL? ,SPELL? ,S-FREEZE>
		       <COND (<VERB? DIAGNOSE WAIT> <RFALSE>)
			     (T
			      <TELL
"Vous êtes entièrement gelé. Autant attendre que cela passe : dans cet état, vous ne pouvez rien faire d'autre." CR>)>)
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
"Oups, vous semblez quelque peu chancelant... Je ne suis pas certain que vous soyez arrivé là où vous le souhaitiez." CR CR>
		       <RANDOM-WALK>)
		      (<AND <EQUAL? ,SPELL? ,S-FEAR>
			    <SET V <INFESTED? ,HERE>>>
		       <TELL
"Soudain, la peur vous submerge ! Un " D .V " est ici !
Cette créature est peut-être à vos trousses ! ">
		       <COND (<FSET? <LOC ,WINNER> ,VEHBIT>
			      <TELL
"Vous vous blottissez dans un coin, terrifié." CR>)
			     (T
			      <TELL
"Vous fuyez la salle en hurlant de terreur !" CR CR>
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
"Une fureur irrésistible vous pousse à attaquer le "
D .V " à la place." CR>
	 <PERFORM ,V?ATTACK .V .W>>

\

"SOUS-TITRE : LABYRINTHE DE DIAMANT"

<GLOBAL DIAMOND-SOLVE <>> ;"T if solved"

<GLOBAL DIAMOND-COUNT 0>  ;"count of current progress"
<GLOBAL DIAMOND-MOVES 0>  ;"count of moves since progressed"
<GLOBAL DIAMOND-BASE 0>	  ;"count of maximum progress ever"

<GLOBAL DWDESCS
	<TABLE "sombre"
	       "vacillant faiblement"
	       "faiblement lumineux"
	       "lumineux"
	       "rayonnant vivement">>

<ROUTINE DWINDOW-DESC ()
	 <TELL
"Au sol se trouve une très petite fenêtre en forme de losange qui est ">
	 <COND (,DIAMOND-SOLVE <TELL "rayonnant paisiblement">)
	       (T <TELL <GET ,DWDESCS ,DIAMOND-COUNT>>)>
	 <TELL "." CR>>

<ROUTINE DWINDOW-FCN ()
	 <COND (<VERB? TAKE>
		<TELL
"La fenêtre fait partie intégrante du sol." CR>)
	       (<VERB? MUNG>
		<TELL
"La fenêtre, dure comme le diamant, est incassable." CR>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<DWINDOW-DESC>)>>

<ROUTINE DIAMOND-MOTION (RARG "AUX" DC DIR RM)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Cette salle aux murs étrangement inclinés est percée de passages dans toutes les directions. Les parois sont faites d'une matière vitreuse." CR>
		<COND (<EQUAL? ,HERE ,DIAMOND-5>
		       <TELL
"Un escalier de marbre monte vers les hauteurs.">
		       <COND (,DIAMOND-SOLVE
			      <TELL
" Le sol a basculé au pied de l'escalier, révélant un passage secret qui plonge dans des ténèbres absolues.">)>
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
"Un étrange grincement rouillé résonne au loin." CR>
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
"Vous ne pouvez pas aller dans cette direction." CR>
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
"Tandis que vous vous débattez dans le labyrinthe, la voix réjouie du Magicien vous nargue : « Imbécile ! Vous ne franchirez jamais ">
		<TELL <GET ,BASES ,DIAMOND-BASE>>
		<TELL " base à ce rythme ! »" CR>)>
	 <GOTO <GET ,DIAMOND-ROOMS <+ 3 <RANDOM 5>>>>>

<GLOBAL BASES <TABLE "première" "première" "première" "deuxième" "troisième" "dernière">>

<GLOBAL DIAMOND-ROOMS
	<TABLE DIAMOND-2 DIAMOND-4 DIAMOND-6 DIAMOND-8
	       DIAMOND-1 DIAMOND-3 DIAMOND-5 DIAMOND-7 DIAMOND-9>>

<GLOBAL DIDIRS <TABLE P?SE P?NE P?NW P?SW>>

\

"SOUS-TITRE : CERBÈRE"

<GLOBAL CERBERUS-LEASHED <>>

<ROUTINE CERBERUS-FCN ()
	 <COND (<AND <VERB? WAVE RUB RAISE> <EQUAL? ,PRSO ,WAND>>
		<TELL "Le chien a l'air perplexe." CR>
		<RFALSE>)
	       (<AND ,WAND-ON <VERB? SAY INCANT>> <RFALSE>)
	       (<HELLO? ,CERBERUS>
		<COND (,CERBERUS-LEASHED <TELL "« Ouaf ! Ouaf ! Ouaf ! »" CR>)
		      (T <TELL "« Grrrr ! »" CR>)>)
	       (<VERB? ATTACK MUNG STAB>
		<COND (,CERBERUS-LEASHED
		       <REMOVE ,CERBERUS>
		       <TELL
"La créature pousse un faible aboiement de déception et expire. Ses six yeux vous adressent un dernier regard de reproche. Son corps s'effondre alors en un petit tas de poussière que le vent disperse jusqu'à ce qu'il n'en reste rien." CR>)
		      (<PROB 50>
		       <JIGS-UP
"La créature canine referme sauvagement ses mâchoires sur vous. Votre tête ne représente apparemment qu'une petite bouchée pour la pauvre bête, qui demeure tout aussi affamée après coup.">)
		      (T
		       <TELL
"La créature canine enragée claque férocement des mâchoires dans votre direction." CR>)>)
	       (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSO ,COLLAR>>
		<MOVE ,COLLAR ,CERBERUS>
		<FSET ,COLLAR ,NDESCBIT>
		<FSET ,COLLAR ,TRYTAKEBIT>
		<PUTP ,CERBERUS ,P?LDESC
"Un chien à trois têtes, arborant un sourire béat, remue la queue. Il porte un gigantesque collier.">
		<SETG CERBERUS-LEASHED T>
		<TELL
"La créature gémit de bonheur, puis sa tête centrale vous lèche le visage -- sensation assez proche d'une toilette au papier de verre. Les deux autres regardent autour d'elles, comme si le monstre éprouvait soudain le besoin de retrouver une paire de pantoufles. Son énorme queue bat l'air avec enthousiasme, projetant de petits cailloux et manquant de vous renverser par le vent qu'elle soulève." CR>)
	       (<VERB? ENCHANT>
		<COND (<EQUAL? ,SPELL-USED ,W?FLOAT>
		       <SETG SPELL-HANDLED? T>
		       <TELL
"L'énorme chien s'élève un instant à quelques centimètres du sol." CR>)
		      (<EQUAL? ,SPELL-USED ,W?FIERCE>
		       <SETG SPELL-HANDLED? T>
		       <JIGS-UP
"Cerbère vous déchire membre par membre ! Quelle férocité !">)
		      (<EQUAL? ,SPELL-USED ,W?FEEBLE>
		       <TELL
"Quel effet ! Il n'a plus que la force d'un seul éléphant, au lieu de dix !" CR>)>)
	       (<NOT ,CERBERUS-LEASHED>
		<TELL "Le chien à trois têtes claque férocement des mâchoires dans votre direction !" CR>)
	       (<AND ,CERBERUS-LEASHED <VERB? RUB>>
		<TELL
"Le chien est désormais fou de joie : il bave partout et gémit, incapable de contenir son enthousiasme canin." CR>)>>

<ROUTINE COLLAR-FCN ()
	 <COND (<AND <VERB? TAKE> ,CERBERUS-LEASHED>
		<JIGS-UP
"Ce n'était guère judicieux. La créature appréciait son rôle d'animal de compagnie. Lorsque vous détachez le collier, le monstre déçu se met à grogner, puis ses trois gueules hérissées de crocs vous réduisent en biscuits pour chien.">)
	       (<AND <VERB? ENCHANT> <EQUAL? ,SPELL-USED ,W?FLOAT>>
		<PERFORM ,V?ENCHANT ,CERBERUS>
		<RTRUE>)>>

\

"SOUS-TITRE : DRAGON ET GLACIER"

<GLOBAL ICE-MELTED <>>

<ROUTINE GLACIER-FCN ()
	 <COND (<VERB? MELT>
		<TELL
"Ce glacier est immense ; il vous faudra une source de chaleur considérable." CR>)>>

<ROUTINE GLACIER-ROOM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Cette vaste galerie de lave ancienne a été polie par le lent passage d'un glacier. Un large couloir mène à l'est ; au sommet d'un amas de rochers effondrés, un tunnel de lave monte vers les hauteurs." CR>
		<COND (,ICE-MELTED
		       <TELL
"Un passage humide et calciné mène à l'ouest. De la vapeur l'emplit encore en partie." CR>)>
		<RTRUE>)>>

<ROUTINE DRAGON-FCN ()
	 <ENABLE <QUEUE I-DRAGON -1>>
	 <COND (<HELLO? ,DRAGON>
		<TELL
"Le dragon paraît amusé. Il parle d'une voix si grave que vous la ressentez plus que vous ne l'entendez, dans une langue qui vous est inconnue. Vous vous sentez presque hypnotisé." CR>
		<SETG DRAGON-ANGER <+ ,DRAGON-ANGER 2>>)
	       (<VERB? EXAMINE>
		<TELL
"Il se retourne vers vous ; ses yeux de chat luisent d'un jaune inquiétant dans la pénombre. Vos forces vous abandonnent ; vous détournez vivement le regard." CR>
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
"Le dragon apprécie votre présent, s'absente un instant et revient sans lui." CR>)
		      (<BOMB? ,PRSO>
		       <SETG DRAGON-ANGER <+ ,DRAGON-ANGER 2>>
		       <REMOVE ,BRICK>
		       <TELL
"Le dragon enroule sa longue langue rouge autour de la bombe et l'avale poliment. Quelques instants plus tard, il rote ; des volutes de fumée s'échappent de ses narines." CR>)
		      (T
		       <TELL "Le dragon refuse votre cadeau." CR>)>)
	       (<AND <VERB? WALK>
		     <EQUAL? ,HERE ,DRAGON-ROOM>
		     <EQUAL? ,PRSO ,P?NORTH>>
		<SETG DRAGON-ANGER <+ ,DRAGON-ANGER 3>>
		<TELL
"Le dragon tend une griffe, découvre dans un rictus toutes ses dents acérées comme des épées, et vous barre le passage." CR>)>>

<GLOBAL DRAGON-ANGER 0>

<GLOBAL DRAGON-ATTACKS
        <LTABLE
"La peau du dragon est dure comme l'acier, mais vous avez tout de même réussi à l'agacer. Il vous dévisage, comme s'il hésitait encore à vous manger."
"Cela a suscité son intérêt. Il vous regarde d'un air sinistre."
"Le dragon est surpris et intéressé (pour le moment)."
"Vous l'avez plutôt mis en colère. Vous feriez mieux d'être très prudent maintenant."
"Cela ne lui fait aucun mal. Il tourne toutefois vers vous ses yeux jaunes et fumeux, puis soupire.">>

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
"Le dragon se lasse de ce petit jeu. Avec un bâillement presque ennuyé, il ouvre la gueule et ">
		<COND (<EQUAL? ,SPELL? ,S-FIREPROOF>
		       <TELL
" vous crache un formidable torrent de flammes, qui vous enveloppe sans vous blesser." CR>)
		      (T
		       <DRAGON-LEAVES>
		       <JIGS-UP
" vous incinère dans un torrent de flammes de dragon chauffées à blanc.">)>)
	       (<AND <IN? ,WINNER ,DRAGON-ROOM>
		     <NOT <IN? ,DRAGON ,DRAGON-ROOM>>>
		<MOVE ,DRAGON ,DRAGON-ROOM>
		<TELL
"Fou de rage devant votre tentative de lui fausser compagnie, le dragon fait demi-tour et charge dans la salle. Ses yeux brillent d'une colère chauffée à blanc." CR>
		<COND (<EQUAL? ,SPELL? ,S-FIREPROOF>
		       <JIGS-UP
"Une énorme boule de feu vous enveloppe, mais vous n'en ressentez même pas la chaleur. Le dragon est perplexe -- pas assez, toutefois, pour oublier de vous broyer entre ses mâchoires.">)
		      (T
		       <JIGS-UP
"Pour votre malheur, il ouvre la gueule et crache un formidable jet de flammes qui vous consume sur place.">)>)
	       (<NOT <G? ,DRAGON-ANGER 0>>
		<COND (<AND <PROB 50>
			    <IN? ,DRAGON ,HERE>>
		       <TELL "Le dragon a l'air de s'ennuyer." CR>)
		      (T
		       <DRAGON-LEAVES>
		       <COND (<EQUAL? ,HERE ,GLACIER-ROOM>
			      <TELL
"Le dragon n'est plus là. Il a dû se lasser de vous." CR>)
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
		       <TELL "Le dragon refuse de vous suivre plus loin." CR>)
		      (<EQUAL? .ROOM ,GLACIER-ROOM>
		       <TELL CR
"En entrant, le dragon aperçoit son reflet sur la surface glacée du glacier, à l'extrémité ouest. Il entre en fureur : un autre dragon se cache derrière cette paroi de verre ! Les dragons sont intelligents, mais parfois naïfs, et celui-ci n'a jamais vu de glace. Il se dresse de toute sa hauteur pour défier l'intrus qui ose empiéter sur son territoire. Il rugit ; son adversaire lui répond ! Le dragon prend une profonde inspiration et crache un formidable torrent de flammes. La glace fond à toute vitesse, libérant des flots d'eau et un immense nuage de vapeur. Vous parvenez à vous hisser sur une petite saillie, mais le dragon, lui, est pris de panique. Une énorme gerbe d'eau s'engouffre dans sa gorge. Une explosion sourde retentit ; l'air perplexe, le dragon meurt et le courant emporte son corps.| |Lorsque les eaux se retirent, vous redescendez avec précaution. Le dragon a disparu sans laisser de trace, mais la fonte du glacier a révélé un passage vers l'ouest." CR>
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
			      <TELL "La licorne s'éloigne d'un bond léger." CR>)>)
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
"Une licorne broute paisiblement à l'extrémité nord du jardin. Quelque chose pend autour de son cou." CR>)>)
		      (<EQUAL? ,HERE ,TOPIARY-ROOM>
		       <COND (<AND <NOT ,TOPIARY-MOVED> <PROB 12>>
			      <SETG TOPIARY-MOVED T>
			      <TELL
"Vous regardez autour de vous. Étrangement, les animaux de verdure semblent avoir légèrement changé de position." CR>)
			     (<AND ,TOPIARY-MOVED
				   <NOT ,TOPIARY-NEAR>
				   <PROB 8>>
			      <SETG TOPIARY-NEAR T>
			      <TELL
"Les animaux de verdure semblent se rapprocher. Vous vous retournez : ils sont désormais tout près." CR>)
			     (<AND ,TOPIARY-NEAR <PROB 4>>
			      <SETG TOPIARY-MOVED <>>
			      <SETG TOPIARY-NEAR <>>
			      <JIGS-UP
"Les animaux de verdure attaquent ! Leurs branches vous écrasent et leurs épines vous lacèrent.">)>)>)
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
	 "Une licorne broute de l'autre côté de la salle. Une clé d'or pend à un ruban noué autour de son cou."
	 "Une magnifique licorne mange des roses. Autour de son cou, un ruban de satin rouge retient une minuscule clé.">>

<ROUTINE GARDEN-ROOM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<ENABLE <QUEUE I-GARDEN -1>>)>>

<ROUTINE GLOBAL-UNICORN-FCN ()
	 <COND (<IN? ,UNICORN ,GARDEN-NORTH>
		<TELL
"La licorne se trouve tout au nord du jardin." CR>)
	       (<VERB? FIND FOLLOW>
		<COND (<FSET? ,UNICORN ,TOUCHBIT>
		       <TELL "Je ne sais plus où cela se trouve." CR>)
		      (T <TELL
"La licorne est une créature légendaire." CR>)>)
	       (T
		<TELL
"Licorne ? Quelle licorne ?" CR>)>>

<ROUTINE UNICORN-FCN ()
	 <COND (<HELLO? ,UNICORN>
		<TELL
"La licorne écoute distraitement, puis recommence à brouter." CR>)
	       (<VERB? FOLLOW>
		<TELL
"La licorne se dérobe à votre approche." CR>)
	       (<AND <VERB? EXAMINE> <EQUAL? ,PRSO ,UNICORN>>
		<TELL
"La licorne recule à votre approche. Vous remarquez toutefois une minuscule clé d'or suspendue à un ruban de satin rouge noué autour de son cou." CR>)
	       (<VERB? EXAMINE>
		<TELL "La licorne se dérobe à votre approche." CR>)
	       (<VERB? TAKE PUT RUB MUNG ATTACK>
		<REMOVE ,UNICORN>
		<SETG UNICORN-FRIGHTENED T>
		<TELL
"Cette preuve confirme à la licorne que vous êtes bien le rustre vagabond qu'elle soupçonnait. Sans surprise, elle se fond dans les haies et disparaît." CR>)>>

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
"Les charnières sont très rouillées, mais elles commencent à céder. Vous pourrez probablement l'ouvrir en essayant encore une fois. Quelque chose remue à l'intérieur.">
		       <COND (<AND <IN? ,PRINCESS ,HERE>
				   <NOT ,PRINCESS-AWAKE>>
			      <TELL
" Tout ce remue-ménage a fait sursauter la jeune femme.">)>
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
"Vous ne pouvez pas la suivre avant qu'elle ne parte..." CR>)
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
"La princesse pousse un cri à votre approche. « Personne ne me délivrera donc de cet affreux destin ? » se lamente-t-elle. ">
		<COND (<IN? ,WIZARD ,HERE>
		       <TELL
"Choqué, le Magicien de Frobozz se tourne vers vous.">)
		      (ELSE
		       <TELL "Juste à temps, le Magicien de Frobozz surgit du néant, comme un store que l'on déroulerait.">)>
		<TELL
" « Foudroiement ! » déclame-t-il. Un éclair colossal vous réduit aussitôt en un tas de cendres fumantes. (À mon avis, vous l'avez bien cherché.)">
		<JIGS-UP>)
	       (<OR <HELLO? ,PRINCESS> <VERB? ALARM KISS EXAMINE RUB>>
		<COND (<AND <IN? ,PRINCESS ,DRAGON-LAIR>
			    <EQUAL? <GET .DEM ,C-ENABLED?> 0>>
		       <PUTP ,PRINCESS ,P?LDESC
"Une princesse échevelée et quelque peu négligée se tient ici.">
		       <ENABLE <QUEUE I-PRINCESS 2>>
		       <SETG PRINCESS-AWAKE T>
		       <TELL
"La princesse -- car c'en est manifestement une -- sort de sa torpeur et vous remarque enfin. Elle sourit. « Merci de m'avoir délivrée de cet affreux ver. Je dois partir ; mes parents doivent s'inquiéter. » Sur ces mots, elle se lève et regarde résolument vers la sortie de l'antre." CR>)
		      (T
		       <TELL
"La princesse ne vous prête aucune attention. Elle regarde autour d'elle, mais son regard se fixe sur ">
		       <COND (<EQUAL? ,HERE ,GAZEBO-ROOM>
			      <TELL "jardin, à l'extérieur">)
			     (<EQUAL? ,HERE ,GARDEN-NORTH>
			      <TELL "pavillon">)
			     (<EQUAL? ,HERE ,RAVINE-LEDGE>
			      <TELL "corniche">)
			     (T
			      <TELL <GET ,PRDIRS <* ,PRCOUNT 4>>>)>
		       <TELL "." CR>)>)
	       (<NOT ,PRINCESS-AWAKE>
		<TELL "Elle est en transe !" CR>)>>

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
	       "dans" GAZEBO-ROOM "dehors" P?IN>>

<ROUTINE I-PRINCESS ("AUX" (DEM <INT I-PRINCESS>) (OLDP <LOC ,PRINCESS>)
		     (PC <* ,PRCOUNT 4>))
	 <MOVE ,PRINCESS <GET ,PRDIRS <+ .PC 1>>>
	 <SETG PRFOLLOW <>>
	 <COND (<AND <IN? ,PRINCESS ,STREAM-PATH>
		     <IN? ,WINNER ,MARBLE-HALL>>
		<TELL
"La princesse appuie sur une plaque de marbre descellée. Une large portion du mur coulisse, révélant un passage vers l'est, dans lequel elle s'engage." CR>
		<COND (<IN? ,WINNER .OLDP>
		       <SETG PRFOLLOW <GET ,PRDIRS <+ .PC 3>>>)>
		<SETG SECRET-DOOR T>)
	       (<AND <IN? ,PRINCESS ,STREAM-PATH>
		     <IN? ,WINNER ,STREAM-PATH>>
		<SETG SECRET-DOOR T>
		<TELL
"La princesse surgit de derrière des rochers, comme si elle avait traversé la paroi." CR>)
	       (<IN? ,WINNER .OLDP>
		<SETG PRFOLLOW <GET ,PRDIRS <+ .PC 3>>>
	        <COND (<EQUAL? .OLDP ,GARDEN-NORTH>
		       <TELL "La princesse entre dans le pavillon.">
		       <COND (<FSET? ,GAZEBO-ROOM ,RMUNGBIT>
			      <TELL ", même si les décombres vous empêcheraient de passer. Elle doit bénéficier d'une protection magique.">)>
		       <TELL "." CR>)
		      (<EQUAL? .OLDP ,RAVINE-LEDGE>
		       <TELL
"La princesse descend gracieusement la paroi rocheuse." CR>)
		      (T
		       <TELL "La princesse marche ">
		       <TELL <GET ,PRDIRS .PC>>
		       <TELL ". Elle vous lance un regard par-dessus son épaule en s'éloignant." CR>)>)
	       (<IN? ,PRINCESS ,HERE>
		<COND (<EQUAL? ,HERE ,GAZEBO-ROOM>
		       <TELL "La princesse vous rejoint dans le pavillon." CR>)
		      (<EQUAL? ,HERE ,DEEP-FORD>
		       <TELL "La princesse descend la paroi rocheuse jusqu'à la plage." CR>)
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
"Timidement, une licorne passe la tête hors des haies. Elle remarque la princesse et paraît aussitôt fascinée. Elle s'approche, puis incline la tête comme pour lui faire la révérence. Autour de son cou, un ruban de satin rouge retient une délicate clé d'or. La princesse retire le ruban et s'en sert pour nouer ses cheveux. Puis elle vous sourit, vous tend la clé et cueille une rose fraîche sous la tonnelle.| |« Ceci pourrait vous être utile, dit-elle. C'est bien peu pour celui qui m'a sauvée d'un destin que je n'ose imaginer. » Sur ces mots, elle monte la licorne -- en amazone, naturellement -- et s'éloigne dans la pénombre." CR>
		<REMOVE ,PRINCESS>)
	       (T
		<REMOVE ,PRINCESS>
		<MOVE ,ROSE ,GAZEBO-ROOM>
		<RFALSE>)>>

\

"SOUS-TITRE : ATELIER DU MAGICIEN ET ENVIRONS"

<ROUTINE MENHIR-ROOM-FCN (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-FLASH> ,MENHIR-POSITION>
		<DESCRIBE-MENHIR>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Cette vaste salle servait manifestement autrefois de carrière. D'énormes blocs de calcaire y sont éparpillés sans ordre : certains encore bruts, d'autres soigneusement taillés et polis. Une moitié de la carrière paraît avoir produit des pierres de construction, l'autre des menhirs. Des passages bien visibles mènent au nord et au sud." CR>
		<COND (<IN? ,MENHIR ,LOCAL-GLOBALS>
		       <DESCRIBE-MENHIR>)>
		T)>>

<ROUTINE DESCRIBE-MENHIR ()
	 <COND (<EQUAL? ,HERE ,MENHIR-ROOM>
		<COND (<EQUAL? ,MENHIR-POSITION <>>
		       <TELL
"Un menhir particulièrement imposant -- au moins vingt pieds de haut pour huit d'épaisseur -- est appuyé contre le mur et bloque une ouverture obscure vers le sud-ouest. Une lettre « F » richement ouvragée est gravée sur sa face visible." CR>)
		      (<EQUAL? ,MENHIR-POSITION 1>
		       <TELL
"Un énorme menhir gît au sol, près d'un passage menant au sud-ouest." CR>)
		      (<EQUAL? ,MENHIR-POSITION 2>
		       <TELL
"Une ouverture obscure mène au sud-ouest." CR>)
		      (<EQUAL? ,MENHIR-POSITION 3>
		       <TELL "Un énorme menhir se dresse ici." CR>)
		      (T
		       <TELL
"Un énorme menhir flotte ici dans les airs, léger comme une plume. Un passage vers le sud-ouest s'ouvre sous lui." CR>)>
		<COND (<EQUAL? ,HERE ,MUNGED-ROOM>
		       <TELL
"L'explosion semble n'avoir eu aucun effet sur le menhir." CR>)>
		<RTRUE>)
	       (T <TELL "Une ouverture obscure mène au sud-ouest." CR>)>>

<GLOBAL MENHIR-POSITION <>>

<ROUTINE MENHIR-FCN ()
	 <COND (<VERB? LOOK-UNDER LOOK-BEHIND>
		<COND (,MENHIR-POSITION
		       <TELL
"Derrière le menhir, il n'y a qu'un mince espace, puis une paroi." CR>)
		      (T
		       <TELL
"L'espace entre le menhir et la paroi est très étroit, mais une salle assez vaste se trouve manifestement derrière. Votre lumière n'en révèle qu'une partie du mur opposé." CR>)>)
	       (<VERB? TAKE MOVE TURN>
		<TELL
"Le menhir pèse plusieurs tonnes et mesure huit pieds de large. Vous ne parvenez même pas à le saisir, encore moins à le déplacer." CR>)
	       (<VERB? READ> <TELL "\"F\"" CR>)
	       (<VERB? EXAMINE>
		<TELL
"La finition est soignée, et la lettre « F » qui y figure est particulièrement bien sculptée." CR>)
	       (<AND <VERB? ENCHANT> <EQUAL? ,SPELL-USED ,W?FLOAT>>
		<TELL
"Le menhir s'élève majestueusement à une dizaine de pieds dans les airs. Le passage ainsi dégagé vous invite à vous y engager." CR>
		<SETG MENHIR-POSITION 3>)
	       (<AND <VERB? DISENCHANT>
		     <EQUAL? ,SPELL-USED ,W?FLOAT>>
		<SETG MENHIR-POSITION <>>
		<COND (<EQUAL? ,HERE ,MENHIR-ROOM ,KENNEL>
		       <TELL
"Le menhir redescend jusqu'au sol." CR>)>)>>

<GLOBAL GUARDIAN-FED <>>

<ROUTINE DOOR-KEEPER-FCN ()
	 <COND (<AND <VERB? ALARM> ,GUARDIAN-FED>
		<TELL "Vous aurez beau essayer, vous ne le réveillerez pas." CR>)
	       (<AND <VERB? GIVE> <EQUAL? ,PRSI ,DOOR-KEEPER>>
		<COND (,GUARDIAN-FED
		       <TELL
"Il dort, du moins pour le moment." CR>)
		      (<EQUAL? ,PRSO ,CANDY>
		       <SETG GUARDIAN-FED T>
		       <REMOVE ,CANDY>
		       <TELL
"Le gardien engloutit avidement les friandises, emballage compris -- il semble particulièrement apprécier les sauterelles. Puis il s'apaise et ferme les yeux. (Les lézards sont connus pour dormir longtemps pendant leur digestion.)" CR>)
		      (<EQUAL? ,PRSO ,FLASK>
		       <TELL
"Le lézard le renifle avec précaution, puis vous dévisage avec colère en sifflant et en claquant des mâchoires." CR>)
		      (<BOMB? ,PRSO>
		       <REMOVE ,PRSO>
		       <TELL
"Le gardien l'engloutit avidement. Un moment plus tard, un minuscule « pop » retentit et ses yeux lui sortent de la tête. Il siffle méchamment dans votre direction." CR>)
		      (<EQUAL? ,PRSO ,PALANTIR-1 ,PALANTIR-2 ,PALANTIR-3>
		       <TELL
"Le gardien engloutit avidement la sphère, mais ne parvient pas à la mâcher. Il essaie encore et encore de l'avaler tout entière, sans plus de succès, puis finit par la recracher au sol." CR>
		       <MOVE ,PRSO ,HERE>)
		      (T
		       <REMOVE ,PRSO>
		       <TELL
"Le lézard engloutit le " D ,PRSO " en croquant goulûment." CR>)>)
	       (<VERB? ATTACK MUNG>
		<TELL
"Le gardien paraît insensible à votre attaque. À vrai dire, vos coups ne semblent même pas l'atteindre." CR>)>>

<GLOBAL WIZ-DOOR-FLAG <>>

<ROUTINE WIZ-DOOR-FCN ()
	 <COND (<NOT ,GUARDIAN-FED>
		<COND (<VERB? OPEN>
		       <TELL
"Le lézard s'anime et tente de vous mordre lorsque vous approchez la main de la poignée." CR>)
		      (<VERB? UNLOCK>
		       <TELL
"Le lézard gardien s'éveille et tente de vous mordre la main. Vous la retirez juste à temps.">
		       <COND (<AND <EQUAL? ,PRSI ,GOLD-KEY> <PROB 5>>
			      <REMOVE ,GOLD-KEY>
			      <TELL " Le gardien prend bien la clé, cependant. Il affiche un sourire dément." CR>)
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
"La clé tourne et le pêne se rétracte avec un déclic. La porte est déverrouillée." CR>)
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
				   "La porte se referme à contrecoeur.">)
		      (<VERB? OPEN>
		       <TELL "La porte est verrouillée !" CR>)>)>>

<ROUTINE GUARDIAN-ROOM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Cette salle sent le renfermé et les toiles d'araignée l'envahissent, mais les traces dans la poussière révèlent des visites récentes. Au sud se dresse une porte tachée et malmenée, quoique d'apparence très solide. Un couloir part vers le nord." CR>
		<COND (<FSET? ,WIZ-DOOR ,OPENBIT>
		       <TELL "La porte est ouverte." CR>)>
		<COND (<NOT ,GUARDIAN-FED>
		       <TELL
"Une tête de lézard repoussante, aux dents acérées et aux petits yeux brillants, est enchâssée dans la porte. ">
		       <COND (<IN? ,CANDY ,WINNER>
			      <TELL "Le lézard vous renifle." CR>)
			     (T
			      <TELL
"Les yeux suivent votre approche." CR>)>)
		      (T
		       <TELL
"Une tête de lézard ensommeillée est fixée à la porte." CR>)>)>>

<ROUTINE WORKSHOP-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Vous êtes dans le vestibule de l'atelier du Magicien. Des couloirs obscurs mènent à l'ouest et au sud. Celui de l'ouest exhale une légère odeur d'encens ou de fumée de bougie.">
		<COND (<FSET? ,WIZ-DOOR ,OPENBIT>
		       <TELL " La porte de l'atelier est ouverte.">)>
		<CRLF>
		<RTRUE>)>>

<ROUTINE ARCANA-PSEUDO ()
	 <COND (<VERB? TAKE>
		<TELL
"Tout ce qui encombre l'établi ressemble à un amas de camelote. Vous décidez que l'emporter ne ferait que vous gêner." CR>)>>

<ROUTINE TROPHY-PSEUDO ()
	 <COND (<VERB? READ> <RFALSE>)
	       (<VERB? TAKE RUB>
		<TELL
"Lorsque vos doigts s'en approchent, vous recevez une violente décharge -- heureusement pas mortelle." CR>)>>

<ROUTINE STAND-FCN ()
	 <COND (<VERB? TAKE>
		<TELL "Le " D ,PRSO " est solidement fixé à l'établi." CR>)
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
"Lorsque vous placez le " D ,PRSO " dans le " D ,PRSI ", un faible bourdonnement s'élève et les poils de votre nuque se hérissent. Les trois sphères vibrent de plus en plus vite, tandis que le son devient toujours plus aigu. Trois volutes de fumée -- l'une rouge, l'autre bleue, la dernière blanche -- montent des socles désormais vides. Les sphères ont disparu ! Au centre du triangle formé par les socles se dresse à présent un socle d'obsidienne noire, sur lequel repose une étrange sphère sombre." CR>)>
		T)>>

<ROUTINE IN-AQUARIUM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Le sol est couvert de sable et votre vue demeure trouble. La paroi que vous examinez est faite de blocs de pierre soigneusement taillés." CR>
		<COND (<IN? ,SERPENT ,AQUARIUM>
		       <COND (<PROB 25>
			      <TELL
"Pendant que vous regardez, une ombre semble passer au-dessus de votre tête." CR>)
			     (<PROB 5>
			      <TELL
"La tête d'un horrible serpent entre dans votre champ de vision ; ses petits yeux verts semblent presque vous apercevoir." CR>)>)>
		<RTRUE>)
	       (<EQUAL? .RARG ,M-ENTER>
		<COND (<IN? ,SERPENT ,AQUARIUM>
		       <JIGS-UP
"Vous tombez dans l'aquarium avec une grande éclaboussure, attirant aussitôt le serpent. Il vous dévore avec avidité. Après tout, ce n'est qu'un bébé : il lui faut toute la nourriture possible.">)
		      (T <JIGS-UP
"Oh là là... Vous vous êtes profondément entaillé avec le verre brisé. J'ai bien peur que vous ne soyez mort vidé de votre sang.">)>)>>

<ROUTINE AQUARIUM-FCN ("AUX" OBJ)
	 <COND (<VERB? BOARD THROUGH> <DO-WALK ,P?IN> <RTRUE>)
	       (<AND <VERB? LOOK-INSIDE>
		     <IN? ,SERPENT ,AQUARIUM>>
		<TELL
"Un bébé serpent de mer nage dans l'aquarium et vous observe avec méfiance. Son corps écailleux ondule dans l'immense bassin." CR>)
	       (<OR <AND <VERB? MUNG ATTACK> <EQUAL? ,PRSO ,AQUARIUM>>
		    <AND <VERB? THROW> <EQUAL? ,PRSI ,AQUARIUM>>>
		<COND (<EQUAL? ,PRSO ,AQUARIUM>
		       <COND (<NOT ,PRSI> <RFALSE>)
			     (T <SET OBJ ,PRSI>)>)
		      (T <SET OBJ ,PRSO>)>
		<MOVE .OBJ ,HERE>
		<COND (<IN? ,DEAD-SERPENT ,HERE>
		       <TELL
"L'aquarium est déjà brisé !" CR>
		       <RTRUE>)
		      (<EQUAL? .OBJ ,FLASK>
		       <JIGS-UP
"Le flacon se brise et un gaz toxique envahit la salle !">
		       <RTRUE>)
		      (<BOMB? .OBJ>
		       <DISABLE <INT I-FUSE>>)
		      (<OR <FSET? .OBJ ,WEAPONBIT>
			   <G? <GETP .OBJ ,P?SIZE> 10>>
		<REMOVE ,SERPENT>
		<MOVE ,PALANTIR-3 ,AQUARIUM>
		<FCLEAR ,PALANTIR-3 ,NDESCBIT>
		<PUTP ,AQUARIUM ,P?LDESC
"Les débris d'un aquarium occupent la moitié nord de la salle.">
		<MOVE ,DEAD-SERPENT ,HERE>
		<TELL
"Le " D .OBJ " fracasse la paroi de verre de l'aquarium, libérant une quantité impressionnante d'eau salée et de sable détrempé. Un serpent de mer extrêmement contrarié s'en échappe également et mord avec rage " D .OBJ ", puis vers vous. Il respire avec difficulté et paraît vous tenir responsable de son état.">
		<COND (<VERB? MUNG>
		       <TELL
" Il parvient à vous arracher les membres avant de suffoquer dans l'air." CR>
		       <JIGS-UP "Vous avez sans doute été trop imprudent.">)
		      (T
		       <TELL
" Il tente de ramper vers vous sur le sol de pierre. Heureusement, il expire à quelques pouces seulement de votre pied. Une sphère de cristal transparente repose parmi le sable et les débris de verre au fond de l'aquarium." CR>)>)
		      (T
		       <TELL
"Le " D .OBJ " rebondit sans danger sur le verre." CR>)>)>>

<ROUTINE SERPENT-FCN ()
	 <COND (<EQUAL? ,SERPENT ,WINNER>
		<TELL
"Le serpent ne fait que vous regarder avec avidité." CR>)
	       (<VERB? ATTACK MUNG>
		<TELL
"Il fonce vers vous d'un puissant coup de nageoires, ses dents acérées comme des poignards dégoulinant d'eau. Ne souhaitant heureusement pas percuter la paroi de l'aquarium, il se contente de vous éclabousser." CR>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,PRSO ,SERPENT>>
		<TELL "Impossible pour de nombreuses raisons." CR>)
	       (<VERB? TAKE GIVE>
		<JIGS-UP
"Il vous dévore à sa place. *Beurp !*">)>>

<ROUTINE DEAD-SERPENT-FCN ()
	 <COND (<VERB? TAKE>
		<TELL
"Ce n'est peut-être qu'un bébé serpent de mer, mais il est aussi gros qu'une petite baleine." CR>)>>

<ROUTINE GENIE-FCN ("OPTIONAL" (RARG ,M-OBJECT) "AUX" V HOARD)
	<COND (<VERB? HELLO>
	       <TELL
"Le démon affiche un sourire diabolique, mais ne dit rien." CR>)
	      (<EQUAL? ,WINNER ,GENIE>
	       <COND (<NOT ,GENIE-READY?>
		      <TELL
"« Mes honoraires n'ont pas été réglés ! Je ne travaille pas gratuitement. Les démons ont aujourd'hui un syndicat très puissant. »" CR>
		      <RFATAL>)
		     (<VERB? SGIVE> <RFALSE>)
		     (<OR <G? <GET ,P-PRSO 0> 1>
			  <G? <GET ,P-PRSI 0> 1>>
		      <TELL
"« Je n'accomplirai qu'une seule tâche, ô gracieux maître ! »" CR>
		      <RFATAL>)
		     (<AND <VERB? MOVE> <EQUAL? ,PRSO ,GLOBAL-MENHIR>>
		      <SETG MENHIR-POSITION 1>
		      <TELL
"Le démon disparaît un instant. « Une broutille... Mon petit doigt a suffi. »" CR>
		      <GENIE-LEAVES>)
		     (<VERB? TAKE>
		      <COND (<EQUAL? ,PRSO ,GLOBAL-MENHIR>
			     <REMOVE ,MENHIR>
			     <SETG MENHIR-POSITION 2>
			     <TELL
"Le démon disparaît l'espace d'un instant. « Je n'ai guère l'usage de pareille chose, mais elle pourrait servir de cale-porte... »" CR>
			     <GENIE-LEAVES>)
			    (<EQUAL? ,PRSO ,WAND>
			     <TELL
"« Avec plaisir, ô imbécile ! » ricane joyeusement le démon. Il tend une main gigantesque vers la baguette, la saisit comme un cure-dent -- c'est un très grand démon -- et la pointe sur lui-même. « Libre ! » ordonne-t-il. Le démon et sa baguette disparaissent à jamais." CR>
			     <GENIE-LEAVES <>>
			     <REMOVE ,WAND>)
			    (<FSET? ,PRSO ,TAKEBIT>
			     <GENIE-LEAVES <>>
			     <REMOVE ,PRSO>
			     <TELL
"Le démon claque des doigts ; l'objet désigné -- " D ,PRSO " -- se met à tournoyer follement devant lui ; tous deux disparaissent alors." CR>)
			    (T
			     <TELL
"« Je crains de ne pouvoir prendre pareille chose. »" CR>)>)
		     (<AND <VERB? GIVE> <EQUAL? ,PRSI ,ME>>
		      <COND (<EQUAL? ,PRSO ,WAND>
			     <TELL
"« J'entends et j'obéis ! » répond le démon. Il tend une main gigantesque vers la baguette. Le Magicien hésite, la braquant tour à tour sur le démon et sur vous. « Fondant ! » s'écrie-t-il ; mais hormis une forte odeur de chocolat, rien ne se produit. Le démon lui arrache la baguette -- à peine un cure-dent entre ses doigts -- et la dépose délicatement devant vous. Puis il se fond dans un nuage de fumée qui se dissipe. Le Magicien s'enfuit, terrorisé." CR>
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
"D'un geste des mains, il dépose doucement le menhir à vos pieds." CR>
			     <GENIE-LEAVES>)
			    (<FSET? ,PRSO ,TAKEBIT>
			     <MOVE ,PRSO ,PENTAGRAM-ROOM>
			     <TELL
"Le " D ,PRSO " apparaît devant vous et se pose au sol." CR>
			     <GENIE-LEAVES>)
			    (T
			     <TELL
"« Si seulement c'était possible : tel serait mon voeu le plus cher. Hélas... »" CR>)>)
		     (<VERB? ATTACK>
		      <COND (<EQUAL? ,PRSO ,GLOBAL-CERBERUS>
			     <TELL
"« La tâche s'annonce ardue, mais voyons cela. Peut-être pourrai-je le dompter et en faire un petit chien. » Le démon disparaît un instant, puis revient couvert de morsures et de griffures. Il grimace. « Trop coriace, même pour moi. Un petit chien, vraiment ! Je vous le laisse. Je n'ai jamais aimé les chiens, de toute façon... D'autres ordres, ô bienfaiteur ? »" CR>)
			    (<EQUAL? ,PRSO ,WIZARD>
			     <TELL
"Le démon affiche un sourire hideux. « Je désire cela depuis que ce charlatan m'a asservi. C'est avec joie que j'accomplirai cette tâche ! » Il se change en un nuage de fumée grasse qui enveloppe le Magicien. Celui-ci agite vainement sa baguette en marmonnant diverses formules commençant par la lettre F. Un hurlement atroce retentit, puis la fumée se dissipe. Du Magicien, il ne reste que sa baguette." CR>
			     <REMOVE ,WIZARD>
			     <FCLEAR ,WAND ,NDESCBIT>
			     <MOVE ,WAND ,HERE>
			     <GENIE-LEAVES>)
			    (<EQUAL? ,PRSO ,ME>
			     <GENIE-LEAVES <>>
			     <SETG WINNER ,ADVENTURER>
			     <JIGS-UP
"« Insensé mortel, puisque vous insistez... » Le démon vous écrase d'un seul coup de son énorme main.">)
			    (T
			     <TELL 
"« Je ne connais aucun moyen de tuer un " D ,PRSO ".\"" CR>)>)
		     (<VERB? FIND EXAMINE>
		      <TELL
"« Je ne suis pas autorisé à ">
		      <COND (<VERB? FIND>
			     <TELL "répondre à des questions">)
			    (T <TELL "effectuer de telles tâches subalternes">)>
		      <TELL ". Les clauses de mon contrat sont formelles sur ce point, ô savant maître. Vous ne songeriez tout de même pas à les enfreindre ? » Il passe sur ses lèvres une langue fourchue de serpent. « Les pénalités sont... hum... diaboliques. »" CR>)
		     (T
		      <TELL
"« Pardonnez-moi, ô maître, mais cela demeure impossible, même pour un être tel que moi. » Il paraît quelque peu mortifié de devoir l'admettre." CR>
		      <RTRUE>)>)
	      (<VERB? EXORCISE ATTACK MUNG>
	       <TELL
"Le démon rit aux éclats." CR>)
	      (<AND <VERB? GIVE> <EQUAL? ,PRSI ,GENIE>>
	       <COND (<AND <EQUAL? ,PRSO ,IRON-BOX>
			   <IN? ,VIOLIN ,PRSO>>
		      <TELL
"Le démon fronce brièvement les sourcils, puis ">
		      <COND (<FSET? ,PRSO ,OPENBIT> <TELL "regarde à l'intérieur">)
			    (ELSE <TELL "ouvre">)>
		      <TELL " le coffre. Il affiche un sourire effroyable." CR>
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
"Le Magicien, abattu et craintif, vous observe depuis un coin.">
			     <TELL
"« Ceci couvrira mes honoraires. Le butin est maigre, mais puisque vous m'avez rendu le modeste service de me libérer de ce sorcier, je m'en contenterai. »" CR>)
			    (T
			     <TELL
"\"" <GET ,GENIE-THANKS .HOARD> "\"" CR>
			     <COND (<EQUAL? .HOARD 8>
				    <TELL
"Le Magicien vous regarde comme si vous étiez fou. Il s'arrache la barbe et vous dévisage avec effroi." CR>)>
			     <RTRUE>)>)
		     (<BOMB? ,PRSO>
		      <GENIE-LEAVES <>>
		      <TELL
"« Je crains que cela ne rompe notre contrat, ô insensé. Je suis donc libre de partir. »" CR>)
		     (T
		      <REMOVE-CAREFULLY ,PRSO>
		      <TELL
"Le démon accepte volontiers l'objet nommé « " D ,PRSO " » et affiche un sourire sinistre, dévoilant d'énormes crocs." CR>)>)>>

<ROUTINE GENIE-LEAVES ("OPTIONAL" (NOISY? T))
	 <FSET ,GENIE ,INVISIBLE>
	 <COND (.NOISY?
		<TELL "Le démon s'en va : son engagement est rempli." CR>)>
	 <SETG P-CONT <>>
	 <RFATAL>>

<GLOBAL GENIE-READY? <>>
<GLOBAL GENIE-HOARD 0>
<CONSTANT TREASURES-MAX 10>	;"all treasures but palantirs(4),
				  candy, collar, wand."

<GLOBAL GENIE-THANKS <LTABLE
"Fort bien, maître ! Mais cela ne suffit pas. Je vais rendre un grand service, et les grands services ne se paient-ils pas au prix fort ?"
"Très joli, mais cela ne suffit pas !"
"Ah, c'est absolument magnifique ! Continuez ainsi."
"Vous voici presque à mi-chemin, ô digne maître !"
"Oh, quelle merveille ! Votre générosité me bouleverse presque !"
"En vérité, je vous rendrai un merveilleux service lorsque vous aurez terminé !"
"Vous êtes vraiment fort généreux ! Pourtant, cela ne suffit pas encore."
"Un magnifique présent, ô puissant maître ! Mes honoraires sont presque acquittés."
"Merveilleux, maître ! Il reste cependant un trésor à offrir !">>

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
"Vous tentez de pénétrer dans le pentagramme, mais une force invisible vous repousse." CR>)
	              (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSO ,PALANTIR-4>>
		       <REMOVE ,PALANTIR-4>
		       <FCLEAR ,GENIE ,INVISIBLE>
		       <MOVE ,GENIE ,PENTAGRAM-ROOM>
		       <TELL
"Un vent glacé jaillit de la sphère. Les bougies vacillent et un gémissement presque inaudible s'élève. Il gagne en force et en hauteur jusqu'à devenir une plainte perçante. Une forme indistincte apparaît dans les airs au-dessus de la sphère, puis prend les traits d'un démon immense et passablement redoutable. Il inspecte les lieux, éprouve les parois du pentagramme, puis vous aperçoit.| |« Hum... un nouveau maître », murmure-t-il. « Salutations, ô maître ! Désirez-vous quelque service, ainsi que le stipule notre contrat ? Pour une modeste offrande, une broutille, je comblerai vos souhaits jusqu'aux dernières limites de mes pouvoirs -- qui ne sont pas négligeables. » D'un geste de ses bras massifs, il fait trembler les murs ; d'un second, il les immobilise. « Bel effet, n'est-ce pas ? Une démonstration précoce favorise toujours de bonnes relations. » Il affiche un sourire abominable." CR>)>)>>

<ROUTINE WIZARD-FCN ("OPTIONAL" (RARG ,M-OBJECT) "AUX" OLIT)
	 <COND (<EQUAL? ,WINNER ,WIZARD>
		<COND (<VERB? GIVE> <TELL
"Le Magicien répond : « Sottises ! »" CR>)
		      (T
		       <TELL
"Le Magicien réfléchit attentivement à vos paroles. Son expression indique qu'il les juge fantaisistes." CR>)>)
	       (<AND <VERB? GIVE> <EQUAL? ,PRSI ,WIZARD>>
		<SET OLIT ,LIT>
		<REMOVE-CAREFULLY ,PRSO>
		<COND (<BOMB? ,PRSO>
		       <COND (<IN? ,GENIE ,PENTAGRAM-ROOM>
			      <MOVE ,PRSO ,HERE>
			      <TELL
"Le Magicien accepte cette ultime folie avec résignation." CR>)
			     (T
			      <REMOVE ,WIZARD>
			      <TELL
"« Hum... » Le Magicien marmonne quelques mots, puis agite sa baguette au-dessus de la bombe. Celle-ci se change en bouquet de fleurs. Le Magicien et le bouquet disparaissent ensemble." CR>)>)
		      (<AND .OLIT <NOT ,LIT>>
		       <TELL
"« Merci. » Tandis que le Magicien glisse le " D ,PRSO " sous sa robe, la salle plonge dans l'obscurité." CR>)
		      (T
		       <TELL "« Merci. »" CR>)>)
	       (<HELLO? ,WIZARD>
		<TELL
"Le Magicien paraît aussi surpris que vous le seriez si un chien se mettait à parler." CR>)
	       (<VERB? ATTACK MUNG>
		<REMOVE ,WIZARD>
		<COND (<IN? ,WAND ,WIZARD>
		       <TELL
"Le Magicien recule en agitant sa baguette et en psalmodiant : « Peur ! »
">)
		      (T
		       <TELL
"Le Magicien essaie de lancer le sort « Peur ! », mais il n'a plus sa baguette !
">)>
		<COND (<NOT <FSET? ,GENIE ,INVISIBLE>>
		       <TELL
"Rien ne se produit ! Après un regard terrifié vers le démon, le Magicien vous dépasse en courant et s'enfuit de la salle." CR>)
		      (T
		       <TELL
"Une terreur soudaine vous saisit. Le Magicien paraît immense et effroyable, dressé au-dessus de vous. Vous prenez la fuite. Il glousse, claque des doigts et disparaît." CR CR>
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
"Lorsque le sort se dissipe, vous plongez jusqu'au fond du conduit.">
			      <RTRUE>)
			     (<AND <FSET? ,HERE ,NONLANDBIT>
				   <NOT <EQUAL? ,HERE ,WELL-BOTTOM
						,VOLCANO-BOTTOM>>>
			      <JIGS-UP
"Lorsque le sort se dissipe, vous vous retrouvez lancé dans un demi-salto vers le fond du volcan.">
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

"Soudain, le Magicien se matérialise dans la pièce. Il n'en croit pas ses yeux : son serviteur converse tranquillement avec un vulgaire aventurier ! Il brandit sa baguette, l'agite frénétiquement et incante : « Frobizz ! Frobozzle ! Frobnoid ! » Le démon éclate de rire. « Tu ne contrôles plus le Cristal noir, sorcier de pacotille ! Ta baguette est impuissante et ton destin scellé ! » Puis le démon se tourne vers vous, dans l'attente de vos ordres." CR>)>)>
		<RTRUE>)>
	 <COND (<AND <NOT ,LIT>
		     <FSET? ,LAMP ,RMUNGBIT>
		     <G? ,SCORE 200>>
		<SETG ALWAYS-LIT T>
		<SETG LIT T>
		<TELL
"Dans les ténèbres, vous entendez la voix du Magicien. « Eh bien, vous voilà dans de beaux draps. » Il glousse. « Fluorescence ! » incante-t-il. L'obscurité se dissipe." CR>
		<RTRUE>)>
	 <COND (<AND <LOC ,WIZARD> <PROB 80>>
		<COND (<AND ,LIT <IN? ,WIZARD ,HERE>>
		       <TELL "Le Magicien disparaît." CR>)>
		<REMOVE ,WIZARD>
		<RTRUE>)>
	 <COND (<PROB 10>
		<COND (<NOT ,LIT>
		       <TELL
"Vous ressentez un léger souffle d'air alors que quelque chose bouge à proximité." CR>)
		      (<EQUAL? ,HERE ,POSTS-ROOM ,POOL-ROOM>
		       <TELL
"Un Magicien immense et terrifiant apparaît devant vous, aussi haut que le plus grand des arbres ! Il vous contemple comme vous regarderiez un moucheron." CR>)
		      (<FSET? ,HERE ,NONLANDBIT>
		       <TELL
"Le Magicien apparaît, flottant nonchalamment dans les airs à vos côtés. Il vous adresse un sourire en coin." CR>)
		      (T
		       <TELL
"Un étrange petit homme vêtu d'une longue cape apparaît soudain dans la pièce. Il porte un haut chapeau pointu brodé de signes astrologiques et une longue barbe filasse, fort mal entretenue." CR>)>
		<COND (<IN? ,PALANTIR-4 ,ADVENTURER>
		       <COND (,LIT
			      <TELL
"Le Magicien remarque que vous portez le Cristal noir et disparaît avec une hâte peu digne de son rang." CR>)
			     (ELSE
			      <TELL
"Vous ressentez un soudain afflux d'air comme si quelque chose avait disparu." CR>)>
		       <REMOVE ,WIZARD>
		       <RTRUE>)
		      (<PROB 20>
		       <COND (,LIT
			      <TELL
"Il marmonne quelques mots, étouffés par sa barbe, puis disparaît aussi brusquement qu'il était venu." CR>)
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
"D'une voix grave et résonnante, le Magicien prononce \""
<GET ,SPELL-NAMES ,SPELL?> " ! » Puis il disparaît en gloussant de joie." CR>)
			     (T
			      <TELL
"Le Magicien murmure presque imperceptiblement un mot commençant par « F », puis disparaît avec un gloussement malveillant." CR>)>
		       <REMOVE ,WIZARD>
		       <COND (<GET ,SPELL-HINTS ,SPELL?>
			      <TELL <GET ,SPELL-HINTS ,SPELL?> CR>)>
		       <COND (<EQUAL? ,SPELL? ,S-FALL>
			      <COND (<FSET? .WLOC ,VEHBIT>
				     <TELL
"Vous tombez soudainement hors du " D .WLOC " comme si quelqu'un l'avait retourné." CR>
				     <COND (<EQUAL? ,HERE ,WELL-TOP>
					    <JIGS-UP
"Vous chutez jusqu'au fond du conduit.">)
					   (<AND <FSET? ,HERE ,NONLANDBIT>
						 <NOT <EQUAL? ,HERE
							      ,VOLCANO-BOTTOM
							      ,WELL-BOTTOM>>>
					    <JIGS-UP
"Vous exécutez un plongeon en cygne plutôt désordonné jusqu'au fond du volcan.">)
					   (ELSE <MOVE ,WINNER ,HERE>)>)>)
			     (<EQUAL? ,SPELL? ,S-FLOAT>
			      <COND (<FSET? .WLOC ,VEHBIT>
				     <TELL
" Vous vous élevez majestueusement hors du " D .WLOC ", puis vous vous immobilisez à environ cinq pieds au-dessus, légèrement sur le côté." CR>
				     <MOVE ,WINNER ,HERE>)
				    (T
				     <TELL
"Lentement, vous vous élevez dans les airs avec toutes vos possessions et vous immobilisez à environ cinq pieds du sol." CR>)>)
			     (<EQUAL? ,SPELL? ,S-FEEBLE>
			      <SETG LOAD-ALLOWED 50>
			      <COND (<SET F <FIRST? ,WINNER>>
				     <TELL
"En fait, vous vous sentez si faible que vous laissez tomber le " D .F "." CR>
				     <MOVE .F .WLOC>)>)
			     (<EQUAL? ,SPELL? ,S-FEAR>
			      <COND (<FSET? .WLOC ,VEHBIT>
				     <TELL
"Vous vous recroquevillez dans le coin du " D .WLOC ", en espérant que le Magicien ne vous voie pas." CR>)
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
"Le Magicien marmonne dans sa barbe et disparaît juste avant que vous ne l'atteigniez." CR>)>
		       <RTRUE>)
		      (<PROB 50>
		       <REMOVE ,WIZARD>
		       <TELL
"Un fort crépitement retentit. De la fumée bleue s'échappe de la manche du Magicien. Il soupire et disparaît." CR>)
		      (<PROB 50>
		       <REMOVE ,WIZARD>
		       <TELL
"Le Magicien prononce \"" <RANDOM-ELEMENT ,SPELL-NAMES> " ! » Mais rien ne se produit. Il secoue la baguette. Toujours rien. Après un regard légèrement embarrassé dans votre direction, il disparaît." CR>)
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
	<LTABLE "Faiblesse" "Fébrilité" "Frayeur" "Fauche" "Figer"
		"Faire choir" "Fermentation" "Fureur" "Flottaison" "Feu-froid"
		"Fortification" "Fantasme">>

<GLOBAL SPELL-HINTS
	<LTABLE
"Tout d'un coup, vous vous sentez très fatigué."
<>
"Vous contemplez le Magicien avec terreur, puis détalez pour mettre le plus de distance possible entre lui et vous."
<>
"Vos membres semblent soudain changés en pierre. Vous ne pouvez plus bouger un seul muscle."
<>
"Vous commencez à vous sentir étourdi."
"Vous vous ruez sur le Magicien avec l'intention de le démembrer."
<>
<>
<>
<>>>

<GLOBAL SPELL-STOPS
	<LTABLE
"Vous vous sentez plus énergique maintenant."
<>
"Soudain, le Magicien ne vous paraît plus si terrifiant..."
<>
"Votre petit doigt se met à frémir, puis votre corps tout entier retrouve sa liberté de mouvement."
<>
"Vous avez désormais les idées plus claires."
"Vous vous sentez moins échauffé et moins en colère."
"Vous redescendez doucement."
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
"Le démon pulvérise la vitrine ; tout son contenu subit le même sort." CR>)>)
	       (<AND <VERB? ENCHANT> <EQUAL? ,SPELL-USED ,W?FILCH>>
		<ROB ,WIZARD-CASE ,HERE>
		<SETG SPELL-HANDLED? T>
		<TELL
"Le contenu de la vitrine est disposé à vos pieds." CR>)
	       (<VERB? OPEN MUNG CLOSE TAKE>
		<TELL
"Un redoutable sortilège protège la vitrine. Impossible de la toucher." CR>)>>

<GLOBAL SPELL-HANDLED? <>>	;"T if handled before I-SPELL runs"
<GLOBAL WAND-ON <>>
<GLOBAL SPELL-USED <>>
<GLOBAL SPELL-VICTIM <>>

<ROUTINE WAND-FCN ()
	 <COND (<AND <VERB? TAKE PUT GIVE> <IN? ,WAND ,WIZARD>>
		<COND (<EQUAL? ,WINNER ,ADVENTURER>
		       <TELL "Le Magicien s'en empare vivement." CR>)
		      (<EQUAL? ,WINNER ,ROBOT>
		       <JIGS-UP
"Le Magicien arrache la baguette et marmonne « Flottant » en direction du robot. Hélas, celui-ci ne possède pas d'unité de calcul en virgule flottante et succombe en tentant vainement de diviser 4,85 par 3,62.">)>)
	       (<AND <VERB? WAVE>
		     <EQUAL? ,PRSI ,GRUE>>
	        <TELL
"Aucune grue n'est visible, mais un sifflement monte des ténèbres." CR>)
	       (<VERB? WAVE RUB RAISE>
		<COND (<AND <EQUAL? ,PRSO ,WAND>
			    <NOT <IN? ,WAND ,WINNER>>>
		       <TELL "Vous n'avez pas la baguette !" CR>
		       <RTRUE>)
		      (<OR ,WAND-ON ,SPELL-USED ,SPELL-VICTIM>
		       <COND (<PROB 5>
			      <JIGS-UP
"La baguette n'avait pas fini de se recharger depuis sa dernière utilisation. Elle répand sa magie dans toutes les directions : vous êtes changé en crapaud, la pièce s'emplit d'une odeur fétide et quantité d'autres choses répugnantes se produisent. Puis la baguette explose !">)
			     (T
			      <TELL
"Vos connaissances en magie laissent à désirer ! Une baguette magique doit se recharger après chaque utilisation. Vous risqueriez de provoquer un court-circuit !" CR>)>
		       <RTRUE>)
		      (<VERB? WAVE>
		       <COND (<AND <EQUAL? ,PRSO ,WAND> ,PRSI>
			      <SETG WAND-ON ,PRSI>
			      <SETG WAND-ON-LOC ,HERE>)
			     (T <TELL "À quoi ?" CR> <RTRUE>)>)
		      (<VERB? RUB>
		       <COND (<AND <EQUAL? ,PRSI ,WAND> ,PRSO>
			      <SETG WAND-ON ,PRSO>)
			     (T <TELL "Que voulez-vous toucher ?" CR> <RTRUE>)>)
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
"La baguette se réchauffe ; l'objet désigné -- " D ,WAND-ON " -- semble luire faiblement d'essences magiques, tandis qu'une puissance nouvelle vous envahit." CR>)>
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
"un sérail somptueusement meublé, tout droit sorti d'un conte arabe."
"décoré dans le style Louis XIV."
"surplombé de palmiers et de lianes. Le seul meuble est un hamac."
"faite de nuées délicates et vaporeuses."
"meublée de plastique et de métal, à la manière de la passerelle d'un vaisseau spatial."
"une chambre de banlieue datant des années 1950, dotée de lits superposés."
"une grotte humide et faiblement éclairée, dont le sol est couvert de fourrures et de vieux os.">>

<ROUTINE BRIDGE-FCN ()
	 <COND (<VERB? CROSS>
		<DO-WALK ,P?CROSS>)
	       (<VERB? LEAP>
		<JIGS-UP
"Vous exécutez un plongeon en cygne parfait dans les profondeurs.">)>>

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
"Pour une fois, vous regardez avant de sauter et comprenez que vous n'y survivriez pas." CR>)
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
"Les seuls que vous puissiez atteindre sont trop gros pour être détachés." CR>)>>

<ROUTINE MOSS-FCN ()
	 <COND (<VERB? TAKE RUB>
		<TELL
"Un peu de mousse reste sur vous, mais elle cesse très vite de luire une fois arrachée à son milieu." CR>)>>

<ROUTINE ROSE-BUSH-FCN ()
	 <COND (<VERB? TAKE>
		<TELL
"En tentant de cueillir une rose, vous vous piquez le doigt et reculez, contrarié. La fleur a presque semblé placer ses épines sur votre chemin." CR>)>>

<ROUTINE I-SPELL ()
	 <COND (<AND <NOT ,SPELL-HANDLED?> ,SPELL-VICTIM>
		<PERFORM ,V?DISENCHANT ,SPELL-VICTIM>)>
	 <SETG SPELL-HANDLED? <>>
	 <SETG WAND-ON <>>
	 <SETG SPELL-USED <>>
	 <SETG SPELL-VICTIM <>>>

<GLOBAL FANTASIES
	<LTABLE "tas de bijoux" "lingot d'or" "basilic"
		"coffre débordant" "sphère jaune" "grue"
		"congrès de magiciens" "exemplaire de ZORK I">>

^/L

;"special-cased routines"

<ROUTINE V-DIAGNOSE ()
	 <COND (,DEAD <TELL "Vous êtes mort.">)
	       (<EQUAL? ,SPELL? ,S-FERMENT>
		<TELL "Vous êtes ivre.">)
	       (<EQUAL? ,SPELL? ,S-FEEBLE>
		<TELL "Vous semblez inhabituellement faible en ce moment.">)
	       (<EQUAL? ,SPELL? ,S-FLOAT>
		<TELL "Vous vous sentez étrangement léger.">)
	       (<EQUAL? ,SPELL? ,S-FREEZE>
		<TELL "Vous êtes raide comme un glaçon.">)
	       (ELSE <TELL "Vous êtes en parfaite santé.">)>
	 <CRLF>
	 <COND (<NOT <0? ,DEATHS>>
		<TELL "Vous avez été tué ">
		<COND (<1? ,DEATHS> <TELL "une fois.">)
		      (<EQUAL? ,DEATHS 2> <TELL "deux fois.">)
		      (T <TELL "un nombre incalculable de fois.">)>
		<CRLF>)>>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
	 #DECL ((ASK?) <OR ATOM FALSE>)
	 <TELL "Votre score ">
	 <COND (.ASK? <TELL "serait ">) (ELSE <TELL "est ">)>
	 <TELL N ,SCORE>
	 <TELL " sur 400, après ">
	 <TELL N ,MOVES>
	 <COND (<1? ,MOVES> <TELL " tour.">) (ELSE <TELL " tours.">)>
	 <CRLF>
	 <TELL "Ce score vous donne le rang de ">
	 <COND (<EQUAL? ,SCORE 400> <TELL "Maître aventurier">
		<COND (<NOT ,WON-FLAG>
		       <TELL ", mais vous sentez confusément que ce n'est pas terminé">)>)
	       (<G? ,SCORE 360> <TELL "Magicien">)
	       (<G? ,SCORE 320> <TELL "Maître">)
	       (<G? ,SCORE 240> <TELL "Aventurier">)
	       (<G? ,SCORE 160> <TELL "Aventurier junior">)
	       (<G? ,SCORE 80> <TELL "Aventurier novice">)
	       (<G? ,SCORE 40> <TELL "Aventurier amateur">)
	       (T <TELL "Débutant">)>
	 <TELL "." CR>
	 ,SCORE>

<ROUTINE JIGS-UP ("OPTIONAL" (DESC <>) (PLAYER? <>))
 	 #DECL ((PLAYER?) <OR ATOM FALSE>)
 	 <COND (.DESC <TELL .DESC CR>)>
	 <COND (<NOT <EQUAL? ,ADVENTURER ,WINNER>>
		<TELL "
| **** Le " D ,WINNER " est mort ****
|
|">
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
"Voyons un peu...|Eh bien, vous méritez probablement une nouvelle chance. Je ne peux pas vous remettre entièrement d'aplomb, mais on ne peut pas tout avoir." CR CR>
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
