package domain;

import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;
import tekgenesis.form.Action;

/** User class for form: VentaForm */
public class VentaForm extends VentaFormBase

{

    @Override
    public void load() {
        setMedioDePagoOptions(MedioDePago.listAll());
    }

    public Action methodForTotalDeVenta() {
        int result = 0;
        for (VentaProductosRow ventaProductosRow : getVentaProductos()){
            result += ventaProductosRow.getPrecioFinal();
        }

        setPrecioTotal(result);
        return actions.getDefault();
    }

    public Action setearSoportaCuotas() {
        if(isDefined(Field.MEDIO_DE_PAGO)) {
            setSoportaCuotas(getMedioDePago().isSoportaCuota());
        }
        return actions.getDefault();
    }

    public Action calcularMontoCuotas (){
        if ( isDefined(Field.MEDIO_DE_PAGO) && isDefined(Field.CANTIDAD_DE_CUOTAS) && isDefined(Field.PRECIO_TOTAL) && getCantidadDeCuotas() > 0) {
            setMontoCuota(getPrecioTotal()/ getCantidadDeCuotas());
        }
        return actions.getDefault();
    }

    public Action borrarFila() {
        if(!getVentaProductos().isEmpty()) {
            int indiceUltimaFila = getVentaProductos().size() - 1;
            getVentaProductos().remove(indiceUltimaFila);
            methodForTotalDeVenta();
        }
        return actions.getDefault();
    }

    public Action guardarVenta() {
        create();
        return actions.navigate(VentaListing.class).withMessage("Venta " + keyAsString()+ " guardada!");
    }

    //~ Inner Classes ............................................................................................................

    public class VentaProductosRow extends VentaProductosRowBase
    {
        //~ Methods ..................................................................................................................

        /** 
         * Invoked when suggest_box(productoVenta) value changes
         * Invoked when text_field(cantidad) value changes
         */
        @Override
        @NotNull

        public Action calcularPrecioFinal() {
            if(isDefined(Field.PRODUCTO_VENTA)) {
                setPrecioUnitario(getProductoVenta().getPrecio());
                if(isDefined(Field.CANTIDAD)) {
                    setPrecioFinal(getProductoVenta().getPrecio()*getCantidad());
                } else {
                    setPrecioFinal(0);
                    methodForTotalDeVenta();
                }
            }

            return actions.getDefault();
        }

         @NotNull
        @Override
        public Action totalDeVenta() {
            methodForTotalDeVenta();
            return actions.getDefault();
        }


    }
}
