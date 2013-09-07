DROP DATABASE IF EXISTS globusdatabase;

DROP USER IF EXISTS globus;

CREATE USER fresa WITH PASSWORD 'globus';

CREATE DATABASE globusdatabase OWNER globus;
