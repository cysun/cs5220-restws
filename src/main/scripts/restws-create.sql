-- set minvalue to 1000 so thd id's generated from this sequence won't
-- conflict with the id's of the existing records.
create sequence hibernate_sequence minvalue 1000;

create table users (
    id          integer primary key,
    first_name  varchar(255),
    last_name   varchar(255),
    email       varchar(255)
);

insert into users values (1, 'John', 'Doe', 'jdoe1@localhost');
insert into users values (2, 'Jane', 'Doe', 'jdoe2@localhost');
