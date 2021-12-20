<!doctype html>
<html lang="en">
    <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <title>Liste des candidats</title>
    </head>

    <body>
        <div class="container">
        <h1>Liste des candidats</h1>
        <br>
        <table class="table table-bordered border-light">
            <tr>
                <th>n°</th>
                <th>Page de candidature</th>
                <th>Nom du groupe</th>
                <th>Département</th>
                <th>Ville</th>
                <th>Scène</th>
                <th>Style</th>
                <th>Année de création</th>
                <th>Présentation</th>
                <th>Expérience</th>
            </tr>
            {foreach from=$groupes item=$uneligne}
                <tr>
                    <td>{$uneligne.num_groupe}</td>
                    <td><a href="./candidate-{$uneligne.num_groupe}">Détails</a></td>
                    <td>{$uneligne.nom_groupe}</td>
                    <td>{$uneligne.departement_groupe}</td>
                    <td>{$uneligne.ville_representant}</td>
                    <td>{$uneligne.type_scene}</td>
                    <td>{$uneligne.style_groupe}</td>
                    <td>{$uneligne.annee_crea_groupe}</td>
                    <td>{$uneligne.presentation_groupe}</td>
                    <td>{$uneligne.experience_groupe}</td>
            </tr>
            {/foreach}
        </table>
        <br>
    <a href="./"><button type="button" class="btn btn-primary">Retour</button></a>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>
