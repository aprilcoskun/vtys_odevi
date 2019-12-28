const router = require('express').Router();
const mssql = require('mssql');

router.get('/', async function(req, res) {
  const result = await mssql.query`select * from tools`;

  res.render('inventory', {
    isAdmin: req.cookies['userType'] === 'trainer',
    isInventory: true,
    tools: result.recordset
  });
});

module.exports = router;
