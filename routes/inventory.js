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

router.get('/searchByName/:name', async function(req, res) {
  const request = new mssql.Request()

  request.input('name', mssql.VarChar, req.params.name)

  const result = await request.query(`select * from tools where name like '%' + @name + '%'`);
  console.log(result.recordset);
  
  res.render('inventory', {
    isAdmin: req.cookies['userType'] === 'trainer',
    isInventory: true,
    tools: result.recordset
  });
});

router.post('/', async function(req, res) {
  try {
    const { name, usage_time } = req.body;
    const result = await mssql.query`insert tools (name, usage_time) values (${name}, ${usage_time})`;
    res.json(result);
    const act = `Envantere Yeni Eşya eklendi(${name})` 
    if(req.cookies['userType'] === 'trainer') {
      await mssql.query`insert useractivity(trainer_tc, type) values (${req.cookies['tc']}, ${act})`
    } else {
      await mssql.query`insert useractivity(user_tc, type) values (${req.cookies['tc']}, ${act})`
    }
  } catch (error) {
    console.error(error);
    res.status(500).send(error);
  }
});


router.post('/import', async function(req, res) {
  try {
    let queryString = '';
    req.body.tools.forEach((t, i) => {
      if(req.body.tools.length > (i+1)) {
        queryString += `('${t.name}', '${t.usage_time}'),`
      } else {
        queryString += `('${t.name}', '${t.usage_time}')`
      }
    })
    const request = new mssql.Request()
    const result = await request.query(`insert tools (name, usage_time) values  ${queryString}`);
    res.json(result);
  } catch (error) {
    console.error(error);
    res.status(500).send(error);
  }
});


router.delete('/:id', async function(req, res) {
  try {
    const result = await mssql.query`delete from tools where id=${req.params.id}`;
    res.json(result);
    const act = `Envanterden Eşya Silindi` 
    if(req.cookies['userType'] === 'trainer') {
      await mssql.query`insert useractivity(trainer_tc, type) values (${req.cookies['tc']}, ${act})`
    } else {
      await mssql.query`insert useractivity(user_tc, type) values (${req.cookies['tc']}, ${act})`
    }
  } catch (error) {
    console.error(error);
    res.status(500).send(error);
  }
});

module.exports = router;
