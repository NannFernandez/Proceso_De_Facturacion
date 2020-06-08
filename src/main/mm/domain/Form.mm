package domain;


form ClienteForm "Cliente Form"
    : Cliente
{
    header {
        message(entity), col 8;
        search_box, col 4, style "pull-right";
    };
    "Id"                  : id, internal, optional;
    "Tipo de documento"   : tipoDeDocumento;
    "Numero de documento" : numeroDeDocumento, mask decimal;
    "Nombre"              : nombre;
    "Fecha de Nacimiento" : fechaDeNacimiento, combo_date_box ;
    footer {
        button(save);
        button(cancel);
        button(delete), style "pull-right";
    };
}


form MedioDePagoForm "Medio De Pago Form"
    : MedioDePago
{
    header {
        message(entity), col 8;
        search_box, col 4, style "pull-right";
    };
    "Id"                 : id, internal, optional;
    "Descripcion"        : descripcion;
    "Soporta o no Cuota" : soportaCuota;
    footer {
        button(save);
        button(cancel);
        button(delete), style "pull-right";
    };
}


form ProductoForm "Producto Form"
    : Producto
{
    header {
        message(entity), col 8;
        search_box, col 4, style "pull-right";
    };
    "Id"          : id, internal, optional;
    "Descripcion" : descripcion;
    "Precio"      : precio, mask decimal;
    footer {
        button(save);
        button(cancel);
        button(delete), style "pull-right";
    };
}

form VentaForm "Venta Form"
    : Venta
{
    header {
        message(entity), col 8;
        search_box, col 4, style "pull-right";
    };
    "Id"                 : id, internal, optional;
    "Fecha"              : fecha;
    "Cliente"            : cliente;
    "Producto"      : ventaProductos, table {
                        "Producto"         : productoVenta, on_change calcularPrecioFinal;
                        "cantidad"         : cantidad, mask decimal, optional , on_change calcularPrecioFinal;
        precioUnitario  "Precio Unitario"  : Int, display, optional;
                        "Precio Final"     : precioFinal,display, mask decimal, on_change totalDeVenta;

    };

    horizontal, style "margin-top-20" {
        button(add_row, ventaProductos), style "margin-right-5";
        //button(remove_row, ventaProductos);
        "Borrar"       : button, on_click borrarFila;
    };

    "Precio Total Venta" : precioTotal, display,mask decimal,on_change calcularMontoCuotas ;

    "Medio De Pago"      : medioDePago, combo_box, on_change setearSoportaCuotas;
    soportaCuotas: Boolean, internal;
    "Cantidad de cuotas" : cantidadDeCuotas, mask decimal, optional when !soportaCuotas,hide when !soportaCuotas, on_change calcularMontoCuotas;
    "Monto cuotas"       : montoCuota, display, optional when !soportaCuotas, hide when !soportaCuotas, mask decimal;
    footer {
        "Guardar"       : button(validate), on_click guardarVenta;
        button(cancel);
        button(delete), style "pull-right";
    };
}


form VentaListing "Venta Listing"

{
    header {
        message(title), col 12;
    };
    ventas    : Venta, table, on_change saveVenta, on_load loadVentas, sortable {
        "Numero"             : id, display, style "pull-left", column_style "none";
        "Fecha"              : fecha,display;
        "Cliente"            : cliente, display;
        //"Producto"           : ventaProductos, table;
        //"Medio De Pago"      : medioDePago;
        //"Cantidad de cuotas" : cantidadDeCuotas, mask decimal, optional;
        "Precio Total"       : precioTotal, display,mask decimal, optional, style "pull-left", column_style "none";
    };


    horizontal, style "margin-top-20" {
        fechaDesde "Fecha Desde" : Date,optional;
        fechaHasta "Fecha Hasta" : Date, optional;
        clienteFiltro "Cliente"     : Cliente, optional;
        //button(add_row, ventas), disable when forbidden(create), style "margin-right-5";
        //button(remove_row, ventas), disable when forbidden(delete), on_click removeVenta;
    };

    horizontal, style "margin-top-20" {
        "Filtrar"       : button, on_click filtrarTabla;
        botonExportar "Exportar"    : button(export), icon file_excel_o, content_style "btn-info";
    };

}























