const router = require('express').Router();
const mssql = require('mssql');

router.get('/', async function(req, res) {
  const result = await mssql.query`select * from users`;

  res.render('users', {
    isAdmin: req.cookies['userType'] === 'trainer',
    isUsers: true,
    users: result.recordset
  });
});

module.exports = router;
