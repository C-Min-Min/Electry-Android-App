var express = require('express')
var mysql = require('mysql')
var bodyParser = require('body-parser')

//connect MySQL
var con = mysql.createConnection({
    host:'localhost',
    user:'root',
    password:'',
    database:'electry'
});

//Create RESTFul
var app = express();
var publicDir=(__dirname+'/public/');
app.use(express.static(publicDir));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended:true}));

//GET ALL ODD DEVICES from DATABASE
app.get("/odd_devices",(req, res, next)=>{
    con.query('SELECT * FROM devices WHERE (DEV_ID % 2) != 0', function(error, result, fields){
        con.on('error', function(err){
            console.log('[MySQL]ERROR',err);
        });
        if(result && result.length){
            res.end(JSON.stringify(result));
        }else{
            res.end(JSON.stringify('No Devices here'));
        }
    });
});

//GET ALL EVEN DEVICES from DATABASE
app.get("/even_devices",(req, res, next)=>{
    con.query('SELECT * FROM devices WHERE (DEV_ID % 2) = 0', function(error, result, fields){
        con.on('error', function(err){
            console.log('[MySQL]ERROR',err);
        });
        if(result && result.length){
            res.end(JSON.stringify(result));
        }else{
            res.end(JSON.stringify('No Devices here'));
        }
    });
});

//Start Server
app.listen(3000, ()=>{
    console.log('Electry Search API running on port 3000');
});