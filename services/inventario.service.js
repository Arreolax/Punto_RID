// In-memory data store (TEMP). TODO: replace with DB queries.
let _nextId = 1005;

const products = [
  {
    id: 1001,
    sku: 'RW-4581',
    name: 'Rueda Poliuretano 4"',
    category: 'Ruedas',
    stock: 128,
    minStock: 30,
    cost: 280,
    price: 420,
    status: 'Activo',
    supplier: 'PoliTrade',
    location: 'Pasillo A / Rack 4',
    updatedAt: new Date(Date.now() - 5 * 60 * 1000)
  },
  {
    id: 1002,
    sku: 'RD-2190',
    name: 'Rodamiento 6205 ZZ',
    category: 'Rodamientos',
    stock: 34,
    minStock: 40,
    cost: 95,
    price: 185,
    status: 'Activo',
    supplier: 'Rodamax',
    location: 'Pasillo B / Rack 2',
    updatedAt: new Date(Date.now() - 12 * 60 * 1000)
  },
  {
    id: 1003,
    sku: 'AC-7732',
    name: 'Freno giratorio 5"',
    category: 'Accesorios',
    stock: 212,
    minStock: 50,
    cost: 45,
    price: 95,
    status: 'Activo',
    supplier: 'BrakePro',
    location: 'Pasillo C / Rack 1',
    updatedAt: new Date(Date.now() - 25 * 60 * 1000)
  },
  {
    id: 1004,
    sku: 'RW-3329',
    name: 'Rueda Nylon 6"',
    category: 'Ruedas',
    stock: 12,
    minStock: 25,
    cost: 340,
    price: 510,
    status: 'Activo',
    supplier: 'Nylonix',
    location: 'Pasillo A / Rack 2',
    updatedAt: new Date(Date.now() - 60 * 60 * 1000)
  }
];

const movements = [
  {
    id: 9001,
    date: new Date(Date.now() - 60 * 60 * 1000),
    type: 'Entrada',
    product: 'Rueda Poliuretano 4"',
    qty: 60,
    owner: 'A. Rodr?guez',
    ref: 'PO-8821'
  },
  {
    id: 9002,
    date: new Date(Date.now() - 2 * 60 * 60 * 1000),
    type: 'Salida',
    product: 'Rodamiento 6205 ZZ',
    qty: -12,
    owner: 'M. Casta?eda',
    ref: 'VTA-3341'
  },
  {
    id: 9003,
    date: new Date(Date.now() - 26 * 60 * 60 * 1000),
    type: 'Ajuste',
    product: 'Rueda Nylon 6"',
    qty: -3,
    owner: 'L. Moreno',
    ref: 'AJ-1021'
  }
];

const clients = [
  { id: 5001, name: 'Constructora Delta', lastPurchase: '28/01/2026', total: 12400 },
  { id: 5002, name: 'Log?stica Sierra', lastPurchase: '27/01/2026', total: 3900 },
  { id: 5003, name: 'Hospital Regional', lastPurchase: '26/01/2026', total: 8200 }
];

const sales = [
  { id: 7001, invoice: 'F-12940', detail: 'Rueda Poliuretano 4" (x20)', amount: 8400, time: 'Hoy 09:10' },
  { id: 7002, invoice: 'F-12939', detail: 'Rodamiento 6205 ZZ (x12)', amount: 2220, time: 'Hoy 08:05' },
  { id: 7003, invoice: 'F-12938', detail: 'Freno giratorio 5" (x40)', amount: 3800, time: 'Ayer 18:40' }
];

function _matchesSearch(p, search) {
  if (!search) return true;
  const q = search.toLowerCase();
  return (
    p.sku.toLowerCase().includes(q) ||
    p.name.toLowerCase().includes(q) ||
    (p.supplier || '').toLowerCase().includes(q)
  );
}

function _matchesCategory(p, category) {
  return !category || category === 'Todos' || p.category === category;
}

function _matchesStatus(p, status) {
  if (!status || status === 'Todos') return true;
  if (status === 'Bajo stock') return p.stock <= p.minStock;
  return p.status === status;
}

function _sortProducts(list, sortBy) {
  const items = [...list];
  switch (sortBy) {
    case 'Nombre (A-Z)':
      return items.sort((a, b) => a.name.localeCompare(b.name));
    case 'Stock (mayor a menor)':
      return items.sort((a, b) => b.stock - a.stock);
    case 'Precio (mayor a menor)':
      return items.sort((a, b) => b.price - a.price);
    case '?ltima actualizaci?n':
    default:
      return items.sort((a, b) => b.updatedAt - a.updatedAt);
  }
}

function listProducts(filters = {}) {
  const { search, category, status, sortBy } = filters;
  const filtered = products.filter((p) => (
    _matchesSearch(p, search) && _matchesCategory(p, category) && _matchesStatus(p, status)
  ));
  return _sortProducts(filtered, sortBy);
}

function getProductById(id) {
  return products.find((p) => p.id === Number(id));
}

function createProduct(payload) {
  const now = new Date();
  const product = {
    id: _nextId++,
    sku: payload.sku?.trim() || '',
    name: payload.name?.trim() || '',
    category: payload.category || 'Ruedas',
    stock: Number(payload.stock || 0),
    minStock: Number(payload.minStock || 0),
    cost: Number(payload.cost || 0),
    price: Number(payload.price || 0),
    status: payload.status || 'Activo',
    supplier: payload.supplier?.trim() || '',
    location: payload.location?.trim() || '',
    updatedAt: now
  };

  products.push(product);
  movements.unshift({
    id: Date.now(),
    date: now,
    type: 'Entrada',
    product: product.name,
    qty: product.stock,
    owner: 'Sistema',
    ref: 'ALTA'
  });

  return product;
}

function updateProduct(id, payload) {
  const product = getProductById(id);
  if (!product) return null;

  const prevStock = product.stock;

  product.sku = payload.sku?.trim() || product.sku;
  product.name = payload.name?.trim() || product.name;
  product.category = payload.category || product.category;
  product.stock = Number(payload.stock ?? product.stock);
  product.minStock = Number(payload.minStock ?? product.minStock);
  product.cost = Number(payload.cost ?? product.cost);
  product.price = Number(payload.price ?? product.price);
  product.status = payload.status || product.status;
  product.supplier = payload.supplier?.trim() || product.supplier;
  product.location = payload.location?.trim() || product.location;
  product.updatedAt = new Date();

  const diff = product.stock - prevStock;
  if (diff !== 0) {
    movements.unshift({
      id: Date.now(),
      date: new Date(),
      type: diff > 0 ? 'Entrada' : 'Salida',
      product: product.name,
      qty: diff,
      owner: 'Sistema',
      ref: 'AJUSTE'
    });
  }

  return product;
}

function listMovements() {
  return movements;
}

function listClients() {
  return clients;
}

function listSales() {
  return sales;
}

function getMetrics() {
  const activeCount = products.filter((p) => p.status === 'Activo').length;
  const lowStock = products.filter((p) => p.stock <= p.minStock).length;
  const totalValue = products.reduce((acc, p) => acc + (p.cost * p.stock), 0);
  const todayMovements = movements.filter((m) => {
    const d = m.date;
    const today = new Date();
    return d.toDateString() === today.toDateString();
  }).length;

  return { activeCount, lowStock, totalValue, todayMovements };
}

module.exports = {
  listProducts,
  getProductById,
  createProduct,
  updateProduct,
  listMovements,
  listClients,
  listSales,
  getMetrics
};
