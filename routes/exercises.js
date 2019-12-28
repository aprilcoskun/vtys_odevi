const router = require('express').Router();
const mssql = require('mssql');

router.get('/', async function(req, res) {
  const result = await mssql.query`select * from exercises`;

  res.render('exercises', {
    isAdmin: req.cookies['userType'] === 'trainer',
    isExercises: true,
    exercises: result.recordset
  });
});

module.exports = router;
