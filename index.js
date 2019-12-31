const express = require('express');
const expressHandlebars = require('express-handlebars');
const cookieParser = require('cookie-parser');
const morgan = require('morgan');
const mssql = require('mssql');
const authRoute = require('./routes/auth');
const usersRoute = require('./routes/users');
const backupRoute = require('./routes/backup');
const trainersRoute = require('./routes/trainers');
const exercisesRoute = require('./routes/exercises');
const inventoryRoute = require('./routes/inventory');
const app = express();

mssql.connect({
  server: '134.209.251.92',
  user: 'sa',
  password: 'vtysOdevi81_',
  parseJSON: true,
  database: 'gym',
  options: { encrypt: false }
});

app.use(morgan('dev'));
app.use(cookieParser());
app.use(express.json());

app.use(function(req, res, next) {
  if (req.url.includes('/auth') || req.cookies.tc) {
    next();
  } else {
    res.redirect('/auth');
  }
});

app.engine(
  'hbs',
  expressHandlebars({
    defaultLayout: 'layout',
    layoutsDir: `./views`,
    extname: '.hbs',
    helpers: {
      json: function () { return JSON.stringify(this);},
      calculateAge: function getAge() {
        const today = new Date();
        const birthDate = new Date(this.birth_date);
        let age = today.getFullYear() - birthDate.getFullYear();
        const month = today.getMonth() - birthDate.getMonth();
        if (month < 0 || (month === 0 && today.getDate() < birthDate.getDate())) {
          age--;
        }
        return age;
      }
    }
  })
);

app.set('view engine', 'hbs');

app.use('/auth', authRoute);
app.use('/users', usersRoute);
app.use('/backup', backupRoute);
app.use('/trainers', trainersRoute);
app.use('/exercises', exercisesRoute);
app.use('/inventory', inventoryRoute);

app.get('/', async function(req, res) {
  res.render('index', { isAdmin: req.cookies['userType'] === 'trainer', isMain: true });
});

app.listen(3000);
