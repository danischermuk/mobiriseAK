<?php

require_once('../../admin/Connections/drihm.php');

$requestMethod = $_SERVER['REQUEST_METHOD'];
// retrieve the inbound parameters based on request type.
switch ($requestMethod) {

    case 'GET':
        if (isset($_GET['function'])) {
            $function = $_GET['function'];
            switch ($function) {
                case 'products':
                    mysqli_select_db($drihm, $database_drihm);
                    mysqli_set_charset($drihm, 'utf8');
                    $query = "SELECT producto.id AS id, producto.descripcion AS name, producto.marca AS brand, producto.sintacc AS sinTacc, producto.barcode AS barcode, producto.rubroId AS idCat, rubro.nombre AS Cat, CONCAT(codigo.codigo ,' ', lecheparve.nombre) as cod, producto.imagen 
                                FROM producto
                                JOIN rubro ON rubro.id = producto.rubroId
                                JOIN codigo ON codigo.id = producto.nivelId
                                JOIN lecheparve ON lecheparve.id = producto.lecheparveId
                                WHERE producto.publicar = 'Si' ";
                    $result = mysqli_query($drihm, $query) or die(mysqli_error($drihm));
                    $loginFoundUser = mysqli_num_rows($result);
                    mysqli_close($drihm);
                    $myArray = array();
                    while ($row = mysqli_fetch_assoc($result)) {
                        $myArray[] = $row;
                    }
                    echo '{"products":';
                    echo json_encode($myArray);
                    echo '}';
                    break;


                case 'categories':
                    mysqli_select_db($drihm, $database_drihm);
                    mysqli_set_charset($drihm, 'utf8');
                    $query = "SELECT rubro.id AS id, rubro.nombre AS name, rubro.descripcion AS descripcion
                                FROM rubro";
                    $result = mysqli_query($drihm, $query) or die(mysqli_error($drihm));
                    $loginFoundUser = mysqli_num_rows($result);
                    mysqli_close($drihm);
                    $myArray = array();
                    while ($row = mysqli_fetch_assoc($result)) {
                        $myArray[] = $row;
                    }
                    echo '{"categories":';
                    echo json_encode($myArray);
                    echo '}';
                    break;

                case 'lastUpdate':
                    mysqli_select_db($drihm, $database_drihm);
                    mysqli_set_charset($drihm, 'utf8');
                    $query = "SELECT MAX(fechaUltimaModificacion) as lastUpdate
                                FROM producto";
                    $result = mysqli_query($drihm, $query) or die(mysqli_error($drihm));
                    $loginFoundUser = mysqli_num_rows($result);
                    mysqli_close($drihm);
                    echo json_encode(mysqli_fetch_assoc($result));

                    break;

                case 'lastUpdateUnix':
                    mysqli_select_db($drihm, $database_drihm);
                    mysqli_set_charset($drihm, 'utf8');
                    $query = "SELECT MAX(fechaUltimaModificacion) as lastUpdate
                                FROM producto";
                    $result = mysqli_query($drihm, $query) or die(mysqli_error($drihm));
                    $loginFoundUser = mysqli_num_rows($result);
                    mysqli_close($drihm);
                    $lastUpdate = mysqli_fetch_assoc($result);
                    $newDate = date(strtotime($lastUpdate['lastUpdate']));
                    echo "{\"lastUpdate\":\"" .$newDate. "\"}";
                    // echo json_encode(mysqli_fetch_assoc($result));

                    break;

                case 'lastNews':
                    mysqli_select_db($drihm, $database_drihm);
                    mysqli_set_charset($drihm, 'utf8');
                    $query = "SELECT alertas.id AS id, alertas.nombre AS title, alertas.descripcion as introtext, alertas.fechaUltimaModificacion as publish_up
                                FROM alertas
                                WHERE alertas.mostrar = 's'";
                    $result = mysqli_query($drihm, $query) or die(mysqli_error($drihm));
                    $loginFoundUser = mysqli_num_rows($result);
                    mysqli_close($drihm);
                    $myArray = array();
                    while ($row = mysqli_fetch_assoc($result)) {
                        $myArray[] = $row;
                    }
                    echo '{"lastNews":';
                    echo json_encode($myArray);
                    echo '}';
                    break;

                default:
                    $returnArray = array('error' => 'Invalid function selected.');
                    $jsonEncodedReturnArray = json_encode($returnArray, JSON_PRETTY_PRINT);
                    echo $jsonEncodedReturnArray;
                    break;
            }
        } else {
            $returnArray = array('error' => 'No function selected.');
            $jsonEncodedReturnArray = json_encode($returnArray, JSON_PRETTY_PRINT);
            echo $jsonEncodedReturnArray;
        }
        break;

    default:
        $returnArray = array('error' => 'You have requested an invalid method.');
        $jsonEncodedReturnArray = json_encode($returnArray, JSON_PRETTY_PRINT);
        echo $jsonEncodedReturnArray;
}
