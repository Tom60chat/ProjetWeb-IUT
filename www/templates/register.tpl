<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Register</title>
</head>
<body>
    <form action="./register" method="post">
        <label>
            Nom<br>
            <input type="text" name="Nom" value="{$data.Nom|escape|default:''}" placeholder="Nom"><br>
            {if !empty($messages.Nom)}
            {$messages.Nom}<br>
            {/if}
        </label>
        <label>
            Email<br>
            <input type="email" name="Email" value="{$data.Email|escape|default:''}" placeholder="Adresse valide"><br>
            {if !empty($messages.Email)}
                {$messages.Email}<br>
            {/if}
        </label>
        <label>
            MotDepasse<br>
            <input type="password" name="Motdepasse" value="{$data.Motdepasse|escape|default:''}" placeholder="MotDePasse"><br>
            {if !empty($messages.Motdepasse)}
                {$messages.Motdepasse}<br>
            {/if}
        </label>
        <input type="submit" value="Sign in"><br>
    </form>
</body>
</html>