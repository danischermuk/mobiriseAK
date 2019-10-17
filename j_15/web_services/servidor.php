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
                    $query = "SELECT producto.id AS id, producto.descripcion AS name, producto.marca AS brand, producto.sintacc AS sinTacc, producto.barcode AS barcode, producto.rubroId AS idCat, rubro.nombre AS Cat, CONCAT(codigo.codigo ,' ', lecheparve.codigo) as cod, CONCAT(codigo.nombre ,' ', lecheparve.nombre) as codCompleto, producto.imagen 
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
                                FROM rubro ORDER BY rubro.nombre";
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
                    $query = "SELECT MAX(fechaUltimaModificacion) AS lastUpdate FROM ( SELECT fechaUltimaModificacion FROM rubro UNION ALL SELECT fechaUltimaModificacion FROM producto ) foo";
                    $result = mysqli_query($drihm, $query) or die(mysqli_error($drihm));
                    $loginFoundUser = mysqli_num_rows($result);
                    mysqli_close($drihm);
                    echo json_encode(mysqli_fetch_assoc($result));

                    break;

                case 'lastUpdateUnix':
                    mysqli_select_db($drihm, $database_drihm);
                    mysqli_set_charset($drihm, 'utf8');
                    $query = "SELECT MAX(fechaUltimaModificacion) AS lastUpdate FROM ( SELECT fechaUltimaModificacion FROM rubro UNION ALL SELECT fechaUltimaModificacion FROM producto ) foo";
                    $result = mysqli_query($drihm, $query) or die(mysqli_error($drihm));
                    $loginFoundUser = mysqli_num_rows($result);
                    mysqli_close($drihm);
                    $lastUpdate = mysqli_fetch_assoc($result);
                    $newDate = date(strtotime($lastUpdate['lastUpdate']));
                    echo "{\"lastUpdate\":\"" . $newDate . "\"}";
                    // echo json_encode(mysqli_fetch_assoc($result));

                    break;

                case 'lastNews':
                    mysqli_select_db($drihm, $database_drihm);
                    mysqli_set_charset($drihm, 'utf8');
                    $query = "SELECT alertas.id AS id, alertas.nombre AS title, alertas.descripcion as introtext, alertas.fechaUltimaModificacion as publish_up
                                FROM alertas
                                WHERE alertas.mostrar = 's'
                                ORDER BY alertas.fechaUltimaModificacion DESC";
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

                case 'alertasApp':
                    mysqli_select_db($drihm, $database_drihm);
                    mysqli_set_charset($drihm, 'utf8');
                    $query = "SELECT alertasapp.id AS id, alertasapp.nombre AS title, alertasapp.descripcion as introtext, alertasapp.fechaUltimaModificacion as publish_up, alertasapp.guid
                                FROM alertasapp
                                WHERE alertasapp.mostrar = 's' ORDER BY alertasapp.fechaUltimaModificacion DESC LIMIT 1";
                    $result = mysqli_query($drihm, $query) or die(mysqli_error($drihm));
                    $loginFoundUser = mysqli_num_rows($result);
                    mysqli_close($drihm);
                    $myArray = array();
                    while ($row = mysqli_fetch_assoc($result)) {
                        $myArray[] = $row;
                    }
                    echo '{"alertasAPP":';
                    echo json_encode($myArray[0]);
                    echo '}';
                    break;

                case 'texts':

                    echo '{"texts":';
                    echo '{"barcodeNotFound":"No se encontró el código de barras. Aún estamos cargando los productos. Intente la búsqueda manual."}';
                    echo '}';
                    break;

                case 'donate':

                    echo '{"donations":';
                    echo '{
                        "titulo": "Donar dinero a Ajdut Kosher para fortalecer el kashrut abierto",
                        "links": [
                          {
                            "monto": "180",
                            "link": "https://www.mercadopago.com.ar/checkout/v1/redirect?pref_id=263172998-2bd2a292-e7a1-47ca-9578-14c1e499c259"
                          },
                          {
                            "monto": "260",
                            "link": "https://www.mercadopago.com.ar/checkout/v1/redirect?pref_id=263172998-dfc565ff-bab4-4484-a913-d4cecfe3485f"
                          },
                          {
                            "monto": "500",
                            "link": "https://www.mercadopago.com.ar/checkout/v1/redirect?pref_id=263172998-cc1f67a7-72c2-4c38-ba82-d61e0895ea60"
                          },
                          {
                            "monto": "1000",
                            "link": "https://www.mercadopago.com.ar/checkout/v1/redirect?pref_id=263172998-e2c275e3-ca98-4c76-8017-5777b53f45cc"
                          }
                        ]
                      }';
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
