SELECT 
SUM(b.apple_count + COALESCE(ch.apple_count, 0)) AS apple_count,
SUM(b.orange_count + COALESCE(ch.orange_count, 0)) AS orange_count
FROM boxes b 
LEFT JOIN chests ch ON b.chest_id = ch.chest_id