-- ============================================
-- Script de création de la base ITManagementDB
-- Système de gestion du recyclage IT
-- ============================================

-- Se déconnecter et supprimer la base
\c postgres
DROP DATABASE IF EXISTS ITManagementDB;

-- Recréer avec UTF8
CREATE DATABASE ITManagementDB
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    TEMPLATE = template0;

COMMENT ON DATABASE ITManagementDB IS 'Base de données pour la gestion du recyclage et de la revente de produits IT retournés';

-- Se connecter à la base
\c ITManagementDB;

-- Créer les extensions nécessaires
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm"; -- Pour la recherche full-text

SELECT '✅ Base de données ITManagementDB créée avec succès!' as message;
