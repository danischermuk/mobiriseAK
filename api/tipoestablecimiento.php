<?php 

require_once('../admin/Connections/drihm.php'); 
                    mysqli_select_db( $drihm,$database_drihm);
                    mysqli_set_charset($drihm, 'utf8');
                    $query = "SELECT tipoestablecimiento.id, tipoestablecimiento.nombre, tipoestablecimiento.descripcion FROM tipoestablecimiento";
                    $result = mysqli_query($drihm, $query) or die(mysqli_error($drihm));
                    $loginFoundUser = mysqli_num_rows($result);
                    mysqli_close($drihm);
                    $myArray = array();
                    while($row = mysqli_fetch_assoc($result)) {
                        $myArray[] = $row;
                    }
                    echo json_encode($myArray);

?>