const router = require('express').Router();
const mssql = require('mssql');

router.get('/', function(req, res) {
  res.render('index', { isAdmin: req.cookies['userType'] === 'trainer'});
});

module.exports = router;
