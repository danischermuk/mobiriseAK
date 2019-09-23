<?php

require_once('admin/Connections/drihm.php');

if (isset($_POST['email'])) {

  // EDIT THE 2 LINES BELOW AS REQUIRED
  $email_to = "afogel@ajdut.com.ar, rab@ajdut.com.ar, asistentekosher@ajdut.com.ar";
  $email_subject = "Contacto Ajdut Kosher";

  function died($error)
  {
    // your error code can go here
    echo "Lamentablemente se ha producisdo un error y no se ha podido enviar su solicitud de contacto. ";
    echo $error . "<br /><br />";
    echo "Por favor verifique los errores e intente nuevamente.<br /><br />";
    die();
  }

  // validation expected data exists
  if (
    !isset($_POST['first_name'])
    || !isset($_POST['company'])
    || !isset($_POST['email'])
    || !isset($_POST['message'])
  ) {
    died('Ha sucedido un error en el envío de su formulario. Por favor complete todos los campos y vuelva a enviarlo.');
  }



  $first_name = $_POST['first_name']; // required
  $company = $_POST['company']; // required
  $email_from = $_POST['email']; // required
  $comments = $_POST['message']; // required

  if (isset($_POST['cargo'])) {
    $cargo = $_POST['cargo'];
  } else {
    $cargo = "";
  }

  if (isset($_POST['telefono'])) {
    $telefono = $_POST['telefono'];
  } else {
    $telefono = "";
  }
  if (isset($_POST['producto'])) {
    $producto = $_POST['producto'];
  } else {
    $producto = "";
  }


  $error_message = "";
  $email_exp = '/^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/';

  if (!preg_match($email_exp, $email_from)) {
    $error_message .= 'El email ingersado no es valido.<br />';
  }

  $string_exp = "/^[A-Za-z .'-]+$/";

  if (!preg_match($string_exp, $first_name)) {
    $error_message .= 'El nombre no es valido.<br />';
  }



  if (strlen($comments) < 2) {
    $error_message .= 'El mensaje está vacío o no es válido<br />';
  }

  if (strlen($error_message) > 0) {
    died($error_message);
  }

  $email_message = "Form details below.\n\n";


  function clean_string($string)
  {
    $bad = array("content-type", "bcc:", "to:", "cc:", "href");
    return str_replace($bad, "", $string);
  }



  $email_message .= "Nombre: " . clean_string($first_name) . "\n";
  $email_message .= "Empresa: " . clean_string($company) . "\n";
  $email_message .= "Cargo: " . clean_string($cargo) . "\n";
  $email_message .= "Email: " . clean_string($email_from) . "\n";
  $email_message .= "Teléfono: " . clean_string($telefono) . "\n";
  $email_message .= "Producto a Certificar: " . clean_string($producto) . "\n";
  $email_message .= "Mensaje: " . clean_string($comments) . "\n";

  // create email headers
  $headers = 'From: ' . $email_from . "\r\n" .
    'Reply-To: ' . $email_from . "\r\n" .
    'X-Mailer: PHP/' . phpversion();
  $nunu = mail($email_to, $email_subject, $email_message, $headers);
  if ($nunu = true) {
    // echo "exito";
    // header("Location: index.html#/exito");
  };

  // Cargo los datos en una DB para tener de referencia y poder hacer estadisticas.
  mysqli_select_db($drihm, $database_drihm);
  mysqli_set_charset($drihm, 'utf8');
  $query = "INSERT INTO `contactos` (`email`, `nombre`, `empresa`, `cargo`, `telefono`, `producto`, `mensaje`, `contactoDesde`) VALUES ('$email_from', '$first_name', '$company', '$cargo', '$telefono', '$producto', '$comments', 'EMPRESAS WEB')";
  $result = mysqli_query($drihm, $query) or die(mysqli_error($drihm));
  ?>

  <!-- include your own success html here -->

  <script>
window.location.replace("index.html#/exito");
    </script>


<?php

}
?>