-- Run this file as a superuser connected to the default database
create schema if not exists sandbox;
create schema if not exists flood;
set search_path = flood, sandbox;