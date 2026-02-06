const expressLayouts = require('express-ejs-layouts');
const express = require('express');
const path = require('path');
require('dotenv').config();

const app = express();

//Que entre en la carpeta views y lea archivos .ejs
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

//Layouts
app.use(expressLayouts);
app.use(express.static(path.join(__dirname, 'public')));


//Middleware global
app.use((req, res, next) => {
  res.locals.path = req.path;
  next();
});

//rutas
app.use('/', require('./routes/routes'));
app.use('/tickets', require('./routes/tickets.routes'));

//Puerto Servidor
app.listen(process.env.SERVER_PORT, () => {
    console.log('Localhost:3000');
})

//404
app.use((req, res) => {
  res.status(404).render('404');
});
