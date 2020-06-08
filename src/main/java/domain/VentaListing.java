package domain;


import domain.g.VentaTable;
import tekgenesis.common.collections.ImmutableList;
import tekgenesis.common.collections.Seq;
import tekgenesis.common.core.DateOnly;
import tekgenesis.form.Action;
import tekgenesis.form.FormTable;
import tekgenesis.persistence.Criteria;
import tekgenesis.persistence.Select;

/** User class for form: VentaListing */
public class VentaListing extends VentaListingBase
{

    public Action filtrarTabla() {
        Criteria criteria = Criteria.EMPTY;
        if(isDefined(Field.FECHA_DESDE)) criteria = criteria.and(VentaTable.VENTA.FECHA.ge(getFechaDesde()));
        if(isDefined(Field.FECHA_HASTA)) criteria = criteria.and(VentaTable.VENTA.FECHA.le(getFechaHasta()));
        if(isDefined(Field.CLIENTE_FILTRO)) criteria = criteria.and(VentaTable.VENTA.CLIENTE_ID.eq(getClienteFiltro().getId()));
        Select<Venta> list = Venta.listWhere(criteria);
        popularTabla(list);
        return actions.getDefault();
    }

    public Action popularTabla(Select<Venta> ventasFiltradas) {
        FormTable<VentasRow> ventasTable = getVentas();
        ventasTable.clear();
        for (Venta venta : ventasFiltradas.list()){
            VentasRow row = ventasTable.add();
            row.populate(venta);
        }
        return actions.getDefault();
    }



   /* Criteria criteria = Criteria.EMPTY;
    if(isDefined(Field.FECHA_DESDE))
    criteria = criteria.and(VentaTable.VENTA.VENTA_DATE.ge(getFechaDesde()));
    Select<Venta>list = Venta.list().where(criteria);*/




    /*public Action filtrarTabla() {
        Seq<Venta> ventasFiltradas = Venta.listAll().filter(venta -> cumpleFechaDesde(venta) && cumpleFechaHasta(venta) && cumpleCliente(venta.getCliente()) );
         FormTable<VentasRow> ventasTable = getVentas();
        ventasTable.clear();
        for (Venta venta : ventasFiltradas){
            VentasRow row = ventasTable.add();
            row.populate(venta);
        }
        return actions.getDefault();
    }

    public boolean cumpleFechaDesde(Venta venta) {
        if (isDefined(Field.FECHA_DESDE)) {
            return venta.getFecha().isGreaterThan(getFechaDesde());
        }
        else { return true;}
    };

    public boolean cumpleFechaHasta(Venta venta) {
        if (isDefined(Field.FECHA_HASTA)) {
            return venta.getFecha().isLessThan(getFechaHasta());
        }
        else { return true;}
    };

    public boolean cumpleCliente(Cliente cliente) {
        if (isDefined(Field.CLIENTE_FILTRO)){
            return getClienteFiltro() == cliente;
        }
        else { return true;}
    };*/

    //~ Inner Classes ............................................................................................................

    public class VentasRow  extends VentasRowBase
    {

    }
}
