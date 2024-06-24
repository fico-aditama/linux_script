#!/bin/bash

# Konfigurasi database
DB_HOST="172.17.0.1"
DB_USER="root"
DB_PASSWORD="debian"
DB_NAME="smp52"


# # Daftar file dump SQL
# dump_files=("user.sql" "visitor_count.sql" "user_group.sql")

# # Loop untuk setiap file dump SQL
# for file in "${dump_files[@]}"; do
#     # Mendapatkan nama tabel dari nama file
#     table=$(basename -s .sql "$file")

#     # Melakukan restore tabel ke database
#     mysql -h $DB_HOST -u $DB_USER -p$DB_PASSWORD $DB_NAME < $file
#     echo "Tabel $table berhasil direstore dari $file"
# done

# Temukan semua file dengan ekstensi .sql dan restore satu per satu
find . -type f -name "*.sql" -print0 | while IFS= read -r -d '' file; do
    # Mendapatkan nama tabel dari nama file
    table=$(basename -s .sql "$file")

    # Melakukan restore tabel ke database
    mysql -h $DB_HOST -u $DB_USER -p$DB_PASSWORD $DB_NAME < "$file"
    
    echo "Tabel $table berhasil direstore dari $file"
done

