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

//GET ALL DEVICES from DATABASE
app.get("/devices",(req, res, next)=>{
    con.query('SELECT * FROM devices ', function(error, result, fields){
        con.on('error', function(err){
            console.log('[MySQL]ERROR',err);
        });
        if(result && result.length){
            res.end(JSON.stringify(result));
        }else{
            res.end(JSON.stringify('No Devices here'));
        }
    });
    console.log("get on devices made")
});

//Search Device by Id
app.post("/search",(req, res, next)=>{

    var post_data = req.body;
    var id_search = Number(post_data.search);

    var query = "SELECT * FROM devices WHERE DEV_ID = "+id_search+"";

    con.query(query,function(error, result, fields){
        con.on('error', function(err){
            console.log('[MySQL]ERROR',err);
        });
        if(result && result.length){
            res.end(JSON.stringify(result));
        }else{
            res.end(JSON.stringify('No Devices here'));
        }
    });
    console.log("post on devices made with id = "+id_search+"")
});

app.post("/update",(req, res, next)=>{
    
    var post_data = req.body
    var id = Number(post_data.id)
    var fav = Number(post_data.fav)
    var desc = post_data.desc

    var query = "UPDATE devices SET DEV_FAV = "+fav+", DEV_DESC = '"+desc+"' WHERE DEV_ID = "+id+""
    con.query(query,function(error, result, fields){
        con.on('error', function(err){
            console.log('[MySQL]ERROR',err);
        });
    });
    console.log("update on devices made with id = "+id+"")
})


//Start Server
app.listen(3000, ()=>{
    console.log('Electry Search API running on port 3000');
});