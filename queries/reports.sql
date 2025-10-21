-- ============================================
-- Requêtes de reporting
-- ============================================

\c ITManagementDB;

-- Rapport : Produits par statut
SELECT 
    s.status_name,
    COUNT(rp.serial_number) as nombre_produits,
    ROUND(COUNT(rp.serial_number) * 100.0 / SUM(COUNT(rp.serial_number)) OVER(), 2) as pourcentage
FROM status s
LEFT JOIN returned_products rp ON rp.current_status_id = s.status_id
GROUP BY s.status_id, s.status_name, s.status_order
ORDER BY s.status_order;

-- Rapport : Performance des techniciens
SELECT 
    t.technician_id,
    t.first_name || ' ' || t.last_name as technicien,
    COUNT(pc.checkup_id) as nb_verifications,
    AVG(EXTRACT(EPOCH FROM (pc.checkup_end_time - pc.checkup_start_time))/60) as duree_moyenne_minutes,
    SUM(CASE WHEN pc.overall_status = 'COMPLETED' THEN 1 ELSE 0 END) as nb_completees
FROM technicians t
LEFT JOIN product_checkups pc ON pc.technician_id = t.technician_id
WHERE t.is_active = TRUE
GROUP BY t.technician_id, t.first_name, t.last_name
ORDER BY nb_verifications DESC;

-- Rapport : Problèmes techniques les plus fréquents
SELECT 
    ti.issue_name,
    COUNT(pi.id) as nb_occurrences,
    ROUND(COUNT(pi.id) * 100.0 / SUM(COUNT(pi.id)) OVER(), 2) as pourcentage
FROM technical_issues ti
LEFT JOIN product_issues pi ON pi.technical_issue_id = ti.issue_id
GROUP BY ti.issue_id, ti.issue_name
ORDER BY nb_occurrences DESC
LIMIT 10;