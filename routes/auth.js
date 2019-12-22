const router = require('express').Router();
const mssql = require('mssql');

router.get('/', function(req, res) {
  res.render('auth');
});

router.post('/login', async function(req, res) {
  const result = await mssql.query`select tc, password from users where tc = ${req.body.tc}`;
  if (!result.recordset[0]) {
    res.status(404).send('User not Found');
    return;
  }

  const user = result.recordset[0];
  if (user.password === req.body.password) {
    res.cookie('tc', req.body.tc);
    res.sendStatus(200);
    return;
  } else {
    res.status(401).send('Wrong Password');
    return;
  }
});

module.exports = router;
