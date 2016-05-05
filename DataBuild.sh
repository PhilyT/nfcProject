    #!/usr/bin/env bash

    # Définition des couleurs du script

    ROUGE="\\033[31m"
    VERT="\\033[1;32m"
    JAUNE="\\033[1;33m"
    NORMAL="\\033[0m"

    # récupération des données de connexion

    read -s -p "Entrer MYSQL host: " host
    read -s -p "Entrer MYSQL user: " user
    read -s -p "Entrer MYSQL password: " password

    # Vérification de la connexion à la base de donnée

    echo -e " \n --- Vérification que la connexion à la base ... \c\n";

    bases=`mysql -h$host -u$user -p$password -e "show databases;" -B -s 2> /dev/null`

    if [ -z "$bases" ];then
            echo -e "[$ROUGE ERR $NORMAL]"
            echo -e "${ROUGE} [ERR] Identifiant incorrect ou pas de base de données $NORMAL"
            exit 1;
    fi
    echo -e "[${VERT} OK ${NORMAL}]"

    # Vérification de l'existance de la base de donnée, supression de la base si existante

    echo -e " --- Vérification de l'existance de la database 'rfid_badgeuse' ... \c \n"

    bases=`mysql -h$host -u$user -p$password -e "SHOW DATABASES LIKE 'rfid_badgeuse';" -B -s 2> /dev/null`
    if [ -z "$bases" ];then
        echo -e "[${VERT} NON ${NORMAL}]"
    else
        echo -e "[${JAUNE} OUI ${NORMAL}]"
        echo -e " --- Suppression de la database 'Rfid_badgeuse' existante ... \c"
        mysql mysql -h$host -u$user -p$password -e "DROP DATABASE rfid_badgeuse;" -B -s 2> /dev/null
        bases=`mysql -h$host -u$user -p$password -e "SHOW DATABASES LIKE 'rfid_badgeuse';" -B -s 2> /dev/null`
        if [ -z "$bases" ];then
            echo -e  "[${VERT} OK ${NORMAL}]"
        else
            echo -e "[${ROUGE} ERR ${NORMAL}]"
            echo -e "${ROUGE}     [ERR] La database uno existe encore $NORMAL"
            exit 1;
        fi
    fi

    # Exécution du script de creation

    echo " --- Création de la nouvelle database 'rfid_badgeuse' ... \c"
    bases=`mysql -h$host -u$user -p$password  < BuildDatabase.sql -B -s`
    if [ -z "$bases" ];then
        echo -e "[${VERT} OK ${NORMAL}]"
    else
        echo -e "[${ROUGE} ERR ${NORMAL}]"
        echo -e "${ROUGE}     [ERR] Probleme script ${NORMAL}"
        exit 1;
    fi

    # Vérification de la bonne création de la base

    bases=`mysql -h$host -u$user -p$password -e "SHOW DATABASES LIKE 'rfid_badgeuse';" -B -s 2> /dev/null`
    if [ -z "$bases" ];then
            echo -e  "[${ROUGE} ERR $NORMAL]"
            echo -e "${ROUGE}     [ERR] La database rfid n'existe pas $NORMAL"
            exit 1;
    fi
    echo -e "[${VERT} OK ${NORMAL}]"