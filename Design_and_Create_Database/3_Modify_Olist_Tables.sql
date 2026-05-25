COPY company_dim
FROM 'C:\Users\lewis\Downloads\all_folders\csv_files\company_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');