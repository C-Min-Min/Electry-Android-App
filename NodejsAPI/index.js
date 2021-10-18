var express = require('express')
var mysql = require('mysql')
var bodyParser = require('body-parser')
var cors = require('cors')

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
app.use(cors);

app.post("/devices",(req, res, next)=>{
    var post_data = req.body
    var sub_api = post_data.sub_api

    if(sub_api == 'all'){
        var get_query = 'SELECT * FROM `devices` ORDER BY DEV_STATE DESC, CASE WHEN IMAGE_PATH = "lightbulb" THEN NULL WHEN IMAGE_PATH = "pc" THEN 1 ELSE IMAGE_PATH END ASC'
        con.query(get_query, function(error, result, fields){
            con.on('error', function(err){
                console.log('[MySQL]ERROR',err);
            });
            if(result && result.length){
                res.end(JSON.stringify(result));
            }
        });
        console.log("get on devices made")
    }else if(sub_api == 'search'){
        var id_search = Number(post_data.search);

        var query = "SELECT * FROM devices WHERE DEV_ID = "+id_search+"";

        con.query(query,function(error, result, fields){
            con.on('error', function(err){
                console.log('[MySQL]ERROR',err);
            });
            if(result && result.length){
                res.end(JSON.stringify(result));
            }
        });
        console.log("post on devices made with id = "+id_search+"")
    }else if(sub_api == 'edit'){
        var id = Number(post_data.id)
        var change_set = post_data.change_set
        var dev_x = post_data.dev_x

        if(change_set == "dev_desc"){
            var query = "UPDATE devices SET DEV_DESC = '"+dev_x+"' WHERE DEV_ID = "+id+""
        }else if(change_set == "dev_name"){
            var query = "UPDATE devices SET DEV_NAME = '"+dev_x+"' WHERE DEV_ID = "+id+""
        }else if(change_set == "dev_icon"){
            var query = "UPDATE devices SET IMAGE_PATH = '"+dev_x+"' WHERE DEV_ID = "+id+""
        }else if(change_set == "dev_fav") {
            dev_x = Number(dev_x)
            var query = "UPDATE devices SET DEV_FAV = "+dev_x+" WHERE DEV_ID = "+id+""
        }

        con.query(query,function(error, result, fields){
            con.on('error', function(err){
                console.log('[MySQL]ERROR',err);
            });
        });
        console.log("update on devices made with id = "+id+" for "+change_set+" with "+dev_x+"")
        console.log(query);
    }else if(sub_api == 'delete'){
        var id = Number(post_data.id)

        var query = "DELETE FROM devices WHERE DEV_ID = "+id+""
        con.query(query,function(error, result, fields){
            con.on('error', function(err){
                console.log('[MySQL]ERROR',err);
            });
            if(result && result.length){
                res.end(JSON.stringify(result));
            }
        });
        console.log("deleted device with id = "+id+"")
    }else if(sub_api == 'measurements'){
        var id = Number(post_data.id)

        var query = "SELECT * FROM measurements_00001 WHERE consumer_id="+id+" ORDER BY timestamp"
        con.query(query, function(error, result, fields){
            con.on('error', function(err){
                console.log('[MySQL]ERROR',err);
            });
            if(result && result.length){
                res.end(JSON.stringify(result));
            }
        });
        console.log("post on measurements with id = "+id+"")
    }
});

app.get("/cors", (req, res, next)=>{
    res.end(JSON.stringify("Hello asshole"));
});
//Start Server
app.listen(3000, ()=>{
    console.log('Electry Search API running on port 3000');
});