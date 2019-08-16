<?php 

require_once('../../admin/Connections/drihm.php'); 

            $requestMethod = $_SERVER['REQUEST_METHOD'];
            // retrieve the inbound parameters based on request type.
            switch($requestMethod) {
                
                case 'GET':
                    if (isset($_GET['function'])) {
                        $function = $_GET['function'];
                        switch ($function) {
                            case 'products':
                                mysqli_select_db( $drihm,$database_drihm);
                                mysqli_set_charset($drihm, 'utf8');
                                $query = "SELECT producto.id AS id, producto.descripcion AS name, producto.marca AS brand, producto.rubroId AS idCat, rubro.nombre AS cat, CONCAT(codigo.codigo ,' ', lecheparve.nombre) as cod
                                FROM producto
                                JOIN rubro ON rubro.id = producto.rubroId
                                JOIN codigo ON codigo.id = producto.nivelId
                                JOIN lecheparve ON lecheparve.id = producto.lecheparveId";
                                $result = mysqli_query($drihm, $query) or die(mysqli_error($drihm));
                                $loginFoundUser = mysqli_num_rows($result);
                                mysqli_close($drihm);
                                $myArray = array();
                                while($row = mysqli_fetch_assoc($result)) {
                                    $myArray[] = $row;
                                }
                                echo '{"products":';
                                echo json_encode($myArray);
                                echo '}';
                            break;

                            default:
                                $returnArray = array('error' => 'Invalid function selected.');
                                $jsonEncodedReturnArray = json_encode($returnArray, JSON_PRETTY_PRINT);
                                echo $jsonEncodedReturnArray;
                            break;
                        }     
                    }
                    else {
                        $returnArray = array('error' => 'No function selected.');
                        $jsonEncodedReturnArray = json_encode($returnArray, JSON_PRETTY_PRINT);
                        echo $jsonEncodedReturnArray;
                    }
                    

                break;

                case 'POST':
                // Hacer el post del contacto
                break;

            default:
                $returnArray = array('error' => 'You have requested an invalid method.');
                $jsonEncodedReturnArray = json_encode($returnArray, JSON_PRETTY_PRINT);
                echo $jsonEncodedReturnArray;
            }
