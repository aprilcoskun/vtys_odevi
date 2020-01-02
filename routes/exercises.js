const router = require('express').Router();
const mssql = require('mssql');

router.get('/', async function(req, res) {
  const result = await mssql.query`select * from exercises left join tools
	on tools.id=exercises.tool_id for json auto`;
  
  res.render('exercises', {
    isAdmin: req.cookies['userType'] === 'trainer',
    isExercises: true,
    exercises: result.recordset[0]
  });
});

router.get('/searchByName/:name', async function(req, res) {
  const request = new mssql.Request()

  request.input('name', mssql.VarChar, req.params.name)

  const result = await request.query(`select * from exercises where name like '%' + @name + '%'`);

  res.render('exercises', {
    isAdmin: req.cookies['userType'] === 'trainer',
    isExercises: true,
    exercises: result.recordset
  });
});

router.delete('/:id', async function(req, res) {
  try {
    const result = await mssql.query`delete from exercises where id=${req.params.id}`;
    res.json(result);
  } catch (error) {
    console.error(error);
    res.status(500).send(error);
  }
});

module.exports = router;
