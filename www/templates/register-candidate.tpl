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
                <p>{$messages.NomGrp|escape|default:''}</p>
            </div>

            <!-- Département d'origine -->
            <div class="mb-3">
                <label for="Departement" class="form-label">Département d'origine :</label>
                <select name="Departement" id="Departement">
                    <option value="">Choisissez votre département</option>
                    {foreach from=$listeDep item=$dep}
                        <option value="{$dep[0]}">{$dep[1]}</option>
                    {/foreach}
                </select>
                <p>{$messages.Departement|escape|default:''}</p>
            </div>

            <!-- Type de scène -->
            <div class="mb-3">
                <label for="Scene" class="form-label">Type de scène :</label>
                <select name="Scene" id="Scene">
                    <option value="">Choisissez votre scène</option>
                    {foreach from=$listeScene item=$dep}
                        <option value="{$dep[0]}" {if $data.Scene eq $dep[0]}selected{/if}}>{$dep[1]}</option>
                    {/foreach}
                </select>
                <p>{$messages.Scene|escape|default:''}</p>
            </div>

            <!-- Représentant du groupe !!!! -->
            <div class="mb-3">
                <label for="Motdepasse" class="form-label">Représentant du groupe :</label>
                <input type="password" class="form-control" name="Motdepasse" id="Motdepasse" value="{$data.Motdepasse|escape|default:''}" placeholder="M0nM0ts2Pass1">
                <p>{$messages.Motdepasse|escape|default:''}</p>
            </div>

            <!-- Style musical !!!! -->
            <div class="mb-3">
                <label for="Motdepasse" class="form-label">Style musical :</label>
                <input type="password" class="form-control" name="Motdepasse" id="Motdepasse" value="{$data.Motdepasse|escape|default:''}" placeholder="M0nM0ts2Pass1">
                <p>{$messages.Motdepasse|escape|default:''}</p>
            </div>

            <!-- Année de création -->
            <div class="mb-3">
                <label for="AnneeCreation" class="form-label">Année de création ;</label>
                <input type="number" min="1900" max="2099" step="1" value="2016" class="form-control"  name="AnneeCreation" id="AnneeCreation" value="{$data.AnneeCreation|escape|default:''}" />
                <p>{$messages.AnneeCreation|escape|default:''}</p>
            </div>

            <!-- Présentation du texte -->
            <div class="mb-3">
                <label for="Presentation" class="form-label">Présentation du texte :</label>
                <input type="text" maxlength="500" class="form-control" name="Presentation" id="Presentation" value="{$data.Presentation|escape|default:''}" placeholder="Nous somme le groupe...">
                <p>{$messages.Presentation|escape|default:''}</p>
            </div>

            <!-- Expériences scéniques -->
            <div class="mb-3">
                <label for="Exeriences" class="form-label">Expériences scéniques :</label>
                <input type="text" maxlength="500" class="form-control" name="Exeriences" id="Exeriences" value="{$data.Exeriences|escape|default:''}" placeholder="Nous avons fait...">
                <p>{$messages.Exeriences|escape|default:''}</p>
            </div>

            <!-- Site web ou réseau social -->
            <div class="mb-3">
                <label for="URL" class="form-label">MotDepasse</label>
                <input type="url" class="form-control" name="URL" id="URL" value="{$data.URL|escape|default:''}" placeholder="https://thegroupe.com">
                <p>{$messages.URL|escape|default:''}</p>
            </div>

            <!-- Adresse page soundcloud -->
            <div class="mb-3">
                <label for="SoundCloud" class="form-label">SoundCloud (facultatif) :</label>
                <input type="url" class="form-control" name="SoundCloud" id="SoundCloud" value="{$data.SoundCloud|escape|default:''}" placeholder="https://soundcloud.com/thegroupe">
                <p>{$messages.SoundCloud|escape|default:''}</p>
            </div>

            <!-- Adresse page youtube -->
            <div class="mb-3">
                <label for="YouTube" class="form-label">YouTube (facultatif) :</label>
                <input type="url" class="form-control" name="YouTube" id="YouTube" value="{$data.YouTube|escape|default:''}" placeholder="https://www.youtube.com/c/thegroupe">
                <p>{$messages.YouTube|escape|default:''}</p>
            </div>

            <!-- Membres du groupe !!! -->
            <div class="mb-3">
                <label for="Motdepasse" class="form-label">Membres du groupe :</label>
                <input type="password" class="form-control" name="Motdepasse" id="Motdepasse" value="{$data.Motdepasse|escape|default:''}" placeholder="M0nM0ts2Pass1">
                <p>{$messages.Motdepasse|escape|default:''}</p>
            </div>

            <!-- Status associatif -->
            <div class="mb-3">
                <label for="Associatif" class="form-check-input">Status associatif :</label>
                <input class="form-check-input" type="checkbox" role="switch" name="Associatif" id="Associatif" {if $data.Associatif eq True}checked{/if}>
            </div>

            <!-- Inscrit à la SACEM -->
            <div class="mb-3">
                <label for="SACEM" class="form-check-input">Inscrit à la SACEM :</label>
                <input class="form-check-input" type="checkbox" role="switch" name="SACEM" id="SACEM" {if $data.SACEM eq True}checked{/if}>
            </div>

            <!-- Producteur -->
            <div class="mb-3">
                <label for="SACEM" class="form-check-input">Producteur :</label>
                <input class="form-check-input" type="checkbox" role="switch" name="SACEM" id="SACEM" {if $data.SACEM eq True}checked{/if}>
            </div>

            <!-- Dossier de presse -->
            <div class="mb-3">
                <label for="Motdepasse" class="form-label">Dossier de presse (facultatif) :</label>
                <input type="file" class="form-control" name="DossierPresse" id="DossierPresse">
            </div>

            <!-- Photos de groupe -->
            <div class="mb-3">
                <label class="form-label">Photos de groupe :</label>

                <input type="file" class="form-control" name="PhotoGrp1" id="PhotoGrp1">
                <label class="input-group-text" for="PhotoGrp1">Photo 1</label>
                <input type="file" class="form-control" name="PhotoGrp2" id="PhotoGrp2">
                <label class="input-group-text" for="PhotoGrp2">Photo 2</label>
                <p>{$messages.PhotoGrp|escape|default:''}</p>
            </div>

            <!-- Fiche technique -->
            <div class="mb-3">
                <label for="Motdepasse" class="form-label">Fiche technique :</label>
                <input type="password" class="form-control" name="FicheTechnique" id="FicheTechnique" value="{$data.FicheTechnique|escape|default:''}">
                <p>{$messages.FicheTechnique|escape|default:''}</p>
            </div>

            <!-- Document SACEM -->
            <div class="mb-3">
                <label for="Motdepasse" class="form-label">Document SACEM :</label>
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