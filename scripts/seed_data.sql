-- ============================================
-- Données de test pour ITManagementDB
-- Tablettes industrielles tactiles
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
('SUP001', 'Shenzhen HDFocus Technology Co Ltd', 'Shenzhen, Chine'),

ON CONFLICT (supplier_id) DO NOTHING;

-- ============================================
-- CUSTOMERS
-- ============================================

INSERT INTO customers (customer_id, customer_name, customer_email) VALUES
('CUST001', 'Dalloz', ''),
('CUST002', 'ARPA', ''),
('CUST003', 'ROECHLING', 'tech@retailstore.fr'),
('CUST004', 'LOUVRE-HOTEL', 'it@manufacturing.fr'),
ON CONFLICT (customer_id) DO NOTHING;

-- ============================================
-- OS (Systèmes d'exploitation pour tablettes industrielles)
-- ============================================

INSERT INTO os (os_id, os_name, os_version) VALUES
('OS001', 'Android', '11 Enterprise'),
('OS002', 'Android', '12 Enterprise'),
('OS003', 'Android', '13 Enterprise'),
('OS004', 'Windows', '10 IoT Enterprise'),
('OS005', 'Windows', '11 IoT Enterprise'),
('OS006', 'Aucun', NULL)
ON CONFLICT (os_id) DO NOTHING;

-- ============================================
-- TECHNICAL ISSUES (Problèmes spécifiques tablettes industrielles)
-- ============================================

INSERT INTO technical_issues (issue_id, issue_name, issue_description) VALUES
('ISS001', 'Écran tactile défectueux', 'Zones non réactives ou mauvaise calibration tactile'),
('ISS002', 'Batterie défectueuse', 'Batterie ne tient plus la charge ou gonflée'),
('ISS003', 'NFC non fonctionnel', 'Lecteur NFC ne détecte pas les tags'),
('ISS004', 'Scanner code-barres HS', 'Lecteur de code-barres 1D/2D défaillant'),
('ISS005', 'Wi-Fi instable', 'Connexion Wi-Fi intermittente ou inexistante'),
('ISS006', 'Bluetooth inopérant', 'Impossible de connecter périphériques Bluetooth'),('ISS008', 'Caméra défectueuse', 'Caméra arrière ou avant floue/cassée'),
('ISS009', 'Port USB défectueux', 'Port USB-C ou micro-USB ne charge pas ou ne synchronise pas'),
('ISS010', 'Écran fissuré', 'Écran LCD/LED fissuré ou cassé'),
('ISS011', 'Boutons physiques HS', 'Boutons power/volume ne répondent pas'),
('ISS012', 'Surchauffe', 'Tablette chauffe anormalement en utilisation'),
('ISS013', 'Problème démarrage', 'Ne démarre pas ou redémarre en boucle'),
('ISS014', 'Haut-parleur muet', 'Son inaudible ou distordu'),
('ISS015', 'Connectique dock cassée', 'Connecteur de station d''accueil endommagé'),
('ISS016', '4G/LTE non fonctionnel', 'Module cellulaire ne se connecte pas au réseau'),
('ISS017', 'Capteur luminosité HS', 'Luminosité auto ne fonctionne pas'),
('ISS018', 'Gyroscope/accéléromètre', 'Orientation écran ne change pas'),
('ISS019', 'Étanchéité compromise', 'Joint IP65/IP67 endommagé'),
('ISS020', 'Lenteur système', 'Système très lent, lag important')
ON CONFLICT (issue_id) DO NOTHING;

-- ============================================
-- COMPONENTS (Composants tablettes industrielles)
-- ============================================

INSERT INTO components (component_id, component_name, component_category) VALUES
-- Écran et tactile
('COMP001', 'Écran LCD 8"', 'Display'),
('COMP002', 'Écran LCD 10"', 'Display'),
('COMP003', 'Écran LCD 11"', 'Display'),
('COMP004', 'Écran LCD 12"', 'Display'),
('COMP005', 'Écran LCD 13.3"', 'Display'),
('COMP006', 'Écran LCD 14"', 'Display'),
('COMP007', 'Écran LCD 15.6"', 'Display'),
('COMP008', 'Écran LCD 17"', 'Display'),
('COMP009', 'Digitizer tactile capacitif', 'Input'),

-- Alimentation
('COMP010', 'Chargeur secteur', 'Power'),

-- Connectivité
('COMP011', 'Module Wi-Fi 802.11ac', 'Network'),
('COMP012', 'Module Wi-Fi 6 (802.11ax)', 'Network'),
('COMP013', 'Module Bluetooth 5.0', 'Network'),
('COMP014', 'Module 4G LTE', 'Network'),
('COMP015', 'Antenne GPS', 'Network'),
('COMP016', 'Module NFC', 'Network'),

-- Lecteurs et capteurs
('COMP017', 'Scanner code-barres 1D', 'Scanner'),
('COMP018', 'Scanner code-barres 2D', 'Scanner'),
('COMP019', 'Lecteur RFID UHF', 'Scanner'),

-- Multimédia
('COMP020', 'Caméra arrière 13MP', 'Camera'),
('COMP021', 'Caméra avant 5MP', 'Camera'),
('COMP022', 'Haut-parleur frontal', 'Audio'),
('COMP023', 'Microphone antibruit', 'Audio'),

-- Stockage et mémoire
('COMP024', 'eMMC 32GB', 'Storage'),
('COMP025', 'eMMC 64GB', 'Storage'),
('COMP026', 'SSD 128GB', 'Storage'),
('COMP027', 'RAM 3GB', 'Memory'),
('COMP028', 'RAM 4GB', 'Memory'),
('COMP029', 'RAM 8GB', 'Memory'),

-- Connectiques
('COMP030', 'Port USB-C', 'Connectivity'),
('COMP031', 'Port micro-USB', 'Connectivity'),
('COMP032', 'Port HDMI', 'Connectivity'),
('COMP033', 'Slot carte SIM', 'Connectivity'),
('COMP034', 'Slot carte microSD', 'Connectivity'),
('COMP035', 'Port RJ45', 'Connectivity'),
('COMP042', 'Port USB-A', 'Connectivity'),
('COMP043', 'Port USB-A', 'Connectivity'),

-- Coque et protection et accessoires
('COMP036', 'Coque renforcée IP65', 'Protection'),
('COMP037', 'Coque renforcée IP67', 'Protection'),
('COMP038', 'Joint d''étanchéité', 'Protection'),
('COMP039', 'Dragonne de sécurité', 'Protection'),
('COMP040', 'Support VESA', 'Installation'),

-- Boutons et contrôles
('COMP041', 'Bouton Power', 'Control'),
('COMP042', 'Boutons volume', 'Control'),
ON CONFLICT (component_id) DO NOTHING;

-- ============================================
-- TECHNICIANS
-- ============================================

INSERT INTO technicians (technician_id, first_name, last_name, email, phone, hire_date, is_active) VALUES
('TECH001', 'Laurent', 'Diagnostique', 'lboyer@solutyo.com', '0687384936', '', '2025-09-29', TRUE),

ON CONFLICT (technician_id) DO NOTHING;

-- ============================================
-- CHECKUP TASKS (Tâches de vérification tablettes industrielles)
-- ============================================

INSERT INTO checkup_tasks (task_name, task_description, task_category, task_order, is_mandatory, estimated_duration_minutes) VALUES
-- Inspection visuelle
('Inspection visuelle externe', 'Vérifier l''état de la coque, rayures, fissures, étanchéité', 'COSMETIC', 1, TRUE, 5),
('Vérification étanchéité IP', 'Contrôler joints et certification IP65/IP67', 'HARDWARE', 2, TRUE, 5),

-- Tests alimentation
('Test de l''alimentation', 'Vérifier le démarrage et la charge de la batterie', 'HARDWARE', 3, TRUE, 10),
('Test autonomie batterie', 'Mesurer l''autonomie réelle de la batterie', 'HARDWARE', 4, TRUE, 15),
('Test chargement rapide', 'Vérifier la charge rapide et le chargeur', 'HARDWARE', 5, FALSE, 5),

-- Tests écran et tactile
('Test écran tactile', 'Vérifier la réactivité tactile sur toute la surface', 'HARDWARE', 6, TRUE, 10),
('Calibration tactile', 'Effectuer la calibration du tactile', 'HARDWARE', 7, TRUE, 5),
('Test pixels morts', 'Vérifier pixels morts, luminosité, couleurs', 'HARDWARE', 8, TRUE, 5),
('Test luminosité auto', 'Vérifier le capteur de luminosité ambiante', 'HARDWARE', 9, TRUE, 3),
('Test rotation écran', 'Vérifier gyroscope et rotation automatique', 'HARDWARE', 10, TRUE, 3),

-- Tests connectivité
('Test Wi-Fi', 'Vérifier connexion Wi-Fi 2.4GHz et 5GHz', 'NETWORK', 11, TRUE, 5),
('Test Bluetooth', 'Tester l''appairage avec périphériques Bluetooth', 'NETWORK', 12, TRUE, 5),
('Test NFC', 'Vérifier lecture de tags NFC', 'NETWORK', 13, TRUE, 5),
('Test 4G/LTE', 'Vérifier connexion réseau cellulaire (si équipé)', 'NETWORK', 14, FALSE, 5),
('Test GPS', 'Vérifier acquisition signal GPS', 'NETWORK', 15, FALSE, 5),

-- Tests lecteurs
('Test scanner code-barres 1D', 'Tester lecture codes-barres 1D (EAN, Code128, etc.)', 'HARDWARE', 16, TRUE, 10),
('Test scanner code-barres 2D', 'Tester lecture QR codes et DataMatrix', 'HARDWARE', 17, TRUE, 10),
('Test RFID/NFC lecteur', 'Vérifier lecture tags RFID/NFC', 'HARDWARE', 18, FALSE, 5),


-- Tests connectiques
('Test port USB-C', 'Vérifier charge et transfert données USB-C', 'HARDWARE', 23, TRUE, 5),
('Test autres connectiques', 'Tester HDMI, jack audio, etc. (si équipé)', 'HARDWARE', 24, FALSE, 5),
('Test station d''accueil', 'Vérifier connexion dock si disponible', 'HARDWARE', 25, FALSE, 5),

-- Tests boutons
('Test boutons physiques', 'Vérifier boutons power, volume, programmables', 'HARDWARE', 26, TRUE, 3),

-- Tests système
('Vérification BIOS/bootloader', 'Accéder aux paramètres système', 'SOFTWARE', 27, TRUE, 5),
('Test démarrage OS', 'Vérifier le démarrage du système Android/Windows', 'SOFTWARE', 28, TRUE, 10),
('Test stockage interne', 'Vérifier espace disponible et performances eMMC/SSD', 'HARDWARE', 29, TRUE, 10),
('Test RAM', 'Vérifier utilisation et performances mémoire', 'HARDWARE', 30, TRUE, 5),

-- Tests sécurité
('Scan antivirus/malware', 'Effectuer un scan complet de sécurité', 'SECURITY', 31, TRUE, 20),
('Vérification chiffrement', 'Contrôler état du chiffrement des données', 'SECURITY', 32, TRUE, 5),
('Effacement données', 'Factory reset et vérification effacement complet', 'SECURITY', 33, TRUE, 10),

-- Tests stress
('Test de stress thermique', 'Vérifier comportement en charge intensive', 'HARDWARE', 34, FALSE, 15),
('Test de chute (si protocole)', 'Vérifier résistance aux chocs selon norme MIL-STD', 'HARDWARE', 35, FALSE, 10)
ON CONFLICT DO NOTHING;

-- ============================================
-- DONNÉES EXEMPLES DE PRODUITS RETOURNÉS
-- ============================================

-- Quelques produits de test
INSERT INTO returned_products (serial_number, purchase_date, return_date, supplier_id, customer_id, os_id, current_status_id) VALUES
('ZEB-TAB-001234', '2023-06-15', '2024-10-01', 'SUP001', 'CUST001', 'OS001', 'ST001'),
('HON-TAB-005678', '2023-08-20', '2024-10-05', 'SUP002', 'CUST002', 'OS002', 'ST002'),
('SAM-TAB-009012', '2024-01-10', '2024-10-10', 'SUP003', 'CUST003', 'OS003', 'ST001'),
('PAN-TAB-003456', '2023-09-05', '2024-10-12', 'SUP004', 'CUST004', 'OS004', 'ST003'),
('GET-TAB-007890', '2024-02-20', '2024-10-15', 'SUP005', 'CUST005', 'OS005', 'ST001')
ON CONFLICT (serial_number) DO NOTHING;

-- Problèmes signalés sur quelques produits
INSERT INTO product_issues (serial_number, technical_issue_id, reported_date) VALUES
('ZEB-TAB-001234', 'ISS001', '2024-10-01 10:00:00'),
('ZEB-TAB-001234', 'ISS003', '2024-10-01 10:00:00'),
('HON-TAB-005678', 'ISS002', '2024-10-05 14:30:00'),
('SAM-TAB-009012', 'ISS010', '2024-10-10 09:15:00'),
('PAN-TAB-003456', 'ISS004', '2024-10-12 16:45:00')
ON CONFLICT DO NOTHING;

-- Composants défectueux détectés
INSERT INTO defective_components (serial_number, component_id, reported_by_customer, detection_date) VALUES
('ZEB-TAB-001234', 'COMP003', TRUE, '2024-10-01 10:00:00'),
('ZEB-TAB-001234', 'COMP016', FALSE, '2024-10-02 11:30:00'),
('HON-TAB-005678', 'COMP006', TRUE, '2024-10-05 14:30:00'),
('SAM-TAB-009012', 'COMP001', TRUE, '2024-10-10 09:15:00'),
('PAN-TAB-003456', 'COMP017', FALSE, '2024-10-13 10:20:00')
ON CONFLICT DO NOTHING;

-- ============================================
-- MESSAGE DE CONFIRMATION
-- ============================================

SELECT '✅ Données de test insérées avec succès! (Tablettes industrielles)' as message;

-- Statistiques d'insertion
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
SELECT 'checkup_tasks', COUNT(*) FROM checkup_tasks
UNION ALL
SELECT 'returned_products', COUNT(*) FROM returned_products
UNION ALL
SELECT 'product_issues', COUNT(*) FROM product_issues
UNION ALL
SELECT 'defective_components', COUNT(*) FROM defective_components
ORDER BY table_name;