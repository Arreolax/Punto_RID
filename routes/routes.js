const express = require('express');
const router = express.Router();

//Layouts pora especificas paginas (test)
router.use((req, res, next) => {

  if (req.path.startsWith('/login') || req.path.startsWith('/register') ) {
    res.locals.layout = 'layouts/auth';
  } else {
    res.locals.layout = 'layouts/header-menu';
  }

  next();
});

router.get('/', (req, res) => {
  res.render('index');
});

module.exports = router;
