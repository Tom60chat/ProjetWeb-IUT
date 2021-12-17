<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Register</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="../includes/default.css">
</head>
<body>
    <div class="container">
        <h2 class="mb-3">Enregistrement candidat</h2>

        <form class="mb-3 row" action="./register-candidate" method="post">

            <!-- Nom du groupe -->
            <div class="mb-3">
                <label for="NomGrp" class="form-label">Nom du groupe :</label>
                <input name="NomGrp" id="NomGrp" class="form-control"
                       type="text" value="{$data.NomGrp|escape|default:''}" placeholder="TheGroup">
                <p>{$messages.NomGrp|escape|default:''}</p>
            </div>

            <!-- Département d'origine ! -->
            <div class="mb-3">
                <label for="Departement" class="form-label">Département d'origine :</label>
                <select name="Departement" id="Departement" class="form-select">
                    <option value="">Choisissez votre département</option>
                    {foreach from=$listeDep item=$dep}
                        <option value="{$dep[0]}" {if $data.Departement|escape|default:0 eq $dep[0]}selected{/if}}>{$dep[1]}</option>
                    {/foreach}
                </select>
                <p>{$messages.Departement|escape|default:''}</p>
            </div>

            <!-- Type de scène -->
            <div class="mb-3">
                <label for="Scene" class="form-label">Type de scène :</label>
                <input name="Scene" id="Scene" class="form-control"
                       type="text" value="{$data.Scene|escape|default:''}" placeholder="Rock, Punk, Indie Rock, etc">
                <p>{$messages.Scene|escape|default:''}</p>
            </div>

            <div class="mb-3 divider"></div>

            <!-- Représentant du groupe -->
            <div class="mb-3">
                <label class="form-label">Représentant du groupe :</label>

                <div class="row g-3">
                    <div class="col-md-6">
                        <label for="rprsGrp_Nom" class="form-label">Nom</label>
                        <input name="rprsGrp_Nom" id="rprsGrp_Nom" class="form-control"
                               type="text" placeholder="John" value="{$data.rprsGrp_Nom|escape|default:''}" >
                        <p>{$messages.rprsGrp_Nom|escape|default:''}</p>
                    </div>
                    <div class="col-md-6">
                        <label for="rprsGrp_Prenom" class="form-label">Prénom</label>
                        <input name="rprsGrp_Prenom" id="rprsGrp_Prenom" class="form-control"
                               type="text" placeholder="Smit" value="{$data.rprsGrp_Prenom|escape|default:''}">
                        <p>{$messages.rprsGrp_Prenom|escape|default:''}</p>
                    </div>
                    <div class="col-md-9">
                        <label for="rprsGrp_Address" class="form-label">Address</label>
                        <input name="rprsGrp_Address" id="rprsGrp_Address" class="form-control"
                               type="text" placeholder="1234 Main St" value="{$data.rprsGrp_Address|escape|default:''}">
                        <p>{$messages.rprsGrp_Address|escape|default:''}</p>
                    </div>
                    <div class="col-md-3">
                        <label for="rprsGrp_CodPost" class="form-label">Code postal</label>
                        <input name="rprsGrp_CodPost" id="rprsGrp_CodPost" class="form-control"
                               type="number" min="01000" max="99000" step="1" placeholder="XXXXX" value="{$data.rprsGrp_CodPost|escape|default:''}">
                        <p>{$messages.rprsGrp_CodPost|escape|default:''}</p>
                    </div>
                    <div class="col-md-6">
                        <label for="rprsGrp_Email" class="form-label">Email</label>
                        <input name="rprsGrp_Email" id="rprsGrp_Email" class="form-control"
                               type="email" placeholder="nom@domaine.fr" value="{$data.rprsGrp_Email|escape|default:''}">
                        <p>{$messages.rprsGrp_Email|escape|default:''}</p>
                    </div>
                    <div class="col-md-6"">
                        <label for="rprsGrp_Tel" class="form-label">Téléphone</label>
                        <input name="rprsGrp_Tel" id="rprsGrp_Tel" class="form-control"
                               type="number" placeholder="0XXXXXXXXX" value="{$data.rprsGrp_Tel|escape|default:''}">
                    <p>{$messages.rprsGrp_Tel|escape|default:''}</p>
                    </div>
                </div>
            </div>

            <div class="mb-3 divider"></div>

            <!-- Style musical ! -->
            <div class="mb-3">
                <label for="Style" class="form-label">Style musical :</label>
                <select name="Style" id="Style" class="form-select">
                    <option value="">Choisissez votre style</option>
                    {foreach from=$listeStyle item=$style}
                        <option value="{$style[0]}">{$style[1]}</option>
                    {/foreach}
                </select>
                <p>{$messages.Style|escape|default:''}</p>
            </div>

            <!-- Année de création -->
            <div class="mb-3">
                <label for="AnneeCreation" class="form-label">Année de création :</label>
                <input name="AnneeCreation" id="AnneeCreation" class="form-control"
                       type="number" min="1900" max="2099" step="1" placeholder="2016" value="{$data.AnneeCreation|escape|default:''}" />
                <p>{$messages.AnneeCreation|escape|default:''}</p>
            </div>

            <div class="mb-3 divider"></div>

            <!-- Présentation du texte -->
            <div class="mb-3">
                <label for="Presentation" class="form-label">Présentation du texte (500 caractères maximum) :</label>
                <textarea name="Presentation" id="Presentation" class="form-control"
                          rows="3" maxlength="500" placeholder="Nous somme le groupe..."
                >{$data.Presentation|escape|default:''}</textarea>
                <p>{$messages.Presentation|escape|default:''}</p>
            </div>

            <!-- Expériences scéniques -->
            <div class="mb-3">
                <label for="Exeriences" class="form-label">Expériences scéniques (500 caractères maximum) :</label>
                <textarea name="Exeriences" id="Exeriences" class="form-control"
                          rows="3" maxlength="500" placeholder="Nous avons fait..."
                >{$data.Exeriences|escape|default:''}</textarea>
                <p>{$messages.Exeriences|escape|default:''}</p>
            </div>

            <div class="mb-3 divider"></div>

            <!-- Site web ou réseau social -->
            <div class="mb-3">
                <label for="URL" class="form-label">Site web ou réseau social :</label>
                <input name="URL" id="URL" class="form-control"
                       type="url" value="{$data.URL|escape|default:''}" placeholder="https://thegroup.com">
                <p>{$messages.URL|escape|default:''}</p>
            </div>

            <!-- Adresse page soundcloud -->
            <div class="mb-3">
                <label for="SoundCloud" class="form-label">SoundCloud (facultatif) :</label>
                <input name="SoundCloud" id="SoundCloud" class="form-control"
                       type="url" value="{$data.SoundCloud|escape|default:''}" placeholder="https://soundcloud.com/thegroup">
                <p>{$messages.SoundCloud|escape|default:''}</p>
            </div>

            <!-- Adresse page youtube -->
            <div class="mb-3">
                <label for="YouTube" class="form-label">YouTube (facultatif) :</label>
                <input name="YouTube" id="YouTube" class="form-control"
                       type="url" value="{$data.YouTube|escape|default:''}" placeholder="https://www.youtube.com/c/thegroup">
                <p>{$messages.YouTube|escape|default:''}</p>
            </div>

            <div class="mb-3 divider"></div>

            <!-- Membres du groupe -->
            <div class="mb-3">
                <label for="Membre1_Nom" class="form-label">Membres du groupe (jusqu'à 8 membre) :</label><br>

                <div class="row mb-2" style="text-align: center;">
                    <div class="col-sm-1"></div>
                    <div class="col">Nom</div>
                    <div class="col">Prénom</div>
                    <div class="col">Instrument</div>
                </div>

                <div class="row mb-3">
                    <label for="Membre1_Nom" class="col-sm-1 col-form-label">1 : </label>
                    <div class="col">
                        <input name="Membre1_Nom" id="Membre1_Nom" class="form-control"
                               type="text" placeholder="Nom" value="{$data.Membre1_Nom|escape|default:''}">
                    </div>
                    <div class="col">
                        <input name="Membre1_Prenom" class="form-control"
                               type="text" placeholder="Prenom" value="{$data.Membre1_Prenom|escape|default:''}">
                    </div>
                    <div class="col">
                        <input name="Membre1_Instrument" class="form-control"
                               type="text" placeholder="Instrument" value="{$data.Membre1_Instrument|escape|default:''}">
                    </div>
                </div>

                <div class="row mb-3">
                    <label for="Membre2_Nom" class="col-sm-1 col-form-label">2 : </label>
                    <div class="col">
                        <input name="Membre2_Nom" id="Membre2_Nom" class="form-control"
                               type="text" placeholder="Nom" value="{$data.Membre2_Nom|escape|default:''}">
                    </div>
                    <div class="col">
                        <input name="Membre2_Prenom" class="form-control"
                               type="text" placeholder="Prenom" value="{$data.Membre2_Prenom|escape|default:''}">
                    </div>
                    <div class="col">
                        <input name="Membre2_Instrument" class="form-control"
                               type="text" placeholder="Instrument" value="{$data.Membre2_Instrument|escape|default:''}">
                    </div>
                </div>

                <div class="row mb-3">
                    <label for="Membre3_Nom" class="col-sm-1 col-form-label">3 : </label>
                    <div class="col">
                        <input name="Membre3_Nom" id="Membre3_Nom" class="form-control"
                               type="text" placeholder="Nom" value="{$data.Membre3_Nom|escape|default:''}">
                    </div>
                    <div class="col">
                        <input name="Membre3_Prenom" class="form-control"
                               type="text" placeholder="Prenom" value="{$data.Membre3_Prenom|escape|default:''}">
                    </div>
                    <div class="col">
                        <input name="Membre3_Instrument" class="form-control"
                               type="text"placeholder="Instrument" value="{$data.Membre3_Instrument|escape|default:''}">
                    </div>
                </div>

                <div class="row mb-3">
                    <label for="Membre4_Nom" class="col-sm-1 col-form-label">4 : </label>
                    <div class="col">
                        <input name="Membre4_Nom" id="Membre4_Nom" class="form-control"
                               type="text" placeholder="Nom" value="{$data.Membre4_Nom|escape|default:''}">
                    </div>
                    <div class="col">
                        <input name="Membre4_Prenom" class="form-control"
                               type="text" placeholder="Prenom" value="{$data.Membre4_Prenom|escape|default:''}">
                    </div>
                    <div class="col">
                        <input name="Membre4_Instrument" class="form-control"
                               type="text" placeholder="Instrument" value="{$data.Membre4_Instrument|escape|default:''}">
                    </div>
                </div>

                <div class="row mb-3">
                    <label for="Membre5_Nom" class="col-sm-1 col-form-label">5 : </label>
                    <div class="col">
                        <input name="Membre5_Nom" id="Membre5_Nom" class="form-control"
                               type="text" placeholder="Nom" value="{$data.Membre5_Nom|escape|default:''}">
                    </div>
                    <div class="col">
                        <input name="Membre5_Prenom" class="form-control"
                               type="text" placeholder="Prenom" value="{$data.Membre5_Prenom|escape|default:''}">
                    </div>
                    <div class="col">
                        <input name="Membre5_Instrument" class="form-control"
                               type="text" placeholder="Instrument" value="{$data.Membre5_Instrument|escape|default:''}">
                    </div>
                </div>

                <div class="row mb-3">
                    <label for="Membre6_Nom" class="col-sm-1 col-form-label">6 : </label>
                    <div class="col">
                        <input name="Membre6_Nom" id="Membre6_Nom" class="form-control"
                               type="text" placeholder="Nom" value="{$data.Membre6_Nom|escape|default:''}">
                    </div>
                    <div class="col">
                        <input name="Membre6_Prenom" class="form-control"
                               type="text" placeholder="Prenom" value="{$data.Membre6_Prenom|escape|default:''}">
                    </div>
                    <div class="col">
                        <input name="Membre6_Instrument" class="form-control"
                               type="text" placeholder="Instrument" value="{$data.Membre6_Instrument|escape|default:''}">
                    </div>
                </div>

                <div class="row mb-3">
                    <label for="Membre7_Nom" class="col-sm-1 col-form-label">7 : </label>
                    <div class="col">
                        <input name="Membre7_Nom" id="Membre7_Nom" class="form-control"
                               type="text" placeholder="Nom" value="{$data.Membre7_Nom|escape|default:''}">
                    </div>
                    <div class="col">
                        <input name="Membre7_Prenom" class="form-control"
                               type="text" placeholder="Prenom" value="{$data.Membre7_Prenom|escape|default:''}">
                    </div>
                    <div class="col">
                        <input name="Membre7_Instrument" class="form-control"
                               type="text" placeholder="Instrument" value="{$data.Membre7_Instrument|escape|default:''}">
                    </div>
                </div>

                <div class="row mb-3">
                    <label for="Membre8_Nom" class="col-sm-1 col-form-label">8 : </label>
                    <div class="col">
                        <input name="Membre8_Nom" id="Membre8_Nom" class="form-control"
                               type="text" placeholder="Nom" value="{$data.Membre8_Nom|escape|default:''}">
                    </div>
                    <div class="col">
                        <input name="Membre8_Prenom" class="form-control"
                               type="text" placeholder="Prenom" value="{$data.Membre8_Prenom|escape|default:''}">
                    </div>
                    <div class="col">
                        <input name="Membre8_Instrument" class="form-control"
                               type="text" placeholder="Instrument" value="{$data.Membre8_Instrument|escape|default:''}">
                    </div>
                </div>

                <p>{$messages.Membre|escape|default:''}</p>
            </div>

            <div class="mb-3 divider"></div>

            <!-- Status associatif -->
            <div class="mb-3">
                <label for="Associatif" class="form-check-label" >Status associatif :</label>
                <input name="Associatif" id="Associatif" class="form-check-input"
                       type="checkbox" {if $data.Associatif|escape|default:False eq True}checked{/if}>
            </div>

            <!-- Inscrit à la SACEM -->
            <div class="mb-3">
                <label for="SACEM" class="form-check-label">Inscrit à la SACEM :</label>
                <input name="SACEM" id="SACEM" class="form-check-input"
                       type="checkbox" {if $data.SACEM|escape|default:False eq True}checked{/if}>
            </div>

            <!-- Producteur -->
            <div class="mb-3">
                <label for="Producteur" class="form-check-label">Producteur :</label>
                <input name="Producteur" id="Producteur" class="form-check-input"
                       type="checkbox" {if $data.Producteur|escape|default:False eq True}checked{/if}>
            </div>

            <div class="mb-3 divider"></div>

            <!-- MP3 -->
            <div class="mb-3">
                <label for="Musiques" class="form-label">Exemples de musique (3 fichiers au format MP3) :</label>
                <input name="Musiques" id="Musiques" class="form-control"
                       type="file" accept=".mp3" multiple>
                <p>{$messages.Musiques|escape|default:''}</p>
            </div>

            <!-- Dossier de presse -->
            <div class="mb-3">
                <label for="DossierPresse" class="form-label">Dossier de presse (en format PDF, facultatif) :</label>
                <input name="DossierPresse" id="DossierPresse" class="form-control"
                       type="file" accept=".pdf">
                <p>{$messages.DossierPresse|escape|default:''}</p>
            </div>

            <!-- Photos de groupe -->
            <div class="mb-3">
                <label for="PhotoGrp" class="form-label">Photos de groupe (2 photos avec résolution > 300 dpi) :</label>
                <input name="PhotoGrp" id="PhotoGrp" class="form-control"
                       type="file" accept="image/*" multiple>
                <p>{$messages.PhotoGrp|escape|default:''}</p>
            </div>

            <!-- Fiche technique -->
            <div class="mb-3">
                <label for="FicheTechnique" class="form-label">Fiche technique (en format PDF) :</label>
                <input name="FicheTechnique" id="FicheTechnique" class="form-control"
                       type="file" accept=".pdf">
                <p>{$messages.FicheTechnique|escape|default:''}</p>
            </div>

            <!-- Document SACEM -->
            <div class="mb-3">
                <label for="DocSacemSetlist" class="form-label">Document SACEM ou Setlist (en format PDF) :</label>
                <input name="DocSacemSetlist" id="DocSacemSetlist" class="form-control"
                       type="file" accept=".pdf">
                <p>{$messages.DocSACEM|escape|default:''}</p>
            </div>

            <!-- Envoyer -->
            <div class="col-auto">
                <button type="submit" class="btn btn-primary mb-3">Envoyer</button>
            </div>
        </form>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
            Sntegrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>