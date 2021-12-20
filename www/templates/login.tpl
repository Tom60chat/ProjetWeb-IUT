<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Connexion</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    </head>
    <body>
        <div class="container">
            <h2>Connexion candidat</h2>
               <form action="./login" method="post">
                <div class="mb-3">
                    <label for="Email" class="form-label">Email</label>
                    <input type="email" class="form-control" name="Email" id="Email" value="{$data.Email|escape|default:''}" placeholder="nom@domaine.fr"><br>
                    {if !empty($messages.Email)}
                        {$messages.Email}<br>
                    {/if}
                </div>
                <div class="mb-3">
                    <label for="Motdepasse" class="form-label">MotDepasse</label>
                    <input type="password" class="form-control" name="Motdepasse" id="Motdepasse" value="{$data.Motdepasse|escape|default:''}" placeholder="M0nM0ts2Pass1"><br>
                    {if !empty($messages.Motdepasse)}
                        {$messages.Motdepasse}<br>
                    {/if}
                </div>
                <div class="col-auto">
                    <button type="submit" class="btn btn-primary mb-3">Connexion</button>
                </div>
            </form>
        </div>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>
