var express = require('express')
var mysql = require('mysql')
var bodyParser = require('body-parser')
var cors = require('cors')

var con = mysql.createConnection({
    host:'localhost',
    user:'root',
    password:'',
    database:'electry' 
});

const api_key_value = "tPmAT5Ab3j7F9"

var app = express();
var publicDir=(__dirname+'/public/');
app.use(express.static(publicDir));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended:true}));
app.use(cors);

app.post("/esp",(req, res, next)=>{
    var post_data = req.body
    var api_key = post_data.api_key
    if(api_key == api_key_value){
        var command = post_data.command
        //var serial_num = post_data.test_input
        var consumer_id = Number(post_data.consumer_id)

        if(command == "measurement_table"){
            var timestamp = post_data.timestamp
            var power = Number(post_data.power)
            var state = Number(post_data.state)

            var query = 'INSERT INTO `measurements_00001` (`id`, `consumer_id`, `timestamp`, `power`, `state`) VALUES (NULL, '+consumer_id+', "'+timestamp+'", '+power+', '+state+')'
            con.query(query, function(error, result, fields){
                con.on('error', function(err){
                    res.end(JSON.stringify("Error: "+query+"<br>"+err));
                    console.log("Error: "+query+"<br>"+err);
                });
                if(result && result.length){
                    res.end("New measurement created successfully");
                }
            });
        }
    }
});


//Start Server
app.listen(3000, ()=>{
    console.log('ESP post API running on port 3000');
});