const router = require('express').Router();
const mssql = require('mssql');

router.get('/', function(req, res) {
  res.render('index', { userType: req.cookies['userType']});
});

module.exports = router;
