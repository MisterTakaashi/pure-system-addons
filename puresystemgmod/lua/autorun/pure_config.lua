AddCSLuaFile()
/* Ici vous ne touchez pas encore comme vous le voulez :P */

PURE = {}

/* Ici vous touchez comme vous le voulez ,
c'est un fichier de config où vous pouvez changer les groupes pour le Pure System sur votre serveur par exemple !
Certaines valeurs se changent que sur la page du serveur sur le Site : http://puresystem.fr !!Pas encore implementé!!

Merci de faire confience au PureSystem !
Bonne Config et Bisous !
*/

---SERVEUR------------------------------------------------------------------------------------------------------------------------------------------------

	PURE.minauthorisedrep = 75 // Minimum de reputation

	PURE.maxauthorisedrep = 100 // Maximum de reputation

	PURE.minauthorisatedrprep = 50 // Minimum de reputation RP

	PURE.maxauthorisatedrprep = 100 // Maximum de reputation RP

	PURE.authorisenewplayers = true // Autoriser les nouveaux joueurs (true = oui / false = non)

	PURE.port = 27015 -- IMPORTANT !!! --> Indiquez le port sur lequel tourne votre serveur habituellement c'est tres tres tres IMPORTANT !!!

----STAFF-------------------------------------------------------------------------------------------------------------------------------------------------


	/* Ici, vous pouvez ajouter des groupes pouvant ouvrir le PureSystem !
	 n'oubliez pas de mettre le nom exact du groupe entre '' et avec une "," à la fin (sauf au dernier) !
	*/

	PURE.authgrp = {
		'superadmin',
		'admin'
	}


-----PURELOADING------------------------------------------------------------------------------------------------------------------------------------------
	/* Ici vous pouvez mettre votre logo serveur sur une image de preference,
	la taille du tout doit être du 460 x 215 px en png ou jpeg et elle sera
	placée dans le dossier resource sur l'addon !

	Vous pouvez placer plusieurs images (toujours en 460 x 215 px) ou une seule, si c'est une seule supprimez
	le "resource/base_logo.png" et remplacez le premier par votre logo en enlevant le ","
	pour en mettre plus que 2 rajoutez un "," apres chaque logo sauf le dernier (Comme pour les groupes).

	Ils serons telecharges automatiquement par les joueurs si votre sv_allowdownloads est a 1
	Le Pure Loading en choisira un au hasard a chaque fois */

	PURE.servlogo = {
		"materials/puresystem/base_log.jpg",
		"materials/puresystem/base_logo.png"
	}

	PURE.servname = "Serveur Dev PureSystem" // Indiquez ici le nom qui apparaitra sur le loading

	/* Pas encore prêt ^^
	PURE.butcr = {
		-------------------On-touche-pas----------------------------------------------------------
	cobut =	{tipe = "Connect", name = "Entrer Serveur", http = nil},
	but2 =	{tipe = "Web", name = "Page CGU",http = "http://puresystem.fr/cgu.html"},
	but3 =	{tipe = "Web", name = "Site PS",http = "http://puresystem.fr"},*/
	--but4 =	{tipe = "Web", name = "Votre Profil",http = "http://puresystem.fr/id/"..ply:GetNWInt("St64").."/"},
		-------------------La-vous-pouvez--------------------
		/*Mais a quoi ca sert ce truc ? Eh bien a créer automtiquement des boutons pour le loading
		et vous savez quoi ? Vous pouvez faire les votres ! Super simple en plus
		tipe = ici vous mettez le type de boutton, vous n'utiliserez que les "Web", le reste c est pour le Pure
		name = Le nom qu'aura votre boutton, evitez de le faire trop long, sinon ca depasse
		http = vous mettez le lien vers lequel votre site renvoi !
		N'en faites pas trop parcontre ^^
		*/

		// Apres cette ligne c'est a vous, oubliez pas les "," a la fin, sinon lua errors
		-------------------------------------------------------------------------------------------

		// EXEMPLE: but5 = {tipe = "Web",name = "Forum Serveur",http = "http://monsupersite.fr/forum"},
		-------------------Et-on-ne-retouche-pas---------------------------------------------------
	/*decobut =	{type = "Discon", name = "Deconnexion",http = nil}
}*/
