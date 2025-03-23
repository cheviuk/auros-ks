-- Insert K-PAC if the table is empty
INSERT INTO kpac (title, description, creation_date)
SELECT * FROM (
    SELECT 'K-PAC 1', 'Description K-PAC 1', '01-03-2025'
    UNION ALL
    SELECT 'K-PAC 2', 'Description K-PAC 2', '02-03-2025'
    UNION ALL
    SELECT 'K-PAC 3', 'Description K-PAC 3', '03-03-2025'
) AS new_data
WHERE NOT EXISTS (SELECT 1 FROM kpac);

-- Insert K-PAC_SET if the table is empty
INSERT INTO kpac_set (title)
SELECT * FROM (
    SELECT 'Set A'
    UNION ALL
    SELECT 'Set B'
) AS new_data
WHERE NOT EXISTS (SELECT 1 FROM kpac_set);

-- Insert relations if the table is empty
INSERT INTO kpac_to_set_kpac (set_id, kpac_id)
SELECT * FROM (
    SELECT 1 AS set_id, 1 AS kpac_id
    UNION ALL
    SELECT 1 AS set_id, 2 AS kpac_id
    UNION ALL
    SELECT 2 AS set_id, 2 AS kpac_id
    UNION ALL
    SELECT 2 AS set_id, 3 AS kpac_id
) AS new_data
WHERE NOT EXISTS (SELECT 1 FROM kpac_to_set_kpac);