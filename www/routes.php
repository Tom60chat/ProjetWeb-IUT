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

    // Verification MotsDePass
    if (empty(trim($data->Motdepasse)))
        $messages['Motdepasse'] = "Le mots de pass est vide.";
    else if (strlen($data->Motdepasse) < 8)
        $messages['Motdepasse'] = "Le mots de pass est trop court (Minimum 8 caractères).";

    // Écheque
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

    // Verification MotsDePass
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

    // Écheque
    $tab = array(
        'data' => $data,
        'messages' => $messages,
    );

    Flight::render('templates/login.tpl', $tab);
});