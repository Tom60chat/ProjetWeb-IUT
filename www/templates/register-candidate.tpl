<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <title>Register</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

</head>
<body>
    <div class="container">
        <h2>Enregistrement candidat</h2>

        <form class="mb-3 row" action="./register" method="post">

            <!-- Nom du groupe -->
            <div class="mb-3">
                <label for="NomGrp" class="form-label">Nom du groupe :</label>
                <input type="text" class="form-control" name="NomGrp" id="NomGrp" value="{$data.NomGrp|escape|default:''}" placeholder="TheGroupe">
                <p>{$messages.Nom|escape|default:''}</p>
            </div>

            <!-- Département d'origine -->
            <div class="mb-3">
                <label for="" class="form-label">Département d'origine</label>
                <input type="email" class="form-control" name="Email" id="Email" value="{$data.Email|escape|default:''}" placeholder="nom@domaine.fr">
                <select name="" id="">
                    <option value="">Choisissez votre département</option>
                    {foreach}
                        <option value=""></option>
                    {/foreach}
                </select>
                <p>{$messages.Email|escape|default:''}</p>
            </div>

            <!-- Type de scène -->
            <div class="mb-3">
                <label for="Motdepasse" class="form-label">MotDepasse</label>
                <input type="password" class="form-control" name="Motdepasse" id="Motdepasse" value="{$data.Motdepasse|escape|default:''}" placeholder="M0nM0ts2Pass1">
                <p>{$messages.Motdepasse|escape|default:''}</p>
            </div>

            <!-- Envoyer -->
            <div class="col-auto">
                <button type="submit" class="btn btn-primary mb-3">Envoyer</button>
            </div>
        </form>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>