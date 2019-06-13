<?php 

require_once('../Connections/drihm.php'); 

            $requestMethod = $_SERVER['REQUEST_METHOD'];
            // retrieve the inbound parameters based on request type.
            switch($requestMethod) {
                
                case 'GET':
                    if (isset($_GET['id'])) {$id = $_GET['id'];}
                    $namequery = "";
                    if (isset($_GET['name'])) {
                        $name = $_GET['name'];
                        $namequery = "WHERE textos.nombre = \"" .$name. "\"";
                    }
                    mysqli_select_db( $drihm,$database_drihm);
                    mysqli_set_charset($drihm, 'utf8');
                    $query = "SELECT textos.id, textos.descripcion, textos.nombre, textos.fechaUltimaModificacion FROM textos " .$namequery. " ORDER BY textos.nombre DESC" ;
                    $result = mysqli_query($drihm, $query) or die(mysqli_error($drihm));
                    $loginFoundUser = mysqli_num_rows($result);
                    mysqli_close($drihm);
                    $myArray = array();
                    while($row = mysqli_fetch_assoc($result)) {
                        $myArray[] = $row;
                    }
                    echo json_encode($myArray);

                break;

            default:
                $returnArray = array('error' => 'You have requested an invalid method.');
                $jsonEncodedReturnArray = json_encode($returnArray, JSON_PRETTY_PRINT);
                echo $jsonEncodedReturnArray;
            }

?>