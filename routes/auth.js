const router = require('express').Router();
const mssql = require('mssql');

router.get('/', function(req, res) {
  res.render('auth', { layout: false });
});

router.post('/login', async function(req, res) {
  let result = await mssql.query`select tc, password from users where tc = ${req.body.tc}`;
  let userType = 'custumer';
  if (!result.recordset[0]) {
    result = await mssql.query`select tc, password from trainers where tc = ${req.body.tc}`;
    userType = 'trainer';
  }
  
  if (!result.recordset[0] && req.body.tc === 'admin' && req.body.password === 'admin') {
    res.cookie('tc', req.body.tc);
    res.cookie('userType', userType);
    res.sendStatus(200);
   } else if (!result.recordset[0]) {
    res.status(404).send('User not Found');
    return;
  }

  const user = result.recordset[0];
  if (user.password === req.body.password) {
    res.cookie('tc', req.body.tc);
    res.cookie('userType', userType);
    res.sendStatus(200);
    return;
  } else {
    res.status(401).send('Wrong Password');
    return;
  }
});

module.exports = router;
