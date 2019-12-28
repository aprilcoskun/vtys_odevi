const router = require('express').Router();
const mssql = require('mssql');

router.get('/', async function(req, res) {
  const result = await mssql.query`select tc, name, birth_date, field from trainers`;

  res.render('trainers', {
    isAdmin: req.cookies['userType'] === 'trainer',
    isTrainers: true,
    trainers: result.recordset
  });
});

module.exports = router;
