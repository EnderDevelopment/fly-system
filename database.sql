CREATE TABLE IF NOT EXISTS fly_system (
    id INT AUTO_INCREMENT PRIMARY KEY,
    identifier VARCHAR(60) NOT NULL,
    fly_enabled BOOLEAN DEFAULT FALSE,
    UNIQUE KEY unique_identifier (identifier)
);