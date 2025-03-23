package org.aurosks.dao;

import org.aurosks.model.Kpac;
import org.aurosks.model.KpacSet;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Repository
public class KpacSetDaoImpl implements KpacSetDao {

    private final JdbcTemplate jdbcTemplate;

    public KpacSetDaoImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<KpacSet> getAllSets() {
        String sql = "SELECT * FROM kpac_set";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            KpacSet set = new KpacSet();
            set.setId(rs.getInt("id"));
            set.setTitle(rs.getString("title"));
            return set;
        });
    }

    @Override
    @Transactional
    public void addSet(KpacSet set, int[] kpacIds) {
        try {
            String sql = "INSERT INTO kpac_set (title) VALUES (?)";
            KeyHolder keyHolder = new GeneratedKeyHolder();
            jdbcTemplate.update(connection -> {
                PreparedStatement ps = connection.prepareStatement(sql, new String[]{"id"});
                ps.setString(1, set.getTitle());
                return ps;
            }, keyHolder);
            int setId = keyHolder.getKey().intValue();

            if (kpacIds != null && kpacIds.length > 0) {
                String joinSql = "INSERT INTO kpac_to_set_kpac (set_id, kpac_id) VALUES (?, ?)";
                List<Object[]> batchArgs = new ArrayList<>();
                for (int kpacId : kpacIds) {
                    batchArgs.add(new Object[]{setId, kpacId});
                }
                jdbcTemplate.batchUpdate(joinSql, batchArgs);
            }
        } catch (Exception e) {
            throw new RuntimeException("Error while adding KpacSet and associated Kpacs", e);
        }
    }

    @Override
    public void deleteSet(int id) {
        String sql = "DELETE FROM kpac_set WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

    @Override
    public KpacSet getSetById(int id) {
        String sql = "SELECT * FROM kpac_set WHERE id = ?";
        KpacSet set = jdbcTemplate.queryForObject(sql, new Object[]{id}, new RowMapper<KpacSet>() {
            @Override
            public KpacSet mapRow(ResultSet rs, int rowNum) throws SQLException {
                KpacSet s = new KpacSet();
                s.setId(rs.getInt("id"));
                s.setTitle(rs.getString("title"));
                return s;
            }
        });

        String joinSql = "SELECT k.* FROM kpac k " + "JOIN kpac_to_set_kpac ks ON k.id = ks.kpac_id " + "WHERE ks.set_id = ?";
        List<Kpac> kpacs = jdbcTemplate.query(joinSql, new Object[]{id}, new RowMapper<Kpac>() {
            @Override
            public Kpac mapRow(ResultSet rs, int rowNum) throws SQLException {
                Kpac k = new Kpac();
                k.setId(rs.getInt("id"));
                k.setTitle(rs.getString("title"));
                k.setDescription(rs.getString("description"));
                k.setCreationDate(rs.getString("creation_date"));
                return k;
            }
        });
        set.setKpacs(kpacs);
        return set;
    }
}

