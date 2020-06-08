-- SQL for Schema DOMAIN --

-- if NeedsCreateSequence

create sequence QName(DOMAIN, CLIENTE_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

create sequence QName(DOMAIN, MEDIO_DE_PAGO_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

create sequence QName(DOMAIN, PRODUCTO_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

create sequence QName(DOMAIN, VENTA_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

-- end

create table QName(DOMAIN, CLIENTE) (
	ID                                Serial(1,CLIENTE_SEQ)                     not null,
	TIPO_DE_DOCUMENTO                 nvarchar(50)     default 'DNI'            not null,
	NUMERO_DE_DOCUMENTO               int              default 0                not null,
	NOMBRE                            nvarchar(255)    default EmptyString      not null,
	FECHA_DE_NACIMIENTO               date             default CurrentDate      not null,
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_CLIENTE             primary key (ID)
);;

create table QName(DOMAIN, INNER_VENTA_PRODUCTOS) (
	VENTA_ID                          int                                       not null,
	SEQ_ID                            int              default 0                not null,
	PRODUCTO_VENTA_ID                 int                                       not null,
	CANTIDAD                          int              default 0                not null,
	PRECIO_FINAL                      int              default 0                not null,
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_INNER_VENTA_PRODUCTOS primary key (VENTA_ID,SEQ_ID)
);;

create table QName(DOMAIN, MEDIO_DE_PAGO) (
	ID                                Serial(1,MEDIO_DE_PAGO_SEQ)               not null,
	DESCRIPCION                       nvarchar(255)    default EmptyString      not null,
	SOPORTA_CUOTA                     boolean          default False CheckBoolConstraint(MEDIO_DE_PAGO_SOPORTA_CUOTA_B, SOPORTA_CUOTA) not null,
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_MEDIO_DE_PAGO       primary key (ID)
);;

create table QName(DOMAIN, PRODUCTO) (
	ID                                Serial(1,PRODUCTO_SEQ)                    not null,
	DESCRIPCION                       nvarchar(255)    default EmptyString      not null,
	PRECIO                            int              default 0                not null,
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_PRODUCTO            primary key (ID)
);;

create table QName(DOMAIN, VENTA) (
	ID                                Serial(1,VENTA_SEQ)                       not null,
	FECHA                             date             default CurrentDate      not null,
	CLIENTE_ID                        int                                       not null,
	MEDIO_DE_PAGO_ID                  int                                       not null,
	CANTIDAD_DE_CUOTAS                int,
	MONTO_CUOTA                       int,
	PRECIO_TOTAL                      int              default 0                not null,
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_VENTA               primary key (ID)
);;

create table QName(DOMAIN, _METADATA) (
	VERSION                           nvarchar(24)                              not null,
	SHA                               nvarchar(128)                             not null,
	SHA_OVL                           nvarchar(128),
	UPDATE_TIME                       datetime(0),
	SCHEMA                            clob,
	OVERLAY                           clob,

	constraint PK_METADATA            primary key (VERSION)
);;

alter table QName(DOMAIN, INNER_VENTA_PRODUCTOS) add constraint VENTA_INNER_VENTA_PRODUCTOS_FK
	foreign key (VENTA_ID)
	references QName(DOMAIN, VENTA) (ID);;

alter table QName(DOMAIN, INNER_VENTA_PRODUCTOS) add constraint PRODUCTO_VENTA_INNER_53BB1E_FK
	foreign key (PRODUCTO_VENTA_ID)
	references QName(DOMAIN, PRODUCTO) (ID);;

alter table QName(DOMAIN, VENTA) add constraint CLIENTE_VENTA_FK
	foreign key (CLIENTE_ID)
	references QName(DOMAIN, CLIENTE) (ID);;

alter table QName(DOMAIN, VENTA) add constraint MEDIO_DE_PAGO_VENTA_FK
	foreign key (MEDIO_DE_PAGO_ID)
	references QName(DOMAIN, MEDIO_DE_PAGO) (ID);;

-- if NeedsSerialComment
comment on column QName(DOMAIN,CLIENTE).ID                 is 'Serial(1,CLIENTE_SEQ)';;
comment on column QName(DOMAIN,MEDIO_DE_PAGO).ID           is 'Serial(1,MEDIO_DE_PAGO_SEQ)';;
comment on column QName(DOMAIN,PRODUCTO).ID                is 'Serial(1,PRODUCTO_SEQ)';;
comment on column QName(DOMAIN,VENTA).ID                   is 'Serial(1,VENTA_SEQ)';;
-- end

