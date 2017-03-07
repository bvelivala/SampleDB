-- Table: public.login

ALTER TABLE IF EXISTS public.login DROP CONSTRAINT IF EXISTS "login_pkey";

DROP TABLE IF EXISTS public.login;

CREATE TABLE public.login
(
  userid character varying(20) NOT NULL,
  passwd character varying(20) NOT NULL,
  groupid character varying(20) NOT NULL,
  fname character varying(20) DEFAULT NULL,
  lname character varying(20) DEFAULT NULL,
  address character varying(45) DEFAULT NULL,
  phone character varying(45) DEFAULT NULL,
  mailId character varying(45) DEFAULT NULL,
  bname character varying(45) DEFAULT NULL,
  lastused_date_time timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT login_pkey PRIMARY KEY (userid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.login
  OWNER TO postgres;

-- Table: public.groupusers

ALTER TABLE IF EXISTS public.groupusers DROP CONSTRAINT IF EXISTS "groupusers_pkey";

DROP TABLE IF EXISTS public.groupusers;

CREATE TABLE public.groupusers
(
  groupid character varying(20) NOT NULL DEFAULT 'user',
  userid character varying(20) NOT NULL,
  CONSTRAINT groupusers_pkey PRIMARY KEY (userid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.groupusers
  OWNER TO postgres;

-- Table: public.addressbook

ALTER TABLE IF EXISTS public.addressbook DROP CONSTRAINT IF EXISTS "addressbook_pkey";

DROP TABLE IF EXISTS public.addressbook;

CREATE TABLE public.addressbook
(
  loginid character varying(20) NOT NULL,
  userid character varying(20) NOT NULL,
  fname character varying(20) DEFAULT NULL,
  lname character varying(20) DEFAULT NULL,
  phoneno character varying(45) DEFAULT NULL,
  mailId character varying(45) DEFAULT NULL,
  address character varying(45) DEFAULT NULL,
  officeadd character varying(45) DEFAULT NULL,
  officephone character varying(45) DEFAULT NULL,
  CONSTRAINT addressbook_pkey PRIMARY KEY (loginid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.addressbook
  OWNER TO postgres;

-- Table: public.messages

DROP TABLE IF EXISTS public.messages;

CREATE TABLE public.messages
(
  senderid character varying(20) NOT NULL,
  receiverid character varying(20) NOT NULL,
  m_date timestamp without time zone DEFAULT now(), 
  subject character varying(50) DEFAULT NULL,
  message character varying(500) DEFAULT NULL
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.messages
  OWNER TO postgres;

-- Table: public.news

DROP TABLE IF EXISTS public.news;

DROP SEQUENCE IF EXISTS public.news_sno_seq;

CREATE SEQUENCE public.news_sno_seq
  INCREMENT 1
  MINVALUE 1
  START 1;
  
ALTER TABLE public.news_sno_seq OWNER TO postgres;

CREATE TABLE public.news
(
  sno integer NOT NULL DEFAULT nextval('news_sno_seq'::regclass),
  message character varying(500) DEFAULT NULL,
  m_date timestamp without time zone DEFAULT now()
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.news
  OWNER TO postgres;

 -- Table: public.schedular

DROP TABLE IF EXISTS public.schedular;

CREATE TABLE public.schedular
(
  userid character varying(20) NOT NULL,
  mdate character varying(20) DEFAULT NULL,
  task character varying(200) DEFAULT NULL
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.schedular
  OWNER TO postgres;

-- Insert test data
INSERT INTO public.login(
            userid, passwd, groupid, fname, lname, address, phone, mailid, bname, lastused_date_time)
    VALUES ('bhavani', '12345', 'admin', 'bhavani', 'velivala', 'hyderabad', '23158000', 'test@gmail.com', 'Hyderabad', now());
			
INSERT INTO public.login(
            userid, passwd, groupid, fname, lname, address, phone, mailid, bname, lastused_date_time)
    VALUES ('rikky', '12345', 'user', 'rakesh', 'kumar', 'hyderabad', '23158000', 'test@gmail.com', 'Hyderabad', now());

INSERT INTO public.groupusers(groupid, userid)
    VALUES ('admin', 'bhavani');

INSERT INTO public.groupusers(groupid, userid)
    VALUES ('user', 'rikky');
	
INSERT INTO public.addressbook(
            loginid, userid, fname, lname, phoneno, mailid, address, officeadd, officephone)
    VALUES ('bhavani', 'test@gmail.com', 'bhavani', 'velivala', '23158000', 'test@gmail.com', 'Hyderabad', 'Hyderabad', '23148900');

INSERT INTO public.addressbook(
            loginid, userid, fname, lname, phoneno, mailid, address, officeadd, officephone)
    VALUES ('rikky', 'test@gmail.com', 'rakesh', 'kumar', '23158000', 'test@gmail.com', 'Hyderabad', 'Hyderabad', '23148900');
