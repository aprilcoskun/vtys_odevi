const router = require('express').Router();
const mssql = require('mssql');

router.get('/', function(req, res) {
  res.render('backup', {
    isAdmin: req.cookies['userType'] === 'trainer',
    isSettings: true
  });
});

module.exports = router;
