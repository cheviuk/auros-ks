package org.aurosks.service;

import org.aurosks.dao.KpacSetDao;
import org.aurosks.model.KpacSet;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class KpacSetService {
    private final KpacSetDao kpacSetDao;

    public KpacSetService(KpacSetDao kpacSetDao) {
        this.kpacSetDao = kpacSetDao;
    }

    public List<KpacSet> getAllSets() {
        return kpacSetDao.getAllSets();
    }

    public KpacSet getSetById(int id) {
        return kpacSetDao.getSetById(id);
    }

    public void addSet(KpacSet kpacSet, int[] kpacIds) {
        kpacSetDao.addSet(kpacSet, kpacIds);
    }

    public void deleteSet(int id) {
        kpacSetDao.deleteSet(id);
    }
}
