<!doctype html>
<html lang="en">
    <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <title>Accueil</title>
    </head>
    <body>
        <div class="container">
        <h1>Accueil</h1>
        <h4>Site officiel du festival IUT</h4>
        <br>
        {*Affichage de liens différent si l'utilisateur est connecté ou non*}
        {if !isset($session.user) || empty($_SESSION)}
            {*Affichage des liens d'inscription et de connexion*}
            <p>Vous voulez participer au festival ? <a href=./register>Inscrivez-vous</a></p>
            <p>Déja inscrit ? <a href=./login >Connectez-vous</a></p>
        {else}
            {*Affichage de liens différent selon le type de l'utilisateur connecté *}
            {if $session.user['type'] == 'utilisateur'}
                {*Affichage différent de liens si l'utilisateur connecté de type utilisateur a déposé une candidature ou non*}
                {if !isset($session.user['groupeinscrit'])}
                    <h4>Bienvenue !</h4>
                    <p><a href=./register-candidate>Ajoutez la candidature de votre groupe</a></p>
                {else}
                    <h4>Bienvenue {$session.user['username']} !</h4>
                    <p><a href=./candidate>Consultez la candidature de votre groupe</a></p>
                {/if}
            {else}
                <h4>Bienvenue admin !</h4>
                <p><a href=./liste-candidate>Accéder à la liste des candidatures</a></p>
                <p><a href=./liste-user>Accéder à la liste des profils</a></p>
            {/if}
            <br>
            {*Affichage des liens pour consulter le profil et de déconnexion*}
            <p><a href=./profil>Accéder au profil</a></p>
            <p><a href=./logout>Se déconnecter</a></p>
        {/if}
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>
