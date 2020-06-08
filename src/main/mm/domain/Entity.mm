package domain;

entity Cliente
    described_by nombre
    searchable
{

tipoDeDocumento      "Tipo de Documento"    :Documento;
numeroDeDocumento    "Numero de documento"  :Int;
nombre               "Nombre"               :String;
fechaDeNacimiento    "Fecha de Nacimiento"  :Date;

}

enum Documento {

    DNI                     :"DNI";
    PASAPORTE               :"Pasaporte";
    PARTIDADENACIMIENTO     : "Partida de Nacimiento";
    CEDULA                  : "Cédula de Identidad";
}


entity MedioDePago
    described_by descripcion
    searchable
{

descripcion  "Descripcion"          :String;
soportaCuota "Soporta o no Cuota"   :Boolean;

}



entity Producto
    described_by descripcion
    searchable
{

descripcion "Descripcion"  :String;
precio      "Precio"       :Int;

}

entity Venta
    described_by fecha
    searchable

{

fecha           "Fecha"          :Date;
cliente         "Cliente"        :Cliente;
ventaProductos   "Producto"       :entity InnerVentaProductos*{

                             productoVenta      "Producto"      :Producto;
                             cantidad           "cantidad"      :Int;
                             precioFinal        "Precio Final"  :Int;

                             };
medioDePago  "Medio De Pago"           : MedioDePago;
cantidadDeCuotas "Cantidad de cuotas"  :Int, optional ;
montoCuota       "Monto cuotas"        :Int, optional ;
precioTotal       "Precio Total"       :Int;
}





