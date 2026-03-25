# AWS-TerraDeploy-Core

Ce projet automatise le déploiement d'une instance **EC2** sur **AWS (Région Stockholm)** en utilisant **Terraform**. Il configure également un environnement **Docker** prêt à l'emploi pour héberger une application conteneurisée.

##  Architecture du Projet
L'infrastructure est entièrement définie par le code et comprend :
* **Fournisseur Cloud** : AWS (eu-north-1).
* **Instance EC2** : Type `t3.micro` avec Amazon Linux 2023.
* **Sécurité** : Groupe de sécurité (Security Group) autorisant le SSH (port 22) et le trafic Web (port 80).
* **Provisioning** : Script `user_data` pour l'installation automatique de Docker, Docker Compose et Git.



##  Technologies utilisées
* **Terraform** : Pour l'orchestration de l'infrastructure.
* **AWS** : Cloud provider.
* **Docker & Docker Compose** : Pour la conteneurisation de l'application.
* **Bash** : Pour les scripts de démarrage automatique.

##  Installation et Utilisation

### Prérequis
1. Avoir un compte AWS et une paire de clés (`.pem`) nommée `mini-projet-ci-cd`.
2. Terraform installé localement.
3. AWS CLI configuré (`aws configure`).

### Déploiement
1. Cloner ce dépôt :
   ```bash
   git clone [https://github.com/maryamgadi/AWS-TerraDeploy-Core.git](https://github.com/maryamgadi/AWS-TerraDeploy-Core.git)
   cd AWS-TerraDeploy-Core
