const salesService = require('../services/sales.service');

const getAllSales = async (req, res) => {
  try {

    const { fechaInicio, fechaFin } = req.query;
    let sales;

    if (fechaInicio && fechaFin) {

      const fechaInicioCompleta = `${fechaInicio} 00:00:00`;
      const fechaFinCompleta = `${fechaFin} 23:59:59`;

      sales = await salesService.getSalesDatesService(
        fechaInicioCompleta,
        fechaFinCompleta
      );

    } else {
      sales = await salesService.getSalesService();
    }

    res.render('ventas/ventas', {
      sales,
      errorMessage: null,
      fechaInicio,
      fechaFin
    });

  } catch (error) {

    console.error(error);

    res.render('ventas/ventas', {
      sales: [],
      errorMessage: "Ocurrió un error al cargar las ventas."
    });
  }
};

const getSalePreview = async (req, res) => {
  try {
    const { id } = req.params;

    const sale = await salesService.getSaleByIDService(id);

    if (!sale) {
      return res.render('ventas/preview', {
        sale: null,
        errorMessage: "Venta no encontrada."
      });
    }

    res.render('ventas/preview', {
      sale,
      errorMessage: null
    });

  } catch (error) {
    console.error(error);

    res.render('ventas/preview', {
      sale: null,
      errorMessage: "Ocurrió un error al cargar la venta."
    });
  }
};

module.exports = {
  getAllSales,
  getSalePreview
};