<?php

Flight::route('GET /register-candidate', function () {
    $pdo = Flight::get('db');
    $depQuery = $pdo->query('select num_departement,nom_departement from departement');
    $sceneQuery = $pdo->query('select id_scene,type_scene from scene');
    $genreQuery = $pdo->query('select id,nom from genre');

    $dep = $depQuery->fetchAll();
    $scene = $sceneQuery -> fetchAll();
    $style = $genreQuery-> fetchAll();

    $tab = array(
        "listeDep" => $dep,
        "listeScene" => $scene,
        'listeStyle' => $style,
        "data" => array(
        )
    );

    Flight::render('templates/register-candidate.tpl', $tab);
});

Flight::route('POST /register-candidate', function () {
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

    // Verification MotDePasse
    if (empty(trim($data->Motdepasse)))
        $messages['Motdepasse'] = "Le mots de pass est vide.";
    else if (strlen($data->Motdepasse) < 8)
        $messages['Motdepasse'] = "Le mots de pass est trop court (Minimum 8 caractères).";

    // Échec
    if (count($messages) > 0) {
        $depQuery = $pdo->query('select num_departement,nom_departement from departement');
        $sceneQuery = $pdo->query('select id_scene,type_scene from scene');
        $genreQuery = $pdo->query('select id,nom from genre');
        $dep = $depQuery->fetchAll();
        $scene = $sceneQuery->fetchAll();
        $style = $genreQuery-> fetchAll();

        $tab = array(
            "listeDep" => $dep,
            "listeScene" => $scene,
            'listeStyle' => $style,
            'data' => $data,
            'messages' => $messages,
        );

        Flight::render('templates/register-candidate.tpl', $tab);
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
        Flight::render('templates/candidate.tpl', array('groupe'=>$groupe,'session'=>$_SESSION['user']));
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
        Flight::render('templates/candidate.tpl', array('groupe'=>$groupe,'session'=>$_SESSION['user']));
    }
});
