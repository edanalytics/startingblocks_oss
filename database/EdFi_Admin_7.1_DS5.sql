--
-- PostgreSQL database dump
--

-- Dumped from database version 13.12
-- Dumped by pg_dump version 13.7

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
-- Name: dbo; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA dbo;


ALTER SCHEMA dbo OWNER TO postgres;

--
-- Name: getclientforkey(character varying); Type: FUNCTION; Schema: dbo; Owner: postgres
--

CREATE FUNCTION dbo.getclientforkey(apikey character varying) RETURNS TABLE(key character varying, usesandbox boolean, studentidentificationsystemdescriptor character varying, educationorganizationid bigint, claimsetname character varying, namespaceprefix character varying, profilename character varying, creatorownershiptokenid smallint, ownershiptokenid smallint, apiclientid integer, secret character varying, secretishashed boolean)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        SELECT
            d.Key
            , d.UseSandbox
            , d.StudentIdentificationSystemDescriptor
            , d.EducationOrganizationId
            , d.ClaimSetName
            , d.NamespacePrefix
            , d.ProfileName
            , d.CreatorOwnershipTokenId
            , d.OwnershipTokenId
            , d.ApiClientId
            , d.Secret
            , d.SecretIsHashed
        FROM    dbo.ApiClientIdentityRawDetails d
        WHERE   d.Key = ApiKey;
    END
    $$;


ALTER FUNCTION dbo.getclientforkey(apikey character varying) OWNER TO postgres;

--
-- Name: getclientfortoken(uuid); Type: FUNCTION; Schema: dbo; Owner: postgres
--

CREATE FUNCTION dbo.getclientfortoken(accesstoken uuid) RETURNS TABLE(key character varying, usesandbox boolean, studentidentificationsystemdescriptor character varying, educationorganizationid bigint, claimsetname character varying, namespaceprefix character varying, profilename character varying, creatorownershiptokenid smallint, ownershiptokenid smallint, odsinstanceid integer, apiclientid integer, expiration timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        SELECT
            ac.Key
            ,ac.UseSandbox
            ,ac.StudentIdentificationSystemDescriptor
            ,aeo.EducationOrganizationId
            ,app.ClaimSetName
            ,vnp.NamespacePrefix
            ,p.ProfileName
            ,ac.CreatorOwnershipTokenId_OwnershipTokenId as CreatorOwnershipTokenId
            ,acot.OwnershipToken_OwnershipTokenId as OwnershipTokenId
            ,acoi.OdsInstance_OdsInstanceId as OdsInstanceId
            ,cat.ApiClient_ApiClientId as ApiClientId
            ,cat.Expiration
        FROM dbo.ClientAccessTokens cat
             INNER JOIN dbo.ApiClients ac ON
            cat.ApiClient_ApiClientId = ac.ApiClientId
            AND cat.Id = AccessToken
             INNER JOIN dbo.Applications app ON
            app.ApplicationId = ac.Application_ApplicationId
             LEFT OUTER JOIN dbo.Vendors v ON
            v.VendorId = app.Vendor_VendorId
             LEFT OUTER JOIN dbo.VendorNamespacePrefixes vnp ON
            v.VendorId = vnp.Vendor_VendorId
             -- Outer join so client key is always returned even if no EdOrgs have been enabled
             LEFT OUTER JOIN dbo.ApiClientApplicationEducationOrganizations acaeo ON
            acaeo.ApiClient_ApiClientId = cat.ApiClient_ApiClientId
             LEFT OUTER JOIN dbo.ApplicationEducationOrganizations aeo ON
            aeo.ApplicationEducationOrganizationId = acaeo.ApplicationEdOrg_ApplicationEdOrgId
                AND (cat.Scope IS NULL OR aeo.EducationOrganizationId = CAST(cat.Scope AS INTEGER))
             LEFT OUTER JOIN dbo.ProfileApplications ap ON
            ap.Application_ApplicationId = app.ApplicationId
             LEFT OUTER JOIN dbo.Profiles p ON
            p.ProfileId = ap.Profile_ProfileId
            LEFT OUTER JOIN dbo.ApiClientOwnershipTokens acot ON
            ac.ApiClientId = acot.ApiClient_ApiClientId
            LEFT OUTER JOIN dbo.ApiClientOdsInstances acoi ON
            acoi.ApiClient_ApiClientId = ac.ApiClientId
        WHERE cat.Expiration > CURRENT_TIMESTAMP;
    END
    $$;


ALTER FUNCTION dbo.getclientfortoken(accesstoken uuid) OWNER TO postgres;

--
-- Name: getodsinstanceconfigurationbyid(integer); Type: FUNCTION; Schema: dbo; Owner: postgres
--

CREATE FUNCTION dbo.getodsinstanceconfigurationbyid(ods_instanceid integer) RETURNS TABLE(odsinstanceid integer, connectionstring character varying, contextkey character varying, contextvalue character varying, derivativetype character varying, connectionstringbyderivativetype character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT  ods.OdsInstanceId
            ,ods.ConnectionString
            ,ctx.ContextKey
            ,ctx.ContextValue
            ,der.DerivativeType
            ,der.ConnectionString AS ConnectionStringByDerivativeType
    FROM dbo.OdsInstances ods
    LEFT OUTER JOIN dbo.OdsInstanceContexts ctx 
        ON ods.OdsInstanceId = ctx.OdsInstance_OdsInstanceId
    LEFT JOIN dbo.OdsInstanceDerivatives der 
        ON ods.OdsInstanceId = der.OdsInstance_OdsInstanceId
    WHERE   ods.OdsInstanceId = ods_instanceId;
END
$$;


ALTER FUNCTION dbo.getodsinstanceconfigurationbyid(ods_instanceid integer) OWNER TO postgres;

--
-- Name: getodsinstancecontextvalues(character varying); Type: FUNCTION; Schema: dbo; Owner: postgres
--

CREATE FUNCTION dbo.getodsinstancecontextvalues(contextkey character varying) RETURNS TABLE(contextvalue character varying)
    LANGUAGE plpgsql
    AS $$
#variable_conflict use_variable
BEGIN
	RETURN QUERY
	SELECT DISTINCT
          ctx.contextvalue
    FROM dbo.odsinstances ods
    INNER JOIN dbo.odsinstancecontexts ctx 
        ON ods.odsinstanceid = ctx.odsinstance_odsinstanceid
		WHERE ctx.contextkey = contextkey;
END
$$;


ALTER FUNCTION dbo.getodsinstancecontextvalues(contextkey character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: apiclientapplicationeducationorganizations; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.apiclientapplicationeducationorganizations (
    apiclient_apiclientid integer NOT NULL,
    applicationedorg_applicationedorgid integer NOT NULL
);


ALTER TABLE dbo.apiclientapplicationeducationorganizations OWNER TO postgres;

--
-- Name: apiclientownershiptokens; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.apiclientownershiptokens (
    apiclientownershiptokenid integer NOT NULL,
    apiclient_apiclientid integer NOT NULL,
    ownershiptoken_ownershiptokenid smallint NOT NULL
);


ALTER TABLE dbo.apiclientownershiptokens OWNER TO postgres;

--
-- Name: apiclients; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.apiclients (
    apiclientid integer NOT NULL,
    key character varying(50) NOT NULL,
    secret character varying(100) NOT NULL,
    name character varying(50) NOT NULL,
    isapproved boolean NOT NULL,
    usesandbox boolean NOT NULL,
    sandboxtype integer NOT NULL,
    application_applicationid integer,
    user_userid integer,
    keystatus character varying,
    challengeid character varying,
    challengeexpiry timestamp without time zone,
    activationcode character varying,
    activationretried integer,
    secretishashed boolean DEFAULT false NOT NULL,
    studentidentificationsystemdescriptor character varying(306),
    creatorownershiptokenid_ownershiptokenid smallint
);


ALTER TABLE dbo.apiclients OWNER TO postgres;

--
-- Name: applicationeducationorganizations; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.applicationeducationorganizations (
    applicationeducationorganizationid integer NOT NULL,
    educationorganizationid bigint NOT NULL,
    application_applicationid integer NOT NULL
);


ALTER TABLE dbo.applicationeducationorganizations OWNER TO postgres;

--
-- Name: applications; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.applications (
    applicationid integer NOT NULL,
    applicationname character varying,
    vendor_vendorid integer,
    claimsetname character varying(255),
    operationalcontexturi character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE dbo.applications OWNER TO postgres;

--
-- Name: profileapplications; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.profileapplications (
    profile_profileid integer NOT NULL,
    application_applicationid integer NOT NULL
);


ALTER TABLE dbo.profileapplications OWNER TO postgres;

--
-- Name: profiles; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.profiles (
    profileid integer NOT NULL,
    profilename character varying NOT NULL,
    profiledefinition xml
);


ALTER TABLE dbo.profiles OWNER TO postgres;

--
-- Name: vendornamespaceprefixes; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.vendornamespaceprefixes (
    vendornamespaceprefixid integer NOT NULL,
    namespaceprefix character varying(255) NOT NULL,
    vendor_vendorid integer NOT NULL
);


ALTER TABLE dbo.vendornamespaceprefixes OWNER TO postgres;

--
-- Name: vendors; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.vendors (
    vendorid integer NOT NULL,
    vendorname character varying
);


ALTER TABLE dbo.vendors OWNER TO postgres;

--
-- Name: apiclientidentityrawdetails; Type: VIEW; Schema: dbo; Owner: postgres
--

CREATE VIEW dbo.apiclientidentityrawdetails AS
 SELECT ac.key,
    ac.usesandbox,
    ac.studentidentificationsystemdescriptor,
    aeo.educationorganizationid,
    app.claimsetname,
    vnp.namespaceprefix,
    p.profilename,
    ac.creatorownershiptokenid_ownershiptokenid AS creatorownershiptokenid,
    acot.ownershiptoken_ownershiptokenid AS ownershiptokenid,
    ac.apiclientid,
    ac.secret,
    ac.secretishashed
   FROM ((((((((dbo.apiclients ac
     JOIN dbo.applications app ON ((app.applicationid = ac.application_applicationid)))
     LEFT JOIN dbo.vendors v ON ((v.vendorid = app.vendor_vendorid)))
     LEFT JOIN dbo.vendornamespaceprefixes vnp ON ((v.vendorid = vnp.vendor_vendorid)))
     LEFT JOIN dbo.apiclientapplicationeducationorganizations acaeo ON ((acaeo.apiclient_apiclientid = ac.apiclientid)))
     LEFT JOIN dbo.applicationeducationorganizations aeo ON ((aeo.applicationeducationorganizationid = acaeo.applicationedorg_applicationedorgid)))
     LEFT JOIN dbo.profileapplications ap ON ((ap.application_applicationid = app.applicationid)))
     LEFT JOIN dbo.profiles p ON ((p.profileid = ap.profile_profileid)))
     LEFT JOIN dbo.apiclientownershiptokens acot ON ((ac.apiclientid = acot.apiclient_apiclientid)));


ALTER TABLE dbo.apiclientidentityrawdetails OWNER TO postgres;

--
-- Name: apiclientodsinstances; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.apiclientodsinstances (
    apiclientodsinstanceid integer NOT NULL,
    apiclient_apiclientid integer NOT NULL,
    odsinstance_odsinstanceid integer NOT NULL
);


ALTER TABLE dbo.apiclientodsinstances OWNER TO postgres;

--
-- Name: apiclientodsinstances_apiclientodsinstanceid_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.apiclientodsinstances_apiclientodsinstanceid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.apiclientodsinstances_apiclientodsinstanceid_seq OWNER TO postgres;

--
-- Name: apiclientodsinstances_apiclientodsinstanceid_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.apiclientodsinstances_apiclientodsinstanceid_seq OWNED BY dbo.apiclientodsinstances.apiclientodsinstanceid;


--
-- Name: apiclientownershiptokens_apiclientownershiptokenid_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.apiclientownershiptokens_apiclientownershiptokenid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.apiclientownershiptokens_apiclientownershiptokenid_seq OWNER TO postgres;

--
-- Name: apiclientownershiptokens_apiclientownershiptokenid_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.apiclientownershiptokens_apiclientownershiptokenid_seq OWNED BY dbo.apiclientownershiptokens.apiclientownershiptokenid;


--
-- Name: apiclients_apiclientid_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.apiclients_apiclientid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.apiclients_apiclientid_seq OWNER TO postgres;

--
-- Name: apiclients_apiclientid_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.apiclients_apiclientid_seq OWNED BY dbo.apiclients.apiclientid;


--
-- Name: applicationeducationorganizat_applicationeducationorganizat_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.applicationeducationorganizat_applicationeducationorganizat_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.applicationeducationorganizat_applicationeducationorganizat_seq OWNER TO postgres;

--
-- Name: applicationeducationorganizat_applicationeducationorganizat_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.applicationeducationorganizat_applicationeducationorganizat_seq OWNED BY dbo.applicationeducationorganizations.applicationeducationorganizationid;


--
-- Name: applications_applicationid_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.applications_applicationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.applications_applicationid_seq OWNER TO postgres;

--
-- Name: applications_applicationid_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.applications_applicationid_seq OWNED BY dbo.applications.applicationid;


--
-- Name: aspnetroleclaims; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.aspnetroleclaims (
    id integer NOT NULL,
    roleid text NOT NULL,
    claimtype text,
    claimvalue text
);


ALTER TABLE dbo.aspnetroleclaims OWNER TO postgres;

--
-- Name: aspnetroleclaims_id_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

ALTER TABLE dbo.aspnetroleclaims ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME dbo.aspnetroleclaims_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: aspnetroles; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.aspnetroles (
    id text NOT NULL,
    name character varying(256),
    normalizedname character varying(256),
    concurrencystamp text
);


ALTER TABLE dbo.aspnetroles OWNER TO postgres;

--
-- Name: aspnetuserclaims; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.aspnetuserclaims (
    id integer NOT NULL,
    userid text NOT NULL,
    claimtype text,
    claimvalue text
);


ALTER TABLE dbo.aspnetuserclaims OWNER TO postgres;

--
-- Name: aspnetuserclaims_id_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

ALTER TABLE dbo.aspnetuserclaims ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME dbo.aspnetuserclaims_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: aspnetuserlogins; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.aspnetuserlogins (
    loginprovider text NOT NULL,
    providerkey text NOT NULL,
    providerdisplayname text,
    userid text NOT NULL
);


ALTER TABLE dbo.aspnetuserlogins OWNER TO postgres;

--
-- Name: aspnetuserroles; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.aspnetuserroles (
    userid text NOT NULL,
    roleid text NOT NULL
);


ALTER TABLE dbo.aspnetuserroles OWNER TO postgres;

--
-- Name: aspnetusers; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.aspnetusers (
    id text NOT NULL,
    username character varying(256),
    normalizedusername character varying(256),
    email character varying(256),
    normalizedemail character varying(256),
    emailconfirmed boolean NOT NULL,
    passwordhash text,
    securitystamp text,
    concurrencystamp text,
    phonenumber text,
    phonenumberconfirmed boolean NOT NULL,
    twofactorenabled boolean NOT NULL,
    lockoutend timestamp with time zone,
    lockoutenabled boolean NOT NULL,
    accessfailedcount integer NOT NULL
);


ALTER TABLE dbo.aspnetusers OWNER TO postgres;

--
-- Name: aspnetusertokens; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.aspnetusertokens (
    userid text NOT NULL,
    loginprovider text NOT NULL,
    name text NOT NULL,
    value text
);


ALTER TABLE dbo.aspnetusertokens OWNER TO postgres;

--
-- Name: clientaccesstokens; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.clientaccesstokens (
    id uuid NOT NULL,
    expiration timestamp without time zone NOT NULL,
    scope character varying,
    apiclient_apiclientid integer
);


ALTER TABLE dbo.clientaccesstokens OWNER TO postgres;

--
-- Name: odsinstancecontexts; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.odsinstancecontexts (
    odsinstancecontextid integer NOT NULL,
    odsinstance_odsinstanceid integer NOT NULL,
    contextkey character varying(50) NOT NULL,
    contextvalue character varying(50) NOT NULL
);


ALTER TABLE dbo.odsinstancecontexts OWNER TO postgres;

--
-- Name: odsinstancecontext_odsinstancecontextid_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.odsinstancecontext_odsinstancecontextid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.odsinstancecontext_odsinstancecontextid_seq OWNER TO postgres;

--
-- Name: odsinstancecontext_odsinstancecontextid_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.odsinstancecontext_odsinstancecontextid_seq OWNED BY dbo.odsinstancecontexts.odsinstancecontextid;


--
-- Name: odsinstancederivatives; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.odsinstancederivatives (
    odsinstancederivativeid integer NOT NULL,
    odsinstance_odsinstanceid integer NOT NULL,
    derivativetype character varying(50) NOT NULL,
    connectionstring character varying(1500)
);


ALTER TABLE dbo.odsinstancederivatives OWNER TO postgres;

--
-- Name: odsinstancederivative_odsinstancederivativeid_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.odsinstancederivative_odsinstancederivativeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.odsinstancederivative_odsinstancederivativeid_seq OWNER TO postgres;

--
-- Name: odsinstancederivative_odsinstancederivativeid_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.odsinstancederivative_odsinstancederivativeid_seq OWNED BY dbo.odsinstancederivatives.odsinstancederivativeid;


--
-- Name: odsinstances; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.odsinstances (
    odsinstanceid integer NOT NULL,
    name character varying(100) NOT NULL,
    instancetype character varying(100),
    connectionstring character varying(1500)
);


ALTER TABLE dbo.odsinstances OWNER TO postgres;

--
-- Name: odsinstances_odsinstanceid_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.odsinstances_odsinstanceid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.odsinstances_odsinstanceid_seq OWNER TO postgres;

--
-- Name: odsinstances_odsinstanceid_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.odsinstances_odsinstanceid_seq OWNED BY dbo.odsinstances.odsinstanceid;


--
-- Name: ownershiptokens; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ownershiptokens (
    ownershiptokenid smallint NOT NULL,
    description character varying(50)
);


ALTER TABLE dbo.ownershiptokens OWNER TO postgres;

--
-- Name: ownershiptokens_ownershiptokenid_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ownershiptokens_ownershiptokenid_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ownershiptokens_ownershiptokenid_seq OWNER TO postgres;

--
-- Name: ownershiptokens_ownershiptokenid_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ownershiptokens_ownershiptokenid_seq OWNED BY dbo.ownershiptokens.ownershiptokenid;


--
-- Name: profiles_profileid_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.profiles_profileid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.profiles_profileid_seq OWNER TO postgres;

--
-- Name: profiles_profileid_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.profiles_profileid_seq OWNED BY dbo.profiles.profileid;


--
-- Name: users; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.users (
    userid integer NOT NULL,
    email character varying,
    fullname character varying,
    vendor_vendorid integer
);


ALTER TABLE dbo.users OWNER TO postgres;

--
-- Name: users_userid_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.users_userid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.users_userid_seq OWNER TO postgres;

--
-- Name: users_userid_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.users_userid_seq OWNED BY dbo.users.userid;


--
-- Name: vendornamespaceprefixes_vendornamespaceprefixid_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.vendornamespaceprefixes_vendornamespaceprefixid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.vendornamespaceprefixes_vendornamespaceprefixid_seq OWNER TO postgres;

--
-- Name: vendornamespaceprefixes_vendornamespaceprefixid_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.vendornamespaceprefixes_vendornamespaceprefixid_seq OWNED BY dbo.vendornamespaceprefixes.vendornamespaceprefixid;


--
-- Name: vendors_vendorid_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.vendors_vendorid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.vendors_vendorid_seq OWNER TO postgres;

--
-- Name: vendors_vendorid_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.vendors_vendorid_seq OWNED BY dbo.vendors.vendorid;


--
-- Name: DeployJournal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."DeployJournal" (
    schemaversionsid integer NOT NULL,
    scriptname character varying(255) NOT NULL,
    applied timestamp without time zone NOT NULL
);


ALTER TABLE public."DeployJournal" OWNER TO postgres;

--
-- Name: DeployJournal_schemaversionsid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."DeployJournal_schemaversionsid_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."DeployJournal_schemaversionsid_seq" OWNER TO postgres;

--
-- Name: DeployJournal_schemaversionsid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."DeployJournal_schemaversionsid_seq" OWNED BY public."DeployJournal".schemaversionsid;


--
-- Name: apiclientodsinstances apiclientodsinstanceid; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.apiclientodsinstances ALTER COLUMN apiclientodsinstanceid SET DEFAULT nextval('dbo.apiclientodsinstances_apiclientodsinstanceid_seq'::regclass);


--
-- Name: apiclientownershiptokens apiclientownershiptokenid; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.apiclientownershiptokens ALTER COLUMN apiclientownershiptokenid SET DEFAULT nextval('dbo.apiclientownershiptokens_apiclientownershiptokenid_seq'::regclass);


--
-- Name: apiclients apiclientid; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.apiclients ALTER COLUMN apiclientid SET DEFAULT nextval('dbo.apiclients_apiclientid_seq'::regclass);


--
-- Name: applicationeducationorganizations applicationeducationorganizationid; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.applicationeducationorganizations ALTER COLUMN applicationeducationorganizationid SET DEFAULT nextval('dbo.applicationeducationorganizat_applicationeducationorganizat_seq'::regclass);


--
-- Name: applications applicationid; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.applications ALTER COLUMN applicationid SET DEFAULT nextval('dbo.applications_applicationid_seq'::regclass);


--
-- Name: odsinstancecontexts odsinstancecontextid; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.odsinstancecontexts ALTER COLUMN odsinstancecontextid SET DEFAULT nextval('dbo.odsinstancecontext_odsinstancecontextid_seq'::regclass);


--
-- Name: odsinstancederivatives odsinstancederivativeid; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.odsinstancederivatives ALTER COLUMN odsinstancederivativeid SET DEFAULT nextval('dbo.odsinstancederivative_odsinstancederivativeid_seq'::regclass);


--
-- Name: odsinstances odsinstanceid; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.odsinstances ALTER COLUMN odsinstanceid SET DEFAULT nextval('dbo.odsinstances_odsinstanceid_seq'::regclass);


--
-- Name: ownershiptokens ownershiptokenid; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ownershiptokens ALTER COLUMN ownershiptokenid SET DEFAULT nextval('dbo.ownershiptokens_ownershiptokenid_seq'::regclass);


--
-- Name: profiles profileid; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.profiles ALTER COLUMN profileid SET DEFAULT nextval('dbo.profiles_profileid_seq'::regclass);


--
-- Name: users userid; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.users ALTER COLUMN userid SET DEFAULT nextval('dbo.users_userid_seq'::regclass);


--
-- Name: vendornamespaceprefixes vendornamespaceprefixid; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.vendornamespaceprefixes ALTER COLUMN vendornamespaceprefixid SET DEFAULT nextval('dbo.vendornamespaceprefixes_vendornamespaceprefixid_seq'::regclass);


--
-- Name: vendors vendorid; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.vendors ALTER COLUMN vendorid SET DEFAULT nextval('dbo.vendors_vendorid_seq'::regclass);


--
-- Name: DeployJournal schemaversionsid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DeployJournal" ALTER COLUMN schemaversionsid SET DEFAULT nextval('public."DeployJournal_schemaversionsid_seq"'::regclass);


--
-- Data for Name: apiclientapplicationeducationorganizations; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.apiclientapplicationeducationorganizations (apiclient_apiclientid, applicationedorg_applicationedorgid) FROM stdin;
\.


--
-- Data for Name: apiclientodsinstances; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.apiclientodsinstances (apiclientodsinstanceid, apiclient_apiclientid, odsinstance_odsinstanceid) FROM stdin;
\.


--
-- Data for Name: apiclientownershiptokens; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.apiclientownershiptokens (apiclientownershiptokenid, apiclient_apiclientid, ownershiptoken_ownershiptokenid) FROM stdin;
\.


--
-- Data for Name: apiclients; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.apiclients (apiclientid, key, secret, name, isapproved, usesandbox, sandboxtype, application_applicationid, user_userid, keystatus, challengeid, challengeexpiry, activationcode, activationretried, secretishashed, studentidentificationsystemdescriptor, creatorownershiptokenid_ownershiptokenid) FROM stdin;
\.


--
-- Data for Name: applicationeducationorganizations; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.applicationeducationorganizations (applicationeducationorganizationid, educationorganizationid, application_applicationid) FROM stdin;
\.


--
-- Data for Name: applications; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.applications (applicationid, applicationname, vendor_vendorid, claimsetname, operationalcontexturi) FROM stdin;
\.


--
-- Data for Name: aspnetroleclaims; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.aspnetroleclaims (id, roleid, claimtype, claimvalue) FROM stdin;
\.


--
-- Data for Name: aspnetroles; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.aspnetroles (id, name, normalizedname, concurrencystamp) FROM stdin;
\.


--
-- Data for Name: aspnetuserclaims; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.aspnetuserclaims (id, userid, claimtype, claimvalue) FROM stdin;
\.


--
-- Data for Name: aspnetuserlogins; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.aspnetuserlogins (loginprovider, providerkey, providerdisplayname, userid) FROM stdin;
\.


--
-- Data for Name: aspnetuserroles; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.aspnetuserroles (userid, roleid) FROM stdin;
\.


--
-- Data for Name: aspnetusers; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.aspnetusers (id, username, normalizedusername, email, normalizedemail, emailconfirmed, passwordhash, securitystamp, concurrencystamp, phonenumber, phonenumberconfirmed, twofactorenabled, lockoutend, lockoutenabled, accessfailedcount) FROM stdin;
\.


--
-- Data for Name: aspnetusertokens; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.aspnetusertokens (userid, loginprovider, name, value) FROM stdin;
\.


--
-- Data for Name: clientaccesstokens; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.clientaccesstokens (id, expiration, scope, apiclient_apiclientid) FROM stdin;
\.


--
-- Data for Name: odsinstancecontexts; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.odsinstancecontexts (odsinstancecontextid, odsinstance_odsinstanceid, contextkey, contextvalue) FROM stdin;
\.


--
-- Data for Name: odsinstancederivatives; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.odsinstancederivatives (odsinstancederivativeid, odsinstance_odsinstanceid, derivativetype, connectionstring) FROM stdin;
\.


--
-- Data for Name: odsinstances; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.odsinstances (odsinstanceid, name, instancetype, connectionstring) FROM stdin;
\.


--
-- Data for Name: ownershiptokens; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.ownershiptokens (ownershiptokenid, description) FROM stdin;
\.


--
-- Data for Name: profileapplications; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.profileapplications (profile_profileid, application_applicationid) FROM stdin;
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.profiles (profileid, profilename, profiledefinition) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.users (userid, email, fullname, vendor_vendorid) FROM stdin;
\.


--
-- Data for Name: vendornamespaceprefixes; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.vendornamespaceprefixes (vendornamespaceprefixid, namespaceprefix, vendor_vendorid) FROM stdin;
\.


--
-- Data for Name: vendors; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.vendors (vendorid, vendorname) FROM stdin;
\.


--
-- Data for Name: DeployJournal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."DeployJournal" (schemaversionsid, scriptname, applied) FROM stdin;
1	Artifacts.PgSql.Structure.Admin.0010-Schemas.sql	2023-12-06 23:20:05.191215
2	Artifacts.PgSql.Structure.Admin.0020-Tables.sql	2023-12-06 23:20:05.338413
3	Artifacts.PgSql.Structure.Admin.0030-ForeignKey.sql	2023-12-06 23:20:05.386313
4	Artifacts.PgSql.Structure.Admin.0040-IdColumnIndexes.sql	2023-12-06 23:20:05.526047
5	Artifacts.PgSql.Structure.Admin.0050-StoredProcedures.sql	2023-12-06 23:20:05.533334
6	Artifacts.PgSql.Structure.Admin.0051-Rename-AccessToken-Function.sql	2023-12-06 23:20:05.539423
7	Artifacts.PgSql.Structure.Admin.0060-Add-OwnershipTokens.sql	2023-12-06 23:20:05.551802
8	Artifacts.PgSql.Structure.Admin.0061-Add-ApiClientsOwnershipTokens.sql	2023-12-06 23:20:05.570297
9	Artifacts.PgSql.Structure.Admin.0062-Add-CreatorOwnershipTokenId-To-ApiClients.sql	2023-12-06 23:20:05.582063
10	Artifacts.PgSql.Structure.Admin.0063-Update-GetClientForToken-For-Record-Level-Ownership.sql	2023-12-06 23:20:05.587728
11	Artifacts.PgSql.Structure.Admin.0065-Update-GetClientForToken-For-Scope-Support.sql	2023-12-06 23:20:05.595349
12	Artifacts.PgSql.Structure.Admin.0070-Identity-Support.sql	2023-12-06 23:20:05.740729
13	Artifacts.PgSql.Structure.Admin.0080-Add-Index-ClientAccessTokens-Expiration.sql	2023-12-06 23:20:05.752757
14	Artifacts.PgSql.Structure.Admin.0090-Add-Expiration-to-GetClientForToken.sql	2023-12-06 23:20:05.757497
15	Artifacts.PgSql.Structure.Admin.0100-Add-ApiclientId-to-GetClientForToken.sql	2023-12-06 23:20:05.762018
16	Artifacts.PgSql.Structure.Admin.0110-GetClient-ForToken-ForKey-using-shared-view.sql	2023-12-06 23:20:05.771749
17	Artifacts.PgSql.Structure.Admin.0120-Add-GetClientForKey-Indexes.sql	2023-12-06 23:20:05.794314
18	Artifacts.PgSql.Structure.Admin.0130-Add-ProfileDefinition-to-Profile.sql	2023-12-06 23:20:05.798693
19	Artifacts.PgSql.Structure.Admin.0131-Add-ApiClientOdsInstances-Table-Modify-GetClientForToken.sql	2023-12-06 23:20:05.818276
20	Artifacts.PgSql.Structure.Admin.0140-Add-GetOdsInstanceConfigurationById-Function.sql	2023-12-06 23:20:05.822452
21	Artifacts.PgSql.Structure.Admin.0141-Add-OdsInstanceDerivative.sql	2023-12-06 23:20:05.845829
22	Artifacts.PgSql.Structure.Admin.0142-Add-OdsInstanceContext.sql	2023-12-06 23:20:05.86457
23	Artifacts.PgSql.Structure.Admin.0143-Update-GetOdsInstanceConfigurationById.sql	2023-12-06 23:20:05.869251
24	Artifacts.PgSql.Structure.Admin.0144-Drop-OdsInstanceComponent.sql	2023-12-06 23:20:05.877048
25	Artifacts.PgSql.Structure.Admin.0145-Drop-OdsInstances-UnusedCols.sql	2023-12-06 23:20:05.881554
26	Artifacts.PgSql.Structure.Admin.0150-Alter-EducationOrganizationId-to-bigint.sql	2023-12-06 23:20:05.897415
27	Artifacts.PgSql.Structure.Admin.0155-Alter-OdsInstances-AllowNullOnInstanceTypeColumn.sql	2023-12-06 23:20:05.907277
28	Artifacts.PgSql.Structure.Admin.0160-Rename-OdsInstanceContext.sql	2023-12-06 23:20:05.927776
29	Artifacts.PgSql.Structure.Admin.0161-Rename-OdsInstanceDerivative.sql	2023-12-06 23:20:05.944759
30	Artifacts.PgSql.Structure.Admin.0170-Drop-OdsInstance-From-Application.sql	2023-12-06 23:20:05.949951
31	Artifacts.PgSql.Structure.Admin.0171-Alter-OdsInstances-ConnectionString.sql	2023-12-06 23:20:05.957561
32	Artifacts.PgSql.Structure.Admin.0172-Alter-ApplicationEducationOrganizations.sql	2023-12-06 23:20:05.967879
33	Artifacts.PgSql.Structure.Admin.0173-Add-GetOdsInstanceContextValues.sql	2023-12-06 23:20:05.972133
\.


--
-- Name: apiclientodsinstances_apiclientodsinstanceid_seq; Type: SEQUENCE SET; Schema: dbo; Owner: postgres
--

SELECT pg_catalog.setval('dbo.apiclientodsinstances_apiclientodsinstanceid_seq', 1, false);


--
-- Name: apiclientownershiptokens_apiclientownershiptokenid_seq; Type: SEQUENCE SET; Schema: dbo; Owner: postgres
--

SELECT pg_catalog.setval('dbo.apiclientownershiptokens_apiclientownershiptokenid_seq', 1, false);


--
-- Name: apiclients_apiclientid_seq; Type: SEQUENCE SET; Schema: dbo; Owner: postgres
--

SELECT pg_catalog.setval('dbo.apiclients_apiclientid_seq', 1, false);


--
-- Name: applicationeducationorganizat_applicationeducationorganizat_seq; Type: SEQUENCE SET; Schema: dbo; Owner: postgres
--

SELECT pg_catalog.setval('dbo.applicationeducationorganizat_applicationeducationorganizat_seq', 1, false);


--
-- Name: applications_applicationid_seq; Type: SEQUENCE SET; Schema: dbo; Owner: postgres
--

SELECT pg_catalog.setval('dbo.applications_applicationid_seq', 1, false);


--
-- Name: aspnetroleclaims_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: postgres
--

SELECT pg_catalog.setval('dbo.aspnetroleclaims_id_seq', 1, false);


--
-- Name: aspnetuserclaims_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: postgres
--

SELECT pg_catalog.setval('dbo.aspnetuserclaims_id_seq', 1, false);


--
-- Name: odsinstancecontext_odsinstancecontextid_seq; Type: SEQUENCE SET; Schema: dbo; Owner: postgres
--

SELECT pg_catalog.setval('dbo.odsinstancecontext_odsinstancecontextid_seq', 1, false);


--
-- Name: odsinstancederivative_odsinstancederivativeid_seq; Type: SEQUENCE SET; Schema: dbo; Owner: postgres
--

SELECT pg_catalog.setval('dbo.odsinstancederivative_odsinstancederivativeid_seq', 1, false);


--
-- Name: odsinstances_odsinstanceid_seq; Type: SEQUENCE SET; Schema: dbo; Owner: postgres
--

SELECT pg_catalog.setval('dbo.odsinstances_odsinstanceid_seq', 1, false);


--
-- Name: ownershiptokens_ownershiptokenid_seq; Type: SEQUENCE SET; Schema: dbo; Owner: postgres
--

SELECT pg_catalog.setval('dbo.ownershiptokens_ownershiptokenid_seq', 1, false);


--
-- Name: profiles_profileid_seq; Type: SEQUENCE SET; Schema: dbo; Owner: postgres
--

SELECT pg_catalog.setval('dbo.profiles_profileid_seq', 1, false);


--
-- Name: users_userid_seq; Type: SEQUENCE SET; Schema: dbo; Owner: postgres
--

SELECT pg_catalog.setval('dbo.users_userid_seq', 1, false);


--
-- Name: vendornamespaceprefixes_vendornamespaceprefixid_seq; Type: SEQUENCE SET; Schema: dbo; Owner: postgres
--

SELECT pg_catalog.setval('dbo.vendornamespaceprefixes_vendornamespaceprefixid_seq', 1, false);


--
-- Name: vendors_vendorid_seq; Type: SEQUENCE SET; Schema: dbo; Owner: postgres
--

SELECT pg_catalog.setval('dbo.vendors_vendorid_seq', 1, false);


--
-- Name: DeployJournal_schemaversionsid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."DeployJournal_schemaversionsid_seq"', 33, true);


--
-- Name: apiclientapplicationeducationorganizations apiclientapplicationeducationorganizations_pk; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.apiclientapplicationeducationorganizations
    ADD CONSTRAINT apiclientapplicationeducationorganizations_pk PRIMARY KEY (apiclient_apiclientid, applicationedorg_applicationedorgid);


--
-- Name: apiclientodsinstances apiclientodsinstances_pkey; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.apiclientodsinstances
    ADD CONSTRAINT apiclientodsinstances_pkey PRIMARY KEY (apiclientodsinstanceid);


--
-- Name: apiclientownershiptokens apiclientownershiptokens_pkey; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.apiclientownershiptokens
    ADD CONSTRAINT apiclientownershiptokens_pkey PRIMARY KEY (apiclientownershiptokenid);


--
-- Name: apiclients apiclients_pk; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.apiclients
    ADD CONSTRAINT apiclients_pk PRIMARY KEY (apiclientid);


--
-- Name: applicationeducationorganizations applicationeducationorganizations_pk; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.applicationeducationorganizations
    ADD CONSTRAINT applicationeducationorganizations_pk PRIMARY KEY (applicationeducationorganizationid);


--
-- Name: applications applications_pk; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.applications
    ADD CONSTRAINT applications_pk PRIMARY KEY (applicationid);


--
-- Name: clientaccesstokens clientaccesstokens_pk; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.clientaccesstokens
    ADD CONSTRAINT clientaccesstokens_pk PRIMARY KEY (id);


--
-- Name: odsinstancecontexts odsinstancecontext_pkey; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.odsinstancecontexts
    ADD CONSTRAINT odsinstancecontext_pkey PRIMARY KEY (odsinstancecontextid);


--
-- Name: odsinstancederivatives odsinstancederivative_pkey; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.odsinstancederivatives
    ADD CONSTRAINT odsinstancederivative_pkey PRIMARY KEY (odsinstancederivativeid);


--
-- Name: odsinstances odsinstances_pk; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.odsinstances
    ADD CONSTRAINT odsinstances_pk PRIMARY KEY (odsinstanceid);


--
-- Name: ownershiptokens ownershiptokens_pkey; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ownershiptokens
    ADD CONSTRAINT ownershiptokens_pkey PRIMARY KEY (ownershiptokenid);


--
-- Name: aspnetroleclaims pk_aspnetroleclaims; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.aspnetroleclaims
    ADD CONSTRAINT pk_aspnetroleclaims PRIMARY KEY (id);


--
-- Name: aspnetroles pk_aspnetroles; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.aspnetroles
    ADD CONSTRAINT pk_aspnetroles PRIMARY KEY (id);


--
-- Name: aspnetuserclaims pk_aspnetuserclaims; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.aspnetuserclaims
    ADD CONSTRAINT pk_aspnetuserclaims PRIMARY KEY (id);


--
-- Name: aspnetuserlogins pk_aspnetuserlogins; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.aspnetuserlogins
    ADD CONSTRAINT pk_aspnetuserlogins PRIMARY KEY (loginprovider, providerkey);


--
-- Name: aspnetuserroles pk_aspnetuserroles; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.aspnetuserroles
    ADD CONSTRAINT pk_aspnetuserroles PRIMARY KEY (userid, roleid);


--
-- Name: aspnetusers pk_aspnetusers; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.aspnetusers
    ADD CONSTRAINT pk_aspnetusers PRIMARY KEY (id);


--
-- Name: aspnetusertokens pk_aspnetusertokens; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.aspnetusertokens
    ADD CONSTRAINT pk_aspnetusertokens PRIMARY KEY (userid, loginprovider, name);


--
-- Name: profileapplications profileapplications_pk; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.profileapplications
    ADD CONSTRAINT profileapplications_pk PRIMARY KEY (profile_profileid, application_applicationid);


--
-- Name: profiles profiles_pk; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.profiles
    ADD CONSTRAINT profiles_pk PRIMARY KEY (profileid);


--
-- Name: odsinstancecontexts uc_odsinstancecontext_odsinstance_odsinstanceid_contextkey; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.odsinstancecontexts
    ADD CONSTRAINT uc_odsinstancecontext_odsinstance_odsinstanceid_contextkey UNIQUE (odsinstance_odsinstanceid, contextkey);


--
-- Name: odsinstancederivatives uc_odsinstancederivative_odsinstance_odsinstanceid_derivativety; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.odsinstancederivatives
    ADD CONSTRAINT uc_odsinstancederivative_odsinstance_odsinstanceid_derivativety UNIQUE (odsinstance_odsinstanceid, derivativetype);


--
-- Name: users users_pk; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.users
    ADD CONSTRAINT users_pk PRIMARY KEY (userid);


--
-- Name: vendornamespaceprefixes vendornamespaceprefixes_pk; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.vendornamespaceprefixes
    ADD CONSTRAINT vendornamespaceprefixes_pk PRIMARY KEY (vendornamespaceprefixid);


--
-- Name: vendors vendors_pk; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.vendors
    ADD CONSTRAINT vendors_pk PRIMARY KEY (vendorid);


--
-- Name: DeployJournal PK_DeployJournal_Id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DeployJournal"
    ADD CONSTRAINT "PK_DeployJournal_Id" PRIMARY KEY (schemaversionsid);


--
-- Name: ak_apiclients; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX ak_apiclients ON dbo.apiclients USING btree (apiclientid);


--
-- Name: emailindex; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX emailindex ON dbo.aspnetusers USING btree (normalizedemail);


--
-- Name: ix_apiclient_apiclientid; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX ix_apiclient_apiclientid ON dbo.apiclientapplicationeducationorganizations USING btree (apiclient_apiclientid);


--
-- Name: ix_apiclientownershiptokens_apiclientid; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX ix_apiclientownershiptokens_apiclientid ON dbo.apiclientownershiptokens USING btree (apiclient_apiclientid) INCLUDE (ownershiptoken_ownershiptokenid);


--
-- Name: ix_application_applicationid; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX ix_application_applicationid ON dbo.applicationeducationorganizations USING btree (application_applicationid);


--
-- Name: ix_applicationedorg_applicationedorgid; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX ix_applicationedorg_applicationedorgid ON dbo.apiclientapplicationeducationorganizations USING btree (applicationedorg_applicationedorgid);


--
-- Name: ix_aspnetroleclaims_roleid; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX ix_aspnetroleclaims_roleid ON dbo.aspnetroleclaims USING btree (roleid);


--
-- Name: ix_aspnetuserclaims_userid; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX ix_aspnetuserclaims_userid ON dbo.aspnetuserclaims USING btree (userid);


--
-- Name: ix_aspnetuserlogins_userid; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX ix_aspnetuserlogins_userid ON dbo.aspnetuserlogins USING btree (userid);


--
-- Name: ix_aspnetuserroles_roleid; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX ix_aspnetuserroles_roleid ON dbo.aspnetuserroles USING btree (roleid);


--
-- Name: ix_clientaccesstokens_expiration; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX ix_clientaccesstokens_expiration ON dbo.clientaccesstokens USING btree (expiration DESC);


--
-- Name: ix_creatorownershiptokenid_ownershiptokenid; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX ix_creatorownershiptokenid_ownershiptokenid ON dbo.apiclients USING btree (creatorownershiptokenid_ownershiptokenid);


--
-- Name: ix_ownershiptoken_ownershiptokenid; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX ix_ownershiptoken_ownershiptokenid ON dbo.apiclientownershiptokens USING btree (ownershiptoken_ownershiptokenid);


--
-- Name: ix_profile_profileid; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX ix_profile_profileid ON dbo.profileapplications USING btree (profile_profileid);


--
-- Name: ix_user_userid; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX ix_user_userid ON dbo.apiclients USING btree (user_userid);


--
-- Name: ix_vendor_vendorid; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX ix_vendor_vendorid ON dbo.applications USING btree (vendor_vendorid);


--
-- Name: ix_vendornamespaceprefixes_vendorid; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX ix_vendornamespaceprefixes_vendorid ON dbo.vendornamespaceprefixes USING btree (vendor_vendorid) INCLUDE (namespaceprefix);


--
-- Name: rolenameindex; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX rolenameindex ON dbo.aspnetroles USING btree (normalizedname);


--
-- Name: usernameindex; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX usernameindex ON dbo.aspnetusers USING btree (normalizedusername);


--
-- Name: ux_name_instancetype; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX ux_name_instancetype ON dbo.odsinstances USING btree (name, instancetype);


--
-- Name: apiclientapplicationeducationorganizations fk_apiclientapplicationedorg_applicationedorg; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.apiclientapplicationeducationorganizations
    ADD CONSTRAINT fk_apiclientapplicationedorg_applicationedorg FOREIGN KEY (applicationedorg_applicationedorgid) REFERENCES dbo.applicationeducationorganizations(applicationeducationorganizationid) ON DELETE CASCADE;


--
-- Name: apiclientapplicationeducationorganizations fk_apiclientapplicationeducationorganizations_apiclients; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.apiclientapplicationeducationorganizations
    ADD CONSTRAINT fk_apiclientapplicationeducationorganizations_apiclients FOREIGN KEY (apiclient_apiclientid) REFERENCES dbo.apiclients(apiclientid) ON DELETE CASCADE;


--
-- Name: apiclientodsinstances fk_apiclientodsinstances_apiclients_apiclient_apiclientid; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.apiclientodsinstances
    ADD CONSTRAINT fk_apiclientodsinstances_apiclients_apiclient_apiclientid FOREIGN KEY (apiclient_apiclientid) REFERENCES dbo.apiclients(apiclientid);


--
-- Name: apiclientodsinstances fk_apiclientodsinstances_odsinstances_odsinstance_odsinstanceid; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.apiclientodsinstances
    ADD CONSTRAINT fk_apiclientodsinstances_odsinstances_odsinstance_odsinstanceid FOREIGN KEY (odsinstance_odsinstanceid) REFERENCES dbo.odsinstances(odsinstanceid);


--
-- Name: apiclientownershiptokens fk_apiclientownershiptokens_apiclients_apiclient_apiclientid; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.apiclientownershiptokens
    ADD CONSTRAINT fk_apiclientownershiptokens_apiclients_apiclient_apiclientid FOREIGN KEY (apiclient_apiclientid) REFERENCES dbo.apiclients(apiclientid) ON DELETE CASCADE;


--
-- Name: apiclientownershiptokens fk_apiclientownershiptokens_ownershiptokens_ownershiptoken_owne; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.apiclientownershiptokens
    ADD CONSTRAINT fk_apiclientownershiptokens_ownershiptokens_ownershiptoken_owne FOREIGN KEY (ownershiptoken_ownershiptokenid) REFERENCES dbo.ownershiptokens(ownershiptokenid) ON DELETE CASCADE;


--
-- Name: apiclients fk_apiclients_applications; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.apiclients
    ADD CONSTRAINT fk_apiclients_applications FOREIGN KEY (application_applicationid) REFERENCES dbo.applications(applicationid);


--
-- Name: apiclients fk_apiclients_creatorownershiptokenid_ownershiptokenid; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.apiclients
    ADD CONSTRAINT fk_apiclients_creatorownershiptokenid_ownershiptokenid FOREIGN KEY (creatorownershiptokenid_ownershiptokenid) REFERENCES dbo.ownershiptokens(ownershiptokenid);


--
-- Name: apiclients fk_apiclients_users; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.apiclients
    ADD CONSTRAINT fk_apiclients_users FOREIGN KEY (user_userid) REFERENCES dbo.users(userid);


--
-- Name: applicationeducationorganizations fk_applicationeducationorganizations_applications; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.applicationeducationorganizations
    ADD CONSTRAINT fk_applicationeducationorganizations_applications FOREIGN KEY (application_applicationid) REFERENCES dbo.applications(applicationid);


--
-- Name: applications fk_applications_vendors; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.applications
    ADD CONSTRAINT fk_applications_vendors FOREIGN KEY (vendor_vendorid) REFERENCES dbo.vendors(vendorid);


--
-- Name: aspnetroleclaims fk_aspnetroleclaims_aspnetroles_roleid; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.aspnetroleclaims
    ADD CONSTRAINT fk_aspnetroleclaims_aspnetroles_roleid FOREIGN KEY (roleid) REFERENCES dbo.aspnetroles(id) ON DELETE CASCADE;


--
-- Name: aspnetuserclaims fk_aspnetuserclaims_aspnetusers_userid; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.aspnetuserclaims
    ADD CONSTRAINT fk_aspnetuserclaims_aspnetusers_userid FOREIGN KEY (userid) REFERENCES dbo.aspnetusers(id) ON DELETE CASCADE;


--
-- Name: aspnetuserlogins fk_aspnetuserlogins_aspnetusers_userid; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.aspnetuserlogins
    ADD CONSTRAINT fk_aspnetuserlogins_aspnetusers_userid FOREIGN KEY (userid) REFERENCES dbo.aspnetusers(id) ON DELETE CASCADE;


--
-- Name: aspnetuserroles fk_aspnetuserroles_aspnetroles_roleid; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.aspnetuserroles
    ADD CONSTRAINT fk_aspnetuserroles_aspnetroles_roleid FOREIGN KEY (roleid) REFERENCES dbo.aspnetroles(id) ON DELETE CASCADE;


--
-- Name: aspnetuserroles fk_aspnetuserroles_aspnetusers_userid; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.aspnetuserroles
    ADD CONSTRAINT fk_aspnetuserroles_aspnetusers_userid FOREIGN KEY (userid) REFERENCES dbo.aspnetusers(id) ON DELETE CASCADE;


--
-- Name: aspnetusertokens fk_aspnetusertokens_aspnetusers_userid; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.aspnetusertokens
    ADD CONSTRAINT fk_aspnetusertokens_aspnetusers_userid FOREIGN KEY (userid) REFERENCES dbo.aspnetusers(id) ON DELETE CASCADE;


--
-- Name: clientaccesstokens fk_clientaccesstokens_apiclients; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.clientaccesstokens
    ADD CONSTRAINT fk_clientaccesstokens_apiclients FOREIGN KEY (apiclient_apiclientid) REFERENCES dbo.apiclients(apiclientid);


--
-- Name: odsinstancecontexts fk_odsinstancecontext_odsinstance_odsinstanceid; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.odsinstancecontexts
    ADD CONSTRAINT fk_odsinstancecontext_odsinstance_odsinstanceid FOREIGN KEY (odsinstance_odsinstanceid) REFERENCES dbo.odsinstances(odsinstanceid);


--
-- Name: odsinstancederivatives fk_odsinstancederivative_odsinstance_odsinstanceid; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.odsinstancederivatives
    ADD CONSTRAINT fk_odsinstancederivative_odsinstance_odsinstanceid FOREIGN KEY (odsinstance_odsinstanceid) REFERENCES dbo.odsinstances(odsinstanceid);


--
-- Name: profileapplications fk_profileapplications_applications; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.profileapplications
    ADD CONSTRAINT fk_profileapplications_applications FOREIGN KEY (application_applicationid) REFERENCES dbo.applications(applicationid) ON DELETE CASCADE;


--
-- Name: profileapplications fk_profileapplications_profiles; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.profileapplications
    ADD CONSTRAINT fk_profileapplications_profiles FOREIGN KEY (profile_profileid) REFERENCES dbo.profiles(profileid) ON DELETE CASCADE;


--
-- Name: users fk_users_vendors; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.users
    ADD CONSTRAINT fk_users_vendors FOREIGN KEY (vendor_vendorid) REFERENCES dbo.vendors(vendorid);


--
-- Name: vendornamespaceprefixes fk_vendornamespaceprefixes_vendors; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.vendornamespaceprefixes
    ADD CONSTRAINT fk_vendornamespaceprefixes_vendors FOREIGN KEY (vendor_vendorid) REFERENCES dbo.vendors(vendorid) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

