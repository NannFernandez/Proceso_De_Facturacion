-- SQL for Schema DOMAIN --

-- if NeedsCreateSequence

create sequence QName(DOMAIN, CARGA_DE_VENTA_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

create sequence QName(DOMAIN, CLIENTE_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

create sequence QName(DOMAIN, MEDIO_DE_PAGO_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

create sequence QName(DOMAIN, PRODUCTO_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

-- end

create table QName(DOMAIN, CARGA_DE_VENTA) (
	ID                                Serial(1,CARGA_DE_VENTA_SEQ)              not null,
	FECHA                             date             default CurrentDate      not null,
	CLIENTE_ID                        int                                       not null,
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_CARGA_DE_VENTA      primary key (ID)
);;

create table QName(DOMAIN, CLIENTE) (
	ID                                Serial(1,CLIENTE_SEQ)                     not null,
	TIPO                              nvarchar(255)    default EmptyString      not null,
	NUMERO_DE_DOCUMENTO               int              default 0                not null,
	NOMBRE                            nvarchar(255)    default EmptyString      not null,
	FECHA_DE_NACIMIENTO               date             default CurrentDate      not null,
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_CLIENTE             primary key (ID)
);;

create table QName(DOMAIN, INNER_VENTA_MEDIOS_DE_PAGO) (
	CARGA_DE_VENTA_ID                 int                                       not null,
	SEQ_ID                            int              default 0                not null,
	MEDIO_DE_PAGO_ID                  int                                       not null,
	CANTIDAD_DE_CUOTAS                int              default 0                not null,
	MONTO_CUOTA                       int              default 0                not null,
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_INNER_VENTA_MEDIOS_DE_PAGO primary key (CARGA_DE_VENTA_ID,SEQ_ID)
);;

create table QName(DOMAIN, INNER_VENTA_PRODUCTOS) (
	CARGA_DE_VENTA_ID                 int                                       not null,
	SEQ_ID                            int              default 0                not null,
	PRODUCTO_VENTA_ID                 int                                       not null,
	CANTIDAD                          int              default 0                not null,
	PRECIO_FINAL                      int              default 0                not null,
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_INNER_VENTA_PRODUCTOS primary key (CARGA_DE_VENTA_ID,SEQ_ID)
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

create table QName(DOMAIN, _METADATA) (
	VERSION                           nvarchar(24)                              not null,
	SHA                               nvarchar(128)                             not null,
	SHA_OVL                           nvarchar(128),
	UPDATE_TIME                       datetime(0),
	SCHEMA                            clob,
	OVERLAY                           clob,

	constraint PK_METADATA            primary key (VERSION)
);;

alter table QName(DOMAIN, CARGA_DE_VENTA) add constraint CLIENTE_CARGA_DE_VENTA_FK
	foreign key (CLIENTE_ID)
	references QName(DOMAIN, CLIENTE) (ID);;

alter table QName(DOMAIN, INNER_VENTA_MEDIOS_DE_PAGO) add constraint CARGA_DE_VENTA_INNER_47B9DE_FK
	foreign key (CARGA_DE_VENTA_ID)
	references QName(DOMAIN, CARGA_DE_VENTA) (ID);;

alter table QName(DOMAIN, INNER_VENTA_MEDIOS_DE_PAGO) add constraint MEDIO_DE_PAGO_INNER__73AFB8_FK
	foreign key (MEDIO_DE_PAGO_ID)
	references QName(DOMAIN, MEDIO_DE_PAGO) (ID);;

alter table QName(DOMAIN, INNER_VENTA_PRODUCTOS) add constraint CARGA_DE_VENTA_INNER_240363_FK
	foreign key (CARGA_DE_VENTA_ID)
	references QName(DOMAIN, CARGA_DE_VENTA) (ID);;

alter table QName(DOMAIN, INNER_VENTA_PRODUCTOS) add constraint PRODUCTO_VENTA_INNER_53BB1E_FK
	foreign key (PRODUCTO_VENTA_ID)
	references QName(DOMAIN, PRODUCTO) (ID);;

-- if NeedsSerialComment
comment on column QName(DOMAIN,CARGA_DE_VENTA).ID          is 'Serial(1,CARGA_DE_VENTA_SEQ)';;
comment on column QName(DOMAIN,CLIENTE).ID                 is 'Serial(1,CLIENTE_SEQ)';;
comment on column QName(DOMAIN,MEDIO_DE_PAGO).ID           is 'Serial(1,MEDIO_DE_PAGO_SEQ)';;
comment on column QName(DOMAIN,PRODUCTO).ID                is 'Serial(1,PRODUCTO_SEQ)';;
-- end

