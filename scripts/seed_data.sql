-- ============================================
-- Données de test pour ITManagementDB
-- Tablettes industrielles tactiles
-- ============================================
\encoding UTF8
\c ITManagementDB;

-- ============================================
-- DESTINATIONS
-- ============================================

INSERT INTO destinations (destination_id, destination_name, destination_type) VALUES
('DEST001','Recyclage certifie','RECYCLING'),
('DEST002','Revente reconditionnee','RESALE'),
('DEST003','Don association','DONATION'),
('DEST004','Destruction securisee','DESTRUCTION'),
('DEST005','Atelier reparation','REPAIR')
ON CONFLICT (destination_id) DO NOTHING;

-- ============================================
-- STATUS
-- ============================================

INSERT INTO status (status_id, status_name, status_order, destination_id) VALUES
('ST001','Recu',1,NULL),('ST002','En attente verification',2,NULL),('ST003','En cours de verification',3,NULL),
('ST004','Verifie - Fonctionnel',4,'DEST002'),('ST005','Verifie - Reparable',5,'DEST005'),
('ST006','Verifie - Non reparable',6,'DEST001'),('ST007','En reparation',7,'DEST005'),
('ST008','Repare',8,'DEST002'),('ST009','Pret pour revente',9,'DEST002'),('ST010','Vendu',10,'DEST002'),
('ST011','Don effectue',11,'DEST003'),('ST012','Recycle',12,'DEST001'),('ST013','Detruit',13,'DEST004')
ON CONFLICT (status_id) DO NOTHING;

-- ============================================
-- SUPPLIERS
-- ============================================

INSERT INTO suppliers (supplier_id, supplier_name, supplier_location) VALUES
('SUP001','Shenzhen HDFocus Technology Co Ltd','Shenzhen, Chine'),
('SUP002','Honeywell','USA'),
('SUP003','Samsung','Coree'),
('SUP004','Panasonic','Japon'),
('SUP005','Getac','Taiwan')
ON CONFLICT (supplier_id) DO NOTHING;

-- ============================================
-- CUSTOMERS
-- ============================================

INSERT INTO customers (customer_id, customer_name, customer_email) VALUES
('CUST001','Dalloz',''),
('CUST002','ARPA',''),
('CUST003','ROECHLING','tech@retailstore.fr'),
('CUST004','LOUVRE-HOTEL','it@manufacturing.fr'),
('CUST005','Client demo','')
ON CONFLICT (customer_id) DO NOTHING;

-- ============================================
-- OS (Systèmes d'exploitation pour tablettes industrielles)
-- ============================================

INSERT INTO os (os_id, os_name, os_version) VALUES
('OS001','Android','11 Enterprise'),
('OS002','Android','12 Enterprise'),
('OS003','Android','13 Enterprise'),
('OS004','Windows','10 IoT Enterprise'),
('OS005','Windows','11 IoT Enterprise')
ON CONFLICT (os_id) DO NOTHING;

-- ============================================
-- TECHNICAL ISSUES (Problèmes spécifiques tablettes industrielles)
-- ============================================

INSERT INTO technical_issues (issue_id, issue_name, issue_description) VALUES
('ISS001','Ecran tactile defectueux','Zones non reactives'),
('ISS002','Batterie defectueuse','Ne tient plus la charge'),
('ISS003','NFC non fonctionnel','Ne detecte pas les tags'),
('ISS004','Scanner code-barres HS','Defaillant'),
('ISS010','Ecran fissure','Ecran casse')
ON CONFLICT (issue_id) DO NOTHING;

-- ============================================
-- COMPONENTS (Composants tablettes industrielles)
-- ============================================

INSERT INTO components (component_id, component_name, component_category) VALUES
('COMP010','Chargeur secteur','Power'),
('COMP016','Module NFC','Network'),
('COMP017','Scanner code-barres 1D','Scanner'),
('COMP020','Camera arriere 13MP','Camera'),
('COMP041','Bouton Power','Control'),
('COMP042','Boutons volume','Control')
ON CONFLICT (component_id) DO NOTHING;

-- ============================================
-- TECHNICIANS
-- ============================================

INSERT INTO technicians (technician_id, first_name, last_name, email, phone, hire_date, is_active) VALUES
('TECH001','Laurent','Diagnostique','lboyer@solutyo.com','0687384936','2025-09-29',TRUE)
ON CONFLICT (technician_id) DO NOTHING;

-- ============================================
-- CHECKUP TASKS (Tâches de vérification tablettes industrielles)
-- ============================================

INSERT INTO checkup_tasks (task_name, task_description, task_category, task_order, is_mandatory, estimated_duration_minutes) VALUES
('Inspection visuelle externe','Etat coque','COSMETIC',1,TRUE,5),
('Test alimentation','Demarrage et charge','HARDWARE',2,TRUE,10),
('Test ecran tactile','Reactivite tactile','HARDWARE',3,TRUE,10),
('Test Wi-Fi','Connexion Wi-Fi','NETWORK',4,TRUE,5)
ON CONFLICT (task_name) DO NOTHING;

-- ============================================
-- DONNÉES EXEMPLES DE PRODUITS RETOURNÉS
-- ============================================

-- Quelques produits de test
INSERT INTO returned_products (serial_number, purchase_date, return_date, supplier_id, customer_id, os_id, current_status_id) VALUES
('ZEB-TAB-001234','2023-06-15','2024-10-01','SUP001','CUST001','OS001','ST001'),
('HON-TAB-005678','2023-08-20','2024-10-05','SUP002','CUST002','OS002','ST002'),
('SAM-TAB-009012','2024-01-10','2024-10-10','SUP003','CUST003','OS003','ST001')
ON CONFLICT (serial_number) DO NOTHING;

-- LIENS
INSERT INTO product_issues (serial_number, technical_issue_id, reported_date) VALUES
('ZEB-TAB-001234','ISS001','2024-10-01 10:00:00'),
('HON-TAB-005678','ISS002','2024-10-05 14:30:00')
ON CONFLICT DO NOTHING;

INSERT INTO defective_components (serial_number, component_id, reported_by_customer, detection_date) VALUES
('ZEB-TAB-001234','COMP016',FALSE,'2024-10-02 11:30:00')
ON CONFLICT DO NOTHING;

SELECT 'Seed OK' AS message;