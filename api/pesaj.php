<?php

require_once('../admin/Connections/drihm.php'); 

$requestMethod = $_SERVER['REQUEST_METHOD'];
// retrieve the inbound parameters based on request type.
switch ($requestMethod) {

    case 'GET':
        if (isset($_GET['id'])) {
            $id = $_GET['id'];
        }

        mysqli_select_db($drihm, $database_drihm);
        mysqli_set_charset($drihm, 'utf8');
        $query = "SELECT pesaj.id, pesaj.intro, pesaj.nombre, pesaj.fechaUltimaModificacion, pesaj.ListaProductos, pesaj.Halajot, pesaj.Hejsher, pesaj.mostrar FROM pesaj ORDER BY pesaj.nombre DESC";
        $result = mysqli_query($drihm, $query) or die(mysqli_error($drihm));
        $loginFoundUser = mysqli_num_rows($result);
        mysqli_close($drihm);
        $myArray = array();
        while ($row = mysqli_fetch_assoc($result)) {
            $myArray[] = $row;
        }
        echo json_encode($myArray);

        break;

    default:
        $returnArray = array('error' => 'You have requested an invalid method.');
        $jsonEncodedReturnArray = json_encode($returnArray, JSON_PRETTY_PRINT);
        echo $jsonEncodedReturnArray;
}
