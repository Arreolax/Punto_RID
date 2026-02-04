const inventarioService = require('../services/inventario.service');

function index(req, res) {
  const filters = {
    search: req.query.search || '',
    category: req.query.category || 'Todos',
    status: req.query.status || 'Todos',
    sortBy: req.query.sortBy || '?ltima actualizaci?n'
  };

  const products = inventarioService.listProducts(filters);
  const metrics = inventarioService.getMetrics();
  const movements = inventarioService.listMovements();
  const clients = inventarioService.listClients();
  const sales = inventarioService.listSales();

  let editProduct = null;
  if (req.query.editId) {
    editProduct = inventarioService.getProductById(req.query.editId);
  }

  res.render('inventario/index', {
    filters,
    metrics,
    products,
    movements,
    clients,
    sales,
    editProduct
  });
}

function create(req, res) {
  // TODO: replace with DB insert.
  inventarioService.createProduct(req.body);
  res.redirect('/inventario');
}

function update(req, res) {
  // TODO: replace with DB update.
  inventarioService.updateProduct(req.params.id, req.body);
  res.redirect('/inventario?editId=' + req.params.id);
}

module.exports = {
  index,
  create,
  update
};
