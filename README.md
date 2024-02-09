# CPA
TD CPA
Voici une explication détaillée de ce que fait le code :

## Chargement des données :

Le code charge trois ensembles de données :
Les entrées (inputs.mat), qui sont les données brutes à chiffrer.
Une table de substitution (subBytes.mat), qui est utilisée dans l'opération de substitution.
Des traces de consommation de puissance (traces1000x512.mat), qui sont des mesures de la consommation de puissance pendant le chiffrement.

## Initialisation des variables :

num_traces représente le nombre de traces de consommation de puissance.
num_time_samples représente le nombre d'échantillons de temps dans chaque trace.
num_keys est le nombre de clés possibles pour une sous-clé d'un octet (256 clés dans ce cas).
Une matrice P est initialisée pour stocker les estimations de poids de Hamming pour chaque trace et chaque clé possible.

## Boucle principale :

Une boucle itère sur toutes les clés possibles (de 0 à 255).
Pour chaque clé, la boucle parcourt toutes les traces et fait ce qui suit :
Effectue l'opération AddRoundKey en effectuant un XOR entre chaque octet d'entrée et la clé.
Effectue l'opération SubBytes en utilisant une table de substitution pour remplacer chaque octet par un autre octet selon la table.
Estime le poids de Hamming de la sortie de l'opération SubBytes.
Stocke le poids de Hamming estimé dans la matrice P.

## Calcul de la corrélation :

Une fois que les poids de Hamming ont été estimés pour toutes les clés et toutes les traces, le code calcule la corrélation entre les poids de Hamming et les traces de consommation de puissance.
Il génère une matrice de corrélation où chaque élément représente la corrélation entre le poids de Hamming pour une clé donnée et chaque échantillon de temps dans les traces de consommation de puissance.

## Identification de la clé probable :

Le code identifie la clé probable en trouvant la clé qui a la plus grande corrélation avec les traces de consommation de puissance.

## Tracé des graphiques :

## Le code trace deux graphiques :

Un tracé de corrélation 2D qui montre la corrélation maximale pour chaque échantillon de temps.
Une surface 3D de corrélation qui montre la corrélation pour chaque échantillon de temps en fonction de chaque clé.

## Clé probable :

Le code identifie la clé probable en choisissant la clé avec la plus grande corrélation.
En conclusion, le code implémente une attaque de type DPA ou SPA pour retrouver la clé secrète utilisée dans le chiffrement à partir des traces de consommation de puissance et des données d'entrée chiffrées.
