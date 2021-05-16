# TP_Docker

Le but de ce TP est de créer une image Docker et d'installer une cross-toolchain avec crosstool-ng.

Pour build votre image il faut utiliser commande " docker build -t 'ct-ng:latest' ."
Cette commande va construire toutes les étapes réaliser dans le script.

![Capture d’écran du 2021-05-16 22-19-11](https://user-images.githubusercontent.com/72381443/118411437-d206ad00-b694-11eb-8514-368f85aa1532.png)

![image](https://user-images.githubusercontent.com/72381443/118411692-1a729a80-b696-11eb-97e7-89d9b6b4c78b.png)

Comme on peut le voir il y a 29 étapes pour la construction.

Une fois la construction finit il ne reste plus qu'à executer à l'aide de la commande "docker run -t ct-ng"

![image](https://user-images.githubusercontent.com/72381443/118411539-6244f200-b695-11eb-9d83-426ef25ad3f0.png)


