------------------------------------------------------------------------------------------
-- Users
------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS usr_user;
DROP SEQUENCE IF EXISTS usr_user_id_seq;

CREATE SEQUENCE usr_user_id_seq INCREMENT 1 START 1;

CREATE TABLE usr_user (
  usr_id integer DEFAULT NEXTVAL('usr_user_id_seq'::TEXT) NOT NULL,
	usr_email varchar(20)  NOT NULL,
	usr_password varchar(1000) NOT NULL,
	usr_status boolean DEFAULT FALSE,
	usr_name varchar(200),
	usr_usersystem varchar(200)
);


ALTER TABLE usr_user ADD CONSTRAINT PK_usr_user
	PRIMARY KEY (usr_id);
	
ALTER TABLE usr_user
	ADD CONSTRAINT UQ_usr_user_email UNIQUE (usr_email);

------------------------------------------------------------------------------------------
-- Certs
------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS crt_cert;
DROP SEQUENCE IF EXISTS crt_cert_id_seq;

CREATE SEQUENCE crt_cert_id_seq INCREMENT 1 START 1;

CREATE TABLE crt_cert (
  crt_id integer DEFAULT NEXTVAL('crt_cert_id_seq'::TEXT) NOT NULL,
	crt_serial varchar(200)  NOT NULL,
	crt_issue varchar(1000) NOT NULL,
	crt_keypath varchar(2000),
	crt_certpath varchar(2000),
	crt_proxypath varchar(2000)
);


ALTER TABLE crt_cert ADD CONSTRAINT PK_crt_cert
	PRIMARY KEY (crt_id);

