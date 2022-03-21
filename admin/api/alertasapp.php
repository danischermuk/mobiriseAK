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
                    $activaQuery ="";
                    if (isset($_GET['activa'])) {$activaQuery = " LIMIT 1";}
                    mysqli_select_db( $drihm,$database_drihm);
                    mysqli_set_charset($drihm, 'utf8');
                    $query = "SELECT alertasapp.id, alertasapp.descripcion, alertasapp.nombre, alertasapp.fechaUltimaModificacion, alertasapp.mostrar, alertasapp.guid FROM alertasapp ORDER BY alertasapp.fechaUltimaModificacion DESC" .$activaQuery ;
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

                    if (isset($_POST['id'])) {$id = ($_POST['id']);} else return false;
                    if (isset($_POST['nombre'])) {$nombre = utf8_decode($_POST['nombre']);} else return false;
                    if (isset($_POST['descripcion'])) {$descripcion = utf8_decode($_POST['descripcion']);} else return false;
                    if (isset($_POST['mostrar'])) {$mostrar = ($_POST['mostrar']);} else return false;
                                        
                    mysqli_select_db( $drihm,$database_drihm);
                    
                    $query = sprintf("INSERT INTO `alertasapp` (`id`, `nombre`, `descripcion`, `mostrar`) VALUES( \"%s\", \"%s\", \"%s\", \"%s\") 
                    ON DUPLICATE KEY UPDATE  `nombre`= \"%s\", `descripcion` = \"%s\",`mostrar` = \"%s\"",
                    
                    $id, $nombre, $descripcion, $mostrar, $nombre, $descripcion, $mostrar);

                    $result = mysqli_query($drihm, $query) or die(mysqli_error($drihm));
                    mysqli_close($drihm);
                    echo $result;
                    
                break;
                
                
                case 'DELETE':
                    if (isset($_GET['id'])) {$id = $_GET['id'];} else return false;
                    mysqli_select_db( $drihm,$database_drihm);

                    $query = sprintf("DELETE FROM `alertasapp` WHERE `id` = \"%s\"",
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