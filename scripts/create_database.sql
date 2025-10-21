-- ============================================
-- Script de création de la base ITManagementDB
-- Système de gestion du recyclage IT
-- ============================================
-- Note: La base est déjà créée dans pgAdmin
-- Ce script documente la configuration utilisée

-- Configuration utilisée pour la création :
-- Database name: ITManagementDB
-- Owner: postgres
-- Encoding: UTF8
-- Collation: C.UTF-8 (ou fr_FR.UTF-8)
-- Character Type: C.UTF-8 (ou fr_FR.UTF-8)

-- Commande équivalente (pour référence) :
/*
CREATE DATABASE "ITManagementDB"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C.UTF-8'
    LC_CTYPE = 'C.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
*/

-- Se connecter à la base
\c ITManagementDB;

-- Créer les extensions nécessaires
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm"; -- Pour la recherche full-text

COMMENT ON DATABASE "ITManagementDB" IS 'Base de données pour la gestion du recyclage et de la revente de produits IT retournés';
