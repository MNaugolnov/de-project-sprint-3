-- однократные действия в dbeaver
alter table	staging.user_order_log add column status varchar(15) not null default 'shipped';
alter table	mart.f_sales add column status varchar(15) not null default 'shipped';
