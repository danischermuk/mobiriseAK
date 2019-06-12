<?php 

require_once('../Autho.php');
$token = null;
        $token = "";
        if (isset($_POST['token'])) {$token = $_POST['token'];}
        if (isset($_GET['token'])) {$token = $_GET['token'];}
        
        
        if (Autho::verifyJWT($token)) {
            $requestMethod = $_SERVER['REQUEST_METHOD'];
            // retrieve the inbound parameters based on request type.
            switch($requestMethod) {
                

                case 'POST':

                if(!empty($_FILES['image'])){
                    $ext = pathinfo($_FILES['image']['name'],PATHINFO_EXTENSION);
                            $image = time().'.'.$ext;
                            move_uploaded_file($_FILES["image"]["tmp_name"], '../../images/'.$image);
                    echo $image;
                }else{
                    echo "";
                }


                if(!empty($_FILES['file'])){
                    $ext = pathinfo($_FILES['file']['name'],PATHINFO_EXTENSION);
                            $cert = time().'.'.$ext;
                            move_uploaded_file($_FILES["file"]["tmp_name"], '../../certificados/'.$cert);
                    echo $cert;
                }else{
                    echo "";
                }




                break;
                
                


            default:
                $returnArray = array('error' => 'You have requested an invalid method.');
                $jsonEncodedReturnArray = json_encode($returnArray, JSON_PRETTY_PRINT);
                echo $jsonEncodedReturnArray;
            }
        } 
        else {
            $returnArray = array('error' => 'You are not logged in with a valid token. UPLOAD');
            echo  json_encode($returnArray, JSON_PRETTY_PRINT);
        }
