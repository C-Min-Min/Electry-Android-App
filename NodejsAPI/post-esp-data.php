<?php
$servername = "localhost";
$dbname = "id15617968_tryinghard";
$username = "id15617968_avatarbg555";
$password = "3s?BC&=FY0Ujj>Bn";

    $api_key_value = "tPmAT5Ab3j7F9";

    $api_key = $start_time = $power = $state = "";

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $api_key = test_input($_POST["api_key"]);
        if ($api_key == $api_key_value) {
            // Create connection
            $conn = new mysqli($servername, $username, $password, $dbname);
            // Check connection
            if ($conn->connect_error)  die("Connection failed: " . $conn->connect_error);

            
            $command = test_input($_POST["command"]);
            $serial_num = test_input($_POST["serial_number"]);
            $consumer_id = test_input($_POST["consumer_id"]);
            $name = "measurements_00001"; //.$serial_num

            if ($command == "measurement_table") {
                $timestamp = test_input($_POST["timestamp"]);
                $power = test_input($_POST["power"]);
                $state = test_input($_POST["state"]);

                $sql = "INSERT INTO ".$name." (consumer_id, timestamp, power, state)
                VALUES ('".$consumer_id."', '".$timestamp."', '".$power."', '".$state."')";
                if ($conn->query($sql) === TRUE) echo "New measurement created successfully";
                else  echo "Error: " . $sql . "<br>" . $conn->error;
            } else if ($command == "event_table") {
                $sql = "CREATE TABLE `".$name."` (`id` int(1) NOT NULL AUTO_INCREMENT PRIMARY KEY,
                        `consumer_id` int(1) NOT NULL,
                        `timestamp` datetime NOT NULL,
                        `power` int(1) NOT NULL,
                        `state` int(1) NOT NULL)
                        ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";
                if ($conn->query($sql) === TRUE)  echo "New event_table created successfully";
                else  echo "Error: " . $sql . "<br>" . $conn->error;
            } else  echo "Unregistered command!";

            $conn->close();
        } else {
            echo "Wrong API Key provided.", $_POST["api_key"];
        }
    } else {
        echo "No data posted with HTTP POST.";
    }

    function test_input($data) {
        $data = trim($data);
        $data = stripslashes($data);
        $data = htmlspecialchars($data);
        return $data;
    }
?>