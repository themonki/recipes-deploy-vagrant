
DROP TABLE IF EXISTS users;
DROP SEQUENCE IF EXISTS users_id_seq;

CREATE SEQUENCE users_id_seq INCREMENT 1 START 1;

CREATE TABLE users (
  id integer DEFAULT NEXTVAL('users_id_seq'::TEXT) NOT NULL,
	email varchar(20)  NOT NULL,
	password varchar(1000) NOT NULL,
	estado boolean DEFAULT FALSE,
	name varchar(200),
	usersystem varchar(200)
);


ALTER TABLE users ADD CONSTRAINT PK_users
	PRIMARY KEY (id);
	
ALTER TABLE users
	ADD CONSTRAINT UQ_users_email UNIQUE (email);


