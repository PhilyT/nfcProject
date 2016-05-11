var express = require('express');
var morgan = require('morgan'); // Charge le middleware de logging
var logger = require('log4js').getLogger('Server');
var bodyParser = require('body-parser');
var XMLHttpRequest = require('xhr2');
var app = express();

// config
app.set('view engine', 'ejs');
app.set('views', __dirname + '/views');

app.use(bodyParser.urlencoded({ extended: false }));
app.use(morgan('combined')); // Active le middleware de logging

app.use(express.static(__dirname + '/public')); // Indique que le dossier /public contient des fichiers statiques (middleware chargé de base)

logger.info('server start');

// Route
app.get('/', function(req, res){
    res.redirect('/login');
});

app.get('/login', function(req, res){
    res.render('login');
});

app.get('/badgeetudiant', function (req, res)
{
	res.render('badgeetudiant', {etat:""});
});
app.get('/admin', function(req, res){
	logger.info(req.user);
    res.render('admin');
});
app.get('/gestionE', function(req, res){
    res.render('gestionE');
});
app.get('/gestionC', function(req, res){
    res.render('gestionC');
});

app.get('/iut.png', function(req, res){
    res.sendFile('img/iut.png', { root:__dirname });
});
app.get('/unice.png', function(req, res){
    res.sendFile('img/unice.png', { root: __dirname });
});
app.get('/badgeuse.png', function(req, res){
    res.sendFile('img/badgeuse.png', { root: __dirname });
});

app.post('/badgeetudiant', function (req, res)
{
	var t;
	var adr = "http://localhost:8080/scan";
	var http = new XMLHttpRequest();
		
	http.open("GET", adr, true);
	http.onreadystatechange = function()
	{
		if(http.readyState==4)
		{
			if (http.status == 200) 
			{
				t=JSON.parse(http.responseText);
				//t = http.responseText;
				logger.info("t : ", t);
				logger.info("etat : ", t.etat);
				logger.info("user : ", t.user);
				logger.info("prenom : ", JSON.parse(t.user).prenom);
				res.render('badgeetudiant', {etat:t.etat, prenom:JSON.parse(t.user).prenom, nom:JSON.parse(t.user).nom});
			}
			else
			{
				logger.info('Status Page : ', http.status);
				logger.info("erreur accès au service rest");
			}
		}
	}
	http.send(null);
});

app.get('/loginprof', function (req,res){
	res.render('loginprof', {etat:""});
});

app.post('/loginprof', function (req,res){
	var t;
	logger.info("password : ", req.body.password);
	var adr = "http://localhost:8080/co_admin?email="+req.body.email+"&mdp="+req.body.password;
	var http = new XMLHttpRequest();
	http.open("GET", adr, true);
	http.onreadystatechange = function()
	{
		if(http.readyState==4)
		{
			if (http.status == 200) 
			{
				t=JSON.parse(http.responseText);
				//t = http.responseText;
				logger.info("t : ", t);
				logger.info("etat : ", t.etat);
				logger.info("user : ", t.user);
				if (t.etat != 'success') 
				{
					res.render('loginprof', {etat:t.etat});
				}
				else
				{
					res.user = JSON.parse(t.user);
					res.redirect('/admin');
				}
			}
			else
			{
				logger.info('Status Page : ', http.status);
				logger.info("erreur accès au service rest");
			}
		}
	}
	http.send(null);
});

app.listen(1414);
