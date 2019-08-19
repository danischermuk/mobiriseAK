<?php 

require_once('../../admin/Connections/drihm.php'); 

            $requestMethod = $_SERVER['REQUEST_METHOD'];
            // retrieve the inbound parameters based on request type.
            switch($requestMethod) {
                
                case 'POST':
                

                    // EDIT THE 2 LINES BELOW AS REQUIRED
                    $email_to = "daniel.schermuk@gmail.com";
                    $email_subject = "Contacto Ajdut Kosher App";
                  
                    function died($error)
                    {
                      // your error code can go here
                      echo "We are very sorry, but there were error(s) found with the form you submitted. ";
                      echo "These errors appear below.<br /><br />";
                      echo $error . "<br /><br />";
                      echo "Please go back and fix these errors.<br /><br />";
                      die();
                    }
                  
                    // validation expected data exists
                    if (
                      !isset($_POST['name'])
                      || !isset($_POST['email'])
                      || !isset($_POST['mensaje'])
                    ) {
                      died('We are sorry, but there appears to be a problem with the form you submitted. ');
                    }
                  
                  
                  
                    $name = $_POST['name']; // required
                    $email_from = $_POST['email']; // required
                    $comments = $_POST['mensaje']; // required
                  
                    $error_message = "";
                    $email_exp = '/^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/';
                  
                    if (!preg_match($email_exp, $email_from)) {
                      $error_message .= 'The Email Address you entered does not appear to be valid.<br />';
                    }
                  
                    $string_exp = "/^[A-Za-z .'-]+$/";
                  
                    if (!preg_match($string_exp, $name)) {
                      $error_message .= 'The Name you entered does not appear to be valid.<br />';
                    }
                  
                  
                    if (strlen($comments) < 2) {
                      $error_message .= 'The Message you entered do not appear to be valid.<br />';
                    }
                  
                    if (strlen($error_message) > 0) {
                      died($error_message);
                    }
                  
                    $email_message = "Contacto:\n\n";
                  
                  
                    function clean_string($string)
                    {
                      $bad = array("content-type", "bcc:", "to:", "cc:", "href");
                      return str_replace($bad, "", $string);
                    }
                  
                  
                  
                    $email_message .= "Nombre: " . clean_string($name) . "\n";
                    $email_message .= "Email: " . clean_string($email_from) . "\n";
                    $email_message .= "Mensaje: " . clean_string($comments) . "\n";
                  
                    // create email headers
                    $headers = 'From: ' . $email_from . "\r\n" .
                      'Reply-To: ' . $email_from . "\r\n" .
                      'X-Mailer: PHP/' . phpversion();
                    $nunu = mail($email_to, $email_subject, $email_message, $headers);
                    if ($nunu = true) {
                      echo "Mensaje Enviado Correctamente";
                    };
                  
                break;

            default:
                $returnArray = array('error' => 'You have requested an invalid method.');
                $jsonEncodedReturnArray = json_encode($returnArray, JSON_PRETTY_PRINT);
                echo $jsonEncodedReturnArray;
            }
