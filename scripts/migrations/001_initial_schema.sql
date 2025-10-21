-- ============================================
-- Migration 001: Création du schéma initial
-- Date: 2025-10-21
-- Description: Création de toutes les tables du système
-- ============================================
\encoding UTF8
\c ITManagementDB;

-- ============================================
-- TABLES DE RÉFÉRENCE
-- ============================================

-- Table suppliers
CREATE TABLE IF NOT EXISTS suppliers (
    supplier_id VARCHAR(255) PRIMARY KEY,
    supplier_name VARCHAR(255) NOT NULL,
    supplier_location VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE suppliers IS 'Fournisseurs des produits retournés';

-- Table customers
CREATE TABLE IF NOT EXISTS customers (
    customer_id VARCHAR(255) PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    customer_email VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE customers IS 'Clients ayant retourné des produits';

-- Table os
CREATE TABLE IF NOT EXISTS os (
    os_id VARCHAR(255) PRIMARY KEY,
    os_name VARCHAR(255) NOT NULL,
    os_version VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE os IS 'Systèmes d''exploitation installés';

-- Table destinations
CREATE TABLE IF NOT EXISTS destinations (
    destination_id VARCHAR(255) PRIMARY KEY,
    destination_name VARCHAR(255) NOT NULL,
    destination_type VARCHAR(50) CHECK (destination_type IN ('RECYCLING', 'RESALE', 'DONATION', 'DESTRUCTION', 'REPAIR')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE destinations IS 'Destinations finales des produits';

-- Table status
CREATE TABLE IF NOT EXISTS status (
    status_id VARCHAR(255) PRIMARY KEY,
    status_name VARCHAR(255) NOT NULL,
    status_order INTEGER NOT NULL,
    destination_id VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_status_destination FOREIGN KEY (destination_id) 
        REFERENCES destinations(destination_id) ON DELETE SET NULL
);

COMMENT ON TABLE status IS 'Statuts du cycle de vie des produits';

-- Table technical_issues
CREATE TABLE IF NOT EXISTS technical_issues (
    issue_id VARCHAR(255) PRIMARY KEY,
    issue_name VARCHAR(255) NOT NULL,
    issue_description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE technical_issues IS 'Catalogue des problèmes techniques';

-- Table components
CREATE TABLE IF NOT EXISTS components (
    component_id VARCHAR(255) PRIMARY KEY,
    component_name VARCHAR(255) NOT NULL,
    component_category VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE components IS 'Catalogue des composants matériels';

-- Table technicians
CREATE TABLE IF NOT EXISTS technicians (
    technician_id VARCHAR(255) PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(50),
    specialization VARCHAR(255),
    hire_date DATE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE technicians IS 'Techniciens effectuant les vérifications';

-- Table checkup_tasks
CREATE TABLE IF NOT EXISTS checkup_tasks (
    task_id SERIAL PRIMARY KEY,
    task_name VARCHAR(255) NOT NULL,
    task_description TEXT,
    task_category VARCHAR(50) CHECK (task_category IN ('HARDWARE', 'SOFTWARE', 'NETWORK', 'SECURITY', 'COSMETIC')),
    task_order INTEGER NOT NULL,
    is_mandatory BOOLEAN DEFAULT TRUE,
    estimated_duration_minutes INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE checkup_tasks IS 'Tâches standard de vérification';

-- ============================================
-- TABLE PRINCIPALE
-- ============================================

CREATE TABLE IF NOT EXISTS returned_products (
    serial_number VARCHAR(255) PRIMARY KEY,
    purchase_date DATE NOT NULL,
    return_date DATE NOT NULL,
    supplier_id VARCHAR(255) NOT NULL,
    customer_id VARCHAR(255) NOT NULL,
    os_id VARCHAR(255),
    current_status_id VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_supplier FOREIGN KEY (supplier_id) 
        REFERENCES suppliers(supplier_id) ON DELETE RESTRICT,
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) 
        REFERENCES customers(customer_id) ON DELETE RESTRICT,
    CONSTRAINT fk_os FOREIGN KEY (os_id) 
        REFERENCES os(os_id) ON DELETE SET NULL,
    CONSTRAINT fk_current_status FOREIGN KEY (current_status_id) 
        REFERENCES status(status_id) ON DELETE RESTRICT
);

COMMENT ON TABLE returned_products IS 'Table centrale des produits IT retournés';

-- ============================================
-- TABLES DE JONCTION
-- ============================================

CREATE TABLE IF NOT EXISTS product_issues (
    id SERIAL PRIMARY KEY,
    serial_number VARCHAR(255) NOT NULL,
    technical_issue_id VARCHAR(255) NOT NULL,
    reported_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_product_issue_serial FOREIGN KEY (serial_number) 
        REFERENCES returned_products(serial_number) ON DELETE CASCADE,
    CONSTRAINT fk_product_issue_tech FOREIGN KEY (technical_issue_id) 
        REFERENCES technical_issues(issue_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS defective_components (
    id SERIAL PRIMARY KEY,
    serial_number VARCHAR(255) NOT NULL,
    component_id VARCHAR(255) NOT NULL,
    reported_by_customer BOOLEAN DEFAULT FALSE,
    detection_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_defective_serial FOREIGN KEY (serial_number) 
        REFERENCES returned_products(serial_number) ON DELETE CASCADE,
    CONSTRAINT fk_defective_component FOREIGN KEY (component_id) 
        REFERENCES components(component_id) ON DELETE CASCADE
);

-- ============================================
-- TABLES DE VÉRIFICATION
-- ============================================

CREATE TABLE IF NOT EXISTS product_checkups (
    checkup_id SERIAL PRIMARY KEY,
    serial_number VARCHAR(255) NOT NULL,
    technician_id VARCHAR(255) NOT NULL,
    checkup_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    checkup_start_time TIMESTAMP,
    checkup_end_time TIMESTAMP,
    overall_status VARCHAR(50) CHECK (overall_status IN ('PENDING', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED')) DEFAULT 'PENDING',
    technician_notes TEXT,
    estimated_repair_cost DECIMAL(10, 2),
    is_completed BOOLEAN DEFAULT FALSE,
    completed_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_checkup_serial FOREIGN KEY (serial_number) 
        REFERENCES returned_products(serial_number) ON DELETE CASCADE,
    CONSTRAINT fk_checkup_technician FOREIGN KEY (technician_id) 
        REFERENCES technicians(technician_id) ON DELETE RESTRICT
);

COMMENT ON TABLE product_checkups IS 'Vérifications techniques des produits';

CREATE TABLE IF NOT EXISTS checkup_component_results (
    id SERIAL PRIMARY KEY,
    checkup_id INTEGER NOT NULL,
    component_id VARCHAR(255) NOT NULL,
    component_status VARCHAR(50) CHECK (component_status IN ('OK', 'DEFECTIVE', 'MISSING', 'WORN')),
    notes TEXT,
    checked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_result_checkup FOREIGN KEY (checkup_id) 
        REFERENCES product_checkups(checkup_id) ON DELETE CASCADE,
    CONSTRAINT fk_result_component FOREIGN KEY (component_id) 
        REFERENCES components(component_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS checkup_task_completion (
    id SERIAL PRIMARY KEY,
    checkup_id INTEGER NOT NULL,
    task_id INTEGER NOT NULL,
    is_completed BOOLEAN DEFAULT FALSE,
    completion_date TIMESTAMP,
    completion_notes TEXT,
    task_result VARCHAR(50) CHECK (task_result IN ('PASS', 'FAIL', 'PARTIAL', 'NOT_APPLICABLE')) DEFAULT 'NOT_APPLICABLE',
    time_spent_minutes INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_completion_checkup FOREIGN KEY (checkup_id) 
        REFERENCES product_checkups(checkup_id) ON DELETE CASCADE,
    CONSTRAINT fk_completion_task FOREIGN KEY (task_id) 
        REFERENCES checkup_tasks(task_id) ON DELETE CASCADE,
    CONSTRAINT unique_checkup_task UNIQUE (checkup_id, task_id)
);

COMMENT ON TABLE checkup_task_completion IS 'Suivi d''exécution des tâches de vérification';

-- Message de confirmation
SELECT '✅ Schéma initial créé avec succès!' as message;