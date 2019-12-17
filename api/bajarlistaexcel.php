<?php
require_once('../admin/Connections/drihm.php');
require_once('PHPExcel/Classes/PHPExcel.php');

date_default_timezone_set('America/Argentina/Buenos_Aires');

function htmlToPlainText($str){
    $str = strip_tags($str, '<br><p><li>');
    $str = str_replace ("&nbsp;", " ", $str);
    $str = preg_replace ('/<[^>]*>/', PHP_EOL, $str);
    $str = str_replace (PHP_EOL . PHP_EOL, PHP_EOL, $str);
    return $str;
}

$date = date('d/m/Y h:i:s a', time());
$titulo = "Esta lista fue creada el día " . $date . ". La misma tiene validez sólo para dicho día.";

$explicacion = "M = Mehadrin | B60 = Bitul 60 | P = Parve | LC = Leche Común | LP = Leche en Polvo | KL = Kelim Lácteos";

if (isset($_GET['id'])) {
    $id = $_GET['id'];
}
mysqli_select_db($drihm, $database_drihm);
mysqli_set_charset($drihm, 'utf8');
$query = "SELECT rubro.id, rubro.descripcion, rubro.nombre FROM rubro ORDER BY rubro.nombre";
$result = mysqli_query($drihm, $query) or die(mysqli_error($drihm));
$loginFoundUser = mysqli_num_rows($result);
$myArray = array();
while ($row = mysqli_fetch_assoc($result)) {
    $myArray[] = $row;
}

mysqli_select_db($drihm, $database_drihm);
mysqli_set_charset($drihm, 'utf8');
$query = "SELECT producto.id, producto.sintacc, producto.descripcion, producto.marca, producto.barcode, producto.rubroId, producto.imagen, codigo.nombre AS codigoNombre, codigo.id AS codigoId, codigo.codigo AS codigoCodigo , lecheparve.id AS lecheparveId, lecheparve.nombre AS lecheparve, lecheparve.codigo AS lecheparveCodigo, rubro.nombre AS rubro FROM producto JOIN codigo ON producto.nivelId = codigo.id JOIN lecheparve ON producto.lecheparveId = lecheparve.id JOIN rubro ON producto.rubroId = rubro.id WHERE producto.publicar = 'Si' ORDER BY rubro, producto.descripcion";
$result = mysqli_query($drihm, $query) or die(mysqli_error($drihm));
$loginFoundUser = mysqli_num_rows($result);
mysqli_close($drihm);
$myArrayProductos = array();
while ($row = mysqli_fetch_assoc($result)) {
    $myArrayProductos[] = $row;
}

$objPHPExcel = new PHPExcel();

$objPHPExcel->getProperties()
    ->setCreator("Ajdut Kosher")
    ->setLastModifiedBy("Ajdut Kosher")
    ->setTitle("Lista Kosher")
    ->setSubject("Lista Kosher")
    ->setDescription("Lista Kosher")
    ->setKeywords("Lista Kosher")
    ->setCategory("Lista Kosher");

$sheet = $objPHPExcel->setActiveSheetIndex(0);
$sheet->setCellValue('A1', $titulo);
$sheet->mergeCells("A1:F1");
$sheet->setCellValue('A2', $explicacion);
$sheet->mergeCells("A2:F2");
$sheet->setCellValue('A3', "Cantidad total de productos:   " .sizeof($myArrayProductos));
$sheet->mergeCells("A3:F3");


$sheet->getStyle("A1:F3")->getFont()->setBold(true);
$sheet->getStyle("A1:F3")->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
$sheet->getStyle("A2:F2")->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
$sheet->getStyle("A1:F1")->getFont()->setSize(15);
$sheet->getRowDimension( 1)->setRowHeight(25);


$objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(75);
$objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(20);
$objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(5);
$objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(8);
$objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(18);
$rowCount = 5;
foreach ($myArray as $i => $item) {

    $descripcion = htmlToPlainText($item['descripcion']);
    $rowHeight = ceil((strlen($descripcion) / 125)+(substr_count($descripcion, PHP_EOL)/2)) * 18.75;


    $sheet->mergeCells('A' .  $rowCount . ':F' . $rowCount);
    $sheet->setCellValue('A' . $rowCount, $item['nombre']);
    $sheet->getStyle('A' .  $rowCount)->getAlignment()->setWrapText(true);
    $sheet->getStyle('A' .  $rowCount)->getFont()->setBold(true);
    $sheet->getStyle('A' .  $rowCount)->getFont()->setSize(16);
    $sheet->getRowDimension( $rowCount)->setRowHeight(25);
    $rowCount++;
    $sheet->getRowDimension( $rowCount)->setRowHeight($rowHeight);
    $sheet->mergeCells('A' . ( $rowCount) . ':F' . $rowCount);
    $sheet->setCellValue('A' . ( $rowCount), $descripcion);
    $sheet->getStyle('A' .  $rowCount)->getFont()->setSize(13);
    $sheet->getStyle('A' .  $rowCount)->getAlignment()->setWrapText(true);
    $sheet->getStyle('A' .  $rowCount)->getAlignment()->setVertical(PHPExcel_Style_Alignment::VERTICAL_TOP);
    $rowCount++;


    // Imprimo los títulos:
    $sheet->setCellValue('A' . $rowCount, "PRODUCTO");
    $sheet->setCellValue('B' . $rowCount, "MARCA");
    $sheet->mergeCells('C' . ( $rowCount) . ':D' . $rowCount);
    $sheet->setCellValue('C' . $rowCount, "CATEGORIA");
    $sheet->setCellValue('F' . $rowCount, "COD. BARRAS");
    $sheet->getStyle('F' .  $rowCount)->getAlignment()->setWrapText(true);
    $rowCount++;

    


    foreach ($myArrayProductos as $j => $prod) {
         if ($prod['rubroId'] == $item['id']) {
            
            $sheet->setCellValue('A' . $rowCount, $prod['descripcion']);
            $sheet->setCellValue('B' . $rowCount, $prod['marca']);
            $sheet->setCellValue('C' . $rowCount, $prod['codigoCodigo']);
            $sheet->setCellValue('D' . $rowCount, $prod['lecheparveCodigo']);
            if($prod['sintacc'] =='Si')
                $sheet->setCellValue('E' . $rowCount, "SIN TACC");
            $sheet->setCellValueExplicit('F' . $rowCount, $prod['barcode'],PHPExcel_Cell_DataType::TYPE_STRING);
            $sheet->getStyle('A' . ( $rowCount))->getAlignment()->setWrapText(true);
            $sheet->getStyle('B' .  $rowCount)->getAlignment()->setWrapText(true);
            
            $sheet->getStyle('B' . ( $rowCount))->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
            $rowCount++;
         }
    }
    $rowCount++;
}

$sheet->getDefaultStyle()->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
$sheet->getDefaultStyle()->getAlignment()->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER);

$sheet->getPageSetup()->setFitToWidth(1);
$sheet->getPageSetup()->setFitToHeight(0); 
$objPHPExcel->getActiveSheet()->setTitle('Lista Kosher');
$objPHPExcel->setActiveSheetIndex(0);

header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
header('Content-Disposition: attachment;filename="Lista Kosher.xlsx"');
header('Cache-Control: max-age=0');
$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
$objWriter->save('php://output');
exit;
