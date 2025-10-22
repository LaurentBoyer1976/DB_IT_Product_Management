\set ON_ERROR_STOP 1
-- ============================================
-- Migration 001: Schéma initial
-- ============================================

-- Référentiels
CREATE TABLE IF NOT EXISTS destinations (
  destination_id   TEXT PRIMARY KEY,
  destination_name TEXT NOT NULL,
  destination_type TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS status (
  status_id       TEXT PRIMARY KEY,
  status_name     TEXT NOT NULL,
  status_order    INTEGER NOT NULL,
  destination_id  TEXT NULL REFERENCES destinations(destination_id),
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS suppliers (
  supplier_id       TEXT PRIMARY KEY,
  supplier_name     TEXT,
  supplier_location TEXT,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS customers (
  customer_id    TEXT PRIMARY KEY,
  customer_name  TEXT,
  customer_email TEXT,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS os (
  os_id      TEXT PRIMARY KEY,
  os_name    TEXT NOT NULL,
  os_version TEXT
);

CREATE TABLE IF NOT EXISTS technical_issues (
  issue_id          TEXT PRIMARY KEY,
  issue_name        TEXT NOT NULL,
  issue_description TEXT
);

CREATE TABLE IF NOT EXISTS components (
  component_id       TEXT PRIMARY KEY,
  component_name     TEXT NOT NULL,
  component_category TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS technicians (
  technician_id TEXT PRIMARY KEY,
  first_name    TEXT,
  last_name     TEXT,
  email         TEXT,
  phone         TEXT,
  hire_date     DATE,
  is_active     BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS checkup_tasks (
  task_id       SERIAL PRIMARY KEY,
  task_name     TEXT UNIQUE NOT NULL,
  task_description TEXT,
  task_category   TEXT,
  task_order      INTEGER,
  is_mandatory    BOOLEAN NOT NULL DEFAULT TRUE,
  estimated_duration_minutes INTEGER
);



CREATE TABLE IF NOT EXISTS product_issues (
  serial_number      TEXT REFERENCES returned_products(serial_number) ON DELETE CASCADE,
  technical_issue_id TEXT REFERENCES technical_issues(issue_id),
  reported_date      TIMESTAMPTZ NOT NULL,
  PRIMARY KEY (serial_number, technical_issue_id, reported_date)
);

CREATE TABLE IF NOT EXISTS defective_components (
  serial_number        TEXT REFERENCES returned_products(serial_number) ON DELETE CASCADE,
  component_id         TEXT REFERENCES components(component_id),
  reported_by_customer BOOLEAN NOT NULL DEFAULT FALSE,
  detection_date       TIMESTAMPTZ NOT NULL,
  PRIMARY KEY (serial_number, component_id, detection_date)
);

SELECT 'Schema initial cree' AS message;