<!doctype html>
<html lang="en">
    <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Candidature</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    </head>

    <body>
    <div class="container">
        <div class="row align-items-center">
            <div class="col-4">
                <div class="text-center">
                    {*Image du groupe*}
                    <img src="{$groupe.photos['0']}" alt="Image du groupe" class="img-fluid">
                </div>
            </div>
        <div class="col-8">
        <h1 class="display-1">{$groupe.nom_groupe}<br></h1>
        <table class="table table-bordered border-light">
            {*Affichage des 3 lecteurs pour les fichiers mp3*}
            {foreach from=$groupe.fichiersmp3 item=$lien}
                <tr>
                    <td class="text-end">Audio</td>
                    {$nomfichier=explode("/",$lien)}
                    <td><audio controls><source src="{$lien}" type="audio/mpeg">{$nomfichier.1} n'est pas suporté</audio><a href="{$lien}">{$nomfichier.1}</a></td>
                </tr>
            {/foreach}
            {*Affichge des informations sur la candidature*}
            <tr>
                <td class="text-end">Département</td>
                <td>{$groupe.departement_groupe}</td>
            </tr>
            <tr>
                <td class="text-end">Ville</td>
                <td>{$groupe.ville_representant}</td>
            </tr>
            <tr>
                <td class="text-end">Code Postal</td>
                <td>{$groupe.cp_representant}</td>
            </tr>
            <tr>
                <td class="text-end">Style</td>
                <td>{$groupe.style_groupe}</td>
            </tr>
            {if isset($groupe.lien_soundcloud)}
                <tr>
                    <td class="text-end">Soundcloud</td>
                    <td><a href={$groupe.lien_soundcloud}>{$groupe.lien_soundcloud}</a></td>
                </tr>
            {/if}
            <tr>
                <td class="text-end">Web</td>
                <td><a href={$groupe.lien_web}>{$groupe.lien_web}</a>
                </td>                
            </tr>
            {*Affichage du lien s'il existe dans le base*}
            {if isset($groupe.lien_youtube)}
                <tr>
                    <td class="text-end">Vidéo</td>
                    <td><a href={$groupe.lien_youtube}>{$groupe.lien_youtube}</a></td>
                </tr>
            {/if}
            <tr>
                <td class="text-end">Présentation</td>
                <td>{$groupe.presentation_groupe}</td>
            </tr>
            <tr>
                <td class="text-end">Expérience</td>
                <td>{$groupe.experience_groupe}</td>
            </tr>
            <tr>
                <td class="text-end">Dossier</td>                
            </tr>
            <tr>
                <td class="text-end">Setlist/SACEM</td>
                <td><a href={$groupe.sacempdf}>{$groupe.sacempdf}</a></td>
            </tr>
            <tr>
                <td class="text-end">Fiche technique</td>
                <td><a href={$groupe.fichepdf}>{$groupe.fichepdf}</a></td>
            </tr>
        </table>
        <br>
        <a href="./"><button type="button" class="btn btn-primary">Retour</button></a>
        </div>
    </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>
