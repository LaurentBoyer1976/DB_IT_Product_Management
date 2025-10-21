-- ============================================
-- Migration 002: Ajout des index pour performances
-- Date: 2025-10-21
-- Description: Création des index pour optimiser les requêtes
-- ============================================

\c ITManagementDB;

-- Index sur returned_products
CREATE INDEX IF NOT EXISTS idx_returned_products_supplier ON returned_products(supplier_id);
CREATE INDEX IF NOT EXISTS idx_returned_products_customer ON returned_products(customer_id);
CREATE INDEX IF NOT EXISTS idx_returned_products_status ON returned_products(current_status_id);
CREATE INDEX IF NOT EXISTS idx_returned_products_dates ON returned_products(return_date, purchase_date);

-- Index sur product_issues
CREATE INDEX IF NOT EXISTS idx_product_issues_serial ON product_issues(serial_number);
CREATE INDEX IF NOT EXISTS idx_product_issues_tech ON product_issues(technical_issue_id);

-- Index sur defective_components
CREATE INDEX IF NOT EXISTS idx_defective_components_serial ON defective_components(serial_number);
CREATE INDEX IF NOT EXISTS idx_defective_components_comp ON defective_components(component_id);

-- Index sur product_checkups
CREATE INDEX IF NOT EXISTS idx_product_checkups_serial ON product_checkups(serial_number);
CREATE INDEX IF NOT EXISTS idx_product_checkups_technician ON product_checkups(technician_id);
CREATE INDEX IF NOT EXISTS idx_product_checkups_status ON product_checkups(overall_status);
CREATE INDEX IF NOT EXISTS idx_product_checkups_dates ON product_checkups(checkup_date, completed_at);

-- Index sur checkup_component_results
CREATE INDEX IF NOT EXISTS idx_checkup_results_checkup ON checkup_component_results(checkup_id);
CREATE INDEX IF NOT EXISTS idx_checkup_results_component ON checkup_component_results(component_id);

-- Index sur checkup_task_completion
CREATE INDEX IF NOT EXISTS idx_checkup_completion_checkup ON checkup_task_completion(checkup_id);
CREATE INDEX IF NOT EXISTS idx_checkup_completion_task ON checkup_task_completion(task_id);

-- Index sur technicians
CREATE INDEX IF NOT EXISTS idx_technicians_email ON technicians(email);
CREATE INDEX IF NOT EXISTS idx_technicians_active ON technicians(is_active);

-- Index pour recherche full-text
CREATE INDEX IF NOT EXISTS idx_technical_issues_name_trgm ON technical_issues USING gin(issue_name gin_trgm_ops);
CREATE INDEX IF NOT EXISTS idx_components_name_trgm ON components USING gin(component_name gin_trgm_ops);

-- ============================================
-- FONCTIONS ET TRIGGERS
-- ============================================

-- Fonction pour mettre à jour automatiquement updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Triggers pour updated_at
DROP TRIGGER IF EXISTS update_returned_products_updated_at ON returned_products;
CREATE TRIGGER update_returned_products_updated_at 
    BEFORE UPDATE ON returned_products 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_technicians_updated_at ON technicians;
CREATE TRIGGER update_technicians_updated_at 
    BEFORE UPDATE ON technicians 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_product_checkups_updated_at ON product_checkups;
CREATE TRIGGER update_product_checkups_updated_at 
    BEFORE UPDATE ON product_checkups 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_checkup_task_completion_updated_at ON checkup_task_completion;
CREATE TRIGGER update_checkup_task_completion_updated_at 
    BEFORE UPDATE ON checkup_task_completion 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Message de confirmation
SELECT '✅ Index et triggers créés avec succès!' as message;