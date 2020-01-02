const router = require('express').Router();
const mssql = require('mssql');

router.get('/', async function(req, res) {
  const result = await mssql.query`exec sp_load_backup`;
  console.log(result.recordset);
  
  res.render('index', { isAdmin: req.cookies['userType'] === 'trainer'});
});

module.exports = router;
