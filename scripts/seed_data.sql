-- ============================================
-- Données de test pour ITManagementDB
-- ============================================

\c ITManagementDB;

-- ============================================
-- DESTINATIONS
-- ============================================

INSERT INTO destinations (destination_id, destination_name, destination_type) VALUES
('DEST001', 'Recyclage certifié', 'RECYCLING'),
('DEST002', 'Revente reconditionnée', 'RESALE'),
('DEST003', 'Don association', 'DONATION'),
('DEST004', 'Destruction sécurisée', 'DESTRUCTION'),
('DEST005', 'Atelier réparation', 'REPAIR')
ON CONFLICT (destination_id) DO NOTHING;

-- ============================================
-- STATUS
-- ============================================

INSERT INTO status (status_id, status_name, status_order, destination_id) VALUES
('ST001', 'Reçu', 1, NULL),
('ST002', 'En attente vérification', 2, NULL),
('ST003', 'En cours de vérification', 3, NULL),
('ST004', 'Vérifié - Fonctionnel', 4, 'DEST002'),
('ST005', 'Vérifié - Réparable', 5, 'DEST005'),
('ST006', 'Vérifié - Non réparable', 6, 'DEST001'),
('ST007', 'En réparation', 7, 'DEST005'),
('ST008', 'Réparé', 8, 'DEST002'),
('ST009', 'Prêt pour revente', 9, 'DEST002'),
('ST010', 'Vendu', 10, 'DEST002'),
('ST011', 'Don effectué', 11, 'DEST003'),
('ST012', 'Recyclé', 12, 'DEST001'),
('ST013', 'Détruit', 13, 'DEST004')
ON CONFLICT (status_id) DO NOTHING;

-- ============================================
-- SUPPLIERS
-- ============================================

INSERT INTO suppliers (supplier_id, supplier_name, supplier_location) VALUES
('SUP001', 'TechReturn Europe', 'Paris, France'),
('SUP002', 'IT Logistics SAS', 'Lyon, France'),
('SUP003', 'Global Tech Returns', 'Bruxelles, Belgique'),
('SUP004', 'Reverse IT Solutions', 'Lille, France')
ON CONFLICT (supplier_id) DO NOTHING;

-- ============================================
-- CUSTOMERS
-- ============================================

INSERT INTO customers (customer_id, customer_name, customer_email) VALUES
('CUST001', 'Jean Dupont', 'jean.dupont@email.fr'),
('CUST002', 'Marie Martin', 'marie.martin@email.fr'),
('CUST003', 'Pierre Bernard', 'pierre.bernard@email.fr'),
('CUST004', 'Sophie Dubois', 'sophie.dubois@email.fr'),
('CUST005', 'Lucas Petit', 'lucas.petit@email.fr')
ON CONFLICT (customer_id) DO NOTHING;

-- ============================================
-- OS
-- ============================================

INSERT INTO os (os_id, os_name, os_version) VALUES
('OS001', 'Windows', '10 Pro'),
('OS002', 'Windows', '11 Pro'),
('OS003', 'Ubuntu', '22.04 LTS'),
('OS004', 'macOS', 'Monterey'),
('OS005', 'Windows', '10 Home'),
('OS006', 'Aucun', NULL)
ON CONFLICT (os_id) DO NOTHING;

-- ============================================
-- TECHNICAL ISSUES
-- ============================================

INSERT INTO technical_issues (issue_id, issue_name, issue_description) VALUES
('ISS001', 'Écran cassé', 'Écran LCD/LED fissuré ou cassé'),
('ISS002', 'Batterie défectueuse', 'Batterie ne tient plus la charge'),
('ISS003', 'Clavier non fonctionnel', 'Certaines touches ne répondent pas'),
('ISS004', 'Surchauffe', 'Appareil chauffe anormalement'),
('ISS005', 'Problème démarrage', 'Ne démarre pas ou écran noir'),
('ISS006', 'Port USB défectueux', 'Un ou plusieurs ports USB ne fonctionnent pas'),
('ISS007', 'Wi-Fi ne fonctionne pas', 'Impossible de se connecter au Wi-Fi'),
('ISS008', 'Son ne fonctionne pas', 'Haut-parleurs ou prise jack défectueux'),
('ISS009', 'Disque dur défaillant', 'Disque dur avec secteurs défectueux'),
('ISS010', 'Lenteur système', 'Système très lent')
ON CONFLICT (issue_id) DO NOTHING;

-- ============================================
-- COMPONENTS
-- ============================================

INSERT INTO components (component_id, component_name, component_category) VALUES
('COMP001', 'Écran LCD 15.6"', 'Display'),
('COMP002', 'Batterie Li-ion', 'Power'),
('COMP003', 'Clavier AZERTY', 'Input'),
('COMP004', 'Trackpad', 'Input'),
('COMP005', 'Disque dur 500GB', 'Storage'),
('COMP006', 'SSD 256GB', 'Storage'),
('COMP007', 'RAM 8GB DDR4', 'Memory'),
('COMP008', 'RAM 16GB DDR4', 'Memory'),
('COMP009', 'Ventilateur CPU', 'Cooling'),
('COMP010', 'Carte Wi-Fi', 'Network'),
('COMP011', 'Webcam', 'Multimedia'),
('COMP012', 'Haut-parleurs', 'Multimedia'),
('COMP013', 'Chargeur 65W', 'Power'),
('COMP014', 'Port USB-C', 'Connectivity'),
('COMP015', 'Port HDMI', 'Connectivity')
ON CONFLICT (component_id) DO NOTHING;

-- ============================================
-- TECHNICIANS
-- ============================================

INSERT INTO technicians (technician_id, first_name, last_name, email, phone, specialization, hire_date, is_active) VALUES
('TECH001', 'Jean', 'Technicien', 'jean.tech@recyclage-it.fr', '0601020304', 'Électronique', '2023-01-15', TRUE),
('TECH002', 'Marie', 'Expert', 'marie.expert@recyclage-it.fr', '0602030405', 'Informatique', '2023-03-20', TRUE),
('TECH003', 'Pierre', 'Réparateur', 'pierre.rep@recyclage-it.fr', '0603040506', 'Réparation', '2023-06-10', TRUE),
('TECH004', 'Sophie', 'Diagnostique', 'sophie.diag@recyclage-it.fr', '0604050607', 'Diagnostic', '2024-01-05', TRUE)
ON CONFLICT (technician_id) DO NOTHING;

-- ============================================
-- CHECKUP TASKS
-- ============================================

INSERT INTO checkup_tasks (task_name, task_description, task_category, task_order, is_mandatory, estimated_duration_minutes) VALUES
('Inspection visuelle externe', 'Vérifier l''état de la coque, rayures, fissures', 'COSMETIC', 1, TRUE, 5),
('Test de l''alimentation', 'Vérifier le démarrage et la charge de la batterie', 'HARDWARE', 2, TRUE, 10),
('Test clavier', 'Tester toutes les touches du clavier', 'HARDWARE', 3, TRUE, 5),
('Test trackpad/souris', 'Vérifier la réactivité du trackpad', 'HARDWARE', 4, TRUE, 3),
('Test ports USB', 'Tester tous les ports USB avec différents périphériques', 'HARDWARE', 5, TRUE, 5),
('Test sortie audio', 'Vérifier haut-parleurs et prise jack', 'HARDWARE', 6, TRUE, 3),
('Test webcam', 'Vérifier le fonctionnement de la caméra', 'HARDWARE', 7, TRUE, 3),
('Test écran', 'Vérifier pixels morts, luminosité, couleurs', 'HARDWARE', 8, TRUE, 10),
('Test RAM', 'Effectuer un test mémoire (Memtest86)', 'HARDWARE', 9, TRUE, 15),
('Test disque dur/SSD', 'Vérifier l''état SMART et les secteurs défectueux', 'HARDWARE', 10, TRUE, 20),
('Test Wi-Fi', 'Vérifier la connectivité sans fil', 'NETWORK', 11, TRUE, 5),
('Test Bluetooth', 'Tester l''appairage Bluetooth', 'NETWORK', 12, FALSE, 5),
('Vérification BIOS/UEFI', 'Accéder au BIOS et vérifier les paramètres', 'SOFTWARE', 13, TRUE, 5),
('Test démarrage OS', 'Vérifier le démarrage du système d''exploitation', 'SOFTWARE', 14, TRUE, 10),
('Scan antivirus', 'Effectuer un scan complet antivirus/malware', 'SECURITY', 15, TRUE, 30),
('Effacement données', 'Vérifier que les données client sont effacées', 'SECURITY', 16, TRUE, 5)
ON CONFLICT DO NOTHING;

-- Message de confirmation
SELECT '✅ Données de test insérées avec succès!' as message;

SELECT 
    'destinations' as table_name, 
    COUNT(*) as nb_lignes 
FROM destinations
UNION ALL
SELECT 'status', COUNT(*) FROM status
UNION ALL
SELECT 'suppliers', COUNT(*) FROM suppliers
UNION ALL
SELECT 'customers', COUNT(*) FROM customers
UNION ALL
SELECT 'os', COUNT(*) FROM os
UNION ALL
SELECT 'technical_issues', COUNT(*) FROM technical_issues
UNION ALL
SELECT 'components', COUNT(*) FROM components
UNION ALL
SELECT 'technicians', COUNT(*) FROM technicians
UNION ALL
SELECT 'checkup_tasks', COUNT(*) FROM checkup_tasks;