package org.aurosks.dao;

import org.aurosks.model.KpacSet;

import java.util.List;

public interface KpacSetDao {

    List<KpacSet> getAllSets();

    void addSet(KpacSet set, int[] kpacIds);

    void deleteSet(int id);

    KpacSet getSetById(int id);
}
