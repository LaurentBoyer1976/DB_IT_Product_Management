-- ============================================
-- Requêtes analytiques
-- ============================================

\c ITManagementDB;

-- Analyse : Taux de recyclage vs revente
SELECT 
    d.destination_type,
    COUNT(rp.serial_number) as nombre_produits,
    ROUND(COUNT(rp.serial_number) * 100.0 / SUM(COUNT(rp.serial_number)) OVER(), 2) as pourcentage
FROM destinations d
LEFT JOIN status s ON s.destination_id = d.destination_id
LEFT JOIN returned_products rp ON rp.current_status_id = s.status_id
GROUP BY d.destination_type
ORDER BY nombre_produits DESC;

-- Analyse : Évolution des retours par mois
SELECT 
    TO_CHAR(return_date, 'YYYY-MM') as mois,
    COUNT(*) as nb_retours
FROM returned_products
GROUP BY TO_CHAR(return_date, 'YYYY-MM')
ORDER BY mois DESC
LIMIT 12;