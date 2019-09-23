<?php
require_once('../admin/Connections/drihm.php');
require_once('PHPExcel/Classes/PHPExcel.php');

date_default_timezone_set('America/Argentina/Buenos_Aires');
$date = date('d/m/Y h:i:s a', time());
$titulo = "Esta lista fue creada el día " . $date;

mysqli_select_db($drihm, $database_drihm);
mysqli_set_charset($drihm, 'utf8');
$query = "SELECT contactos.email, contactos.nombre, contactos.empresa, contactos.cargo, contactos.telefono, contactos.mensaje, contactos.fechaContacto, contactos.contactoDesde  FROM contactos ORDER BY contactos.fechaContacto";
$result = mysqli_query($drihm, $query) or die(mysqli_error($drihm));
$loginFoundUser = mysqli_num_rows($result);
$myArray = array();
while ($row = mysqli_fetch_assoc($result)) {
    $myArray[] = $row;
}

$objPHPExcel = new PHPExcel();

$objPHPExcel->getProperties()
    ->setCreator("Ajdut Kosher")
    ->setLastModifiedBy("Ajdut Kosher")
    ->setTitle("Lista de Contactos")
    ->setSubject("Lista de Contactos")
    ->setDescription("Lista de Contactos")
    ->setKeywords("Lista de Contactos")
    ->setCategory("Lista de Contactos");

$sheet = $objPHPExcel->setActiveSheetIndex(0);
$sheet->setCellValue('A1', $titulo);
$sheet->mergeCells("A1:F1");
$sheet->setCellValue('A2', "Lista de contactos efectuados desde la Web y la App");
$sheet->mergeCells("A2:F2");



$sheet->getStyle("A1:F3")->getFont()->setBold(true);
$sheet->getStyle("A1:F3")->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
$sheet->getStyle("A2:F2")->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
$sheet->getStyle("A1:F1")->getFont()->setSize(15);
$sheet->getRowDimension(1)->setRowHeight(25);

$sheet->setCellValue('A4' , "E-MAIL");
$sheet->setCellValue('B4' , "NOMBRE");
$sheet->setCellValue('C4' , "EMPRESA");
$sheet->setCellValue('D4' , "CARGO");
$sheet->setCellValue('E4' , "TELEFONO");
$sheet->setCellValue('F4' , "MENSAJE");
$sheet->setCellValue('G4' , "FECHA DE CONTACTO");
$sheet->setCellValue('H4' , "CONTACTO DESDE");


$objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(35);
$objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(20);
$objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(20);
$objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(25);
$objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(18);
$objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(45);
$objPHPExcel->getActiveSheet()->getColumnDimension('G')->setWidth(20);
$objPHPExcel->getActiveSheet()->getColumnDimension('H')->setWidth(25);
$rowCountStart = 5;
$rowCount = $rowCountStart;
foreach ($myArray as $i => $item) {


    $sheet->setCellValue('A' . $rowCount, $item['email']);
    $sheet->setCellValue('B' . $rowCount, $item['nombre']);
    $sheet->setCellValue('C' . $rowCount, $item['empresa']);
    $sheet->setCellValue('D' . $rowCount, $item['cargo']);
    $sheet->setCellValue('E' . $rowCount, $item['telefono']);
    $sheet->setCellValue('F' . $rowCount, $item['mensaje']);
    $sheet->setCellValue('G' . $rowCount, $item['fechaContacto']);
    $sheet->setCellValue('H' . $rowCount, $item['contactoDesde']);
    $rowCount++;
}

$objPHPExcel->getActiveSheet()->getStyle('A' . $rowCountStart . ':H' . $rowCount)
    ->getAlignment()->setWrapText(true);

$objPHPExcel->getActiveSheet()->getStyle('A' . $rowCountStart . ':H' . $rowCount)
    ->getAlignment()->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER);


$objPHPExcel->getActiveSheet()->getStyle('A' . $rowCountStart . ':H' . $rowCount)
    ->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);


$sheet->getPageSetup()->setFitToWidth(1);
$sheet->getPageSetup()->setFitToHeight(0);
$objPHPExcel->getActiveSheet()->setTitle('Lista de Contactos - AK');
$objPHPExcel->setActiveSheetIndex(0);

header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
header('Content-Disposition: attachment;filename="Lista Contactos - AK.xlsx"');
header('Cache-Control: max-age=0');
$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
$objWriter->save('php://output');
exit;
