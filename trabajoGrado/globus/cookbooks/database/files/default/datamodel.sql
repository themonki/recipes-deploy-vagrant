
DROP TABLE IF EXISTS users;
DROP SEQUENCE IF EXISTS users_email_seq;

CREATE SEQUENCE users_email_seq INCREMENT 1 START 1;

CREATE TABLE users (
	email varchar(20) DEFAULT NEXTVAL('users_email_seq'::TEXT) NOT NULL,
	password varchar(1000) NOT NULL,
	estado boolean DEFAULT FALSE,
	name varchar(200),
	usersystem varchar(200)
);


ALTER TABLE users ADD CONSTRAINT PK_users
	PRIMARY KEY (email);


