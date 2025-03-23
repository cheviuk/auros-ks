package org.aurosks.dao;

import org.aurosks.model.Kpac;

import java.util.List;

public interface KpacDao {
    List<Kpac> getAllKpacs();

    void addKpac(Kpac kpac);

    void deleteKpac(int id);
}