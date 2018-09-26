create table hibernate_sequence (
    next_val    bigint
);

insert into hibernate_sequence values ( 100 );

create table users (
    id          integer primary key,
    first_name  varchar(255),
    last_name   varchar(255),
    email       varchar(255),
    enabled     boolean not null default true
);

insert into users values (1, 'John', 'Doe', 'jdoe1@localhost', true);
insert into users values (2, 'Jane', 'Doe', 'jdoe2@localhost', true);
