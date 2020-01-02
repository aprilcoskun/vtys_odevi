const router = require('express').Router();
const mssql = require('mssql');

router.get('/', async function(req, res) {
  const result = await mssql.query`select * from trainers`;

  res.render('trainers', {
    isAdmin: req.cookies['userType'] === 'trainer',
    isTrainers: true,
    trainers: result.recordset
  });
});

router.get('/searchByName/:name', async function(req, res) {
  const request = new mssql.Request()

  request.input('name', mssql.VarChar, req.params.name)

  const result = await request.query(`select * from trainers where name like '%' + @name + '%'`);

  res.render('trainers', {
    isAdmin: req.cookies['userType'] === 'trainer',
    isTrainers: true,
    trainers: result.recordset
  });
});

router.post('/', async function(req, res) {
  try {
    const { tc, password, field, name, birth_date } = req.body;
    const result = await mssql.query`insert trainers(tc, name, password, field, birth_date) values(${tc}, ${name}, ${password}, ${field}, ${birth_date})`;
    const act = `Yeni Personel Eklendi(${name})`
    if(req.cookies['userType'] === 'trainer') {
      await mssql.query`insert useractivity(trainer_tc, type) values (${req.cookies['tc']}, ${act})`
    } else {
      await mssql.query`insert useractivity(user_tc, type) values (${req.cookies['tc']}, ${act})`
    }
    res.json(result);
  } catch (error) {
    console.error(error);
    res.status(500).send(error);
  }
});

router.put('/:tc', async function(req, res) {
  try {
    const { tc } = req.params;
    const { tc: newTc, password, field, name } = req.body;
    const result = await mssql.query`update trainers set tc=${newTc}, password=${password}, field=${field}, name=${name} where tc= ${tc}`;
    const act = `Personel Bilgileri Degistirildi(${name})` 
    if(req.cookies['userType'] === 'trainer') {
      await mssql.query`insert useractivity(trainer_tc, type) values (${req.cookies['tc']}, ${act})`
    } else {
      await mssql.query`insert useractivity(user_tc, type) values (${req.cookies['tc']}, ${act})`
    }
    res.json(result);
  } catch (error) {
    console.error(error);
    res.status(500).send(error);
  }
});

router.delete('/:tc', async function(req, res) {
  try {
    const result = await mssql.query`delete from trainers where tc=${req.params.tc}`;
    res.json(result);
    const act = `Personel Silindi (tc:${req.params.tc})` 
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
