const expressLayouts = require('express-ejs-layouts');
const express = require('express');
const path = require('path');

const app = express();

//Que entre en la carpeta views y lea archivos .ejs
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

//Layout
app.use(expressLayouts);
app.use(express.static(path.join(__dirname, 'public')));

//
app.use((req, res, next) => {
  res.locals.path = req.path;
  next();
});

//rutas
app.use(require('./routes'));

//donde corre
app.listen(3000, () => {
    console.log('Localhost:3000');
})