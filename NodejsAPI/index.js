var express = require('express')
var mysql = require('mysql')
var bodyParser = require('body-parser')
var cors = require('cors')
const crypto = require ("crypto")

var con = mysql.createPool({
        host:'localhost',
        user:'root',
        password:'',
        database:'electry'
});

var app = express();
var publicDir=(__dirname+'/public/');
app.use(express.static(publicDir));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended:true}));
app.use(cors())

app.post("/devices",(req, res, next)=>{
        var post_data = req.body
        var sub_api = post_data.sub_api

        if(sub_api == 'all'){
                var get_query = 'SELECT * FROM `devices` ORDER BY DEV_STATE DESC, CASE WHEN IMAGE_PATH = "lightbulb" THEN NULL WHEN IMAGE_PATH = "pc" THEN 1 ELSE IMAGE_PATH END ASC'
                con.query(get_query, function(error, result, fields){
                        con.on('error', function(err){
                                console.log('[MYSQL]ERROR',err);
                        });
                        if(result && result.length){
                                res.end(JSON.stringify(result));
                        }
                });
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
                        var query = 'UPDATE devices SET DEV_DESC = "'+dev_x+'" WHERE DEV_ID = '+id+''
                }else if(change_set == "dev_name"){
                        var query = 'UPDATE devices SET DEV_NAME = "'+dev_x+'" WHERE DEV_ID = '+id+''
                }else if(change_set == "dev_icon"){
                        var query = 'UPDATE devices SET IMAGE_PATH = "'+dev_x+'" WHERE DEV_ID = '+id+''
                }else if(change_set == "dev_fav") {
                        dev_x = Number(dev_x)
                        var query = 'UPDATE devices SET DEV_FAV = '+dev_x+' WHERE DEV_ID = '+id+''
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
        }else if(sub_api == 'login'){
                var user = post_data.user
                var pass = post_data.pass
                var pass_shasum = crypto.createHash('sha256').update(pass).digest('hex')
                var query = "SELECT * FROM users WHERE (username='"+user+"' OR email='"+user+"') AND password='"+pass_shasum+"'"
                con.query(query, function(error, result, fields){
                        con.on('error', function(err){
                                console.log('[MySQL]ERROR',err);
                        });
                        if(result && result.length){
                                res.end(JSON.stringify(result));
                        }
                });
        }else if(sub_api == 'sign'){
                var user = post_data.user
                var pass = post_data.pass
                var email = post_data.email
                var pass_shasum = crypto.createHash('sha256').update(pass).digest('hex')
                var query_check = "SELECT * FROM users WHERE username="+user+" OR email="+email+""
                var query_insert = "INSERT INTO users (`id`, `username`, `password`, `email`) VALUES (NULL, '"+user+"', '"+pass_shasum+"', '"+email+"')"
                con.query(query_check, function(error, result, fields){
                        con.on('error', function(err){
                                console.log('[MySQL]ERROR',err);
                        });
                        if(result && result.length){
                                res.end(JSON.stringify({output:"failure"}))
                        }else{
                                con.query(query_insert, function(error, result, fields){
                                        con.on('error', function(err){
                                                console.log('[MySQL]ERROR',err);
                                        });
                                        
                                })
                        }
                });
        }
});

app.post("/esp_conn",(req, res, next)=>{
var api_key_value = "tPmAT5Ab3j7F9"
var post_data = req.body
var api_key = post_data.api_key
if(api_key == api_key_value){
var command = post_data.command
var consumer_id = Number(post_data.consumer_id)
if(command == "measurement_table"){
var timestamp = post_data.timestamp
var power = Number(post_data.power)
var state = Number(post_data.state)

var query = 'INSERT INTO `measurements_00001` (`id`, `consumer_id`, `timestamp`, `power`, `state`) VALUES (NULL, '+consumer_id+', "'+timestamp+'", '+power+', '+state+')'
con.query(query, function(error, result, fields){
    con.on('error', function(err){
        res.end(JSON.stringify({Error: ''+err+''}));
        console.log("Error: "+err+"");
    });

    res.end(JSON.stringify({output:'success'}));

});
}else if(command == "event_table"){
var create_query = 'CREATE TABLE `measurements_00001` (`id` int(1) NOT NULL AUTO_INCREMENT PRIMARY KEY,`consumer_id` int(1) NOT NULL,`timestamp` datetime NOT NULL,`power` int(1) NOT NULL,`state` int(1) NOT NULL)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;'
con.query(query, function(error, result, fields){
    con.on('error', function(err){
        res.end(JSON.stringify({Error:''+err+''}));
        console.log("Error: "+err+"");
    });
    if(result && result.length){
        res.end(JSON.stringify({output:"success"}));
    }
});
}else{
console.log("NO such command")
}
}else{
console.log("Not the correct api_key")
}
});

app.get("/esp", (req, res, next)=>{
res.end(JSON.stringify("Hello asshole"));
});

app.listen(3000, ()=>{
console.log('Electry Search API running on port 3000');
});