const router = require('express').Router();
const mssql = require('mssql');

router.get('/', function(req, res) {
  res.render('inventory', { userType: req.cookies['userType']});
});

module.exports = router;
