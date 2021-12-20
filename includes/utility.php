<!--
    Classe utilitaire de Tom OLIVIER
    Car j'aime quand le code est propre (ça fait moins mal au yeux)
    -->

<?php
class Utility
{
    private $data;
    public $messages;
    public static $uploadsPath = '../uploads/';

    /**
     * The constructor of the Utility class
     *
     * @param $data
     *  List of post data
     */
    function __construct(&$data) {
        $this->data = $data;
        $this->messages = array();
    }

    public static function isArrayEmpty($var) {
        if (is_array($var))
        {
            foreach ($var as $subVar)
                if (!Utility::isArrayEmpty($subVar))
                    return false;
            return true;
        }
        else
            return empty($var);
    }

    /**
     * Check if the string is empty
     *
     * @param $name
     *  The name of the element.
     * @param $message
     *  Error message to print on failure
     * @return bool
     *  Return true if the value is not empty, else return false
     */
    function isEmpty($name, $message) {
        if (empty(trim($this->data[$name]))) {
            if (!empty($message))
                $this->messages[$name] = $message;
            return true;
        } else
            return false;
    }

    /**
     * Check if the file exist
     *
     * @param $name
     *  The name of the element.
     * @param $message
     *  Error message to print on failure
     * @return bool
     *  Return true if the file exist, else return false
     */
    function isFileExist($name, $message) {
        if (Utility::isArrayEmpty($_FILES[$name]['name'])) {
            if (!empty($message))
                $this->messages[$name] = $message;
            return false;
        } else
            return true;
    }

    /**
     * Check if the string is valid
     *
     * @param $name
     *  The name of the element.
     * @param $displayName
     *  The display name of the element.
     * @param $filer
     *  Filter used to validate
     * @return bool
     *  Return false if the value has not been validated by the filter, else return true
     */
    function isValid($name, $displayName, $filer) {
        if (filter_var($this->data[$name], $filer) === false) {
            $this->messages[$name] = "$displayName est invalide.";
            return false;
        } else
            return true;
    }

    /**
     * Check if the string are too big
     *
     * @param $name
     *  The name of the element.
     * @param $displayName
     *  The display name of the element.
     * @param $length
     *  The length to check
     * @return bool
     *  Return true if the string length is bigger thant the given length, else return false
     */
    function isBig($name, $displayName, $length)
    {
        if (strlen($this->data[$name]) > $length) {
            $this->messages[$name] = "$displayName dépasse la taille autorisée de $length caractères.";
            return true;
        } else
            return false;
    }

    /**
     * Count the number of empty string
     *
     * @return int
     *  Return the number of empty string
     */
    function isComplete() {
        $count = 0;
        $args = func_get_args();

        foreach ($args as $arg) {
            if (empty(trim($arg)))
                $count++;
        }

        return $count;
    }

    /**
     * @param $name
     *  The name of the elements.
     * @return string
     *  The path of the saved files.
     */
    function saveFiles($name, $folderName) {
        $filesName = $_FILES[$name]['name'];
        $filesTmpName = $_FILES[$name]['tmp_name'];
        $uploadFiles = '';

        if (is_array($filesName)) {
            $count = count($filesName);
            for ($i = 0; $i < $count; $i++) {
                $uploadFile = Utility::saveFile($filesName[$i], $folderName);
                $uploadFiles .= move_uploaded_file($filesTmpName[$i], $uploadFile) ?
                    $uploadFile . ($i == $count - 1 ? '' : ';') :
                    '';
            }
        } else {
            $uploadFile = Utility::saveFile($filesName, $folderName);
            $uploadFiles = move_uploaded_file($filesTmpName, $uploadFile) ? $uploadFile : '';
        }

        if (empty($uploadFiles))
            $this->messages[$name] = "Le téléchargement du fichier à échoué, veuillez recommencer";

        return $uploadFiles;
    }

    private static function saveFile($fileName, $folderName) {
        $uploadDir = Utility::$uploadsPath . $folderName . '/';
        $safeName = Utility::nettoyer_nom_fichier($fileName);

        if (!file_exists($uploadDir))
            mkdir($uploadDir, 0777, true);

        return $uploadDir . basename($safeName);
    }

    public static function nettoyer_nom_fichier($nom)
    {
        $transliterator = Transliterator::createFromRules(
            ':: NFD; :: [:Nonspacing Mark:] Remove; ::NFC;', Transliterator::FORWARD
        );
        $normalized = $transliterator->transliterate($nom);
        return preg_replace("/[^a-zA-Z0-9\.]/", "-", $normalized);
    }

    // https://www.php.net/manual/en/function.com-create-guid.php#99425
    public static function GUID()
    {
        if (function_exists('com_create_guid') === true)
            return trim(com_create_guid(), '{}');

        return sprintf('%04X%04X-%04X-%04X-%04X-%04X%04X%04X', mt_rand(0, 65535), mt_rand(0, 65535), mt_rand(0, 65535), mt_rand(16384, 20479), mt_rand(32768, 49151), mt_rand(0, 65535), mt_rand(0, 65535), mt_rand(0, 65535));
    }

    /**
     * Add a message
     *
     * @param $name
     *  The name of the element.
     * @param $message
     *  The message to add
     */
    function addMessage($name, $message) {
        if (!empty($message))
            $this->messages[$name] = $message;
    }
}