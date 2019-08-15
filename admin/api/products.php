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
                    $query = "SELECT producto.id, producto.publicar, producto.sintacc, producto.descripcion, producto.marca, producto.imagen, producto.rubroId, codigo.nombre AS codigoNombre, codigo.id AS codigoId, codigo.codigo AS codigoCodigo , lecheparve.id AS lecheparveId, lecheparve.nombre AS lecheparve, lecheparve.codigo AS lecheparveCodigo, rubro.nombre AS rubro FROM producto JOIN codigo ON producto.nivelId = codigo.id JOIN lecheparve ON producto.lecheparveId = lecheparve.id JOIN rubro ON producto.rubroId = rubro.id ORDER BY rubro, producto.descripcion";
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
                    if (isset($_POST['marca'])) {$marca = utf8_decode($_POST['marca']);} else echo "falta marca";
                    if (isset($_POST['imagen'])) {$imagen = utf8_decode($_POST['imagen']);} else echo "falta imagen";
                    if (isset($_POST['rubroId'])) {$rubroId = utf8_decode($_POST['rubroId']);} else echo "falta rubroId";
                    if (isset($_POST['nivelId'])) {$nivelId = utf8_decode($_POST['nivelId']);} else echo "falta nivelId";
                    if (isset($_POST['lecheparveId'])) {$lecheparveId = utf8_decode($_POST['lecheparveId']);} else echo "falta lecheparveId";
                    if (isset($_POST['descripcion'])) {$descripcion = utf8_decode($_POST['descripcion']);} else echo "falta descripcion";
                    if (isset($_POST['publicar'])) {$publicar = utf8_decode($_POST['publicar']);} else echo "falta publicar";
                    if (isset($_POST['sintacc'])) {$sintacc = utf8_decode($_POST['sintacc']);} else echo "falta sintacc";
                                        
                    mysqli_select_db( $drihm,$database_drihm);
                    
                    $query = sprintf("INSERT INTO `producto` (`id`, `marca`, `imagen`, `rubroId`, `nivelId`, `lecheparveId`, `descripcion`, `publicar`, `sintacc`) VALUES( \"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\") 
                    ON DUPLICATE KEY UPDATE  `marca`= \"%s\", `imagen`= \"%s\", `rubroId`= \"%s\", `nivelId`= \"%s\", `lecheparveId`= \"%s\", `descripcion` = \"%s\", `publicar` = \"%s\", `sintacc` = \"%s\"",
                    
                    $id, $marca, $imagen, $rubroId, $nivelId, $lecheparveId, $descripcion, $publicar, $sintacc, $marca, $imagen, $rubroId, $nivelId, $lecheparveId, $descripcion, $publicar, $sintacc);

                    $result = mysqli_query($drihm, $query) or die(mysqli_error($drihm));
                    mysqli_close($drihm);
                    echo $result;
                    
                break;
                
                
                case 'DELETE':
                    if (isset($_GET['id'])) {$id = $_GET['id'];} else return false;
                    mysqli_select_db( $drihm,$database_drihm);
                    
                    $query = sprintf("DELETE FROM `producto` WHERE `id` = \"%s\"",
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