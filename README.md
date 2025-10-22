## 🧩 Description

Ce document contient :

- les **instructions pour lancer** la base de données et charger le jeu de données (`seed.sql`)
- la **liste des questions** auxquelles vous devrez répondre à l’aide de requêtes SQL

🎯 L’objectif : pratiquer les `SELECT`, filtres, `JOIN`, `GROUP BY`, agrégats, dates, sous-requêtes et fenêtres.

---

## 🧱 Prérequis

Avant de commencer, assurez-vous d’avoir :

- Docker & Docker Compose installés sur votre machine ;
- le fichier `docker-compose.yml` du projet, contenant un service MySQL nommé `mysql` (ou adaptez le nom du service si nécessaire) ;
- un fichier `seed.sql` contenant le jeu de données, placé à la racine du projet ;
- un fichier `.env` contenant les variables d’environnement (notamment `MYSQL_ROOT_PASSWORD`) si votre `docker-compose.yml` en dépend.

---

## 🚀 Étapes pour lancer la base et injecter les données

1. Placez le fichier `seed.sql` à la racine du projet (même dossier que `docker-compose.yml`).

2. Démarrez les conteneurs :

   ```bash
   docker compose up -d
   ```

3. Chargez le jeu de données dans la base MySQL :

   ```bash
   # remplacez le nom du conteneur "mysql" s’il diffère dans votre docker-compose
   docker exec -i mysql mysql -uroot -p"$MYSQL_ROOT_PASSWORD" < seed.sql
   ```

   > Si votre fichier `.env` ne définit pas `MYSQL_ROOT_PASSWORD`, remplacez `"$MYSQL_ROOT_PASSWORD"` par le mot de passe root réel.

4. Alternative — depuis le shell MySQL dans le conteneur :

   ```bash
   docker exec -it mysql mysql -uroot -p
   # puis dans le client mysql :
   SOURCE /chemin/vers/seed.sql;
   ```

5. Vérifiez que tout est bien chargé :

   ```bash
   docker exec -it mysql mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "SHOW DATABASES; USE app_db; SHOW TABLES;"
   ```

---

## 🧹 Reset de l'environnement Docker (projet)

### Arrêter et supprimer les conteneurs

```bash
docker compose down
```

### Supprimer les volumes

```bash
docker compose down -v
```

> ⚠️ Cela supprimera toutes les données de la base de données.

### Supprimer les images

```bash
docker compose down --rmi all
```

### Reset complet (conteneurs + volumes + images)

```bash
docker compose down -v --rmi all
```

## 🧹 Reset de l'environnement Docker (machine)

# 1. Arrêter TOUS les conteneurs Docker sur votre machine

```bash
docker stop $(docker ps -aq)
```

# 2. Supprimer TOUS les conteneurs

```bash
docker rm $(docker ps -aq)
```

# 3. Supprimer TOUS les volumes

```bash
docker volume rm $(docker volume ls -q)
```

# 4. Supprimer TOUTES les images

```bash
docker rmi $(docker images -q) --force
```

# OU utilisez la commande ultime qui fait tout en une fois :

```bash
docker system prune -a --volumes --force
```

La dernière commande docker system prune -a --volumes --force est
l'équivalent d'un reset total de Docker sans demander de confirmation.

⚠️ ATTENTION : Cela va supprimer TOUS vos conteneurs, volumes, images et
réseaux Docker, pas seulement ceux de ce projet !

---

## 🧠 Liste des questions

## Niveau 1 — Filtres simples

1. Affichez la liste des étudiants du département “Informatique”.
2. Quels cours ont plus de 4 crédits ?
3. Quelles sont les professeures embauchées avant 2019 ?
4. Quels étudiants sont en 3ᵉ année ?

## Niveau 2 — Agrégations et GROUP BY

5. Combien d’étudiants par département ?
6. Quelle est la moyenne des salaires des professeurs par département ?
7. Quelle est la note moyenne par cours ?
8. Quel est le nombre total d’inscriptions par cours ?
9. Quel est le nombre moyen de crédits suivis par étudiant ?

## Niveau 3 — Jointures et sous-requêtes

10. Quelle est la meilleure note obtenue dans chaque cours ?
11. Quels étudiants ont une moyenne supérieure à 14 ?
12. Quelle est la note moyenne par département d’étudiants ?
13. Quel professeur encadre le plus d’étudiants ?
14. Quelle est la répartition des étudiants par ville ?
