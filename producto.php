<html>

<head>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1">
    <link rel="shortcut icon" href="assets/images/logoAK.png" type="image/x-icon">
    <meta name="description" content="">
    <title>Ajdut Kosher</title>
</head>

<body>
    <img src="assets/images/logonuevoAK.png" />
    <h1>Prueba de producto</h1>
    <?php
    require_once('admin/Connections/drihm.php');

    
            if (isset($_GET['id'])) {
                $id = $_GET['id'];
            
            mysqli_select_db($drihm, $database_drihm);
            mysqli_set_charset($drihm, 'utf8');
            $query = "SELECT producto.id, producto.sintacc, producto.descripcion, producto.marca, producto.barcode, producto.rubroId, producto.imagen, codigo.nombre AS codigoNombre, codigo.id AS codigoId, codigo.codigo AS codigoCodigo , lecheparve.id AS lecheparveId, lecheparve.nombre AS lecheparve, lecheparve.codigo AS lecheparveCodigo, rubro.nombre AS rubro FROM producto JOIN codigo ON producto.nivelId = codigo.id JOIN lecheparve ON producto.lecheparveId = lecheparve.id JOIN rubro ON producto.rubroId = rubro.id WHERE producto.publicar = 'Si' AND producto.id = $id ORDER BY rubro, producto.descripcion";
            $result = mysqli_query($drihm, $query) or die(mysqli_error($drihm));
            $loginFoundUser = mysqli_num_rows($result);
            mysqli_close($drihm);
            $myArray = array();
            if ($row = mysqli_fetch_assoc($result)) {
                echo json_encode($row);
                echo "<h2>$row[descripcion]</h2>";
                echo "<h2>Marca: $row[marca]</h2>";
                echo "<img src=images/$row[imagen] />";
                
            }
            
        }
    $id = "No se encontro el producto";
    if (isset($_GET['id'])) {
        $id = $_GET['id'];
    }
    ?>
</body>

</html>