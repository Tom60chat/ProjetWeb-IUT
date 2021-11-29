{* Commentaire Smarty *}
<!doctype html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>{$titre}</title>
    </head>
    <body>
        <h1>{$titre}</h1>

        <table>
            <tr style="background-color: lightgray">
                <th>Album</th>
                <th>Artiste</th>
                <th>Genre</th>
                <th>Date</th>
            </tr>
            {foreach from=$liste item=$album}
            <tr>
                <td>{$album[1]}</td>
                <td><a href="./artiste-{$album[3]}-{$album[8]}.html">{$album[8]}</a></td>
                <td>{$album[6]}</td>
                <td>{$album[4]}</td>
            </tr>
            {/foreach}
        </table>

        <style>
            body {
                font-family: Arial;
            }

            table {
                border-spacing: 0;
                border: 2px solid lightgray;
            }
        </style>
    </body>
</html>