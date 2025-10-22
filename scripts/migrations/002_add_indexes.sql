-- ============================================
-- Migration 002: Index
-- ============================================

CREATE INDEX IF NOT EXISTS idx_returned_products_supplier ON returned_products(supplier_id);
CREATE INDEX IF NOT EXISTS idx_returned_products_customer ON returned_products(customer_id);
CREATE INDEX IF NOT EXISTS idx_returned_products_status   ON returned_products(current_status_id);
CREATE INDEX IF NOT EXISTS idx_returned_products_dates    ON returned_products(return_date, purchase_date);

SELECT 'Index crees' AS message;