<!doctype html>
<html lang="en">
    <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <title>Liste des utilisateurs</title>
    </head>

    <body>
        <div class="container">
        <h1>Liste des utilisateurs</h1>
        <br>
        <table class="table table-bordered border-light">
            <tr>
                <th>Adresse mail</th>
                <th>Type de l'utilisateur</th>
            </tr>
            {foreach from=$utilisateurs item=$uneligne}
                <tr>
                    <td>{$uneligne.adresse_mail}</td>
                    <td>{$uneligne.type_utilisateur}</td>
            </tr>
            {/foreach}
        </table>
        <br>
    <a href="./"><button type="button" class="btn btn-primary">Retour</button></a>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>
