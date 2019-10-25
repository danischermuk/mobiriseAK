<html>

<head>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1">
    <link rel="shortcut icon" href="assets/images/logoAK.png" type="image/x-icon">
    <meta name="description" content="">
    <style>
        <?php include "assets/simplegrid/bootstrap.min.css"; ?>
    </style>
    <style>
        <?php include "assets/simplegrid/productos.css"; ?>
    </style>

    <title>Ajdut Kosher</title>
</head>

<body>
    <div class="container" style="width:100% !important;">
        <div class="row">
            <div class="col text-center">
            <a href="https://kosher.org.ar" target="_blank">
                <img src="assets/images/logonuevoAK.png" class="logo" />
            </a>
            </div>
        </div>
        <div class="text-center appbanner">
            <h3>DESCARGA NUESTRA APP!</h3>

            <div class="row" style="margin-right:0 !important;">
                <div class="col text-center align-self-center">
                    <a href="https://play.google.com/store/apps/details?id=com.beatmobile.ak&hl=es_419" target="_blank">
                        <img src="assets/images/badge-android-es.png" alt="" style="height: 75px;"> </a>
                </div>
                <div class="col text-center align-self-center">
                    <a href="https://itunes.apple.com/ar/app/ajdut-kosher/id731823009?mt=8" target="_blank"> <img src="assets/images/badge-ios-es.png" alt="" style="height: 75px;"></a>
                </div>
            </div>
        </div>

        <br />

        <?php
        require_once('admin/Connections/drihm.php');


        if (isset($_GET['id']) && !empty($_GET['id'])) {
            $id = $_GET['id'];

            mysqli_select_db($drihm, $database_drihm);
            mysqli_set_charset($drihm, 'utf8');
            $query = "SELECT producto.id, producto.sintacc, producto.descripcion, producto.marca, producto.barcode, producto.rubroId, producto.imagen, codigo.nombre AS codigoNombre, codigo.id AS codigoId, codigo.codigo AS codigoCodigo , lecheparve.id AS lecheparveId, lecheparve.nombre AS lecheparve, lecheparve.codigo AS lecheparveCodigo, rubro.nombre AS rubro FROM producto JOIN codigo ON producto.nivelId = codigo.id JOIN lecheparve ON producto.lecheparveId = lecheparve.id JOIN rubro ON producto.rubroId = rubro.id WHERE producto.publicar = 'Si' AND producto.id = $id ORDER BY rubro, producto.descripcion";
            $result = mysqli_query($drihm, $query) or die(mysqli_error($drihm));
            $loginFoundUser = mysqli_num_rows($result);

            $myArray = array();
            if ($row = mysqli_fetch_assoc($result)) {
                echo "<div class=\"row\">";
                echo "<div class=\"col-md-4 text-center align-self-center\">";

                $imgsrc = 'images/' . str_replace(' ', '%20', $row["imagen"]);
                if (file_exists(__DIR__ . '/images/' . $row["imagen"])) {
                    echo "<img src=$imgsrc class=\"img-fluid img-thumbnail\"/>";
                } else {
                    echo "<img src=assets/images/logoAK.png class=\"img-fluid img-thumbnail\"/>";
                }
                echo "</div>";
                echo "<div class=\"col-md-8 description\">";
                echo "<h2>$row[descripcion]</h2>";
                echo "<br/><h2>Marca: " . strtoupper($row["marca"]) . "</h2>";
                echo "<div class=\"row\">";
                echo "<div class=\"col\">";
                echo "<br/><h3>" . strtoupper($row["codigoNombre"]) . "<br/>" . strtoupper($row["lecheparve"]) . "<br/>Apto Celíacos: " . strtoupper($row["sintacc"]) . "</h3>";
                echo "</div>";
                if (strtoupper($row["sintacc"]) === "SI") {
                    echo "<div class=\"col-md-3 col-xs-6 text-center align-self-center\">";
                    echo "<img src=assets/images/sintacc.png class=\"img-fluid\" style=\"padding-top: 10px; padding-botom: 10px;\"/>";
                    echo "</div>";
                }
                echo "</div>";
                echo "</div>";
                echo "</div>";
                echo "<br/>";
            } else {
                echo "<h4>Producto no encontrado</h4>";
            }

            mysqli_close($drihm);
        } else {
            echo "<h4>Producto no encontrado</h4>";
        }


        ?>

        <div class="text-center appbanner">
            <h3>MIRA LA LISTA COMPLETA</h3>

            <div class="row" style="margin-right:0 !important;">
                <div class="col text-center align-self-center">
                    <a href="https://kosher.org.ar/#/listakosher" target="_blank">
                        <img src="assets/images/badge-web-es.png" alt="" style="height: 75px;"> </a>
                </div>
            </div>
        </div>
    </div>
</body>

</html>