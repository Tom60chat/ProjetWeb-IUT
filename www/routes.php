<?php

// Page register
Flight::route('GET /register', function () {
    Flight::render('templates/register.tpl', null);
});

// Page register (POST)
Flight::route('POST /register', function () {
    $pdo = Flight::get('db');
    $data = Flight::request()->data;
    $messages = array();

    // Verification nom
    if (empty(trim($data->Nom)))
        $messages['Nom'] = "Le nom est vide.";
    // Verification mail
    if (filter_var($data->Email, FILTER_VALIDATE_EMAIL) === false) {
        $messages['Email'] = "Adresse email invalide";
    } else {
        $emails = $pdo->prepare("select Email from utilisateur where Email = :email");
        $emails->execute(
            array(
                ":email" => $data->Email
            )
        );
        if ($emails->rowCount() > 0)
            $messages['Email'] = "L'email est déjà enregistré.";
    }
    // Verification MotsDePass
    if (empty(trim($data->Motdepasse)))
        $messages['Motdepasse'] = "Le mots de pass est vide.";
    else if (strlen($data->Motdepasse) < 8)
        $messages['Motdepasse'] = "Le mots de pass est trop court (Minimum 8 caractères).";

    // Échec
    if (count($messages) > 0) {
        $tab = array(
            'data' => $data,
            'messages' => $messages,
        );

        Flight::render('templates/register.tpl', $tab);
    }
    else {
        // Succès
        $req_account = $pdo->prepare("insert into utilisateur values (:nom, :email, :motdepasse,'','')");
        $req_account->execute(
            array(
                ":nom" => $data->Nom,
                ":email" => $data->Email,
                ":motdepasse" => password_hash($data->Motdepasse, PASSWORD_DEFAULT)
            )
        );
        Flight::redirect("./success");
    }
});

// Page register-candidate
Flight::route('GET /register-candidate', function () {
    $pdo = Flight::get('db'); // Récupérer la BDD

    // Récupération des listes
    $depQuery = $pdo->query('select num_departement,nom_departement from departement');
    $sceneQuery = $pdo->query('select id_scene,type_scene from scene');

    $dep = $depQuery->fetchAll();
    $scene = $sceneQuery -> fetchAll();

    $tab = array(
        "listeDep" => $dep,
        "listeScene" => $scene
    );

    // Afficher register-candidate
    Flight::render('templates/register-candidate.tpl', $tab);
});

// Page register-candidate (POST)
Flight::route('POST /register-candidate', function () {
    $pdo = Flight::get('db'); // Récupérer la BDD
    $data = Flight::request()->data; // Récupérer le POST
    $ut = new Utility($data);

    // == VERIFICATION ==

    // Verification Nom du groupe (text)
    if (!$ut->isEmpty('NomGrp', 'Le nom du groupe est vide.'))
    {
        $req_NomGroupe = $pdo->prepare("select nom_groupe from candidature where nom_groupe = :nom_groupe");
        $req_NomGroupe->execute(array(
            ':nom_groupe' => $data['NomGrp']
        ));
        $nomGroupe = $req_NomGroupe->fetchAll();
        if (!empty($nomGroupe))
            $ut->addMessage('NomGrp', 'Ce nom de groupe existe déjà.');
    }

    // Verification Département d'origine (select)
    $ut->isEmpty('Departement', 'Veuillez choisir un département');

    // Verification Type de scène (select)
    $ut->isEmpty('Scene', 'Veuillez choisir une scène');

    // Verification Représentant du groupe - Nom (text)
    $ut->isEmpty('rprsGrp_Nom', 'Le nom du représentant est vide.');

    // Verification Représentant du groupe - Prénom (text)
    $ut->isEmpty('rprsGrp_Prenom', 'Le prénom du représentant est vide.');

    // Verification Représentant du groupe - Address (text)
    $ut->isEmpty('rprsGrp_Address', 'L\'address du représentant est vide.');

    // Verification Représentant du groupe - Code Postal (number)
    $ut->isValid('rprsGrp_CodPost', 'Le code postal', FILTER_VALIDATE_INT);
    $ut->isEmpty('rprsGrp_CodPost', 'Le code postal est vide.');

    // Verification Représentant du groupe - Email (email)
    $ut->isValid('rprsGrp_Email', 'L\'address du représentant', FILTER_VALIDATE_EMAIL);
    $ut->isEmpty('rprsGrp_Email', 'L\'address du représentant est vide.');

    // Verification Représentant du groupe - Téléphone (number)
    $ut->isValid('rprsGrp_Tel', 'Le numéro de téléphone', FILTER_VALIDATE_INT);
    $ut->isEmpty('rprsGrp_Tel', 'Le numéro de téléphone est vide.');

    // Verification Style musical (text)
    $ut->isEmpty('Style', 'Le style est vide.');

    // Verification Année de création (number)
    $ut->isValid('AnneeCreation', 'L\'année de création', FILTER_VALIDATE_INT);
    $ut->isEmpty('AnneeCreation', 'L\'année de création est vide.');

    // Verification Présentation du texte (textarea)
    $ut->isBig('Presentation', 'Le text de présentation ', 500);
    $ut->isEmpty('Presentation', 'Le text de présentation est vide.');

    // Verification Expériences scéniques (textarea)
    $ut->isBig('Exeriences', 'Le text du l\'expériences scéniques ', 500);
    $ut->isEmpty('Exeriences', 'Le text du l\'expériences scéniques est vide.');

    // Verification Site web ou réseau social (url)
    $ut->isValid('URL', 'L\'url', FILTER_VALIDATE_URL);
    $ut->isEmpty('URL', 'L\'url est vide.');

    // Verification Adresse page SoundCloud (url) (facultatif)
    if (!$ut->isEmpty('SoundCloud', ''))
        $ut->isValid('SoundCloud', 'L\'url SoundCloud', FILTER_VALIDATE_URL);

    // Verification Adresse page YouTube (url) (facultatif)
    if (!$ut->isEmpty('YouTube', ''))
        $ut->isValid('YouTube', 'L\'url Youtube', FILTER_VALIDATE_URL);

    // Verification Membres du groupe (list)
    for ($i = 1; $i <= 8; $i++) {
        $count = $ut->isComplete($data['Membre'.$i.'_Nom'], $data['Membre'.$i.'_Prenom'], $data['Membre'.$i.'_Instrument']);
        if ($count > 0 && 3 > $count)
            $ut->addMessage('Membre'.$i, "Le membre $i n'est pas complet");
    }

    // Verification MP3 (file)
    $ut->isFileExist('Musiques', 'Veuillez ajouter des musiques');

    // Verification Dossier de presse (file) (facultatif)

    // Verification Photos de groupe (file)
    $ut->isFileExist('PhotoGrp', 'Veuillez ajouter des photos de groupe');

    // Verification Fiche technique (file)
    $ut->isFileExist('FicheTechnique', 'Veuillez ajouter une fiche technique');

    // Verification Document SACEM ou Setlist (file)
    $ut->isFileExist('DocSacemSetlist', 'Veuillez choisir un dossier de press');

    // == TRAITEMENT ==

    $fichiersmp3 = '';
    $pressepdf = '';
    $photos = '';
    $fichepdf = '';
    $sacempdf = '';

    // Récupération des fichiers
    if (empty($ut->messages))
    {
        $folderName = Utility::nettoyer_nom_fichier($data['NomGrp']);
        $fichiersmp3 = $ut->saveFiles('Musiques', $folderName);
        if ($ut->isFileExist('DossierPresse', ''))
            $pressepdf = $ut->saveFiles('DossierPresse', $folderName);
        $photos = $ut->saveFiles('PhotoGrp', $folderName);
        $fichepdf = $ut->saveFiles('FicheTechnique', $folderName);
        $sacempdf = $ut->saveFiles('DocSacemSetlist', $folderName);

        // Raccourcis les noms des fichiers
        $fichiersmp3 = str_replace(Utility::$uploadsPath . $folderName . '/', '', $fichiersmp3);
        $pressepdf = str_replace(Utility::$uploadsPath . $folderName . '/', '', $pressepdf);
        $photos = str_replace(Utility::$uploadsPath . $folderName . '/', '', $photos);
        $fichepdf = str_replace(Utility::$uploadsPath . $folderName . '/', '', $fichepdf);
        $sacempdf = str_replace(Utility::$uploadsPath . $folderName . '/', '', $sacempdf);
    }

    // Échecs
    if (!empty($ut->messages)) {
        $depQuery = $pdo->query('select num_departement,nom_departement from departement');
        $sceneQuery = $pdo->query('select id_scene,type_scene from scene');

        $dep = $depQuery->fetchAll();
        $scene = $sceneQuery->fetchAll();

        $tab = array(
            "listeDep" => $dep,
            "listeScene" => $scene,
            'data' => $data,
            'messages' => $ut->messages,
        );

        Flight::render('templates/register-candidate.tpl', $tab);
    }
    // Succès
    else {
        // Publication de la candidature du groupe
        $req_account = $pdo->prepare("insert into candidature (
                         nom_groupe,
                         departement_groupe,
                         type_scene,
                         nom_representant,
                         prenom_representant,
                         cp_representant,
                         ville_representant,
                         email_representant,
                         telephone_representant,
                         style_groupe,
                         annee_crea_groupe,
                         presentation_groupe,
                         experience_groupe,
                         lien_web,
                         lien_soundcloud,
                         lien_youtube,
                         statut,
                         sacem,
                         producteur,
                         fichiersmp3,
                         pressepdf,
                         photos,
                         fichepdf,
                         sacempdf 
                         ) values (
                               :nom_groupe,
                               :departement_groupe,
                               :type_scene,
                               :nom_representant,
                               :prenom_representant,
                               :cp_representant,
                               :ville_representant,
                               :email_representant,
                               :telephone_representant,
                               :style_groupe,
                               :annee_crea_groupe,
                               :presentation_groupe,
                               :experience_groupe,
                               :lien_web,
                               :lien_soundcloud,
                               :lien_youtube,
                               :statut,
                               :sacem,
                               :producteur,
                               :fichiersmp3,
                               :pressepdf,
                               :photos,
                               :fichepdf,
                               :sacempdf                               
                           )");
        $req_account->execute(
            array(
                ":nom_groupe" => $data['NomGrp'],
                ":departement_groupe" => $data['Departement'],
                ":type_scene" => $data['Scene'],
                ":nom_representant" => $data['rprsGrp_Nom'],
                ":prenom_representant" => $data['rprsGrp_Prenom'],
                ":cp_representant" => $data['rprsGrp_CodPost'],
                ":ville_representant" => $data['rprsGrp_Address'],
                ":email_representant" => $data['rprsGrp_Email'],
                ":telephone_representant" => $data['rprsGrp_Tel'],
                ":style_groupe" => $data['Style'],
                ":annee_crea_groupe" => $data['AnneeCreation'],
                ":presentation_groupe" => $data['Presentation'],
                ":experience_groupe" => $data['Exeriences'],
                ":lien_web" => $data['URL'],
                ":lien_soundcloud" => $data['SoundCloud'],
                ":lien_youtube" => $data['YouTube'],
                ":statut" => isset($data['Associatif']),
                ":sacem" => isset($data['SACEM']),
                ":producteur" => isset($data['Producteur']),
                ":fichiersmp3" => $fichiersmp3,
                ":photos" => $photos,
                ":pressepdf" => $pressepdf,
                ":fichepdf" => $fichepdf,
                ":sacempdf" => $sacempdf
            )
        );

        $id = $pdo->lastInsertId();

        // Ajout des membres dans la liste
        for ($i = 1; $i <= 8; $i++) {
            $count = $ut->isComplete($data['Membre'.$i.'_Nom'], $data['Membre'.$i.'_Prenom'], $data['Membre'.$i.'_Instrument']);
            if ($count == 0) {
                $req_account = $pdo->prepare("insert into membre_groupe (
                         nom_membre,
                         prenom_membre,
                         instrument_membre,
                         num_groupe
                         ) values (
                               :nom_membre,
                               :prenom_membre,
                               :instrument_membre,
                               :num_groupe                            
                           )");
                $req_account->execute(
                    array(
                        ':nom_membre' => $data['Membre'.$i.'_Nom'],
                        ':prenom_membre' => $data['Membre'.$i.'_Prenom'],
                        ':instrument_membre' => $data['Membre'.$i.'_Instrument'],
                        ':num_groupe' => $id,
                    ));
            }
        }

        Flight::redirect("./success");
    }
});

Flight::route('GET /success', function () {
    Flight::render('templates/success.tpl', null);
});

Flight::route('GET /login', function () {
    Flight::render('templates/login.tpl', null);
});

Flight::route('POST /login', function () {
    $pdo = Flight::get('db');
    $data = Flight::request()->data;
    $messages = array();

    // Verification mail
    if (filter_var($data->Email, FILTER_VALIDATE_EMAIL) === false) {
        $messages['Email'] = "Adresse email invalide";
    } else {
        $emails = $pdo->prepare("select Email from utilisateur where Email = :email");
        $emails->execute(
            array(
                ":email" => $data->Email
            )
        );

        if ($emails->rowCount() == 0)
            $messages['Email'] = "Identifiants incorrects";
    }

    // Verification MotDePasse
    if (empty(trim($data->Motdepasse)))
        $messages['Motdepasse'] = "Le mots de pass est vide.";
    else if (strlen($data->Motdepasse) < 8)
        $messages['Motdepasse'] = "Le mots de pass est trop court (Minimum 8 caractères).";

    // Succès
    if (count($messages) == 0) {
        $req_account = $pdo->prepare("select Nom, Motdepasse from utilisateur where Email = :email");
        $req_account->execute(
            array(
                ":email" => $data->Email
            )
        );
        if ($req_account->rowCount() == 0)
        {
            $messages['Motdepasse'] = "Identifiants incorrects";
        }
        else {
            $user = $req_account->fetch();

            if ($user['Motdepasse'] == password_verify($data->Motdepasse, $user['Motdepasse'])) {
                session_start();
                $_SESSION["user"] = array('name' => $user['Nome'], 'mail' => $data->Email);
                Flight::redirect("./");
                return;
            } else
                $messages['Motdepasse'] = "Identifiants incorrects";
        }
    }

    // Échec
    $tab = array(
        'data' => $data,
        'messages' => $messages,
    );

    Flight::render('templates/login.tpl', $tab);
});

Flight::route('/candidate', function(){
    //cette page est accessible seulement à un utilisateur de type utilisateur
    if(!isset($_SESSION['user']) || $_SESSION['user']['type']!="utilisateur"){
        Flight::redirect('/');
    }
    else{
        //on prépare et éxecute une requête pour obtenir les informations d'une canditure
        $req=Flight::get('db')->prepare('SELECT * FROM candidature WHERE email_representant like :email');
        $req->execute(array(':email'=>$_SESSION['user']['Email']));
        //on convertit le résultat de la requête sous forme d'un tableau de chaine de caractère
        $groupe=$req->fetch();
        //on a stocké les liens des 3 fichiers mp3 dans un même champ, on les sépare
        $tab3=explode(";",$groupe['fichiersmp3']);
        $groupe['fichiersmp3']=$tab3;
        //on a stocké les liens des 2 images dans un même champ, on les sépare
        $tab2=explode(";",$groupe['photos']);
        $groupe['photos']=$tab2;
        Flight::render('templates/candidate.tpl', array('groupe'=>$groupe,'session'=>$_SESSION));
    }
});

Flight::route('/candidate-@idgroupe', function($idgroupe){
    //l'admin provient de la page de liste des candidatures, on utilise le num_groupe en paramètre dans le lien pour savoir le groupe dont on veut afficher la candidature
    //cette page est accessible seulement à un utilisateur de type admin
    if(!isset($_SESSION['user']) || $_SESSION['user']['type']!="admin"){
        Flight::redirect('/');
    }
    else{
        //on prépare et éxecute une requête pour obtenir les informations d'une candidature
        $req=Flight::get('db')->prepare('SELECT * FROM candidature WHERE num_groupe like :id');
        $req->execute(array(':id'=>$idgroupe));
        //on convertit le résultat de la requête sous forme d'un tableau de chaine de caractère
        $groupe=$req->fetch();
        //on a stocké les liens des 3 fichiers mp3 dans un même champ, on les sépare
        $tab3=explode(";",$groupe['fichiersmp3']);
        $groupe['fichiersmp3']=$tab3;
        //on a stocké les liens des 2 images dans un même champ, on les sépare
        $tab2=explode(";",$groupe['photos']);
        $groupe['photos']=$tab2;
        Flight::render('templates/candidate.tpl', array('groupe'=>$groupe,'session'=>$_SESSION));
    }
});

Flight::route('/liste-candidate',function(){
    //cette page est accessible seulement par les utilisaeurs de type admin
    if($_SESSION['user']['type']=='admin')
    {
        //on prépare et éxecute la requête sql pour obtenir les informations nécéssaires pour afficher les candidatures
        $req=Flight::get('db')->prepare('SELECT distinct num_groupe, nom_groupe, departement_groupe, ville_representant, type_scene, style_groupe, annee_crea_groupe, presentation_groupe, experience_groupe FROM candidature');
        $req->execute();
        //on convertit et on met le résultat de la requête dans un tableau
        $groupes=$req->fetchAll();
        Flight::render('templates/liste-candidate.tpl', array('groupes'=>$groupes,'session'=>$_SESSION['user']));
    }
    else{
        Flight::redirect('/');
    }
});
