const router = require('express').Router();
const mssql = require('mssql');

router.get('/', async function(req, res) {
  const result = await mssql.query`select * from exercises left join tools
	on tools.id=exercises.tool_id for json auto`;
  const result2 = await mssql.query`select * from tools`;
  
  res.render('exercises', {
    isAdmin: req.cookies['userType'] === 'trainer',
    isExercises: true,
    tools: result2.recordset,
    exercises: result.recordset[0],
  });
});

router.post('/', async function(req, res) {
  try {
    const { name, description, set_size, tool_id } = req.body;
    const result = await mssql.query`insert exercises(name, description, set_size, tool_id) values(${name}, ${description}, ${set_size}, ${tool_id})`;
    res.json(result);
  } catch (error) {
    console.error(error);
    res.status(500).send(error);
  }
});

router.put('/:id', async function(req, res) {
  try {
    const { id } = req.params;
    const { name, description, set_size } = req.body;
    const result = await mssql.query`update exercises set name=${name}, description=${description}, set_size=${set_size} where id=${id}`;
    res.json(result);
  } catch (error) {
    console.error(error);
    res.status(500).send(error);
  }
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
