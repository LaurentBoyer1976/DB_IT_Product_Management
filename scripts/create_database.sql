-- ============================================
-- Script de création de la base itmanagementdb
-- ============================================

\encoding UTF8
\connect -h 127.0.0.1 -U postgres postgres

DROP DATABASE IF EXISTS itmanagementdb;

CREATE DATABASE itmanagementdb
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       LC_COLLATE = 'C'
       LC_CTYPE   = 'C'
       TEMPLATE   = template0;

-- commentaire ASCII (pas d’accents/emoji)
COMMENT ON DATABASE itmanagementdb IS 'Base pour la gestion du recyclage et la revente de produits IT retournes';

SELECT pg_sleep(0.5);

\connect -h 127.0.0.1 -U postgres itmanagementdb

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

-- message ASCII
SELECT 'Base ITManagementDB creee avec succes' AS message;