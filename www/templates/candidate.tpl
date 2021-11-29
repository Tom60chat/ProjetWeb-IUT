{* Commentaire Smarty *}
<!doctype html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>{$titre}</title>
    </head>
    <body>

    <h2>{$artist}</h2>

    <table>
        <tr style="background-color: lightgray">
            <th>Album</th>
            <th>Genre</th>
            <th>Date</th>
        </tr>
        {foreach from=$liste item=$album}
            <tr>
                <td>{$album[1]}</td>
                <td>{$album[6]}</td>
                <td>{$album[4]}</td>
            </tr>
            {foreachelse}
            <p>Pas de résultat</p>
        {/foreach}
    </table>

    <a href="./liste.html"><button>Retour</button></a>

    </body>
</html>