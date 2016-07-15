--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: active_admin_comments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE active_admin_comments (
    id integer NOT NULL,
    namespace character varying,
    body text,
    resource_id character varying NOT NULL,
    resource_type character varying NOT NULL,
    author_id integer,
    author_type character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE active_admin_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE active_admin_comments_id_seq OWNED BY active_admin_comments.id;


--
-- Name: admins; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE admins (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    role character varying
);


--
-- Name: admins_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE admins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE admins_id_seq OWNED BY admins.id;


--
-- Name: apartments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE apartments (
    id integer NOT NULL,
    images character varying[] DEFAULT '{}'::character varying[],
    name character varying NOT NULL,
    model character varying NOT NULL,
    area double precision NOT NULL,
    rental integer NOT NULL,
    room_type character varying,
    sex_limit character varying,
    title character varying NOT NULL,
    body text,
    u_name character varying,
    u_mobile character varying NOT NULL,
    rent_type character varying NOT NULL,
    location point,
    address character varying,
    hide_mobile boolean DEFAULT true,
    approved boolean DEFAULT true,
    sort integer DEFAULT 0,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: apartments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE apartments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: apartments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE apartments_id_seq OWNED BY apartments.id;


--
-- Name: auth_codes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE auth_codes (
    id integer NOT NULL,
    code character varying(6) NOT NULL,
    mobile character varying NOT NULL,
    activated_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: auth_codes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE auth_codes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_codes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE auth_codes_id_seq OWNED BY auth_codes.id;


--
-- Name: banners; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE banners (
    id integer NOT NULL,
    image character varying,
    link character varying,
    sort integer DEFAULT 0,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: banners_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE banners_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: banners_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE banners_id_seq OWNED BY banners.id;


--
-- Name: feedbacks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE feedbacks (
    id integer NOT NULL,
    author character varying,
    content character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: feedbacks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE feedbacks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: feedbacks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE feedbacks_id_seq OWNED BY feedbacks.id;


--
-- Name: pages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pages (
    id integer NOT NULL,
    title character varying NOT NULL,
    body text NOT NULL,
    slug character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pages_id_seq OWNED BY pages.id;


--
-- Name: payouts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE payouts (
    id integer NOT NULL,
    money numeric(16,2) NOT NULL,
    fee numeric(16,2) DEFAULT 0,
    card_no character varying NOT NULL,
    card_name character varying,
    user_id integer,
    payed_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: payouts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE payouts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payouts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE payouts_id_seq OWNED BY payouts.id;


--
-- Name: redactor_assets; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE redactor_assets (
    id integer NOT NULL,
    data_file_name character varying NOT NULL,
    data_content_type character varying,
    data_file_size integer,
    assetable_id integer,
    assetable_type character varying(30),
    type character varying(30),
    width integer,
    height integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: redactor_assets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE redactor_assets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: redactor_assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE redactor_assets_id_seq OWNED BY redactor_assets.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: send_sms_logs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE send_sms_logs (
    id integer NOT NULL,
    mobile character varying NOT NULL,
    send_total integer DEFAULT 0,
    first_sent_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: send_sms_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE send_sms_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: send_sms_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE send_sms_logs_id_seq OWNED BY send_sms_logs.id;


--
-- Name: site_configs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE site_configs (
    id integer NOT NULL,
    key character varying NOT NULL,
    value character varying NOT NULL,
    description character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: site_configs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE site_configs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: site_configs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE site_configs_id_seq OWNED BY site_configs.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    nickname character varying,
    avatar character varying,
    mobile character varying NOT NULL,
    password_digest character varying,
    private_token character varying,
    verified boolean DEFAULT true,
    visible boolean DEFAULT true,
    bean integer DEFAULT 0,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    mac_addr character varying,
    wifi_length integer DEFAULT 0,
    nb_code character varying
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY active_admin_comments ALTER COLUMN id SET DEFAULT nextval('active_admin_comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY admins ALTER COLUMN id SET DEFAULT nextval('admins_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY apartments ALTER COLUMN id SET DEFAULT nextval('apartments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY auth_codes ALTER COLUMN id SET DEFAULT nextval('auth_codes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY banners ALTER COLUMN id SET DEFAULT nextval('banners_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY feedbacks ALTER COLUMN id SET DEFAULT nextval('feedbacks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pages ALTER COLUMN id SET DEFAULT nextval('pages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY payouts ALTER COLUMN id SET DEFAULT nextval('payouts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY redactor_assets ALTER COLUMN id SET DEFAULT nextval('redactor_assets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY send_sms_logs ALTER COLUMN id SET DEFAULT nextval('send_sms_logs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY site_configs ALTER COLUMN id SET DEFAULT nextval('site_configs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: active_admin_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY active_admin_comments
    ADD CONSTRAINT active_admin_comments_pkey PRIMARY KEY (id);


--
-- Name: admins_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- Name: apartments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY apartments
    ADD CONSTRAINT apartments_pkey PRIMARY KEY (id);


--
-- Name: auth_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY auth_codes
    ADD CONSTRAINT auth_codes_pkey PRIMARY KEY (id);


--
-- Name: banners_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY banners
    ADD CONSTRAINT banners_pkey PRIMARY KEY (id);


--
-- Name: feedbacks_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY feedbacks
    ADD CONSTRAINT feedbacks_pkey PRIMARY KEY (id);


--
-- Name: pages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: payouts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY payouts
    ADD CONSTRAINT payouts_pkey PRIMARY KEY (id);


--
-- Name: redactor_assets_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY redactor_assets
    ADD CONSTRAINT redactor_assets_pkey PRIMARY KEY (id);


--
-- Name: send_sms_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY send_sms_logs
    ADD CONSTRAINT send_sms_logs_pkey PRIMARY KEY (id);


--
-- Name: site_configs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY site_configs
    ADD CONSTRAINT site_configs_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_redactor_assetable; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_redactor_assetable ON redactor_assets USING btree (assetable_type, assetable_id);


--
-- Name: idx_redactor_assetable_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_redactor_assetable_type ON redactor_assets USING btree (assetable_type, type, assetable_id);


--
-- Name: index_active_admin_comments_on_author_type_and_author_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_active_admin_comments_on_author_type_and_author_id ON active_admin_comments USING btree (author_type, author_id);


--
-- Name: index_active_admin_comments_on_namespace; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_active_admin_comments_on_namespace ON active_admin_comments USING btree (namespace);


--
-- Name: index_active_admin_comments_on_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_active_admin_comments_on_resource_type_and_resource_id ON active_admin_comments USING btree (resource_type, resource_id);


--
-- Name: index_admins_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_admins_on_email ON admins USING btree (email);


--
-- Name: index_admins_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_admins_on_reset_password_token ON admins USING btree (reset_password_token);


--
-- Name: index_apartments_on_location; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_apartments_on_location ON apartments USING gist (location);


--
-- Name: index_auth_codes_on_code; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_auth_codes_on_code ON auth_codes USING btree (code);


--
-- Name: index_auth_codes_on_mobile; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_auth_codes_on_mobile ON auth_codes USING btree (mobile);


--
-- Name: index_pages_on_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_pages_on_slug ON pages USING btree (slug);


--
-- Name: index_payouts_on_card_no; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_payouts_on_card_no ON payouts USING btree (card_no);


--
-- Name: index_payouts_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_payouts_on_user_id ON payouts USING btree (user_id);


--
-- Name: index_send_sms_logs_on_mobile; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_send_sms_logs_on_mobile ON send_sms_logs USING btree (mobile);


--
-- Name: index_site_configs_on_key; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_site_configs_on_key ON site_configs USING btree (key);


--
-- Name: index_users_on_mac_addr; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_mac_addr ON users USING btree (mac_addr);


--
-- Name: index_users_on_mobile; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_mobile ON users USING btree (mobile);


--
-- Name: index_users_on_nb_code; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_nb_code ON users USING btree (nb_code);


--
-- Name: index_users_on_private_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_private_token ON users USING btree (private_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: fk_rails_f3cf384b33; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY payouts
    ADD CONSTRAINT fk_rails_f3cf384b33 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO public,postgis;

INSERT INTO schema_migrations (version) VALUES ('20160505153558');

INSERT INTO schema_migrations (version) VALUES ('20160505153612');

INSERT INTO schema_migrations (version) VALUES ('20160506135343');

INSERT INTO schema_migrations (version) VALUES ('20160508133955');

INSERT INTO schema_migrations (version) VALUES ('20160508140133');

INSERT INTO schema_migrations (version) VALUES ('20160508140318');

INSERT INTO schema_migrations (version) VALUES ('20160515153503');

INSERT INTO schema_migrations (version) VALUES ('20160515155031');

INSERT INTO schema_migrations (version) VALUES ('20160516012404');

INSERT INTO schema_migrations (version) VALUES ('20160516092719');

INSERT INTO schema_migrations (version) VALUES ('20160626065434');

INSERT INTO schema_migrations (version) VALUES ('20160706072752');

INSERT INTO schema_migrations (version) VALUES ('20160706073703');

INSERT INTO schema_migrations (version) VALUES ('20160712074550');

INSERT INTO schema_migrations (version) VALUES ('20160714043259');

