-- if NeedsCreateSequence

create sequence QName(DOMAIN, VENTA_SEQ)
	start with SequenceStartValue(1)
	increment by 1 SequenceCache;;

-- end
alter  table QName(DOMAIN, CARGA_DE_VENTA)
	drop constraint CLIENTE_CARGA_DE_VENTA_FK;;

alter  table QName(DOMAIN, INNER_VENTA_MEDIOS_DE_PAGO)
	drop constraint CARGA_DE_VENTA_INNER_47B9DE_FK;;

alter  table QName(DOMAIN, INNER_VENTA_MEDIOS_DE_PAGO)
	drop constraint MEDIO_DE_PAGO_INNER__73AFB8_FK;;

alter  table QName(DOMAIN, INNER_VENTA_PRODUCTOS)
	drop constraint CARGA_DE_VENTA_INNER_240363_FK;;

drop   table QName(DOMAIN, CARGA_DE_VENTA);;

drop   table QName(DOMAIN, INNER_VENTA_MEDIOS_DE_PAGO);;

create table QName(DOMAIN, VENTA) (
	ID                                Serial(1,VENTA_SEQ) not null,
	FECHA                             date             default CurrentDate not null,
	CLIENTE_ID                        int              not null,
	MEDIO_DE_PAGO_ID                  int              not null,
	CANTIDAD_DE_CUOTAS                int,
	MONTO_CUOTA                       int,
	PRECIO_TOTAL                      int              default 0 not null,
	UPDATE_TIME                       datetime(3)      default CurrentTime not null,

	constraint PK_VENTA primary key(ID)
);;

alter  table QName(DOMAIN, CLIENTE)
	RenameColumn(TIPO, TIPO_DE_DOCUMENTO);;

alter  table QName(DOMAIN, CLIENTE)
	AlterColumnType(TIPO_DE_DOCUMENTO, nvarchar(50));;

alter  table QName(DOMAIN, CLIENTE)
	SetDefault(TIPO_DE_DOCUMENTO, 'DNI');;

alter  table QName(DOMAIN, INNER_VENTA_PRODUCTOS)
	drop constraint PK_INNER_VENTA_PRODUCTOS;;

alter  table QName(DOMAIN, INNER_VENTA_PRODUCTOS)
	RenameColumn(CARGA_DE_VENTA_ID, VENTA_ID);;

alter  table QName(DOMAIN, INNER_VENTA_PRODUCTOS)
	add constraint PK_INNER_VENTA_PRODUCTOS primary key(VENTA_ID, SEQ_ID);;

alter table QName(DOMAIN, INNER_VENTA_PRODUCTOS) add constraint VENTA_INNER_VENTA_PRODUCTOS_FK
	foreign key(VENTA_ID)
	references QName(DOMAIN, VENTA)(ID);;

alter table QName(DOMAIN, VENTA) add constraint CLIENTE_VENTA_FK
	foreign key(CLIENTE_ID)
	references QName(DOMAIN, CLIENTE)(ID);;


alter table QName(DOMAIN, VENTA) add constraint MEDIO_DE_PAGO_VENTA_FK
	foreign key(MEDIO_DE_PAGO_ID)
	references QName(DOMAIN, MEDIO_DE_PAGO)(ID);;


-- if NeedsCreateSequence

drop   sequence QName(DOMAIN, CARGA_DE_VENTA_SEQ) /* Ignore Errors */;;

-- end
