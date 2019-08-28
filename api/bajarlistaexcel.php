<?php 
require_once('../admin/Connections/drihm.php'); 
require_once('PHPExcel/Classes/PHPExcel.php');

date_default_timezone_set('America/Argentina/Buenos_Aires');
$date = date('d/m/Y h:i:s a', time());
$titulo = "Esta lista fue creada el día " .$date. ". La misma tiene validez sólo para dicho día.";

mysqli_select_db( $drihm,$database_drihm);
mysqli_set_charset($drihm, 'utf8');
$query = "SELECT producto.id, producto.sintacc, producto.descripcion, producto.marca, producto.barcode, producto.rubroId, producto.imagen, codigo.nombre AS codigoNombre, codigo.id AS codigoId, codigo.codigo AS codigoCodigo , lecheparve.id AS lecheparveId, lecheparve.nombre AS lecheparve, lecheparve.codigo AS lecheparveCodigo, rubro.nombre AS rubro FROM producto JOIN codigo ON producto.nivelId = codigo.id JOIN lecheparve ON producto.lecheparveId = lecheparve.id JOIN rubro ON producto.rubroId = rubro.id WHERE producto.publicar = 'Si' ORDER BY rubro, producto.descripcion";
$result = mysqli_query($drihm, $query) or die(mysqli_error($drihm));
$loginFoundUser = mysqli_num_rows($result);
mysqli_close($drihm);
$myArray = array();
while($row = mysqli_fetch_assoc($result)) {
    $myArray[] = $row;
}

$objPHPExcel = new PHPExcel();

$objPHPExcel->
getProperties()
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
$sheet->setCellValue('A3', "Categoría");
$sheet->setCellValue('B3', "Producto");
$sheet->setCellValue('C3', "Marca");
$sheet->setCellValue('D3', "");
$sheet->setCellValue('E3', "");
$sheet->setCellValue('F3', "Sin Tacc");
$sheet->getStyle("A1:F3")->getFont()->setBold( true );
foreach ($myArray as $i => $item) {
    $sheet->setCellValue('A' . ($i + 4), $item['rubro']);
    $sheet->setCellValue('B' . ($i + 4), $item['descripcion']);
    $sheet->setCellValue('C' . ($i + 4), $item['marca']);
    $sheet->setCellValue('D' . ($i + 4), $item['codigoCodigo']);
    $sheet->setCellValue('E' . ($i + 4), $item['lecheparveCodigo']);
    $sheet->setCellValue('F' . ($i + 4), $item['sintacc']);
    
    $objPHPExcel->getActiveSheet()->getStyle('A' . ($i + 1))->getAlignment()->setWrapText(true);
    $objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(15);
    $objPHPExcel->getActiveSheet()->getStyle('B' . ($i + 1))->getAlignment()->setWrapText(true);
    $objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(60);
    $objPHPExcel->getActiveSheet()->getStyle('C' . ($i + 1))->getAlignment()->setWrapText(true);
    $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(17);
    $objPHPExcel->getActiveSheet()->getStyle('D' . ($i + 1))->getAlignment()->setWrapText(true);
    $objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(5);
    $objPHPExcel->getActiveSheet()->getStyle('E' . ($i + 1))->getAlignment()->setWrapText(true);
    $objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(8);
}

$sheet->getStyle()->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

$objPHPExcel->getActiveSheet()->setTitle('Usuarios');
$objPHPExcel->setActiveSheetIndex(0);

header('Content-Type: application/vnd.ms-excel');
header('Content-Disposition: attachment;filename="Lista Kosher.xls"');
header('Cache-Control: max-age=0');
$objWriter=PHPExcel_IOFactory::createWriter($objPHPExcel,'Excel5');
$objWriter->save('php://output');
exit;