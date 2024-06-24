#!/bin/bash

# Variables
MAIN_FOLDER="odoo16-enterprise"
COPY_FOLDER="${MAIN_FOLDER} - Copy"
ARCHIVE_NAME="${MAIN_FOLDER}-$(date '+%Y%m%d').tar.gz"

# Function to compress subfolders
compress_subfolders() {
    find "$1" -type d -mindepth 1 -maxdepth 1 -exec sh -c '
        dir="{}";
        tarfile="$(basename "$dir")-$(date "+%Y%m%d").tar.gz";
        if [ ! -e "$tarfile" ]; then
            tar -czvf "$dir/$tarfile" -C "$dir" .;
        fi
    ' \;
}

# Function to remove subfolders after compression
remove_subfolders() {
    find "$1" -type d -mindepth 1 -maxdepth 1 -exec rm -r {} \;
}

# Function to extract all tar.gz files in a folder
extract_archives() {
    find "$1" -type f -name "*.tar.gz" -exec tar -xvzf {} -C "$1" \;
}

# Ensure the copy folder exists
if [ -d "$COPY_FOLDER" ]; then
    # Compress subfolders in the copy folder
    compress_subfolders "$COPY_FOLDER"

    # Remove subfolders after compression
    remove_subfolders "$COPY_FOLDER"

    # Create an archive of the main folder copy
    tar -czvf "$ARCHIVE_NAME" "$COPY_FOLDER"

    # Extract all tar.gz files in the main folder
    extract_archives "$MAIN_FOLDER"

    # Move the contents of the copy folder to the main folder
    mv "$COPY_FOLDER"/* "$MAIN_FOLDER/"

    # Cleanup
    rm -rf "$COPY_FOLDER"
    rm -f "$MAIN_FOLDER"/*.tar.gz

    # Set ownership to the Odoo user
    chown -R odoo:odoo /opt/odoo/
else
    echo "The folder '$COPY_FOLDER' does not exist."
fi
