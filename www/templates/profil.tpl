<!doctype html>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport"
            content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <   title>Connexion</title>

    </head>
    <body>
    <div class="container">
        <h2 class="mb-3">Profil</h2>

        <form class="mb-3 row" enctype="multipart/form-data" action="./register-candidate" method="post">

        {if($session.user['type']=admin || $session.user['groupeinscrit']=null}
        <!-- Nom de l'utisateur/admin-->
        <div class="mb-3">
            <label class="form-label">informations personnelles</label>
                <div class="row g-3">
                    <div class="col-md-6">
                        <label for="Email" class="form-label">Email :{$data.Email}</label>
                    </div>
        </div>
        {else}
        <!-- Représentant du groupe -->
        <div class="mb-3">
                <label class="form-label">Informations du représentant</label>

                <div class="row g-3">
                    <div class="col-md-6">
                        <label for="rprsGrp_Nom" class="form-label">Nom :{$data.nom_representant}</label>
                    </div>
                    <div class="col-md-6">
                        <label for="rprsGrp_Prenom" class="form-label">Prénom :{$data.prenom_representant}</label>
                    </div>
                    <div class="col-md-6">
                        <label for="rprsGrp_Email" class="form-label">Email :{$data.email_representant}</label>
                    </div>
                     <div class="col-md-3">
                        <label for="rprsGrp_CodPost" class="form-label">Code postal :{$data.cp_representant}</label>
                    </div>
                    <div class="col-md-9">
                        <label for="rprsGrp_Address" class="form-label">Villes :{$data.ville_representant}</label>
                    </div>
                    <div class="col-md-6">
                        <label for="rprsGrp_Tel" class="form-label">Téléphone :{$data.telephone_representant}</label>
                    </div>
                </div>
            </div>
        {/if}
        </form>
    </body>
</html>
