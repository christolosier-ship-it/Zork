 			"Le fichier VERBS générique pour La Trilogie ZORK a commencé le 7/25/83 par SEM"

^L

"Fonctions verbales pour les commandes de jeu"

<GLOBAL VERBOSE <>>
<GLOBAL SUPER-BRIEF <>>
<GDECL (VERBOSE SUPER-BRIEF) <OR ATOM FALSE>>

<ROUTINE V-VERBOSE ()
	 <SETG VERBOSE T>
	 <SETG SUPER-BRIEF <>>
	 <TELL "Maximum verbosité." CR>>

<ROUTINE V-BRIEF ()
	 <SETG VERBOSE <>>
	 <SETG SUPER-BRIEF <>>
	 <TELL "Brèves descriptions." CR>>

<ROUTINE V-SUPER-BRIEF ()
	 <SETG SUPER-BRIEF T>
	 <TELL "Descriptions très brèves." CR>>

;"V-DIAGNOSE is in ACTIONS.ZIL"

<ROUTINE V-INVENTORY ()
	 <COND (<FIRST? ,WINNER> <PRINT-CONT ,WINNER>)
	       (T <TELL "Vous êtes les mains vides." CR>)>>

<ROUTINE FINISH ("AUX" WRD)
	 <V-SCORE>
	 <REPEAT ()
		 <CRLF>
		 <TELL
"Voulez-vous recommencer depuis le début, reprendre une sauvegarde ou quitter cette partie ?|
(Tapez RECOMMENCER, REPRENDRE ou QUITTER) :|
>">
		 <READ ,P-INBUF ,P-LEXV>
		 <SET WRD <GET ,P-LEXV 1>>
		 <COND (<EQUAL? .WRD ,W?RESTART>
			<RESTART>
			<TELL "Échec." CR>)
		       (<EQUAL? .WRD ,W?RESTORE>
			<COND (<RESTORE>
			       <TELL "Ok." CR>)
			      (T
			       <TELL "Échec." CR>)>)
		       (<EQUAL? .WRD ,W?QUIT ,W?Q>
			<QUIT>)>>>

<ROUTINE V-QUIT ("AUX" SCOR)
	 <V-SCORE>
	 <TELL 
"Voulez-vous quitter le jeu ? (répondez OUI pour confirmer) : ">
	 <COND (<YES?>
		<QUIT>)
	       (ELSE <TELL "Ok." CR>)>>

<ROUTINE V-RESTART ()
	 <V-SCORE T>
	 <TELL "Voulez-vous redémarrer ? (Y est affirmatif) : ">
	 <COND (<YES?>
		<TELL "Redémarrage." CR>
		<RESTART>
		<TELL "Échec." CR>)>>

<ROUTINE V-RESTORE ()
	 <COND (<RESTORE>
		<TELL "Ok." CR>
		<V-FIRST-LOOK>)
	       (T
		<TELL "Échec." CR>)>>

<ROUTINE V-SAVE ()
	 <COND (<SAVE>
	        <TELL "Ok." CR>)
	       (T
		<TELL "Échec." CR>)>>

;"V-SCORE is in ACTIONS.ZIL"

<ROUTINE V-SCRIPT ()
	<PUT 0 8 <BOR <GET 0 8> 1>>
	<TELL "Ici commence une transcription de l'interaction avec" CR>
	<V-VERSION>
	<RTRUE>>

<ROUTINE V-UNSCRIPT ()
	<TELL "Ici se termine une transcription de l'interaction avec" CR>
	<V-VERSION>
	<PUT 0 8 <BAND <GET 0 8> -2>>
	<RTRUE>>

<ROUTINE V-VERSION ("AUX" (CNT 17))
	%<COND (<==? ,ZORK-NUMBER 1>
		'<TELL "ZORK I : Le Grand Empire Souterrain|
Fiction interactive d'Infocom - une aventure fantastique|
Copyright (c) 1981, 1982, 1983, 1984, 1985, 1986">)
	       (<==? ,ZORK-NUMBER 2>
		'<TELL "ZORK II : Le Magicien de Frobozz|
Fiction interactive d'Infocom - une aventure fantastique|
Copyright (c) 1981, 1982, 1983, 1986">)
	       (<==? ,ZORK-NUMBER 3>
		'<TELL "ZORK III : Le Maître du Donjon|
Fiction interactive d'Infocom - une aventure fantastique|
Copyright 1982, 1983, 1984, 1986">)>
	<TELL " Infocom, Inc. Tous droits réservés." CR>
	<TELL "ZORK est une marque déposée d'Infocom, Inc.|
Version ">
	<PRINTN <BAND <GET 0 1> *3777*>>
	<TELL " / Numéro de série ">
	<REPEAT ()
		<COND (<G? <SET CNT <+ .CNT 1>> 23>
		       <RETURN>)
		      (T
		       <PRINTC <GETB 0 .CNT>>)>>
	<CRLF>>

<ROUTINE V-VERIFY ()
	 <TELL "Vérification du disque..." CR>
	 <COND (<VERIFY>
		<TELL "Le disque est correct." CR>)
	       (T
		<TELL CR "** Défaillance du disque **" CR>)>>

<ROUTINE V-COMMAND-FILE ()
	 <DIRIN 1>
	 <RTRUE>>

<ROUTINE V-RANDOM ()
	 <COND (<NOT <EQUAL? ,PRSO ,INTNUM>>
		<TELL "Appel illégal à #RND." CR>)
	       (T
		<RANDOM <- 0 ,P-NUMBER>>
		<RTRUE>)>>

<ROUTINE V-RECORD ()
	 <DIROUT 4>
	 <RTRUE>>

<ROUTINE V-UNRECORD ()
	 <DIROUT -4>
	 <RTRUE>>

^L

"Vrai Verbe Fonctions"

<ROUTINE V-ADVENT ()
	 <TELL "Une voix creuse dit \"Imbécile\"." CR>>

;<ROUTINE V-AGAIN ("AUX" (OBJ <>))
	 <COND (<EQUAL? ,L-PRSA ,V?WALK>
		<DO-WALK ,L-PRSO>)
	       (T
		<COND (,L-PRSO
		       <COND (<OR <NOT <LOC ,L-PRSO>>
				  <FSET? ,L-PRSO ,INVISIBLE>>
			      <SET OBJ ,L-PRSO>)>)>
		<COND (,L-PRSI
		       <COND (<OR <NOT <LOC ,L-PRSI>>
				  <FSET? ,L-PRSI ,INVISIBLE>>
			      <SET OBJ ,L-PRSI>)>)>
		<COND (<AND .OBJ 
			    <NOT <EQUAL? .OBJ ,PSEUDO-OBJECT ,ROOMS>>>
		       <TELL "Vous ne pouvez pas voir le " D .OBJ "." CR>
		       <RFATAL>)
		      (T
		       <PERFORM ,L-PRSA ,L-PRSO ,L-PRSI>)>)>>

<ROUTINE V-ALARM ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<COND %<COND (<==? ,ZORK-NUMBER 1>
			      '(<L? <GETP ,PRSO ,P?STRENGTH> 0>
		                <TELL "Le " D ,PRSO " est brutalement réveillée." CR>
		                <AWAKEN ,PRSO>))
			     (T
			      '(<NULL-F> <RTRUE>))>
		      (T
		       <TELL
"Il est bien éveillé, ou vous ne l'avez pas remarqué..." CR>)>)
	       (T
		<TELL "Le " D ,PRSO " ne dort pas." CR>)>>

<ROUTINE V-ANSWER ()
	 <TELL "Personne ne semble attendre votre réponse." CR>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RTRUE>>

<ROUTINE V-ATTACK ()
	 <COND (<NOT <FSET? ,PRSO ,ACTORBIT>>
		<TELL
"J'ai connu des gens étranges, mais combattre un " D ,PRSO "?" CR>)
	       (<OR <NOT ,PRSI>
		    <EQUAL? ,PRSI ,HANDS>>
		<TELL
"Essayer d'attaquer un " D ,PRSO " à mains nues est suicidaire." CR>)
	       (<NOT <IN? ,PRSI ,WINNER>>
		<TELL "Vous ne tenez même pas le " D ,PRSI "." CR>)
	       (<NOT <FSET? ,PRSI ,WEAPONBIT>>
		<TELL
"Essayez d'attaquer le " D ,PRSO " avec un " D ,PRSI " est suicidaire." CR>)
	       (T
	        %<COND (<==? ,ZORK-NUMBER 1>
			'<HERO-BLOW>)
		       (T
			'<TELL "Vous ne pouvez pas." CR>)>)>>

<ROUTINE V-BACK ()
	 <TELL "Désolé, ma mémoire est mauvaise. Veuillez donner une direction." CR>>

<ROUTINE V-BLAST ()
	 <TELL "Vous ne pouvez rien faire exploser en utilisant des mots." CR>>

<ROUTINE PRE-BOARD ("AUX" AV)
	 <SET AV <LOC ,WINNER>>
	 <COND %<COND (<==? ,ZORK-NUMBER 3>
		       '(<EQUAL? ,PRSO ,WATER-CHANNEL ,TM-SEAT ,LAKE>
		         <RFALSE>))
		      (T
		       '(<NULL-F> <RTRUE>))>
	       (<FSET? ,PRSO ,VEHBIT>
		<COND (<NOT <IN? ,PRSO ,HERE>>
		       <TELL
"Le " D ,PRSO " doit être au sol pour être abordé." CR>)
		      (<FSET? .AV ,VEHBIT>
		       <TELL "Vous êtes déjà dans le " D .AV "!" CR>)
		      (T
		       <RFALSE>)>)
	       (<EQUAL? ,PRSO ,WATER ,GLOBAL-WATER>
		<PERFORM ,V?SWIM ,PRSO>
		<RTRUE>)
	       (T
		<TELL
"Vous avez une théorie sur la façon de monter à bord d'un " D ,PRSO ", peut-être ?" CR>)>
	 <RFATAL>>

<ROUTINE V-BOARD ("AUX" AV)
	 <TELL "Vous êtes maintenant dans le " D ,PRSO "." CR>
	 <MOVE ,WINNER ,PRSO>
	 <APPLY <GETP ,PRSO ,P?ACTION> ,M-ENTER>
	 <RTRUE>>

<ROUTINE V-BREATHE ()
	 <PERFORM ,V?INFLATE ,PRSO ,LUNGS>>

<ROUTINE V-BRUSH ()
	 <TELL "Si vous le souhaitez, mais Dieu seul sait pourquoi." CR>>

<ROUTINE V-BUG ()
	 <TELL
"Bug ? Pas dans un programme aussi parfait que celui-ci ! (Toux, toux)." CR>>

<ROUTINE TELL-NO-PRSI ()
	 <TELL "Vous n'avez pas dit avec quoi !" CR>>

<ROUTINE PRE-BURN ()
	 <COND (<NOT ,PRSI>
		<TELL-NO-PRSI>)
	       (<FLAMING? ,PRSI>
	        <RFALSE>)
	       (T
	        <TELL "Avec un " D ,PRSI "??!?" CR>)>>

<ROUTINE V-BURN ()
	 <COND %<COND (<==? ,ZORK-NUMBER 2>
		       '(<EQUAL? <LOC ,PRSO> ,RECEPTACLE>
		         <BALLOON-BURN>
		         <RTRUE>))
		      (T
		       '(<NULL-F> <RFALSE>))>
	       (<FSET? ,PRSO ,BURNBIT>
		<COND (<OR <IN? ,PRSO ,WINNER>
			   <IN? ,WINNER ,PRSO>>
		       <REMOVE-CAREFULLY ,PRSO>
		       <TELL "Le " D ,PRSO>
		       <TELL
" prend feu. Malheureusement, vous le ">
		       <COND (<IN? ,WINNER ,PRSO>
			      <TELL "dans">)
			     (T <TELL "déteniez">)>
		       <JIGS-UP " à ce moment-là.">)
		      (T
		       <REMOVE-CAREFULLY ,PRSO>
		       <TELL
"Le " D ,PRSO " prend feu et se consume." CR>)>)
	       (T
		<TELL "Vous ne pouvez pas brûler un " D ,PRSO "." CR>)>>

<ROUTINE V-CHOMP ()
	 <TELL "Absurde !" CR>>

<ROUTINE V-CLIMB-DOWN () <V-CLIMB-UP ,P?DOWN ,PRSO>>

<ROUTINE V-CLIMB-FOO ()
	 %<COND (<==? ,ZORK-NUMBER 3>
		 '<V-CLIMB-UP <COND (<EQUAL? ,PRSO ,ROPE ,GLOBAL-ROPE>
				     ,P?DOWN)
				    (T ,P?UP)>
			      T>)
		(ELSE
		 '<V-CLIMB-UP ,P?UP ,PRSO>)>>

<ROUTINE V-CLIMB-ON ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		%<COND (<==? ,ZORK-NUMBER 3>
			'<V-CLIMB-UP ,P?UP T>)
		       (ELSE
			'<PERFORM ,V?BOARD ,PRSO>)>
		<RTRUE>)
	       (T
		<TELL "Vous ne pouvez pas grimper sur le " D ,PRSO "." CR>)>>

<ROUTINE V-CLIMB-UP ("OPTIONAL" (DIR ,P?UP) (OBJ <>) "AUX" X TX)
	 <COND (<AND .OBJ <NOT <EQUAL? ,PRSO ,ROOMS>>>
		<SET OBJ ,PRSO>)>
	 <COND (<SET TX <GETPT ,HERE .DIR>>
		<COND (.OBJ
		       <SET X <PTSIZE .TX>>
		       <COND (<OR <EQUAL? .X ,NEXIT>
				  <AND <EQUAL? .X ,CEXIT ,DEXIT ,UEXIT>
				       <NOT <GLOBAL-IN? ,PRSO <GETB .TX 0>>>>>
			      <TELL "Le " D .OBJ " ne">
			      <COND (<NOT <EQUAL? .OBJ ,STAIRS>>
				     <TELL "es">)>
			      <TELL "ne mène pas ">
			      <COND (<==? .DIR ,P?UP>
				     <TELL "haut">)
				    (T <TELL "bas">)>
			      <TELL "ward." CR>
			      <RTRUE>)>)>
		<DO-WALK .DIR>
		<RTRUE>)
	       (<AND .OBJ
		     <ZMEMQ ,W?WALL
			    <SET X <GETPT ,PRSO ,P?SYNONYM>> <PTSIZE .X>>>
		<TELL "Grimper les murs est interdit disponible." CR>)
	       (%<COND (<==? ,ZORK-NUMBER 1>
			'<AND <NOT <EQUAL? ,HERE ,PATH>>
			      <EQUAL? .OBJ <> ,TREE>
			      <GLOBAL-IN? ,TREE ,HERE>>)
		       (ELSE '<NULL-F>)>
		<TELL "Il n'y a pas d'arbres grimpables ici." CR>
		<RTRUE>)
	       (<EQUAL? .OBJ <> ,ROOMS>
		<TELL "Vous ne pouvez pas aller jusque là. chemin." CR>)
	       (T
	        <TELL "Vous ne pouvez pas faire ça !" CR>)>>

<ROUTINE V-CLOSE ()
	 <COND (<AND <NOT <FSET? ,PRSO ,CONTBIT>>
		     <NOT <FSET? ,PRSO ,DOORBIT>>>
		<TELL "Vous devez me dire comment faire cela avec un " D ,PRSO "." CR>)
	       (<AND <NOT <FSET? ,PRSO ,SURFACEBIT>>
		     <NOT <EQUAL? <GETP ,PRSO ,P?CAPACITY> 0>>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <TELL "Fermé." CR>
		       <COND (<AND ,LIT <NOT <SETG LIT <LIT? ,HERE>>>>
			      <TELL "C'est maintenant le pitch noir." CR>)>
		       <RTRUE>)
		      (T
	 	       <TELL "Il est déjà fermé." CR>)>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <TELL "Le " D ,PRSO " est maintenant fermé." CR>)
		      (T
	 	       <TELL "Il est déjà fermé." CR>)>)
	       (T
		<TELL "Vous ne pouvez pas fermer ça." CR>)>>

<ROUTINE V-COMMAND ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "Le " D ,PRSO " n'y prête aucune attention." CR>)
	       (T
		<TELL "Vous ne pouvez pas parler à ça !" CR>)>>

<ROUTINE V-COUNT ()
	 <COND (<EQUAL? ,PRSO ,BLESSINGS>
	 	<TELL "Eh bien, d'une part, vous jouez Zork..." CR>)
	       (T
		<TELL "Vous avez perdu la tête." CR>)>>

<ROUTINE V-CROSS ()
	 <TELL "Vous ne pouvez pas traverser ça !" CR>>

<ROUTINE V-CURSES ()
	 <COND (,PRSO
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <TELL "Insultes de cette nature ne vous aidera pas." CR>)
		      (T
		       <TELL "Quel cinglé !" CR>)>)
	       (T
		<TELL
"Un tel langage dans un établissement haut de gamme comme celui-ci !" CR>)>>

<ROUTINE V-CUT ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?ATTACK ,PRSO ,PRSI>)
	       (<AND <FSET? ,PRSO ,BURNBIT>
		     <FSET? ,PRSI ,WEAPONBIT>>
		<COND (<IN? ,WINNER ,PRSO>
		       <TELL
"Pas une bonne idée, d'autant plus que vous y êtes " CR>
		       <RTRUE>)>
		<REMOVE-CAREFULLY ,PRSO>
		<TELL "Votre habile " D ,PRSI "coupe le " D ,PRSO
" en d'innombrables éclats qui explosent. " CR>)
	       (<NOT <FSET? ,PRSI ,WEAPONBIT>>
		<TELL
"Le « tranchant » d'un " D ,PRSI " n'est guère adéquat." CR>)
	       (T
		<TELL "Concept étrange, coupant le " D ,PRSO "...." CR>)>>

<ROUTINE V-DEFLATE ()
	 <TELL "Allez, maintenant !" CR>>

<ROUTINE V-DIG ()
	 <COND (<NOT ,PRSI>
		<SETG PRSI ,HANDS>)>
	 %<COND (<==? ,ZORK-NUMBER 1>
		 '<COND (<EQUAL? ,PRSI ,SHOVEL>
			 <TELL "Il n'y a aucune raison de creuser ici." CR>
			 <RTRUE>)>)
		(ELSE T)>
	 <COND (<FSET? ,PRSI ,TOOLBIT>
		<TELL "Creusez avec le " D ,PRSI " est lent et fastidieux." CR>)
	       (T
		<TELL "Creuser avec un " D ,PRSI " est idiot." CR>)>>

<ROUTINE V-DISEMBARK ()
	 <COND (<AND <EQUAL? ,PRSO ,ROOMS>
		     <FSET? <LOC ,WINNER> ,VEHBIT>>
		<PERFORM ,V?DISEMBARK <LOC ,WINNER>>
		<RTRUE>)
	       (<NOT <EQUAL? <LOC ,WINNER> ,PRSO>>
		<TELL "Vous n'êtes pas là-dedans !" CR>
		<RFATAL>)
	       (<FSET? ,HERE ,RLANDBIT>
		<TELL "Vous êtes à nouveau autonome." CR>
		<MOVE ,WINNER ,HERE>)
	       (T
		<TELL
"Vous réalisez que sortir d'ici serait fatal." CR>
		<RFATAL>)>>

<ROUTINE V-DISENCHANT ()
	 %<COND (<==? ,ZORK-NUMBER 2>
		 '<COND (<NOT <IN? ,PRSO ,HERE>>
		         <RTRUE>)
	                (<OR <EQUAL? ,SPELL-USED ,W?FEEBLE ,W?FUMBLE ,W?FEAR>
		          <EQUAL? ,SPELL-USED ,W?FREEZE ,W?FALL ,W?FERMENT>
		          <EQUAL? ,SPELL-USED ,W?FIERCE ,W?FENCE ,W?FANTASIZE>>
		          <COND (<FSET? ,PRSO ,ACTORBIT>
		                 <COND (<EQUAL? ,SPELL-USED ,W?FEEBLE>
			                <TELL
"Le " D ,PRSO " semble plus fort maintenant." CR>)
			               (<EQUAL? ,SPELL-USED ,W?FUMBLE>
			                <TELL
"Le " D ,PRSO " n'apparaît plus maladroit." CR>)
			               (<EQUAL? ,SPELL-USED ,W?FEAR>
			                <TELL
"Le " D ,PRSO " n'apparaît plus peur." CR>)
			               (<EQUAL? ,SPELL-USED ,W?FREEZE>
			                <TELL
"Le " D ,PRSO " bouge à nouveau." CR>)
			               (<EQUAL? ,SPELL-USED ,W?FERMENT>
			                <TELL
"Le " D ,PRSO " arrête de se balancer." CR>)
			               (<EQUAL? ,SPELL-USED ,W?FIERCE>
			                <TELL
"Le " D ,PRSO " apparaît plus paisible." CR>)>)>)
	                        (<EQUAL? ,SPELL-USED ,W?FLOAT>
		                 <TELL
"Le " D ,PRSO " coule au sol." CR>)
	                        (<EQUAL? ,SPELL-USED ,W?FUDGE>
		                 <TELL "La douce odeur s'est dispersée." CR>)>)
		(T
		 '<TELL "Rien ne se passe." CR>)>>

<ROUTINE V-DRINK ()
	 <V-EAT>>

<ROUTINE V-DRINK-FROM ()
	 <TELL "Comment particulier !" CR>>

<ROUTINE PRE-DROP ()
	 <COND (<EQUAL? ,PRSO <LOC ,WINNER>>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)>>

<ROUTINE V-DROP ()
	 <COND (<IDROP>
		<TELL "Lâché." CR>)>>

<ROUTINE V-EAT ("AUX" (EAT? <>) (DRINK? <>) (NOBJ <>))
	 <COND (<SET EAT? <FSET? ,PRSO ,FOODBIT>>
		<COND (<AND <NOT <IN? ,PRSO ,WINNER>>
			    <NOT <IN? <LOC ,PRSO> ,WINNER>>>
		       <TELL "Vous ne tenez pas ça." CR>)
		      (<VERB? DRINK>
		       <TELL "Comment pouvez-vous boire ça ?">)
		      (T
		       <TELL "Merci beaucoup. Il a vraiment frappé.">
		       <REMOVE-CAREFULLY ,PRSO>)>
		<CRLF>)
	       (<FSET? ,PRSO ,DRINKBIT>
		<SET DRINK? T>
		<SET NOBJ <LOC ,PRSO>>
		<COND (<OR <IN? ,PRSO ,GLOBAL-OBJECTS>
			   <GLOBAL-IN? ,GLOBAL-WATER ,HERE>
			   <EQUAL? ,PRSO ,PSEUDO-OBJECT>>
		       <HIT-SPOT>)
		      (<OR <NOT .NOBJ>
			   <NOT <ACCESSIBLE? .NOBJ>>>
		       <TELL
"Il n'y a pas d'eau ici." CR>)
		      (<AND <ACCESSIBLE? .NOBJ>
			    <NOT <IN? .NOBJ ,WINNER>>>
		       <TELL
"Vous devez tenir le " D .NOBJ " d'abord." CR>)
		      (<NOT <FSET? .NOBJ ,OPENBIT>>
		       <TELL
"Vous devrez ouvrir le " D .NOBJ " d'abord." CR>)
		      (T
		       <HIT-SPOT>)>)
	       (<NOT <OR .EAT? .DRINK?>>
		<TELL
"Je ne pense pas que le " D ,PRSO " serait d'accord avec vous." CR>)>>

<ROUTINE HIT-SPOT ()
	 <COND (<AND <EQUAL? ,PRSO ,WATER>
		     <NOT <GLOBAL-IN? ,GLOBAL-WATER ,HERE>>>
		<REMOVE-CAREFULLY ,PRSO>)>
	 <TELL
"Merci beaucoup. J'avais plutôt soif (de toute cette conversation, probablement)." CR>>

<ROUTINE V-ECHO ("AUX" LST MAX (ECH 0) CNT) 
	 #DECL ((LST) <PRIMTYPE VECTOR> (MAX CNT ECH) FIX)
	 %<COND (<==? ,ZORK-NUMBER 1>
		 '<COND (<G? <GETB ,P-LEXV ,P-LEXWORDS> 0>
	                 <SET LST <REST 
				   ,P-LEXV
				   <* <GETB ,P-LEXV ,P-LEXWORDS> ,P-WORDLEN>>>
	                 <SET MAX <- <+ <GETB .LST 0> <GETB .LST 1>> 1>>
	                 <REPEAT ()
		            <COND (<G? <SET ECH <+ .ECH 1>> 2>
			           <TELL "..." CR>
				   <RETURN>)
			          (T
			           <SET CNT <- <GETB .LST 1> 1>>
			           <REPEAT ()
				      <COND (<G? <SET CNT <+ .CNT 1>> .MAX>
					     <RETURN>)
					    (T
					     <PRINTC <GETB ,P-INBUF .CNT>>)>>
			           <TELL " ">)>>)
			(T <TELL "echo echo ..." CR>)>)
		(T
		 '<TELL "echo echo ..." CR>)>>

<ROUTINE V-ENCHANT ()
%<COND (<==? ,ZORK-NUMBER 2>
	'<COND (,WAND-ON <SETG SPELL-VICTIM ,WAND-ON>)>)
       (T
	'<NULL-F>)>
%<COND (<==? ,ZORK-NUMBER 2>
	'<COND (,SPELL-VICTIM
		<COND (<NOT ,SPELL-USED>
		       <TELL "Vous devez être plus précis." CR>
		       <RTRUE>)>
		<COND (<OR <EQUAL? ,SPELL-USED ,W?FEEBLE ,W?FUMBLE ,W?FEAR>
			   <EQUAL? ,SPELL-USED ,W?FREEZE ,W?FALL ,W?FERMENT>
			   <EQUAL? ,SPELL-USED ,W?FIERCE ,W?FENCE ,W?FANTASIZE>>
		       <COND (<FSET? ,PRSO ,ACTORBIT>
			      <TELL
"La baguette cesse de briller, mais il n'y a pas d'autre évidence " CR>)
			     (T
			      <TELL
"Cela a peut-être fait quelque chose, mais c'est difficile à dire avec un " D ,PRSO "." CR>)>)
		      ;(<EQUAL? ,SPELL-USED ,W?FIREPROOF>
		       <RTRUE>)
		      (<EQUAL? ,SPELL-USED ,W?FUDGE>
		       <TELL
"Une forte odeur de chocolat imprègne la pièce." CR>)
		      (<EQUAL? ,SPELL-USED ,W?FLUORESCE>
		       <FSET ,PRSO ,LIGHTBIT>
		       <FSET ,PRSO ,ONBIT>
		       <SETG LIT T>
		       <TELL
"Le " D ,PRSO " commence à lueur." CR>)
		      (<EQUAL? ,SPELL-USED ,W?FILCH>
		       <SETG SPELL-HANDLED? T>
		       <COND (<FSET? ,PRSO ,TAKEBIT>
			      <MOVE ,PRSO ,WINNER>
			      <SCORE-OBJ ,PRSO>
			      <TELL "Dérobé !" CR>)
			     (ELSE
			      <TELL "Vous ne pouvez pas voler les " D ,PRSO "!" CR>)>)
		      (<AND <EQUAL? ,SPELL-USED ,W?FLOAT>
			    <FSET? ,PRSO ,TAKEBIT>>
		       <COND (<AND <EQUAL? ,SPELL-VICTIM ,COLLAR>
				   <IN? ,COLLAR ,CERBERUS>>
			      <SETG SPELL-VICTIM ,CERBERUS>)>
		       <TELL
"Le " D ,PRSO " flotte sereinement dans dans les airs." CR>)
		      (<AND <EQUAL? ,SPELL-USED ,W?FRY>
			    <FSET? ,PRSO ,TAKEBIT>>
		       <SETG SPELL-HANDLED? T>
		       <REMOVE-CAREFULLY ,PRSO>
		       <TELL "Le " D ,PRSO " s'élève dans un nuage de fumée." CR>)
		      (ELSE
		       <SETG SPELL-VICTIM <>>
		       <TELL
"La baguette cesse de briller, mais il n'y a aucun autre effet apparent." CR>)>)
	       (ELSE
		<SETG SPELL-VICTIM <>>
		<TELL "Rien ne se passe." CR>)>)
       (T
	'<V-DISENCHANT>)>>

<ROUTINE REMOVE-CAREFULLY (OBJ "AUX" OLIT)
	 <COND (<EQUAL? .OBJ ,P-IT-OBJECT>
		<SETG P-IT-OBJECT <>>)>
	 <SET OLIT ,LIT>
	 <REMOVE .OBJ>
	 <SETG LIT <LIT? ,HERE>>
	 <COND (<AND .OLIT <NOT <EQUAL? .OLIT ,LIT>>>
		<TELL "Vous vous retrouvez dans le noir..." CR>)>
	 T>

<ROUTINE V-ENTER ()
	<DO-WALK ,P?IN>>

<ROUTINE V-EXAMINE ()
	 <COND (<GETP ,PRSO ,P?TEXT>
		<TELL <GETP ,PRSO ,P?TEXT> CR>)
	       (<OR <FSET? ,PRSO ,CONTBIT>
		    <FSET? ,PRSO ,DOORBIT>>
		<V-LOOK-INSIDE>)
	       (T
		<TELL "Il n'y a rien de spécial à propos du " D ,PRSO "." CR>)>>

<ROUTINE V-EXIT ()
	 <COND (<AND <EQUAL? ,PRSO <> ,ROOMS>
		     <FSET? <LOC ,WINNER> ,VEHBIT>>
		<PERFORM ,V?DISEMBARK <LOC ,WINNER>>
		<RTRUE>)
	       (<AND ,PRSO <IN? ,WINNER ,PRSO>>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (ELSE
		<DO-WALK ,P?OUT>)>>

<ROUTINE V-EXORCISE ()
	 <TELL "Quel concept bizarre !" CR>>

<ROUTINE PRE-FILL ("AUX" TX)
	 <COND (<NOT ,PRSI>
		<SET TX <GETPT ,HERE ,P?GLOBAL>>
		<COND (<AND .TX <ZMEMQB ,GLOBAL-WATER .TX <- <PTSIZE .TX> 1>>>
		       <PERFORM ,V?FILL ,PRSO ,GLOBAL-WATER>
		       <RTRUE>)
		      (<IN? ,WATER <LOC ,WINNER>>
		       <PERFORM ,V?FILL ,PRSO ,WATER>
		       <RTRUE>)
		      (T
		       <TELL "Il n'y a rien pour le remplir." CR>
		       <RTRUE>)>)>
	 <COND (<EQUAL? ,PRSI ,WATER>
		<RFALSE>)
	       (<NOT <EQUAL? ,PRSI ,GLOBAL-WATER>>
		<PERFORM ,V?PUT ,PRSI ,PRSO>
		<RTRUE>)>>

;"OLD ZORK1 PRE-FILL"
;<ROUTINE PRE-FILL ("AUX" TX) 
	 <COND (<NOT ,PRSI>
		<COND (<AND <SET TX <GETPT ,HERE ,P?GLOBAL>>
			    <ZMEMQB ,GLOBAL-WATER .TX <- <PTSIZE .TX> 1>>>
		       <SETG PRSI ,GLOBAL-WATER>
		       <RFALSE>)
		      (T
		       <TELL "Il n'y a rien pour le remplir." CR>
		       <RTRUE>)>)
	       (<NOT <EQUAL? ,PRSI ,GLOBAL-WATER>>
		<PERFORM ,V?PUT ,PRSI ,PRSO>
		<RTRUE>)>>

<ROUTINE V-FILL ()
	 <COND (<NOT ,PRSI>
		<COND (<GLOBAL-IN? ,GLOBAL-WATER ,HERE>
		       <PERFORM ,V?FILL ,PRSO ,GLOBAL-WATER>
		       <RTRUE>)
		      (<IN? ,WATER <LOC ,WINNER>>
		       <PERFORM ,V?FILL ,PRSO ,WATER>
		       <RTRUE>)
		      (T
		       <TELL "Il n'y a rien pour le remplir. avec." CR>)>)
	       (T
		<TELL "Vous savez peut-être comment faire cela, mais pas moi." CR>)>>

<ROUTINE V-FIND ("AUX" (L <LOC ,PRSO>))
	 <COND (<EQUAL? ,PRSO ,HANDS ,LUNGS>
		<TELL
"A moins de 6 pieds de la tête, en supposant que tu n'as pas laissé ça quelque part." CR>)
	       (<EQUAL? ,PRSO ,ME>
		<TELL "Vous êtes par ici quelque part..." CR>)
	       (<EQUAL? .L ,GLOBAL-OBJECTS>
		<TELL "Vous le trouvez." CR>)
	       (<IN? ,PRSO ,WINNER>
		<TELL "Vous avez " CR>)
	       (<OR <IN? ,PRSO ,HERE>
		    <GLOBAL-IN? ,PRSO ,HERE>
		    <EQUAL? ,PRSO ,PSEUDO-OBJECT>>
		<TELL "C'est ici." CR>)
	       (<FSET? .L ,ACTORBIT>
		<TELL "Le " D .L " l'a." CR>)
	       (<FSET? .L ,SURFACEBIT>
		<TELL "C'est sur le " D .L "." CR>)
	       (<FSET? .L ,CONTBIT>
		<TELL "C'est dans le " D .L "." CR>)
	       (T
		<TELL "Me bat." CR>)>>

<ROUTINE V-FOLLOW ()
	 <TELL "Vous êtes fou !" CR>>

<ROUTINE V-FROBOZZ ()
	 <TELL
"La société FROBOZZ a créé, possède et exploite ce donjon." CR>>

<ROUTINE PRE-GIVE ()
	 <COND (<NOT <HELD? ,PRSO>>
		<TELL 
"C'est facile pour vous de le dire puisque vous n'avez même pas le " D ,PRSO "." CR>)>>

<ROUTINE V-GIVE ()
	 <COND (<NOT <FSET? ,PRSI ,ACTORBIT>>
		<TELL "Vous ne pouvez pas donner un " D ,PRSO " à un " D ,PRSI "!" CR>)
	       (T
		<TELL "Le " D ,PRSI " le refuse poliment." CR>)>>

<ROUTINE V-HATCH ()
	 <TELL "Bizarre !" CR>>

<GLOBAL HS 0> ;"counts occurences of HELLO, SAILOR"

<ROUTINE V-HELLO ()
	 <COND (,PRSO
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <TELL
"Le " D ,PRSO " incline la tête vers vous en guise de salutation." CR>)
		      (T
		       <TELL
"C'est un fait bien connu que seul Les schizophrènes disent \"Bonjour\" à un "
D ,PRSO "." CR>)>)
	       (T
		<TELL <PICK-ONE ,HELLOS> CR>)>>

<ROUTINE V-INCANT ()
%<COND (<==? ,ZORK-NUMBER 2>
	'<COND (,SPELL-USED
		<TELL "Rien ne se passe." CR>)
	       (,WAND-ON
		<SETG SPELL-VICTIM ,WAND-ON>
		<SETG SPELL-USED <GET ,P-LEXV ,P-CONT>>
		<TELL "La baguette brille très fort pendant un instant." CR>
		<ENABLE <QUEUE I-SPELL <+ 10 <RANDOM 10>>>>
		<SETG WAND-ON <>>
		<PERFORM ,V?ENCHANT ,SPELL-VICTIM>)
	       (T
		<TELL
"L'incantation résonne faiblement, mais rien d'autre. se produit." CR>)>)
       (T
	'<TELL
"L'incantation résonne faiblement, mais rien d'autre. se produit." CR>)>
	 <SETG QUOTE-FLAG <>>
	 <SETG P-CONT <>>
	 <RTRUE>>

<ROUTINE V-INFLATE ()
	 <TELL "Comment pouvez-vous gonfler cela ?" CR>>

;<ROUTINE V-IS-IN ()
	 <COND (<IN? ,PRSO ,PRSI>
		<TELL "Oui, c'est le cas ">
		<COND (<FSET? ,PRSI ,SURFACEBIT>
		       <TELL "sur">)
		      (T
		       <TELL "dans">)>
		<TELL " le " D ,PRSI "." CR>)
	       (T
		<TELL "Non, il ce n'est pas le cas." CR>)>>

<ROUTINE V-KICK () <HACK-HACK "Donner un coup de pied au ">>

<ROUTINE V-KISS ()
	 <TELL "Je préférerais embrasser un cochon." CR>>

<ROUTINE V-KNOCK ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<TELL "Personne n'est à la maison." CR>)
	       (T
		<TELL "Pourquoi frapper à un " D ,PRSO "?" CR>)>>

<ROUTINE V-LAMP-OFF ()
	 <COND (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<NOT <FSET? ,PRSO ,ONBIT>>
		       <TELL "Il est déjà éteint." CR>)
		      (T
		       <FCLEAR ,PRSO ,ONBIT>
		       <COND (,LIT
			      <SETG LIT <LIT? ,HERE>>)>
		       <TELL "Le " D ,PRSO " est maintenant éteint." CR>
		       <COND (<NOT ,LIT>
			      <TELL "C'est maintenant le pitch noir." CR>)>)>)
	       (T
		<TELL "Vous ne pouvez pas le désactiver." CR>)>
	 <RTRUE>>

<ROUTINE V-LAMP-ON ()
	 <COND (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<FSET? ,PRSO ,ONBIT>
		       <TELL "Il est déjà allumé." CR>)
		      (T
		       <FSET ,PRSO ,ONBIT>
		       <TELL "Le " D ,PRSO " est maintenant allumé." CR>
		       <COND (<NOT ,LIT>
			      <SETG LIT <LIT? ,HERE>>
			      <CRLF>
			      <V-LOOK>)>)>)
	       (<FSET? ,PRSO ,BURNBIT>
		<TELL
"Si vous souhaitez graver le " D ,PRSO ", vous devez dire donc." CR>)
	       (T
		<TELL "Vous ne pouvez pas l'activer." CR>)>
	 <RTRUE>>

<ROUTINE V-LAUNCH ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<TELL "Vous ne pouvez pas lancer cela en disant « lancer » !" CR>)
	       (T
		<TELL "C'est joli bizarre." CR>)>>

<ROUTINE V-LEAN-ON ()
	 <TELL "Vous êtes fatigué ?" CR>>

<ROUTINE V-LEAP ("AUX" TX S)
	 <COND (,PRSO
		<COND (<IN? ,PRSO ,HERE>
		       <COND (<FSET? ,PRSO ,ACTORBIT>
			      <TELL
"Le " D ,PRSO " est trop gros pour sauter par-dessus." CR>)
			     (T
			      <V-SKIP>)>)
		      (T
		       <TELL "Ce serait une bonne chose astuce." CR>)>)
	       (<SET TX <GETPT ,HERE ,P?DOWN>>
		<SET S <PTSIZE .TX>>
		<COND (<OR <EQUAL? .S 2> ;NEXIT
       			   <AND <EQUAL? .S 4> ;CEXIT
				<NOT <VALUE <GETB .TX 1>>>>>
		       <TELL
"Ce n'était pas un endroit très sûr pour essayer de sauter." CR>
		       <JIGS-UP <PICK-ONE ,JUMPLOSS>>)
		      %<COND (<==? ,ZORK-NUMBER 1>
			      '(<EQUAL? ,HERE ,UP-A-TREE>
		                <TELL
"Dans un exploit d'audace inaccoutumée, vous arrivez à atterrir sur vos pieds sans vous tuer." CR CR>
		                <DO-WALK ,P?DOWN>
		                <RTRUE>))
			     (T '(<NULL-F> T))>
		      (T
		       <V-SKIP>)>)
	       (T
		<V-SKIP>)>>

<GLOBAL JUMPLOSS
	<LTABLE 0
	       "Vous auriez dû regarder avant de sauter."
	       "Dans les films, votre vie se déroulerait avant votre yeux."
	       "Geronimo...">>

<ROUTINE V-LEAVE () <DO-WALK ,P?OUT>>

<ROUTINE V-LISTEN ()
	 <TELL "Le " D ,PRSO " ne fait aucun son." CR>>

<ROUTINE V-LOCK ()
	 <TELL "Il ne semble pas fonctionne." CR>>

<ROUTINE V-LOOK ()
	 <COND (<DESCRIBE-ROOM T>
		<DESCRIBE-OBJECTS T>)>>

<ROUTINE V-LOOK-BEHIND ()
	 <TELL "Il n'y a rien derrière le " D ,PRSO "." CR>>

<ROUTINE V-LOOK-INSIDE ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL
"Le " D ,PRSO " qui est ouvert, mais je ne peux pas dire ce qu'il y a au-delà.">)
		      (T
		       <TELL "Le " D ,PRSO " est fermé.">)>
		<CRLF>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <TELL "Il n'y a rien de spécial à voir." CR>)
		      (<SEE-INSIDE? ,PRSO>
		       <COND (<AND <FIRST? ,PRSO>
				   <PRINT-CONT ,PRSO>>
			      <RTRUE>)
			     %<COND (<==? ,ZORK-NUMBER 3>
				     '(<FSET? ,PRSO ,SURFACEBIT>
				       <TELL
"Il n'y a rien sur le " D ,PRSO "." CR>))
				    (ELSE '(<NULL-F> <RTRUE>))>
			     (T
			      <TELL "Le " D ,PRSO " vide." CR>)>)
		      (T
		       <TELL "Le " D ,PRSO " est fermé." CR>)>)
	       (T
		<TELL "Vous ne pouvez pas regarder à l'intérieur d'un " D ,PRSO "." CR>)>>

<ROUTINE V-LOOK-ON ()
	 <COND (<FSET? ,PRSO ,SURFACEBIT>
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)
	       (T
		<TELL "Regardez sur un " D ,PRSO "???" CR>)>>

<ROUTINE V-LOOK-UNDER ()
	 <TELL "Il n'y a que de la poussière là." CR>>

<ROUTINE V-LOWER () <HACK-HACK "Jouer de cette façon avec le ">>

<ROUTINE V-MAKE ()
    	<TELL "Vous ne pouvez pas faire ça." CR>>

<ROUTINE V-MELT ()
	 <TELL "Il n'est pas clair qu'un " D ,PRSO " peut fondre." CR>>

<ROUTINE PRE-MOVE ()
	 <COND (<HELD? ,PRSO>
		<TELL "Vous n'êtes pas un jongleur assez accompli." CR>)>>

<ROUTINE V-MOVE ()
	 <COND (<FSET? ,PRSO ,TAKEBIT>
		<TELL "Déplacer le " D ,PRSO " ne révèle rien." CR>)
	       (T
		<TELL "Vous ne pouvez pas déplacer le " D ,PRSO "." CR>)>>

<ROUTINE V-MUMBLE ()
	 <TELL "Vous devrez parler si vous voulez que j'entende vous !" CR>>

<ROUTINE PRE-MUNG ()
	 <COND %<COND (<==? ,ZORK-NUMBER 3>
		       '(<EQUAL? ,PRSO ,BEAM>
		         <RFALSE>))
		      (T
		       '(<NULL-F> <RTRUE>))>
	       (<OR <NOT ,PRSI>
		    <NOT <FSET? ,PRSI ,WEAPONBIT>>>
		<TELL "Essayer de détruire le " D ,PRSO " avec ">
		<COND (<NOT ,PRSI>
		       <TELL "votre nu mains">)
		      (T
		       <TELL "un " D ,PRSI>)>
		<TELL " est inutile." CR>)>>

<ROUTINE V-MUNG ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?ATTACK ,PRSO>
		<RTRUE>)
	       (T
		<TELL "Joli essayez." CR>)>>

<ROUTINE V-ODYSSEUS ()
	 <COND %<COND (<==? ,ZORK-NUMBER 1>
		       '(<AND <EQUAL? ,HERE ,CYCLOPS-ROOM>
			      <IN? ,CYCLOPS ,HERE>
			      <NOT ,CYCLOPS-FLAG>>
		         <DISABLE <INT I-CYCLOPS>>
		         <SETG CYCLOPS-FLAG T>
		         <TELL 
"Les cyclopes, entendant le nom de la némésis mortelle de son père, fuient la pièce en frappant le mur à l'est de la pièce." CR>
		        <SETG MAGIC-FLAG T>
		        <FCLEAR ,CYCLOPS ,FIGHTBIT>
		        <REMOVE-CAREFULLY ,CYCLOPS>))
		      (T
		       '(<NULL-F> T))>
	       (T
		<TELL "N'était-il pas un marin ?" CR>)>>

<ROUTINE V-OIL ()
	 <TELL "Vous avez probablement mis des épinards dans votre réservoir d'essence, aussi." CR>>

<ROUTINE V-OPEN ("AUX" F STR)
	 <COND (<AND <FSET? ,PRSO ,CONTBIT>
		     <NOT <EQUAL? <GETP ,PRSO ,P?CAPACITY> 0>>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "Il est déjà ouvert." CR>)
		      (T
		       <FSET ,PRSO ,OPENBIT>
		       <FSET ,PRSO ,TOUCHBIT>
		       <COND (<OR <NOT <FIRST? ,PRSO>> <FSET? ,PRSO ,TRANSBIT>>
			      <TELL "Ouvert." CR>)
			     (<AND <SET F <FIRST? ,PRSO>>
				   <NOT <NEXT? .F>>
				   <NOT <FSET? .F ,TOUCHBIT>>
				   <SET STR <GETP .F ,P?FDESC>>>
			      <TELL "Le " D ,PRSO " s'ouvre." CR>
			      <TELL .STR CR>)
			     (T
			      <TELL "L'ouverture du " D ,PRSO " révèle ">
			      <PRINT-CONTENTS ,PRSO>
			      <TELL "." CR>)>)>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "Il est déjà ouvert." CR>)
		      (T
		       <TELL "Le " D ,PRSO " s'ouvre." CR>
		       <FSET ,PRSO ,OPENBIT>)>)
	       (T
		<TELL
"Vous devez me dire comment faire cela avec un " D ,PRSO "." CR>)>>

<ROUTINE V-OVERBOARD ("AUX" LOCN)
	 <COND %<COND (<==? ,ZORK-NUMBER 1>
		       '(<EQUAL? ,PRSI ,TEETH>
			 <COND (<FSET? <SET LOCN <LOC ,WINNER>> ,VEHBIT>
				<MOVE ,PRSO <LOC .LOCN>>
				<TELL "Ohé -- " D ,PRSO " par-dessus bord !" CR>)
			       (T
				<TELL "Vous n'êtes pas dans n'importe quoi !" CR>)>))
		      (T '(<NULL-F> T))>
	       (<FSET? <LOC ,WINNER> ,VEHBIT>
		<PERFORM ,V?THROW ,PRSO>
		<RTRUE>)
	       (T
		<TELL "Hein ?" CR>)>>

<ROUTINE V-PICK () <TELL "Vous ne pouvez pas choisir ça." CR>>

<ROUTINE V-PLAY ()
    <COND (<FSET? ,PRSO ,ACTORBIT>
	   <TELL
"Vous devenez tellement absorbé par le rôle du " D ,PRSO "que vous vous tuez, comme il aurait pu le faire !" CR>
	   <JIGS-UP "">)
	  (ELSE <TELL "C'est idiot !" CR>)>>

<ROUTINE V-PLUG ()
	 <TELL "Cela n'a aucun effet." CR>>

<ROUTINE V-POUR-ON ()
	 <COND (<EQUAL? ,PRSO ,WATER>
		<REMOVE-CAREFULLY ,PRSO>
	        <COND (<FLAMING? ,PRSI>
		       <TELL "Le " D ,PRSI " est éteint." CR>
		       %<COND (<==? ,ZORK-NUMBER 2>
			       '<COND (<EQUAL? ,PRSI ,BINF-FLAG>
				       <SETG BINF-FLAG <>>)>)
			      (ELSE '<NULL-F>)>
		       <FCLEAR ,PRSI ,ONBIT>
		       <FCLEAR ,PRSI ,FLAMEBIT>)
	              (T
		       <TELL
"L'eau se répand sur le " D ,PRSI ", jusqu'au sol et s'évapore." CR>)>)
	       %<COND (<==? ,ZORK-NUMBER 1>
		       '(<EQUAL? ,PRSO ,PUTTY>
			 <PERFORM ,V?PUT ,PUTTY ,PRSI>))
		      (T
		       '(<NULL-F> <RTRUE>))>
	       (T
		<TELL "Vous ne pouvez pas verser ça." CR>)>>

<ROUTINE V-PRAY ()
	 <COND %<COND (<==? ,ZORK-NUMBER 1>
		       '(<EQUAL? ,HERE ,SOUTH-TEMPLE>
		         <GOTO ,FOREST-1>))
		      (T
		       '(<NULL-F> <RTRUE>))>
	       (T
		<TELL
"Si vous priez suffisamment, vos prières pourraient être exaucées." CR>)>>

<ROUTINE V-PUMP ()
	 <COND %<COND (<==? ,ZORK-NUMBER 1>
		       '(<AND ,PRSI <NOT <EQUAL? ,PRSI ,PUMP>>>
		         <TELL "Pompez-le avec un " D ,PRSI "?" CR>))
		      (T
		       '(<NULL-F> <RTRUE>))>
	       %<COND (<==? ,ZORK-NUMBER 1>
		       '(<IN? ,PUMP ,WINNER>
		         <PERFORM ,V?INFLATE ,PRSO ,PUMP>))
		      (T
		       '(<NULL-F> <RTRUE>))>
	       (T
		<TELL "Ce n'est vraiment pas clair comment." CR>)>>

<ROUTINE V-PUSH () <HACK-HACK "Pousser le ">>

<ROUTINE V-PUSH-TO ()
	 <TELL "Vous ne pouvez pas pousser les choses à cela." CR>>

<ROUTINE PRE-PUT ()
	 <COND %<COND (<==? ,ZORK-NUMBER 3>
		       '(<EQUAL? ,PRSO ,SHORT-POLE>
		         <RFALSE>))
		      (T
		       '(<NULL-F>
			 <RFALSE>))>
	       (T
		<PRE-GIVE>)>> ;"That's easy for you to say..."

<ROUTINE V-PUT ()
	 <COND (<OR <FSET? ,PRSI ,OPENBIT>
		    <OPENABLE? ,PRSI>
		    <FSET? ,PRSI ,VEHBIT>>)
	       (T
		<TELL "Vous ne pouvez pas faire ça." CR>
		<RTRUE>)>
	 <COND (<NOT <FSET? ,PRSI ,OPENBIT>>
		<TELL "Le " D ,PRSI " n'est pas ouvert." CR>
		<THIS-IS-IT ,PRSI>)
	       (<EQUAL? ,PRSI ,PRSO>
		<TELL "Comment pouvez-vous faire cela ?" CR>)
	       (<IN? ,PRSO ,PRSI>
		<TELL "Le " D ,PRSO " est déjà dans le " D ,PRSI "." CR>)
	       (<G? <- <+ <WEIGHT ,PRSI> <WEIGHT ,PRSO>>
		       <GETP ,PRSI ,P?SIZE>>
		    <GETP ,PRSI ,P?CAPACITY>>
		<TELL "Il n'y a pas salle." CR>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <FSET? ,PRSO ,TRYTAKEBIT>>
		<TELL "Vous n'avez pas le " D ,PRSO "." CR>
		<RTRUE>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <NOT <ITAKE>>>
		<RTRUE>)
	       (T
		<MOVE ,PRSO ,PRSI>
		<FSET ,PRSO ,TOUCHBIT>
		<SCORE-OBJ ,PRSO>
		<TELL "Terminé." CR>)>>

<ROUTINE V-PUT-BEHIND ()
	 <TELL "Cette cachette est trop évidente." CR>>

<ROUTINE V-PUT-ON ()
	 <COND (<EQUAL? ,PRSI ,GROUND>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSI ,SURFACEBIT>
		<V-PUT>)
	       (T
		<TELL "Il n'y a pas de bonne surface sur la " D ,PRSI "." CR>)>>

<ROUTINE V-PUT-UNDER ()
	 <TELL "Vous ne pouvez pas faire ça." CR>>

<ROUTINE V-RAISE ()
	 <V-LOWER>>

<ROUTINE V-RAPE ()
	 <TELL "Quelle (hum !) idée étrange." CR>>

<ROUTINE PRE-READ ()
	 <COND (<NOT ,LIT>
		<TELL "Il est impossible de lire dans le noir." CR>)
	       (<AND ,PRSI <NOT <FSET? ,PRSI ,TRANSBIT>>>
		<TELL "Comment regarder à travers un " D ,PRSI "?" CR>)>>

<ROUTINE V-READ ()
	 <COND (<NOT <FSET? ,PRSO ,READBIT>>
		<TELL "Comment lire un " D ,PRSO "?" CR>)
	       (T
		<TELL <GETP ,PRSO ,P?TEXT> CR>)>>

<ROUTINE V-READ-PAGE ()
	 <PERFORM ,V?READ ,PRSO>
	 <RTRUE>>

<ROUTINE V-REPENT ()
	 <TELL "Il pourrait très bien être trop tard !" CR>>

<ROUTINE V-REPLY ()
	 <TELL "Il est peu probable que le " D ,PRSO " est intéressé." CR>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RTRUE>>

<ROUTINE V-RING ()
	 <TELL "Comment, exactement, pouvez-vous appeler cela ?" CR>>

<ROUTINE V-RUB () <HACK-HACK "Je joue avec le ">>

<ROUTINE V-SAY ("AUX" V)
	 %<COND (<==? ,ZORK-NUMBER 2>
		 '<COND (<OR ,SPELL-USED ,WAND-ON>
		         <PERFORM ,V?INCANT>
		         <RTRUE>)>)
		(<==? ,ZORK-NUMBER 3>
		 '<COND (<AND <FSET? ,FRONT-DOOR ,TOUCHBIT>
		              <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?FROTZ>
		              <EQUAL? <GET ,P-LEXV <+ ,P-CONT 2>> ,W?OZMOO>>
		         <SETG P-CONT <>>
		         <COND (<EQUAL? ,HERE ,MSTAIRS>
		                <CRLF>
		                <GOTO ,FRONT-DOOR>)
		               (T
		                <TELL "Rien ne se passe." CR>)>
		                <RTRUE>)>)
		(T
		 '<COND (<NOT ,P-CONT>
			 <TELL "Dites quoi ?" CR>
			 <RTRUE>)>)>
	 <SETG QUOTE-FLAG <>>
	 <COND (<SET V <FIND-IN ,HERE ,ACTORBIT>>
		<TELL "Vous devez vous adresser au " D .V " directement." CR>
		<SETG P-CONT <>>)
	       (<NOT <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?HELLO>>
	        <SETG P-CONT <>>
		<TELL
"Parler à soi-même est le signe d'un effondrement mental imminent." CR>)>
	 <RTRUE>>

<ROUTINE V-SEARCH ()
	 <TELL "Vous ne trouvez rien d'inhabituel." CR>>

<ROUTINE V-SEND ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "Pourquoi enverriez-vous chercher le " D ,PRSO "?" CR>)
	       (T
		<TELL "Cela n'effectue pas d'envois." CR>)>>

<ROUTINE PRE-SGIVE ()
	 <PERFORM ,V?GIVE ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SGIVE ()
	 <TELL "Foo !" CR>>

<ROUTINE V-SHAKE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "Cela semble n'avoir aucun effet." CR>)
	       (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<TELL "Vous ne pouvez pas le prendre ; vous ne pouvez donc pas le secouer !" CR>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <COND (<FIRST? ,PRSO>
			      <SHAKE-LOOP>
			      <TELL "Le contenu du " D, PRSO " déverse ">
	                      <COND (%<COND (<==? ,ZORK-NUMBER 3>
					     '<FSET? ,HERE ,NONLANDBIT>)
					    (ELSE
					     '<NOT <FSET? ,HERE ,RLANDBIT>>)>
		                     <TELL "et disparaît">)
	                            (T
		                     <TELL "au sol">)>
	                      <TELL "." CR>)
			     (T
			      <TELL "Secoué." CR>)>)
		      (T
		       <COND (<FIRST? ,PRSO>
			      <TELL
"On dirait qu'il y a quelque chose à l'intérieur du " D ,PRSO "." CR>)
			     (T
			      <TELL "Le " D, PRSO " semble vide." CR>)>)>)
	       (T
		<TELL "Secoué." CR>)>>

<ROUTINE SHAKE-LOOP ("AUX" X)
	 <REPEAT ()
		 <COND (<SET X <FIRST? ,PRSO>>
			<FSET .X ,TOUCHBIT>
			<MOVE .X
			      %<COND (<==? ,ZORK-NUMBER 1>
				      '<COND (<EQUAL? ,HERE ,UP-A-TREE>
				              ,PATH)
				             (<NOT <FSET? ,HERE ,RLANDBIT>>
				              ,PSEUDO-OBJECT)
				             (T
				              ,HERE)>)
				     (<==? ,ZORK-NUMBER 2>
				      '<COND (<EQUAL? .X ,WATER>
				              ,PSEUDO-OBJECT)
				             (<NOT <FSET? ,HERE ,RLANDBIT>>
				              ,PSEUDO-OBJECT)
				             (T
				              ,HERE)>)
				     (T
				      '<COND (<EQUAL? ,HERE ,ON-LAKE>
					      ,IN-LAKE)
					     (T
					      ,HERE)>)>>)
		       (T
			<RETURN>)>>>

<ROUTINE V-SKIP ()
	 <TELL <PICK-ONE ,WHEEEEE> CR>>

<GLOBAL WHEEEEE
	<LTABLE 0 "Très bien. Maintenant, tu peux aller en deuxième année."
	       "Tu t'amuses ?"
	       "Wheeeeeeeeeee !!!!!"
	       "Tu t'attends à ce que je le fasse applaudir ?">>

<ROUTINE V-SMELL ()
	 <TELL "Ça sent le " D ,PRSO "." CR>>

<ROUTINE V-SPIN ()
	 <TELL "Tu ne peux pas faire tourner ça !" CR>>

<ROUTINE V-SPRAY ()
	 <V-SQUEEZE>>

<ROUTINE V-SQUEEZE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "Le " D ,PRSO " ne comprend pas ceci.">)
	       (T
		<TELL "Comme c'est singulièrement inutile.">)>
	 <CRLF>>

<ROUTINE V-SSPRAY ()
	 <PERFORM ,V?SPRAY ,PRSI ,PRSO>>

<ROUTINE V-STAB ("AUX" W)
	 <COND (<SET W <FIND-WEAPON ,WINNER>>
		<PERFORM ,V?ATTACK ,PRSO .W>
		<RTRUE>)
	       (T
		<TELL
"Vous proposez sans doute de poignarder le " D ,PRSO " avec votre petit doigt ?" CR>)>>

<ROUTINE V-STAND ()
	 <COND (<FSET? <LOC ,WINNER> ,VEHBIT>
		<PERFORM ,V?DISEMBARK <LOC ,WINNER>>
		<RTRUE>)
	       (T
		<TELL "Tu es déjà debout, je pense." CR>)>>

<ROUTINE V-STAY ()
	 <TELL "Tu seras perdu sans moi !" CR>>

<ROUTINE V-STRIKE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL
"Puisque vous n'êtes pas doué en combat au corps à corps, vous feriez mieux d'attaquer le "
D ,PRSO " avec une arme." CR>)
	       (T
		<PERFORM ,V?LAMP-ON ,PRSO>
		<RTRUE>)>>

<ROUTINE V-SWIM ()
	 <COND %<COND (<OR <==? ,ZORK-NUMBER 1>
			   <==? ,ZORK-NUMBER 2>>
		       '(<GLOBAL-IN? ,GLOBAL-WATER ,HERE>
		         <TELL "La baignade n'est généralement pas autorisée dans le ">
		         <COND (<NOT <EQUAL? ,PRSO ,WATER ,GLOBAL-WATER>>
	                        <TELL D ,PRSO ".">)
		               (T
		                <TELL "donjon.">)>
		         <CRLF>))
		      (T
		       '(<EQUAL? ,HERE ,ON-LAKE ,IN-LAKE>
		         <TELL "Que penses-tu faire ?" CR>))>
	       %<COND (<==? ,ZORK-NUMBER 3>
		       '(<EQUAL? ,HERE ,FLATHEAD-OCEAN>
		         <TELL
"Entre les rochers et les vagues, tu ne tiendrais pas une minute !" CR>))
		      (T
		       '(<NULL-F>
			 <RFALSE>))>
	       (T
		<TELL "Allez sauter dans un lac !" CR>)>>

<ROUTINE V-SWING ()
	 <COND (<NOT ,PRSI>
		<TELL "Whoosh !" CR>)
	       (T
		<PERFORM ,V?ATTACK ,PRSI ,PRSO>)>>

<ROUTINE PRE-TAKE ()
	 <COND (<IN? ,PRSO ,WINNER>
		<COND (<FSET? ,PRSO ,WEARBIT>
		       <TELL "Vous portez déjà " CR>)
		      (T
		       <TELL "Vous l'avez déjà !" CR>)>)
	       (<AND <FSET? <LOC ,PRSO> ,CONTBIT>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<TELL
"Vous ne pouvez pas atteindre quelque chose qui se trouve à l'intérieur d'un conteneur fermé." CR>
		<RTRUE>)
	       (,PRSI
		<COND (<EQUAL? ,PRSI ,GROUND>
		       <SETG PRSI <>>
		       <RFALSE>)>
		%<COND (<==? ,ZORK-NUMBER 2>
			'<COND (<EQUAL? ,PRSO ,DOOR-KEEPER>
				<SETG PRSI <>>
				<RFALSE>)>)
		       (ELSE
			'<NULL-F>)>
		<COND (<NOT <EQUAL? ,PRSI <LOC ,PRSO>>>
		       <TELL "Le " D ,PRSO " n'est pas dans le " D ,PRSI "." CR>)
		      (T
		       <SETG PRSI <>>
		       <RFALSE>)>)
	       (<EQUAL? ,PRSO <LOC ,WINNER>>
		<TELL "Vous êtes à l'intérieur !" CR>)>>

<ROUTINE V-TAKE ()
	 <COND (<EQUAL? <ITAKE> T>
		<COND (<FSET? ,PRSO ,WEARBIT>
		       <TELL "Vous portez maintenant le " D ,PRSO "." CR>)
		      (T
		       <TELL "Pris." CR>)>)>>

<ROUTINE V-TELL ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<COND (,P-CONT
		       <SETG WINNER ,PRSO>
		       <SETG HERE <LOC ,WINNER>>)
		      (T
		       <TELL "Le " D ,PRSO
"pauses un moment, peut-être en pensant que vous devriez relire le manuel." CR>)>)
	       (T
		<TELL "Vous ne pouvez pas parler au " D ,PRSO "!" CR>
		<SETG QUOTE-FLAG <>>
		<SETG P-CONT <>>
		<RFATAL>)>>

<ROUTINE V-THROUGH ("OPTIONAL" (OBJ <>) "AUX" M)
	#DECL ((OBJ) <OR OBJECT FALSE> (M) <PRIMTYPE VECTOR>)
	<COND (<AND <FSET? ,PRSO ,DOORBIT>
		    <SET M <OTHER-SIDE ,PRSO>>>
	       <DO-WALK .M>
	       <RTRUE>)
	      (<AND <NOT .OBJ> <FSET? ,PRSO ,VEHBIT>>
	       <PERFORM ,V?BOARD ,PRSO>
	       <RTRUE>)
	      (<OR .OBJ <NOT <FSET? ,PRSO ,TAKEBIT>>>
	       %<COND (<==? ,ZORK-NUMBER 2>
		       '<COND (<AND ,SCOL-ROOM
				   <OR .OBJ <EQUAL? ,PRSO ,CURTAIN>>>
			      <SCOL-GO .OBJ>
			      <RTRUE>)
			     (<AND <EQUAL? ,HERE ,DEPOSITORY>
				   <EQUAL? ,PRSO ,SNWL>
				   ,SCOL-ROOM>
			      <SCOL-GO .OBJ>
			      <RTRUE>)
			     (<AND <EQUAL? ,HERE ,SCOL-ACTIVE>
				   <EQUAL? ,PRSO 
					   <GET <SET M <GET-WALL ,HERE>> 1>>>
			      <SETG SCOL-ROOM <GET .M 2>>
			      <SETG PRSO <GETP ,PRSO ,P?SIZE>>
			      <COND (.OBJ <SCOL-OBJ .OBJ 0 ,DEPOSITORY>)
				    (T
				     <SCOL-THROUGH 0 ,DEPOSITORY>)>
			      <RTRUE>)
			     (<EQUAL? ,PRSO ,CURTAIN>
			      <TELL
"Vous ne pouvez pas traverser plus qu'une partie du rideau." CR>
			      <RTRUE>)>)
		      (ELSE '<NULL-F>)>
	       <TELL
"Vous vous êtes cogné la tête contre le " D ,PRSO " lorsque vous tentez cet exploit." CR>)
	      (<IN? ,PRSO ,WINNER>
	       <TELL "Cela impliquerait une sacrée contorsion !" CR>)
	      (T
	       <TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE V-THROW ()
	 <COND (<IDROP>
		<COND (<EQUAL? ,PRSI ,ME>
		       <TELL
"Un lancer formidable ! Le " D ,PRSO>
		       <SETG WINNER ,PLAYER>
		       <JIGS-UP "Normalement, cela ne ferait pas beaucoup de dégâts, mais par d'incroyables malchance, vous tombez à l'envers en essayant de vous évacuer et de vous briser le cou, la justice étant rapide et miséricordieux dans le Grand Empire Souterrain.">)
		      (<AND ,PRSI <FSET? ,PRSI ,ACTORBIT>>
		       <TELL
"Le " D ,PRSI " se penche alors que le " D ,PRSO " passe et s'écrase sur le au sol."
CR>)
		      (T <TELL "Lancé." CR>)>)
	       (ELSE <TELL "Hein ?" CR>)>>

<ROUTINE V-THROW-OFF ()
	 <TELL "Vous ne pouvez rien jeter avec ça !" CR>>

<ROUTINE V-TIE ()
	 <COND (<EQUAL? ,PRSI ,WINNER>
		<TELL "Vous ne pouvez rien attacher à vous-même." CR>)
	       (T
		<TELL "Vous ne pouvez pas lier le " D ,PRSO " à cela." CR>)>>

<ROUTINE V-TIE-UP ()
	 <TELL "Vous ne pourrez certainement jamais le lier avec ça !" CR>>

<ROUTINE V-TREASURE ()
	 <COND %<COND (<==? ,ZORK-NUMBER 1>
		       '(<EQUAL? ,HERE ,NORTH-TEMPLE>
		         <GOTO ,TREASURE-ROOM>))
		      (T
		       '(<NULL-F> <RTRUE>))>
	       %<COND (<==? ,ZORK-NUMBER 1>
		       '(<EQUAL? ,HERE ,TREASURE-ROOM>
		         <GOTO ,NORTH-TEMPLE>))
		      (T
		       '(<NULL-F> <RTRUE>))>
	       (T
		<TELL "Rien ne se passe." CR>)>>

<ROUTINE PRE-TURN ()
	 %<COND (<==? ,ZORK-NUMBER 3>
		 '<COND (<AND <EQUAL? ,PRSI <> ,ROOMS>
			      <EQUAL? ,PRSO ,DIAL ,TM-DIAL ,T-BAR>>
			 <TELL
"Vous devriez tourner le " D ,PRSO " en quelque chose." CR>
			 <RTRUE>)>)
		(ELSE T)>
	 <COND (%<COND (<==? ,ZORK-NUMBER 1>
			'<AND <EQUAL? ,PRSI <> ,ROOMS>
			      <NOT <EQUAL? ,PRSO ,BOOK>>>)
		       (ELSE
			'<EQUAL? ,PRSI <> ,ROOMS>)>
		<TELL "Vos mains nues ne semblent pas être ça suffit." CR>)
	       (<NOT <FSET? ,PRSO ,TURNBIT>>
		<TELL "Vous ne pouvez pas l'inverser !" CR>)>>

<ROUTINE V-TURN ()
	 <TELL "Cela n'a aucun effet." CR>>

<ROUTINE V-UNLOCK ()
	 <V-LOCK>>

<ROUTINE V-UNTIE ()
	 <TELL "Cela ne peut pas être lié, donc il ne peut pas être délié !" CR>>

<ROUTINE V-WAIT ("OPTIONAL" (NUM 3))
	 <TELL "Temps passe..." CR>
	 <REPEAT ()
		 <COND (<L? <SET NUM <- .NUM 1>> 0> <RETURN>)
		       (<CLOCKER> <RETURN>)>>
	 <SETG CLOCK-WAIT T>>

<ROUTINE V-WALK ("AUX" PT PTS STR OBJ RM)
	 <COND (<NOT ,P-WALK-DIR>
		<PERFORM ,V?WALK-TO ,PRSO>
		<RTRUE>)
	       (<SET PT <GETPT ,HERE ,PRSO>>
		<COND (<EQUAL? <SET PTS <PTSIZE .PT>> ,UEXIT>
		       <GOTO <GETB .PT ,REXIT>>)
		      (<EQUAL? .PTS ,NEXIT>
		       <TELL <GET .PT ,NEXITSTR> CR>
		       <RFATAL>)
		      (<EQUAL? .PTS ,FEXIT>
		       <COND (<SET RM <APPLY <GET .PT ,FEXITFCN>>>
			      <GOTO .RM>)
			     %<COND (<==? ,ZORK-NUMBER 3>
				     '(<AND <EQUAL? ,HERE ,CP> ,CP-MOVED>
		                       <RTRUE>))
				    (T
				     '(<NULL-F> <RFALSE>))>
			     (T
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,CEXIT>
		       <COND (<VALUE <GETB .PT ,CEXITFLAG>>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,CEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <TELL "Vous ne pouvez pas aller jusque là. chemin." CR>
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,DEXIT>
		       <COND (<FSET? <SET OBJ <GETB .PT ,DEXITOBJ>> ,OPENBIT>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,DEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <TELL "Le " D .OBJ " est fermé." CR>
			      <THIS-IS-IT .OBJ>
			      <RFATAL>)>)>)
	       (<AND <NOT ,LIT>
		     <PROB 80>
		     <EQUAL? ,WINNER ,ADVENTURER>
		     <NOT <FSET? ,HERE ,NONLANDBIT>>>
		<COND (,SPRAYED?
		       <TELL
"Il y a des bruits étranges dans l'obscurité, et il n'y a pas de sortie dans cette direction." CR>
		       <RFATAL>)
		      %<COND (<==? ,ZORK-NUMBER 3>
			      '(<EQUAL? ,HERE ,DARK-1 ,DARK-2>
		                <JIGS-UP
"Oh, non ! Vous êtes entré dans une tanière de grues affamées et c'est l'heure du dîner !">))
			     (T
			      '(<NULL-F>
				<RFALSE>))>
		      (T
		       <JIGS-UP
"Oh, non ! Vous avez marché dans les crocs d'une grue qui rôde !">)>)
	       (T
		<TELL "Vous ne pouvez pas aller jusque là. chemin." CR>
		<RFATAL>)>>

<ROUTINE V-WALK-AROUND ()
	 <TELL "Utilisez les indications de la boussole pour vous déplacer." CR>>

<ROUTINE V-WALK-TO ()
	 <COND (<AND ,PRSO
		     <OR <IN? ,PRSO ,HERE>
			 <GLOBAL-IN? ,PRSO ,HERE>>>
		<TELL "C'est ici !" CR>)
	       (T
		<TELL "Vous devez fournir une direction !" CR>)>>

<ROUTINE V-WAVE ()
	 <HACK-HACK "En agitant le ">>

<ROUTINE V-WEAR ()
	 <COND (<NOT <FSET? ,PRSO ,WEARBIT>>
		<TELL "Vous ne pouvez pas porter le " D ,PRSO "." CR>)
	       (T
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-WIN ()
	 <TELL "Naturellement !" CR>>

<ROUTINE V-WIND ()
	 <TELL "Vous ne pouvez pas liquider un " D ,PRSO "." CR>>

<ROUTINE V-WISH ()
	 %<COND (<==? ,ZORK-NUMBER 2>
		 '<PERFORM ,V?MAKE ,WISH>)
		(T
		 '<TELL "Avec de la chance, votre souhait se réalisera vrai." CR>)>>

<ROUTINE V-YELL () <TELL "Aaaarrrrgggghhhh !" CR>>

<ROUTINE V-ZORK () <TELL "À votre service !" CR>>

^L

"Verbe associé Routines"

"Descriptions"

<GLOBAL LIT <>>

<GLOBAL SPRAYED? <>>

<ROUTINE V-FIRST-LOOK ()
	 <COND (<DESCRIBE-ROOM>
		<COND (<NOT ,SUPER-BRIEF>
		       <DESCRIBE-OBJECTS>)>)>>

<ROUTINE DESCRIBE-ROOM ("OPTIONAL" (LOOK? <>) "AUX" V? STR AV)
	 <SET V? <OR .LOOK? ,VERBOSE>>
	 <COND (<NOT ,LIT>
		<TELL "Il fait noir.">
		<COND (<NOT ,SPRAYED?>
		       <TELL " Vous risquez d'être mangé par un grue.">)>
		<CRLF>
		%<COND (<==? ,ZORK-NUMBER 3>
			'<COND (<EQUAL? ,HERE ,DARK-2>
		                <TELL
"Le sol continue de descendre vers le haut du lac. Vous pouvez à peine détecter une faible lumière de l'est." CR>)>)
		       (T
			'<NULL-F>)>
		<RFALSE>)>
	 <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		<FSET ,HERE ,TOUCHBIT>
		<SET V? T>)>
	 %<COND (<==? ,ZORK-NUMBER 1>
		 '<COND (<FSET? ,HERE ,MAZEBIT>
		         <FCLEAR ,HERE ,TOUCHBIT>)>)
		(T
		 '<NULL-F>)>
	 <COND (<IN? ,HERE ,ROOMS>
		;"Was <TELL D ,HERE CR>"
		<TELL D ,HERE>
		<COND (<FSET? <SET AV <LOC ,WINNER>> ,VEHBIT>
		       <TELL ", dans le " D .AV>)>
		<CRLF>)>
	 <COND (%<COND (<==? ,ZORK-NUMBER 2>
			'<OR .LOOK? <NOT ,SUPER-BRIEF> <EQUAL? ,HERE ,ZORK3>>)
		       (ELSE
			'<OR .LOOK? <NOT ,SUPER-BRIEF>>)>
		<SET AV <LOC ,WINNER>>
		;<COND (<FSET? .AV ,VEHBIT>
		       <TELL "(Vous êtes dans le " D .AV ".)" CR>)>
		<COND (<AND .V? <APPLY <GETP ,HERE ,P?ACTION> ,M-LOOK>>
		       <RTRUE>)
		      (<AND .V? <SET STR <GETP ,HERE ,P?LDESC>>>
		       <TELL .STR CR>)
		      (T
		       <APPLY <GETP ,HERE ,P?ACTION> ,M-FLASH>)>
		<COND (<AND <NOT <EQUAL? ,HERE .AV>> <FSET? .AV ,VEHBIT>>
		       <APPLY <GETP .AV ,P?ACTION> ,M-LOOK>)>)>
	 T>

<ROUTINE DESCRIBE-OBJECTS ("OPTIONAL" (V? <>))
	 <COND (,LIT
		<COND (<FIRST? ,HERE>
		       <PRINT-CONT ,HERE <SET V? <OR .V? ,VERBOSE>> -1>)>)
	       (T
		<TELL "Seules les chauves-souris peuvent voir dans l'obscurité. Et vous ne l'êtes pas. un." CR>)>>

"DESCRIBE-OBJECT -- prend objet et drapeau. si le drapeau est vrai va imprimer une description longue (fdesc ou ldesc), sinon va imprimer court."

<GLOBAL DESC-OBJECT <>>

<ROUTINE DESCRIBE-OBJECT (OBJ V? LEVEL "AUX" (STR <>) AV)
	 <SETG DESC-OBJECT .OBJ>
	 <COND (<AND <0? .LEVEL>
		     <APPLY <GETP .OBJ ,P?DESCFCN> ,M-OBJDESC>>
		<RTRUE>)
	       (<AND <0? .LEVEL>
		     <OR <AND <NOT <FSET? .OBJ ,TOUCHBIT>>
			      <SET STR <GETP .OBJ ,P?FDESC>>>
			 <SET STR <GETP .OBJ ,P?LDESC>>>>
		<TELL .STR>)
	       (<0? .LEVEL>
		<TELL "Vous remarquez ici : " D .OBJ "">
		<COND (<FSET? .OBJ ,ONBIT>
		       <TELL " (fournissant lumière)">)>
		<TELL ".">)
	       (T
		<TELL <GET ,INDENTS .LEVEL>>
		<TELL "- " D .OBJ>
		<COND (<FSET? .OBJ ,ONBIT>
		       <TELL " (fournissant lumière)">)
		      (<AND <FSET? .OBJ ,WEARBIT>
			    <IN? .OBJ ,WINNER>>
		       <TELL " (porté)">)>)>
	 %<COND (<==? ,ZORK-NUMBER 2>
		 '<COND (<AND <EQUAL? .OBJ ,SPELL-VICTIM>
		              <EQUAL? ,SPELL-USED ,W?FLOAT>>
		         <TELL " (flottant dans en vol)">)>)
		(T
		 '<NULL-F>)>
	 <COND (<AND <0? .LEVEL>
		     <SET AV <LOC ,WINNER>>
		     <FSET? .AV ,VEHBIT>>
		<TELL " (à l'extérieur du " D .AV ")">)>
	 <CRLF>
	 <COND (<AND <SEE-INSIDE? .OBJ> <FIRST? .OBJ>>
		<PRINT-CONT .OBJ .V? .LEVEL>)>>

<ROUTINE PRINT-CONTENTS (OBJ "AUX" F N (1ST? T) (IT? <>) (TWO? <>))
	 <COND (<SET F <FIRST? .OBJ>>
		<REPEAT ()
			<SET N <NEXT? .F>>
			<COND (.1ST? <SET 1ST? <>>)
			      (ELSE
			       <TELL ", ">
			       <COND (<NOT .N> <TELL "et ">)>)>
			<TELL "un " D .F>
			<COND (<AND <NOT .IT?> <NOT .TWO?>>
			       <SET IT? .F>)
			      (ELSE
			       <SET TWO? T>
			       <SET IT? <>>)>
			<SET F .N>
			<COND (<NOT .F>
			       <COND (<AND .IT? <NOT .TWO?>>
				      <THIS-IS-IT .IT?>)>
			       <RTRUE>)>>)>>

<ROUTINE PRINT-CONT (OBJ "OPTIONAL" (V? <>) (LEVEL 0)
		     "AUX" Y 1ST? SHIT AV STR (PV? <>) (INV? <>))
	 <COND (<NOT <SET Y <FIRST? .OBJ>>> <RTRUE>)>
	 <COND (<AND <SET AV <LOC ,WINNER>> <FSET? .AV ,VEHBIT>>
		T)
	       (ELSE <SET AV <>>)>
	 <SET 1ST? T>
	 <SET SHIT T>
	 <COND (<EQUAL? ,WINNER .OBJ <LOC .OBJ>>
		<SET INV? T>)
	       (ELSE
		<REPEAT ()
			<COND %<COND (<==? ,ZORK-NUMBER 2>
				      '(<NOT .Y>
					<COND (<AND <0? .LEVEL>
						    <==? ,SPELL? ,S-FANTASIZE>
						    <PROB 20>>
					       <TELL "Vous remarquez ici : "
						     <PICK-ONE ,FANTASIES>
						     " ici." CR>
					       <SET 1ST? <>>)>
					<RETURN>))
				     (ELSE
				      '(<NOT .Y>
					<RETURN>))>
			      (<EQUAL? .Y .AV> <SET PV? T>)
			      (<EQUAL? .Y ,WINNER>)
			      (<AND <NOT <FSET? .Y ,INVISIBLE>>
				    <NOT <FSET? .Y ,TOUCHBIT>>
				    <SET STR <GETP .Y ,P?FDESC>>>
			       <COND (<NOT <FSET? .Y ,NDESCBIT>>
				      <TELL .STR CR>
				      <SET SHIT <>>
				      ;<SET 1ST? <>>)>
			       <COND (<AND <SEE-INSIDE? .Y>
					   <NOT <GETP <LOC .Y> ,P?DESCFCN>>
					   <FIRST? .Y>>
				      <COND (<PRINT-CONT .Y .V? 0>
					     <SET 1ST? <>>)>)>)>
			<SET Y <NEXT? .Y>>>)>
	 <SET Y <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .Y>
			<COND (<AND .PV? .AV <FIRST? .AV>>
			       <SET LEVEL <+ .LEVEL 1>> ;"not in Zork III"
			       <PRINT-CONT .AV .V? .LEVEL>)>
			<RETURN>)
		       (<EQUAL? .Y .AV ,ADVENTURER>)
		       (<AND <NOT <FSET? .Y ,INVISIBLE>>
			     <OR .INV?
				 <FSET? .Y ,TOUCHBIT>
				 <NOT <GETP .Y ,P?FDESC>>>>
			<COND (<NOT <FSET? .Y ,NDESCBIT>>
			       <COND (.1ST?
				      <COND (<FIRSTER .OBJ .LEVEL>
					     <COND (<L? .LEVEL 0>
						    <SET LEVEL 0>)>)>
				      <SET LEVEL <+ 1 .LEVEL>>
				      <SET 1ST? <>>)>
			       <COND (<L? .LEVEL 0> <SET LEVEL 0>)>
			       <DESCRIBE-OBJECT .Y .V? .LEVEL>)
			      (<AND <FIRST? .Y> <SEE-INSIDE? .Y>>
			       <SET LEVEL <+ .LEVEL 1>> ;"not in Zork III"
			       <PRINT-CONT .Y .V? .LEVEL>
			       <SET LEVEL <- .LEVEL 1>> ;"not in Zork III")>)>
		 <SET Y <NEXT? .Y>>>
	 <COND (<AND .1ST? .SHIT> <RFALSE>) (T <RTRUE>)>>

<ROUTINE FIRSTER (OBJ LEVEL)
	 <COND %<COND (<==? ,ZORK-NUMBER 1>
		       '(<EQUAL? .OBJ ,TROPHY-CASE>
		         <TELL
"Votre collection de trésors se compose de :" CR>))
		      (T
		       '(<NULL-F> <RTRUE>))>
	       (<EQUAL? .OBJ ,WINNER>
		<TELL "Vous êtes portant :" CR>)
	       (<NOT <IN? .OBJ ,ROOMS>>
		<COND (<G? .LEVEL 0>
		       <TELL <GET ,INDENTS .LEVEL>>)>
		<COND (<FSET? .OBJ ,SURFACEBIT>
		       <TELL "Assis sur le " D .OBJ " est : " CR>)
		      (<FSET? .OBJ ,ACTORBIT>
		       <TELL "Le " D .OBJ " tient : " CR>)
		      (T
		       <TELL "Le " D .OBJ " contient :" CR>)>)>>

<ROUTINE SEE-INSIDE? (OBJ)
	 <AND <NOT <FSET? .OBJ ,INVISIBLE>>
	      <OR <FSET? .OBJ ,TRANSBIT> <FSET? .OBJ ,OPENBIT>>>>

"Score"

<GLOBAL MOVES 0>

<GLOBAL SCORE 0>

<GLOBAL BASE-SCORE 0>

<GLOBAL WON-FLAG <>>

<ROUTINE SCORE-UPD (NUM)
	 <SETG BASE-SCORE <+ ,BASE-SCORE .NUM>>
	 <SETG SCORE <+ ,SCORE .NUM>>
	 %<COND (<==? ,ZORK-NUMBER 1>
		 '<COND (<AND <EQUAL? ,SCORE 350>
		              <NOT ,WON-FLAG>>
		         <SETG WON-FLAG T>
		         <FCLEAR ,MAP ,INVISIBLE>
		         <FCLEAR ,WEST-OF-HOUSE ,TOUCHBIT>
		         <TELL
"Une voix presque inaudible murmure à ton oreille, \"Regarde tes trésors pour le dernier secret.\"" CR>)>)
		(T
		 '<NULL-F>)>
	 T>

<ROUTINE SCORE-OBJ (OBJ "AUX" TEMP)
	 <COND (<G? <SET TEMP <GETP .OBJ ,P?VALUE>> 0>
		<SCORE-UPD .TEMP>
		<PUTP .OBJ ,P?VALUE 0>)>>

<ROUTINE YES? ()
	 <PRINTI ">">
	 <READ ,P-INBUF ,P-LEXV>
	 <COND (<EQUAL? <GET ,P-LEXV 1> ,W?YES ,W?Y>
		<RTRUE>)
	       (T
		<RFALSE>)>>

"Mort"

<GLOBAL DEAD <>>

<GLOBAL DEATHS 0>

<GLOBAL LUCKY 1>

;"JIGS-UP is in ACTIONS.ZIL"

;"RANDOMIZE-OBJECTS is in ACTIONS.ZIL"

;"KILL-INTERRUPTS is in ACTIONS.ZIL"

"Manipulation d'objet"

<GLOBAL FUMBLE-NUMBER 7>

<GLOBAL FUMBLE-PROB 8>

<ROUTINE ITAKE ("OPTIONAL" (VB T) "AUX" CNT OBJ)
	 #DECL ((VB) <OR ATOM FALSE> (CNT) FIX (OBJ) OBJECT)
	 <COND %<COND (<==? ,ZORK-NUMBER 1>
		       '(,DEAD
		         <COND (.VB
				<TELL
"Votre main passe à travers son objet." CR>)>
		         <RFALSE>))
		      (T
		       '(<NULL-F>
			 <RFALSE>))>
	       (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<COND (.VB
		       <TELL <PICK-ONE ,YUKS> CR>)>
		<RFALSE>)
	       %<COND (<==? ,ZORK-NUMBER 2>
		       '(<AND <EQUAL? ,PRSO ,SPELL-VICTIM>
		              <EQUAL? ,SPELL-USED ,W?FLOAT ,W?FREEZE>>
		         <COND (<EQUAL? ,SPELL-USED ,W?FLOAT>
		                <TELL
"Vous ne pouvez pas atteindre cela. Il flotte au-dessus de votre tête." CR>)
		               (T
		                <TELL "Il semble ancré sur place." CR>)>
		         <RFALSE>))
		      (T
		       '(<NULL-F>
			 <RFALSE>))>
	       (<AND <FSET? <LOC ,PRSO> ,CONTBIT>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		;"Kludge for parser calling itake"
		<RFALSE>)
	       (<AND <NOT <IN? <LOC ,PRSO> ,WINNER>>
		     <G? <+ <WEIGHT ,PRSO> <WEIGHT ,WINNER>> ,LOAD-ALLOWED>>
		<COND (.VB
		       <TELL "Votre charge est trop lourde">
		       <COND (<L? ,LOAD-ALLOWED ,LOAD-MAX>
			      <TELL", surtout à la lumière de votre ">)
			     (T
			      <TELL ".">)>
		       <CRLF>)>
		<RFATAL>)
	       (<AND <VERB? TAKE>
		     <G? <SET CNT <CCOUNT ,WINNER>> ,FUMBLE-NUMBER>
		     <PROB <* .CNT ,FUMBLE-PROB>>>
		<TELL
"Vous tenez déjà trop de choses !" CR>
		<RFALSE>)
	       (T
		<MOVE ,PRSO ,WINNER>
		<FCLEAR ,PRSO ,NDESCBIT>
		<FSET ,PRSO ,TOUCHBIT>
		%<COND (<==? ,ZORK-NUMBER 2>
			'<COND (<EQUAL? ,SPELL? ,S-FILCH>
		                <COND (<RIPOFF ,PRSO ,WIZARD-CASE>
			               <TELL
"Lorsque vous touchez le " D ,PRSO ", il est immédiatement disparaît !" CR>
			               <RFALSE>)>)>)
		       (T
			'<NULL-F>)>
		%<COND (<OR <==? ,ZORK-NUMBER 1>
			    <==? ,ZORK-NUMBER 2>>
			'<SCORE-OBJ ,PRSO>)
		       (T
			'<NULL-F>)>
		<RTRUE>)>>

<ROUTINE IDROP ()
	 <COND (<AND <NOT <IN? ,PRSO ,WINNER>>
		     <NOT <IN? <LOC ,PRSO> ,WINNER>>>
		<TELL "Vous ne transportez pas le " D ,PRSO "." CR>
		<RFALSE>)
	       (<AND <NOT <IN? ,PRSO ,WINNER>>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<TELL "Le " D ,PRSO " est fermé." CR>
		<RFALSE>)
	       (T
		<MOVE ,PRSO <LOC ,WINNER>>
		<RTRUE>)>>

<ROUTINE CCOUNT (OBJ "AUX" (CNT 0) X)
	 <COND (<SET X <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<NOT <FSET? .X ,WEARBIT>>
			       <SET CNT <+ .CNT 1>>)>
			<COND (<NOT <SET X <NEXT? .X>>>
			       <RETURN>)>>)>
	 .CNT>

<ROUTINE WEIGHT (OBJ "AUX" CONT (WT 0))
	 <COND (<SET CONT <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<AND <EQUAL? .OBJ ,PLAYER>
				    <FSET? .CONT ,WEARBIT>>
			       <SET WT <+ .WT 1>>)
			      (T
			       <SET WT <+ .WT <WEIGHT .CONT>>>)>
			<COND (<NOT <SET CONT <NEXT? .CONT>>> <RETURN>)>>)>
	 <+ .WT <GETP .OBJ ,P?SIZE>>>

"Divers"

<CONSTANT REXIT 0>
<CONSTANT UEXIT 1>
<CONSTANT NEXIT 2>
<CONSTANT FEXIT 3>
<CONSTANT CEXIT 4>
<CONSTANT DEXIT 5>

<CONSTANT NEXITSTR 0>
<CONSTANT FEXITFCN 0>
<CONSTANT CEXITFLAG 1>
<CONSTANT CEXITSTR 1>
<CONSTANT DEXITOBJ 1>
<CONSTANT DEXITSTR 1>

<GLOBAL INDENTS
	<TABLE (PURE)
	       ""
	       "  "
	       "    "
	       "      "
	       "        "
	       "          ">>

<ROUTINE HACK-HACK (STR)
	 <COND (<AND <IN? ,PRSO ,GLOBAL-OBJECTS>
		     <VERB? WAVE RAISE LOWER>>
		<TELL "Le " D ,PRSO " n'est pas ici !" CR>)
	       (T
		<TELL .STR D ,PRSO <PICK-ONE ,HO-HUM> CR>)>>

<GLOBAL HO-HUM
	<LTABLE
	 0
	 " ne semble pas fonctionner."
	 " n'est pas particulièrement utile."
	 " n'a aucun effet.">>

<ROUTINE NO-GO-TELL (AV WLOC)
	 <COND (.AV
		<TELL "Vous ne pouvez pas y aller en " D .WLOC ".">)
	       (T
		<TELL "Vous ne pouvez pas y aller sans un véhicule.">)>
	 <CRLF>>

<ROUTINE GOTO (RM "OPTIONAL" (V? T)
	       "AUX" (LB <FSET? .RM ,RLANDBIT>) (WLOC <LOC ,WINNER>)
	             (AV <>) OLIT OHERE)
	 <SET OLIT ,LIT>
	 <SET OHERE ,HERE>
	 <COND (<FSET? .WLOC ,VEHBIT>
		<SET AV <GETP .WLOC ,P?VTYPE>>)>
	 <COND (<AND <NOT .LB>
		     <NOT .AV>>
		<NO-GO-TELL .AV .WLOC>
		<RFALSE>)
	       (<AND <NOT .LB>
		     <NOT <FSET? .RM .AV>>>
		<NO-GO-TELL .AV .WLOC>
		<RFALSE>)
	       (<AND <FSET? ,HERE ,RLANDBIT>
		     .LB
		     .AV
		     <NOT <EQUAL? .AV ,RLANDBIT>>
		     <NOT <FSET? .RM .AV>>>
		<NO-GO-TELL .AV .WLOC>
		<RFALSE>)
	       (<FSET? .RM ,RMUNGBIT>
		<TELL <GETP .RM ,P?LDESC> CR>
		<RFALSE>)
	       (T
		<COND (<AND .LB
			    <NOT <FSET? ,HERE ,RLANDBIT>>
			    <NOT ,DEAD>
			    <FSET? .WLOC ,VEHBIT>>
		       %<COND (<==? ,ZORK-NUMBER 1>
			       '<TELL
"Le " D .WLOC " s'immobilise sur le rivage." CR CR>)
			      (<==? ,ZORK-NUMBER 2>
			       '<COND (<EQUAL? .WLOC ,BALLOON>
				       <TELL
"Le ballon atterrit." CR>)
				      (<FSET? .WLOC ,VEHBIT>
				       <TELL
"Le " D .WLOC " s'immobilise arrêtez." CR CR>)>)
			      (<==? ,ZORK-NUMBER 3>
			       '<COND (<FSET? .WLOC ,VEHBIT>
				       <TELL
"Le " D .WLOC " s'immobilise arrêtez." CR CR>)>)>)>
		<COND (.AV
		       <MOVE .WLOC .RM>)
		      (T
		       <MOVE ,WINNER .RM>)>
		<SETG HERE .RM>
		<SETG LIT <LIT? ,HERE>>
		<COND (<AND <NOT .OLIT>
			    <NOT ,LIT>
			    <PROB 80>>
		       <COND (,SPRAYED?
			      <TELL
"Il y a de sinistres gargouillis dans l'obscurité tout autour de vous !" CR>)
			     %<COND (<==? ,ZORK-NUMBER 3>
				     '(<EQUAL? ,HERE ,DARK-1 ,DARK-2>
		                       <JIGS-UP
"Oh, non, une douzaine de gruyères vous attaquent et vous dévorent ! Vous avez dû trébucher dans un authentique repaire !">))
				    (T
				     '(<NULL-F>
				       <RFALSE>))>
			     (T
			      <TELL
"Oh, non ! Une grue tapie s'est glissée dans la ">
			      <COND (<FSET? <LOC ,WINNER> ,VEHBIT>
				     <TELL D <LOC ,WINNER>>)
				    (T <TELL "salle">)>
			      <JIGS-UP " et vous a dévoré !">
			      <RTRUE>)>)>
		<COND (<AND <NOT ,LIT>
			    <EQUAL? ,WINNER ,ADVENTURER>>
		       <TELL "Vous avez emménagé dans une zone sombre. lieu." CR>
		       <SETG P-CONT <>>)>
		<APPLY <GETP ,HERE ,P?ACTION> ,M-ENTER>
		<SCORE-OBJ .RM>
		<COND (<NOT <EQUAL? ,HERE .RM>> <RTRUE>)
		      (<AND <NOT <EQUAL? ,ADVENTURER ,WINNER>>
			    <IN? ,ADVENTURER .OHERE>>
		       <TELL "Le " D ,WINNER " quitte la pièce." CR>)
		      %<COND (<==? ,ZORK-NUMBER 1>
			      '(<AND <EQUAL? ,HERE .OHERE>
				      ;"no double description"
				     <EQUAL? ,HERE ,ENTRANCE-TO-HADES>>
				<RTRUE>))
			     (ELSE
			      '(<NULL-F> <RTRUE>))>
		      (<AND .V?
			    <EQUAL? ,WINNER ,ADVENTURER>>
		       <V-FIRST-LOOK>)>
		<RTRUE>)>>

<ROUTINE LKP (ITM TBL "AUX" (CNT 0) (LEN <GET .TBL 0>))
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> .LEN>
			<RFALSE>)
		       (<EQUAL? <GET .TBL .CNT> .ITM>
			<COND (<EQUAL? .CNT .LEN> <RFALSE>)
			      (T
			       <RETURN <GET .TBL <+ .CNT 1>>>)>)>>>

<ROUTINE DO-WALK (DIR)
	 <SETG P-WALK-DIR .DIR>
	 <PERFORM ,V?WALK .DIR>>

;<ROUTINE WORD-TYPE (OBJ WORD "AUX" SYNS)
	 <ZMEMQ .WORD
		<SET SYNS <GETPT .OBJ ,P?SYNONYM>>
		<- </ <PTSIZE .SYNS> 2> 1>>>

<ROUTINE GLOBAL-IN? (OBJ1 OBJ2 "AUX" TX)
	 <COND (<SET TX <GETPT .OBJ2 ,P?GLOBAL>>
		<ZMEMQB .OBJ1 .TX <- <PTSIZE .TX> 1>>)>> 

<ROUTINE FIND-IN (WHERE WHAT "AUX" W)
	 <SET W <FIRST? .WHERE>>
	 <COND (<NOT .W>
		<RFALSE>)>
	 <REPEAT ()
		 <COND (<AND <FSET? .W .WHAT>
			     <NOT <EQUAL? .W ,ADVENTURER>>>
			<RETURN .W>)
		       (<NOT <SET W <NEXT? .W>>>
			<RETURN <>>)>>>


;<ROUTINE IN-HERE? (OBJ)
	 <OR <IN? .OBJ ,HERE>
	     <GLOBAL-IN? .OBJ ,HERE>>>

<ROUTINE HELD? (CAN)
	 <REPEAT ()
		 <SET CAN <LOC .CAN>>
		 <COND (<NOT .CAN> <RFALSE>)
		       (<EQUAL? .CAN ,WINNER> <RTRUE>)>>>

<ROUTINE OTHER-SIDE (DOBJ "AUX" (P 0) TX) ;"finds room beyond given door"
	 <REPEAT ()
		 <COND (<L? <SET P <NEXTP ,HERE .P>> ,LOW-DIRECTION>
			<RETURN <>>)
		       (ELSE
			<SET TX <GETPT ,HERE .P>>
			<COND (<AND <EQUAL? <PTSIZE .TX> ,DEXIT>
				    <EQUAL? <GETB .TX ,DEXITOBJ> .DOBJ>>
			       <RETURN .P>)>)>>>

<ROUTINE MUNG-ROOM (RM STR)
	 %<COND (<==? ,ZORK-NUMBER 2>
		 '<COND (<EQUAL? .RM ,INSIDE-BARROW>
			 <RFALSE>)>)
		(ELSE T)>
	 <FSET .RM ,RMUNGBIT>
	 <PUTP .RM ,P?LDESC .STR>>

<ROUTINE THIS-IS-IT (OBJ)
	 <SETG P-IT-OBJECT .OBJ>>

<COND (<N==? ,ZORK-NUMBER 3>
       <GLOBAL SWIMYUKS
	       <LTABLE 0 "Vous ne pouvez pas nager dans le donjon.">>)>

<GLOBAL HELLOS
	<LTABLE 0 "Bonjour."
	       "Bonne journée."
	       "Beau temps que nous avons eu dernièrement."
	       "Au revoir.">>

<GLOBAL YUKS
	<LTABLE
	 0
	 "Une vaillante tentative."
	 "Vous ne pouvez pas être sérieux."
	 ;"Not bloody likely."
	 "Une idée intéressante..."
	 "Quel concept !">>

<GLOBAL DUMMY
	<LTABLE 0 
		"Regardez autour."
	        "Trop tard pour cela."
	        "Faites vérifier vos yeux.">>