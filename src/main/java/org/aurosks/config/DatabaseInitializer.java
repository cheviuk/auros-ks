package org.aurosks.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.jdbc.datasource.init.ResourceDatabasePopulator;

import javax.sql.DataSource;

public class DatabaseInitializer {
    private static final Logger logger = LoggerFactory.getLogger(DatabaseInitializer.class);
    private final DataSource dataSource;

    public DatabaseInitializer(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public void initialize() {
        try {
            executeScript("schema.sql");
            executeScript("data.sql");
        } catch (Exception e) {
            logger.error("Error initializing database", e);
            throw new RuntimeException("Database initialization failed", e);
        }
    }

    private void executeScript(String scriptName) {
        try {
            Resource resource = new ClassPathResource(scriptName);
            if (resource.exists()) {
                logger.info("Executing script: {}", scriptName);
                ResourceDatabasePopulator populator = new ResourceDatabasePopulator(resource);
                populator.execute(dataSource);
                logger.info("Script executed successfully: {}", scriptName);
            } else {
                logger.warn("Script not found: {}", scriptName);
            }
        } catch (Exception e) {
            logger.error("Error executing script: " + scriptName, e);
            throw new RuntimeException("Error executing script: " + scriptName, e);
        }
    }
}