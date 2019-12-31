const router = require('express').Router();
const mssql = require('mssql');

router.get('/', async function(req, res) {
  const result = await mssql.query`select * from calendar`;

  res.render('calendars', {
    isAdmin: req.cookies['userType'] === 'trainer',
    isExercises: true,
    calendars: result.recordset
  });
});

module.exports = router;
