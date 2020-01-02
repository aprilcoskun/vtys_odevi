const router = require('express').Router();
const mssql = require('mssql');

router.get('/', function(req, res) {
  res.render('backup', {
    isAdmin: req.cookies['userType'] === 'trainer',
    isSettings: true
  });
});

router.get('/getbackup', async function(req, res) {
  try {
    const result = await mssql.query`
      BACKUP DATABASE [gym]
      TO DISK = N'/home/gym_backup.bak'
      WITH NOFORMAT, INIT, NAME = 'gym_backup', NOREWIND`;
    res.json(result);
  } catch(err) {
    console.error(error);
    res.status(500).send(error);
  }
});

/*Yedekten geri yükleme*/
router.get('/restorebackup', async function(req, res) {
  try {
    new mssql.ConnectionPool({
      server: '134.209.251.92',
      user: 'sa',
      password: 'vtysOdevi81_',
      parseJSON: true,
      database: 'master',
      options: { encrypt: false }
    }).connect().then(pool => {
      return pool.query`exec sp_load_backup`;
    }).then(result => res.json(result));
  } catch (error) {
    console.error(error);
    res.status(500).send(error);
  }
});

module.exports = router;
