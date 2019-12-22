const express = require('express');
const expressHandlebars = require('express-handlebars');
const cookieParser = require('cookie-parser');
const morgan = require('morgan');
const mssql = require('mssql');
const authRoute = require('./routes/auth');
const app = express();

mssql.connect({
  "server"  : "134.209.251.92",
  "user": "sa",
  "password": "vtysOdevi81_",
  "parseJSON":true,
  "database": "gym",
  "options": {
    "encrypt": false
  }
});

app.use(morgan('dev'));
app.use(cookieParser());
app.use(express.json());

app.use(function (req, res, next) {
  if(req.url.includes('/auth')) {
    next();
  } else if(req.cookies.tc){
    next();
  } else {
    res.redirect('/auth');
  }
});

app.engine('hbs', expressHandlebars({
  defaultLayout: 'layout',
  extname: '.hbs',
  layoutsDir: `./views`
}));

app.set('view engine', 'hbs')

app.use('/auth', authRoute);

app.get('/', async function (req, res) {
  const result = await mssql.query`select * from users`;
  console.log(result.recordset[3]);

  res.render('lagin', { a: result.recordset[3].name });
});

app.listen(3000);