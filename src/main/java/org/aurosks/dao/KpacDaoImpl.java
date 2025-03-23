package org.aurosks.dao;

import org.aurosks.model.Kpac;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;

@Repository
public class KpacDaoImpl implements KpacDao {

    private final JdbcTemplate jdbcTemplate;

    public KpacDaoImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<Kpac> getAllKpacs() {
        String sql = "SELECT * FROM kpac";
        return jdbcTemplate.query(sql, new KpacRowMapper());
    }

    @Override
    public void addKpac(Kpac kpac) {
        try {
            LocalDate.parse(kpac.getCreationDate(), DateTimeFormatter.ofPattern("dd-MM-yyyy"));
            String sql = "INSERT INTO kpac (title, description, creation_date) VALUES (?, ?, ?)";
            jdbcTemplate.update(sql, kpac.getTitle(), kpac.getDescription(), kpac.getCreationDate());
        } catch (DateTimeParseException e) {
            throw new IllegalArgumentException("Incorrect date format. Please use DD-MM-YYYY.", e);
        }
    }

    @Override
    public void deleteKpac(int id) {
        String sql = "DELETE FROM kpac WHERE id = ?";
        int rowsAffected = jdbcTemplate.update(sql, id);
        if (rowsAffected == 0) {
            throw new IllegalArgumentException("Kpac with id " + id + " not found.");
        }
    }

    private static final class KpacRowMapper implements RowMapper<Kpac> {
        @Override
        public Kpac mapRow(ResultSet rs, int rowNum) throws SQLException {
            Kpac kpac = new Kpac();
            kpac.setId(rs.getInt("id"));
            kpac.setTitle(rs.getString("title"));
            kpac.setDescription(rs.getString("description"));
            kpac.setCreationDate(rs.getString("creation_date"));
            return kpac;
        }
    }
}
