package org.aurosks.service;

import org.aurosks.dao.KpacDao;
import org.aurosks.model.Kpac;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class KpacService {
    private final KpacDao kpacDao;

    public KpacService(KpacDao kpacDao) {
        this.kpacDao = kpacDao;
    }

    public List<Kpac> getAllKpacs() {
        return kpacDao.getAllKpacs();
    }

    public void addKpac(Kpac kpac) {
        kpacDao.addKpac(kpac);
    }

    public void deleteKpac(int id) {
        kpacDao.deleteKpac(id);
    }
}
