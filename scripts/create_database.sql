-- ============================================
-- Script de création de la base ITManagementDB
-- Système de gestion du recyclage IT
-- ============================================

\encoding UTF8

-- Se connecter explicitement à postgres
\connect -h 127.0.0.1 -U postgres postgres

-- Supprimer la base (nom en minuscules)
DROP DATABASE IF EXISTS itmanagementdb;

-- Recréer avec UTF8
CREATE DATABASE itmanagementdb
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    TEMPLATE = template0;

COMMENT ON DATABASE itmanagementdb IS 'Base de données pour la gestion du recyclage et de la revente de produits IT retournés';

-- Petite attente (Windows)
SELECT pg_sleep(0.5);

-- Se connecter explicitement à la nouvelle base
\connect -h 127.0.0.1 -U postgres itmanagementdb

-- Extensions nécessaires
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm"; -- Pour la recherche

SELECT '✅ Base de données ITManagementDB créée avec succès!' as message;
