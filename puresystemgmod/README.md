# Pure System GMOD Addon

### Installation

Afin d'installer cet addon, il suffit simplement de le glisser déposer dans le dossier addons de votre serveur Garry's Mod

La configuration se fait ensuite dans le fichier `./lua/autorun/pure_config.lua`.
Les images du serveur doivent être placées dans le dossier `./resource`.

Il est important que le port du serveur soit fixé, afin que le site requête le bon serveur.

Si vous êtes sous Linux: Dans le script de lancement de votre serveur, rajoutez l'option `+port numero_de_port`.

Si vous êtes sous Windows: 
- Si vous utilisez un script de lancement de type .bat, comme sous Linux, rajoutez l'option `+port numero_de_port`.
- Si vous vous servez du raccourcis vers srcds, dans les propriétés du raccourcis, rajoutez l'option `+port numero_de_port`.

Notez que le port de base est 27015, cependant, il peut largement varier, pensez à le modifier dans le `pure_config.lua` mais aussi sur votre interface Serveur sur le site http://puresystem.fr/.

### Usage

L'addon PureSystem offre un menu d'administration grace à la commande `!pure`. Vous obtiendrez ainsi la réputation des joueurs ainsi que les actions à affectuer en cliquant sur leur pseudo.

Attention, seuls les serveurs enregistrés et possédant l'autorisation de se servir du PureSystem seront acceptés par notre serveur de réputation. Contactez un des créateurs pour plus d'informations.

### Crédits

- [MisterTakaashi](http://steamcommunity.com/id/TakaashiKun/)
- [Achild0](http://steamcommunity.com/id/Achild0/)

En cas de soucis, contactez l'une de ces deux personnes.



### Todo


Keep only one file in autorun, call it sh_puresystem.lua

move everything from lua/autorun/*1/*x to lua/puresystem/*1/*x to prevent name conflicts with others addons

stop creating funcs in _G

when creating hooks, call them PS_yourname, not just yourname to prevent conflicts
