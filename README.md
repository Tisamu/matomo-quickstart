Ce repository se base sur [cet exemple](https://github.com/matomo-org/docker/tree/master/.examples/nginx) fourni par Matomo.

## Explication des modifications
- Sortie de nginx dans un dossier dédié, pour y placer un Dockerfile spécifique.
> Ce dernier se base sur une image nginx classique, dans laquelle on vient d'abord démarrer nginx, ensuite appeler le script `certbot.sh` qui va installer
les certificats SSL, démarrer cron pour le renouvellement de ces derniers, et relancer nginx avec une commande qui va laisse le container tourner correctement
en tâche de fond.
> 
> Démarrer nginx d'abord et attendre son bon démarrage est indispensable pour que certbot puisse pinger 
> le nom de domaine associé et installer les certificats.
- Modification du docker-compose en conséquence
## Prérequis
### Fichier d'env et mots de passe

Un fichier d'env est nécessaire à la racine : `db.env`
```
MYSQL_PASSWORD=xxxxx
MYSQL_DATABASE=matomo
MYSQL_USER=matomo
MATOMO_DATABASE_ADAPTER=mysql
MATOMO_DATABASE_TABLES_PREFIX=matomo_
MATOMO_DATABASE_USERNAME=matomo
MATOMO_DATABASE_PASSWORD=
MATOMO_DATABASE_DBNAME=matomo
MARIADB_AUTO_UPGRADE=1
MARIADB_INITDB_SKIP_TZINFO=1
```

Il faut changer le mot de passe MYSQL (`MYSQL_PASSWORD`) pour la connexion à la DB.

Ce même mot de passe doit être indiqué à la ligne `11` du `docker-compose.yml`.

### Changement du nom de domaine dans le projet
Je vous invite à remplacer `matomo.example.com` par l'adresse de votre serveur Matomo partout sur le projet (`matomo.conf` et `certbot.sh` dans le dossier nginx)
N'oubliez pas l'adresse mail dans `certbot.sh`, cette adresse sera utilisée pour vous notifier des renouvellements de noms de domaines, vous ne serez pas spammé.

### Nom de domaine
Avant de lancer ce projet, il vous faut effectuer une redirection de type A depuis votre nom de domaine ou sous domaine vers le serveur qui héberge ce projet.

Si vous le ne faites pas, `certbot` tombera simplement en erreur, car il sera incapable de "pinger" le serveur pour lui déclarer des certificats.

## Lancement du projet

Une fois les prérequis réglés, vous pouvez démarrer le projet avec la commande `docker compose up` à la racine du projet.
Si tout se passe bien, votre serveur Matomo devrait être accessible sur le domaine que vous avez configuré.

Il peut être nécessaire de donner des droits d'accès supérieurs au fichier `certbot.sh` afin que Docker puisse l'exécuter dans le container.

Il est possible qu'il faille stopper et relancer le `docker compose up` la première fois si le démarrage de Matomo ne s'est pas déroulé assez vite pour `certbot` (peut arriver sur un tout petit serveur / VPS).

Si rien ne plante et que le certificat SSL est bien en place, vous pouvez fermer l'instance (Ctrl+C) et la relancer en daemon via `docker compose up -d`.

**Votre serveur Matomo est prêt.** 🎉
