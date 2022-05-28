SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: only_last_four_password_histories(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.only_last_four_password_histories() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
        BEGIN
          DELETE FROM user_password_histories
          WHERE user_id = NEW.user_id AND id NOT IN (
            SELECT id FROM user_password_histories
            WHERE user_id = NEW.user_id ORDER BY created_at DESC limit 4);
          RETURN NEW;
        END;
      $$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: addresses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.addresses (
    id integer NOT NULL,
    city_id integer NOT NULL,
    related_id integer NOT NULL,
    related_type character varying NOT NULL,
    street character varying NOT NULL,
    complement character varying,
    number integer DEFAULT 0 NOT NULL,
    district character varying NOT NULL,
    zipcode character varying(8) NOT NULL,
    lat numeric(14,6),
    long numeric(14,6),
    reference_point character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.addresses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.addresses_id_seq OWNED BY public.addresses.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: churches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.churches (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    address_id integer,
    active boolean DEFAULT true,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: churches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.churches_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: churches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.churches_id_seq OWNED BY public.churches.id;


--
-- Name: cities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cities (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    state_id integer NOT NULL,
    active boolean DEFAULT true,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: cities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cities_id_seq OWNED BY public.cities.id;


--
-- Name: congregateds; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.congregateds (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    birth_dt date NOT NULL,
    entry_dt date NOT NULL,
    baptized boolean DEFAULT false,
    active boolean DEFAULT true,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    email character varying
);


--
-- Name: congregateds_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.congregateds_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: congregateds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.congregateds_id_seq OWNED BY public.congregateds.id;


--
-- Name: countries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.countries (
    id integer NOT NULL,
    name character varying(60),
    acronym character varying(2),
    active boolean DEFAULT true,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: countries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.countries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: countries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.countries_id_seq OWNED BY public.countries.id;


--
-- Name: inventories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inventories (
    id bigint NOT NULL,
    name character varying NOT NULL,
    description text NOT NULL,
    observations text,
    active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: inventories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inventories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.inventories_id_seq OWNED BY public.inventories.id;


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.jobs (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    active boolean DEFAULT true,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.jobs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: members; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.members (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    father_name character varying(150) NOT NULL,
    mother_name character varying(150) NOT NULL,
    post_id integer,
    naturalness_id integer,
    job_id integer,
    convert_dt date NOT NULL,
    birth_dt date NOT NULL,
    gender character varying(1) NOT NULL,
    educational_level character varying(2) NOT NULL,
    marital_status character varying(2) NOT NULL,
    active boolean DEFAULT true,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    photo_file_name character varying,
    photo_content_type character varying,
    photo_file_size bigint,
    photo_updated_at timestamp without time zone,
    email character varying
);


--
-- Name: members_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.members_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.members_id_seq OWNED BY public.members.id;


--
-- Name: permits; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.permits (
    id integer NOT NULL,
    name character varying NOT NULL,
    modulus character varying NOT NULL,
    controller character varying NOT NULL,
    action character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: permits_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.permits_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: permits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.permits_id_seq OWNED BY public.permits.id;


--
-- Name: phone_carriers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.phone_carriers (
    id integer NOT NULL,
    name character varying(20),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: phone_carriers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.phone_carriers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: phone_carriers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.phone_carriers_id_seq OWNED BY public.phone_carriers.id;


--
-- Name: phones; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.phones (
    id integer NOT NULL,
    number character varying NOT NULL,
    related_type character varying NOT NULL,
    related_id integer NOT NULL,
    phone_carrier_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    phone_type character varying(11) DEFAULT 'residential'::character varying NOT NULL,
    whatsapp boolean DEFAULT true NOT NULL
);


--
-- Name: phones_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.phones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: phones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.phones_id_seq OWNED BY public.phones.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.posts (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    classification character varying(1) NOT NULL,
    active boolean DEFAULT true,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.posts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.posts_id_seq OWNED BY public.posts.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    related_id integer NOT NULL,
    related_type character varying NOT NULL,
    permit_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: shepherds; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shepherds (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    church_id integer,
    birth_dt date NOT NULL,
    active boolean DEFAULT true,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: shepherds_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.shepherds_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: shepherds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.shepherds_id_seq OWNED BY public.shepherds.id;


--
-- Name: states; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.states (
    id integer NOT NULL,
    name character varying(60),
    acronym character varying(2),
    country_id integer NOT NULL,
    active boolean DEFAULT true,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: states_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.states_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: states_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.states_id_seq OWNED BY public.states.id;


--
-- Name: user_password_histories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_password_histories (
    id integer NOT NULL,
    user_id integer,
    encrypted_password character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: user_password_histories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_password_histories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_password_histories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_password_histories_id_seq OWNED BY public.user_password_histories.id;


--
-- Name: user_permits; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_permits (
    id integer NOT NULL,
    permit_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: user_permits_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_permits_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_permits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_permits_id_seq OWNED BY public.user_permits.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    admin boolean DEFAULT false NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    failed_attempts integer DEFAULT 0 NOT NULL,
    unlock_token character varying,
    locked_at timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    login character varying,
    administrator boolean DEFAULT false NOT NULL,
    avatar_file_name character varying,
    avatar_content_type character varying,
    avatar_file_size bigint,
    avatar_updated_at timestamp without time zone,
    secret_phrase character varying(30) DEFAULT 'default'::character varying NOT NULL,
    locked boolean DEFAULT true,
    active boolean DEFAULT true NOT NULL,
    name character varying(150) NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: addresses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addresses ALTER COLUMN id SET DEFAULT nextval('public.addresses_id_seq'::regclass);


--
-- Name: churches id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.churches ALTER COLUMN id SET DEFAULT nextval('public.churches_id_seq'::regclass);


--
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);


--
-- Name: congregateds id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.congregateds ALTER COLUMN id SET DEFAULT nextval('public.congregateds_id_seq'::regclass);


--
-- Name: countries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.countries ALTER COLUMN id SET DEFAULT nextval('public.countries_id_seq'::regclass);


--
-- Name: inventories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventories ALTER COLUMN id SET DEFAULT nextval('public.inventories_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: members id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.members ALTER COLUMN id SET DEFAULT nextval('public.members_id_seq'::regclass);


--
-- Name: permits id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permits ALTER COLUMN id SET DEFAULT nextval('public.permits_id_seq'::regclass);


--
-- Name: phone_carriers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.phone_carriers ALTER COLUMN id SET DEFAULT nextval('public.phone_carriers_id_seq'::regclass);


--
-- Name: phones id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.phones ALTER COLUMN id SET DEFAULT nextval('public.phones_id_seq'::regclass);


--
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: shepherds id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shepherds ALTER COLUMN id SET DEFAULT nextval('public.shepherds_id_seq'::regclass);


--
-- Name: states id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.states ALTER COLUMN id SET DEFAULT nextval('public.states_id_seq'::regclass);


--
-- Name: user_password_histories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_password_histories ALTER COLUMN id SET DEFAULT nextval('public.user_password_histories_id_seq'::regclass);


--
-- Name: user_permits id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_permits ALTER COLUMN id SET DEFAULT nextval('public.user_permits_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: churches churches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.churches
    ADD CONSTRAINT churches_pkey PRIMARY KEY (id);


--
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);


--
-- Name: congregateds congregateds_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.congregateds
    ADD CONSTRAINT congregateds_pkey PRIMARY KEY (id);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);


--
-- Name: inventories inventories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventories
    ADD CONSTRAINT inventories_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: members members_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.members
    ADD CONSTRAINT members_pkey PRIMARY KEY (id);


--
-- Name: permits permits_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permits
    ADD CONSTRAINT permits_pkey PRIMARY KEY (id);


--
-- Name: phone_carriers phone_carriers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.phone_carriers
    ADD CONSTRAINT phone_carriers_pkey PRIMARY KEY (id);


--
-- Name: phones phones_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.phones
    ADD CONSTRAINT phones_pkey PRIMARY KEY (id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: shepherds shepherds_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shepherds
    ADD CONSTRAINT shepherds_pkey PRIMARY KEY (id);


--
-- Name: states states_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.states
    ADD CONSTRAINT states_pkey PRIMARY KEY (id);


--
-- Name: user_password_histories user_password_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_password_histories
    ADD CONSTRAINT user_password_histories_pkey PRIMARY KEY (id);


--
-- Name: user_permits user_permits_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_permits
    ADD CONSTRAINT user_permits_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_addresses_on_city_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_addresses_on_city_id ON public.addresses USING btree (city_id);


--
-- Name: index_addresses_on_related_id_and_related_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_addresses_on_related_id_and_related_type ON public.addresses USING btree (related_id, related_type);


--
-- Name: index_addresses_on_related_type_and_related_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_addresses_on_related_type_and_related_id ON public.addresses USING btree (related_type, related_id);


--
-- Name: index_churches_on_address_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_churches_on_address_id ON public.churches USING btree (address_id);


--
-- Name: index_cities_on_state_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_cities_on_state_id ON public.cities USING btree (state_id);


--
-- Name: index_members_on_job_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_members_on_job_id ON public.members USING btree (job_id);


--
-- Name: index_members_on_naturalness_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_members_on_naturalness_id ON public.members USING btree (naturalness_id);


--
-- Name: index_members_on_post_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_members_on_post_id ON public.members USING btree (post_id);


--
-- Name: index_permits_on_action; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_permits_on_action ON public.permits USING btree (action);


--
-- Name: index_permits_on_controller; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_permits_on_controller ON public.permits USING btree (controller);


--
-- Name: index_permits_on_modulus; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_permits_on_modulus ON public.permits USING btree (modulus);


--
-- Name: index_permits_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_permits_on_name ON public.permits USING btree (name);


--
-- Name: index_phones_on_related_type_and_related_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_phones_on_related_type_and_related_id ON public.phones USING btree (related_type, related_id);


--
-- Name: index_roles_on_permit_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_roles_on_permit_id ON public.roles USING btree (permit_id);


--
-- Name: index_roles_on_related_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_roles_on_related_id ON public.roles USING btree (related_id);


--
-- Name: index_roles_on_related_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_roles_on_related_type ON public.roles USING btree (related_type);


--
-- Name: index_shepherds_on_church_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_shepherds_on_church_id ON public.shepherds USING btree (church_id);


--
-- Name: index_states_on_country_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_states_on_country_id ON public.states USING btree (country_id);


--
-- Name: index_user_permits_on_permit_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_permits_on_permit_id ON public.user_permits USING btree (permit_id);


--
-- Name: index_user_permits_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_permits_on_user_id ON public.user_permits USING btree (user_id);


--
-- Name: index_users_on_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_active ON public.users USING btree (active);


--
-- Name: index_users_on_admin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_admin ON public.users USING btree (admin);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_login; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_login ON public.users USING btree (login);


--
-- Name: index_users_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_name ON public.users USING btree (name);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: user_password_histories only_last_four_password_histories; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER only_last_four_password_histories AFTER INSERT ON public.user_password_histories FOR EACH ROW EXECUTE PROCEDURE public.only_last_four_password_histories();


--
-- Name: user_password_histories fk_rails_2f05e4b7a3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_password_histories
    ADD CONSTRAINT fk_rails_2f05e4b7a3 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: states fk_rails_40bd891262; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.states
    ADD CONSTRAINT fk_rails_40bd891262 FOREIGN KEY (country_id) REFERENCES public.countries(id);


--
-- Name: user_permits fk_rails_51ee10b99a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_permits
    ADD CONSTRAINT fk_rails_51ee10b99a FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: cities fk_rails_59b5e22e07; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT fk_rails_59b5e22e07 FOREIGN KEY (state_id) REFERENCES public.states(id);


--
-- Name: members fk_rails_697b31ce94; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.members
    ADD CONSTRAINT fk_rails_697b31ce94 FOREIGN KEY (job_id) REFERENCES public.jobs(id);


--
-- Name: phones fk_rails_6f4dd9e042; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.phones
    ADD CONSTRAINT fk_rails_6f4dd9e042 FOREIGN KEY (phone_carrier_id) REFERENCES public.phone_carriers(id);


--
-- Name: members fk_rails_81ebc4ebda; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.members
    ADD CONSTRAINT fk_rails_81ebc4ebda FOREIGN KEY (post_id) REFERENCES public.posts(id);


--
-- Name: members fk_rails_8bd10a53a3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.members
    ADD CONSTRAINT fk_rails_8bd10a53a3 FOREIGN KEY (naturalness_id) REFERENCES public.cities(id);


--
-- Name: addresses fk_rails_ab048f757c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT fk_rails_ab048f757c FOREIGN KEY (city_id) REFERENCES public.cities(id);


--
-- Name: user_permits fk_rails_b8365b68b2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_permits
    ADD CONSTRAINT fk_rails_b8365b68b2 FOREIGN KEY (permit_id) REFERENCES public.permits(id);


--
-- Name: roles fk_rails_f2b47f18cb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT fk_rails_f2b47f18cb FOREIGN KEY (permit_id) REFERENCES public.permits(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20140323150147'),
('20140323150953'),
('20140323151154'),
('20140330214516'),
('20140330214649'),
('20140330214714'),
('20140330214727'),
('20140406152337'),
('20140406152833'),
('20140702222807'),
('20140702222808'),
('20140708111424'),
('20140708113806'),
('20140708114308'),
('20140708114449'),
('20140708115336'),
('20140708115555'),
('20140717123047'),
('20140813021639'),
('20150809151441'),
('20160902002742'),
('20160903125209'),
('20160905223523'),
('20160917122048'),
('20161001124130'),
('20161006040431'),
('20161007232253'),
('20161015142340'),
('20161015142917'),
('20161020224213'),
('20161021133643'),
('20161024132839'),
('20161106142600'),
('20161110213151'),
('20170510204640'),
('20170510204651'),
('20170510204660'),
('20170510204661'),
('20181005040045'),
('20181005040054'),
('20181005044559'),
('20181005045331'),
('20181005053748'),
('20181011200543'),
('20200530024202');


