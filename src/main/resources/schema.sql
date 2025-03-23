CREATE TABLE IF NOT EXISTS kpac (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(250) NOT NULL,
    description VARCHAR(2000),
    creation_date VARCHAR(10) NOT NULL
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS kpac_set (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(250) NOT NULL
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS kpac_to_set_kpac (
    set_id INT NOT NULL,
    kpac_id INT NOT NULL,
    PRIMARY KEY (set_id, kpac_id),
    FOREIGN KEY (set_id) REFERENCES kpac_set(id) ON DELETE CASCADE,
    FOREIGN KEY (kpac_id) REFERENCES kpac(id) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;