-- liquibase formatted sql

-- changeset activity.cicd:a2.1
create table person_cicd2 (
    id int primary key,
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar(50),
    city varchar(30)
)

-- changeset activity.cicd:a2.2
create table company_cicd2 (
    id int primary key,
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar(50),
    city varchar(30)
)

