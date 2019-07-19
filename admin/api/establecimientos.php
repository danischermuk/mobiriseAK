<?php 

require_once('../Connections/drihm.php'); 
require_once('../Autho.php');
$token = null;
        $token = "";
        if (isset($_GET['token'])) {$token = $_GET['token']; }
        if (isset($_POST['token'])) {$token = $_POST['token'];}
        
        
        if (Autho::verifyJWT($token)) {
            $requestMethod = $_SERVER['REQUEST_METHOD'];
            // retrieve the inbound parameters based on request type.
            switch($requestMethod) {
                
                case 'GET':
                    mysqli_select_db( $drihm,$database_drihm);
                    mysqli_set_charset($drihm, 'utf8');
                    $query = "SELECT establecimientos.id, establecimientos.nombre, establecimientos.direccion, establecimientos.telefono, establecimientos.certificado, establecimientos.vigente, establecimientos.logo, establecimientos.rubroId, tipoestablecimiento.nombre AS tipoNombre FROM establecimientos JOIN tipoestablecimiento ON establecimientos.rubroId = tipoestablecimiento.id ORDER BY rubroId, establecimientos.nombre";
                    $result = mysqli_query($drihm, $query) or die(mysqli_error($drihm));
                    $loginFoundUser = mysqli_num_rows($result);
                    mysqli_close($drihm);
                    $myArray = array();
                    while($row = mysqli_fetch_assoc($result)) {
                        $myArray[] = $row;
                    }
                    echo json_encode($myArray);

                break;

                case 'POST':
                    // CAMBIAR PARA PRODUCTO

                    if (isset($_POST['id'])) {$id = utf8_decode($_POST['id']);} else echo "falta id";
                    if (isset($_POST['nombre'])) {$nombre = utf8_decode($_POST['nombre']);} else echo "falta nombre";
                    if (isset($_POST['direccion'])) {$direccion = utf8_decode($_POST['direccion']);} else echo "falta direccion";
                    if (isset($_POST['telefono'])) {$telefono = utf8_decode($_POST['telefono']);} else echo "falta telefono";
                    if (isset($_POST['certificado'])) {$certificado = utf8_decode($_POST['certificado']);} else echo "falta certificado";
                    if (isset($_POST['vigente'])) {$vigente = utf8_decode($_POST['vigente']);} else echo "falta vigente";
                    if (isset($_POST['logo'])) {$logo = utf8_decode($_POST['logo']);} else echo "falta logo";
                    if (isset($_POST['rubroId'])) {$rubroId = utf8_decode($_POST['rubroId']);} else echo "falta rubroId";
                    
                                        
                    mysqli_select_db( $drihm,$database_drihm);
                    
                    $query = sprintf("INSERT INTO `establecimientos` (`id`, `nombre`, `direccion`, `telefono`, `certificado`, `vigente`, `logo`, `rubroId`) VALUES( \"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\") 
                    ON DUPLICATE KEY UPDATE  `nombre`= \"%s\", `direccion`= \"%s\", `telefono`= \"%s\", `certificado`= \"%s\", `vigente`= \"%s\", `logo` = \"%s\", `rubroId` = \"%s\"",
                    
                    $id, $nombre, $direccion, $telefono, $certificado, $vigente, $logo, $rubroId, $nombre, $direccion, $telefono, $certificado, $vigente, $logo, $rubroId);

                    $result = mysqli_query($drihm, $query) or die(mysqli_error($drihm));
                    mysqli_close($drihm);
                    echo $result;
                    
                break;
                
                case 'DELETE':
                    if (isset($_GET['id'])) {$id = $_GET['id'];} else return false;
                    mysqli_select_db( $drihm,$database_drihm);
                    
                    $query = sprintf("DELETE FROM `establecimientos` WHERE `id` = \"%s\"",
                    $id);
                    
                    $result = mysqli_query($drihm, $query) or die(mysqli_error($drihm));
                    mysqli_close($drihm);
                    echo $result;
                    
                break;


            default:
                $returnArray = array('error' => 'You have requested an invalid method.');
                $jsonEncodedReturnArray = json_encode($returnArray, JSON_PRETTY_PRINT);
                echo $jsonEncodedReturnArray;
            }
        } 
        else {
            $returnArray = array('error' => 'You are not logged in with a valid token. userId not available');
            echo  json_encode($returnArray, JSON_PRETTY_PRINT);
        }

?>