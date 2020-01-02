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

router.get('/searchByName/:name', async function(req, res) {
  const request = new mssql.Request()

  request.input('name', mssql.VarChar, req.params.name)

  const result = await request.query(`select * from users where name like '%' + @name + '%'`);

  res.render('users', {
    isAdmin: req.cookies['userType'] === 'trainer',
    isUsers: true,
    users: result.recordset
  });
});

router.get('/profile', async function(req, res) {
  const result = await mssql.query`select * from users where tc=${req.cookies.tc}`;

  res.render('profile', {
    isAdmin: req.cookies['userType'] === 'trainer',
    isUsers: true,
    user: result.recordset[0]
  });
});

router.post('/', async function(req, res) {
  try {
    const {
      tc,
      password,
      gender,
      name,
      birth_date,
      phone,
      user_height,
      user_weight
    } = req.body;
    const query = new mssql.Request().input('tc', tc)
    .input('password', password)
    .input('gender', gender)
    .input('birth_date', birth_date)
    .input('phone', phone)
    .input('name', name)
    .input('user_heigth', user_height)
    .input('user_weight', user_weight)
    .input('other_measurements', '')
    const exec = await query.execute('sp_insert_users');
    if(exec.returnValue === 0) throw new Error('returned 0');
    const act = `Yeni Kullanıcı Eklendi(${name})` 
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
    const {
      tc: newTc,
      password,
      gender,
      name,
      phone,
      user_height,
      user_weight
    } = req.body;
    let result;
    if(password) {
      result = await mssql.query`update users set tc=${newTc}, gender=${gender}, password=${password}, name=${name}, phone=${phone}, user_height=${user_height}, user_weight=${user_weight} where tc=${tc}`;
    } else {
    result = await mssql.query`update users set tc=${newTc}, gender=${gender}, name=${name}, phone=${phone}, user_height=${user_height}, user_weight=${user_weight} where tc=${tc}`;
    }
    const act = `Kullanıcı Bilgileri Degistirildi(${name})` 
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
    const result = await mssql.query`delete from users where tc=${req.params.tc}`;
    const act = `Kullanıcı Silindi (tc:${req.params.tc})` 
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

module.exports = router;
