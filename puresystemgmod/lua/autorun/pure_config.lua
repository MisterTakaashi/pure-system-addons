AddCSLuaFile()
/* Ici vous ne touchez pas encore comme vous le voulez :P */

PURE = {}


	PURE.minauthorisedrep = 75

	PURE.maxauthorisedrep = 100

	PURE.minauthorisatedrprep = 50

	PURE.maxauthorisatedrprep = 100
	--------------------------------------------------------------------OnPeutToucher:D-----------------------------------------------------------
	/* Ici vous touchez comme vous le voulez ,
	c'est un fichier de config où vous pouvez changer les groupes pour le Pure System sur votre serveur par exemple !
	Certaines valeurs se changent que sur la page du serveur sur le Site : http://puresystem.fr

	Merci de faire confience au PureSystem !
	Bonne Config et Bisous !
	*/

	/* Ici, vous pouvez ajouter des groupes pouvant ouvrir le PureSystem !
	 n'oubliez pas de mettre le nom exact du groupe entre '' et avec une "," à la fin (sauf au dernier) !
	*/

	PURE.authgrp = {
		'superadmin',
		'admin'
	}

	PURE.port = 27015 -- IMPORTANT !!! --> Indiquez le port sur lequel tourne votre serveur habituellement c'est tres tres tres IMPORTANT !!!

	/* Ici vous pouvez mettre votre logo serveur sur une image de preference,
	la taille du tout doit être du 460 x 215 px en png ou jpeg et elle sera
	placée dans le dossier resource sur l'addon !

	Vous pouvez placer plusieurs images (toujours en 460 x 215 px) ou une seule, si c'est une seule supprimez
	le "resource/base_logo.png" et remplacez le premier par votre logo en enlevant le ","
	pour en mettre plus que 2 rajoutez un "," apres chaque logo sauf le dernier (Comme pour les groupes).

	Ils seront telecharges automatiquement par les joueurs
	Le Pure System en choisira un au hasard a chaque fois */

	PURE.servlogo = {
		"resource/base_log.jpg",
		"resource/base_logo.png"
	}
