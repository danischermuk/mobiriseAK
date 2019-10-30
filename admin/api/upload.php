<?php

require_once('../Autho.php');
$token = null;
$token = "";
if (isset($_POST['token'])) {
    $token = $_POST['token'];
}
if (isset($_GET['token'])) {
    $token = $_GET['token'];
}


if (Autho::verifyJWT($token)) {
    $requestMethod = $_SERVER['REQUEST_METHOD'];
    // retrieve the inbound parameters based on request type.
    switch ($requestMethod) {


        case 'POST':

            if (!empty($_FILES['image'])) {


                $file = $_FILES['image']['tmp_name'];
                $sourceProperties = getimagesize($file);
                $fileNewName = time();
                $folderPath = "../../images/";
                $ext = pathinfo($_FILES['image']['name'], PATHINFO_EXTENSION);
                $imageType = $sourceProperties[2];

                switch ($imageType) {


                    case IMAGETYPE_PNG:
                        $imageResourceId = imagecreatefrompng($file);
                        $targetLayer = imageResize($sourceProperties, $imageResourceId, $sourceProperties[0], $sourceProperties[1]);
                        imagepng($targetLayer, $folderPath . $fileNewName . "_thum." . $ext);
                        break;

                    case IMAGETYPE_JPEG:
                        $imageResourceId = imagecreatefromjpeg($file);
                        $targetLayer = imageResize($sourceProperties, $imageResourceId, $sourceProperties[0], $sourceProperties[1]);
                        imagejpeg($targetLayer, $folderPath . $fileNewName . "_thum." . $ext);
                        break;


                    default:
                        echo "Invalid Image type.";
                        exit;
                        break;
                }

                $ext = pathinfo($_FILES['image']['name'], PATHINFO_EXTENSION);
                $image = time() . '.' . $ext;
                move_uploaded_file($_FILES["image"]["tmp_name"], '../../images/' . $image);
                move_uploaded_file($file, $folderPath. $fileNewName. ".". $ext);
                echo $fileNewName . "_thum." . $ext;
            } else {
                echo "";
            }


            if (!empty($_FILES['file'])) {
                $ext = pathinfo($_FILES['file']['name'], PATHINFO_EXTENSION);
                $cert = time() . '.' . $ext;
                move_uploaded_file($_FILES["file"]["tmp_name"], '../../certificados/' . $cert);
                echo $cert;
            } else {
                echo "";
            }

            if (!empty($_FILES['pesaj'])) {
                $ext = pathinfo($_FILES['pesaj']['name'], PATHINFO_EXTENSION);
                if(file_exists('../../pesaj/' .$_FILES['pesaj']['name'])) {
                    unlink('../../pesaj/' .$_FILES['pesaj']['name']); 
                }
                move_uploaded_file($_FILES["pesaj"]["tmp_name"], '../../pesaj/' . $_FILES['pesaj']['name']);
                echo $_FILES['pesaj']['name'];
            } else {
                echo "";
            }

            break;




        default:
            $returnArray = array('error' => 'You have requested an invalid method.');
            $jsonEncodedReturnArray = json_encode($returnArray, JSON_PRETTY_PRINT);
            echo $jsonEncodedReturnArray;
    }
} else {
    $returnArray = array('error' => 'You are not logged in with a valid token. UPLOAD');
    echo  json_encode($returnArray, JSON_PRETTY_PRINT);
}

function imageResize($sourceProperties, $imageResourceId, $width, $height)
{

    if ($sourceProperties[0] > $sourceProperties[1]) {
        //wide image
        $targetWidth = 250;
        $targetHeight = 250*$sourceProperties[1]/$sourceProperties[0];

    } else {
        $targetHeight = 250;
        $targetWidth = 250*$sourceProperties[0]/$sourceProperties[1];
    }

    


    $targetLayer = imagecreatetruecolor($targetWidth, $targetHeight);
    imagecopyresampled($targetLayer, $imageResourceId, 0, 0, 0, 0, $targetWidth, $targetHeight, $width, $height);


    return $targetLayer;
}
