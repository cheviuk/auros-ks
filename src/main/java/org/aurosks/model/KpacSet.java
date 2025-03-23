package org.aurosks.model;

import java.util.List;

public class KpacSet {
    private int id;
    private String title;
    private List<Kpac> kpacs;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public List<Kpac> getKpacs() {
        return kpacs;
    }

    public void setKpacs(List<Kpac> kpacs) {
        this.kpacs = kpacs;
    }
}
