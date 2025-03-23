package org.aurosks.controller;

import org.aurosks.model.KpacSet;
import org.aurosks.service.KpacService;
import org.aurosks.service.KpacSetService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/")
public class KpacSetController {

    private final KpacSetService kpacSetService;
    private final KpacService kpacService;

    public KpacSetController(KpacSetService kpacSetService, KpacService kpacService) {
        this.kpacSetService = kpacSetService;
        this.kpacService = kpacService;
    }

    @GetMapping("/sets")
    public String getAllSets(Model model) {
        model.addAttribute("sets", kpacSetService.getAllSets());
        model.addAttribute("allKpacs", kpacService.getAllKpacs());
        return "sets";
    }

    @PostMapping("/sets")
    public String addSet(@ModelAttribute KpacSet kpacSet, @RequestParam(value = "kpacIds", required = false) int[] kpacIds) {
        kpacSetService.addSet(kpacSet, kpacIds);
        return "redirect:/sets";
    }

    @DeleteMapping("/sets/{id}")
    public ResponseEntity<Void> deleteSet(@PathVariable("id") String id) {
        try {
            kpacSetService.deleteSet(Integer.parseInt(id));
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }

    @GetMapping("/sets/{id}")
    public String getSetDetails(@PathVariable("id") int id, Model model) {
        KpacSet set = kpacSetService.getSetById(id);
        model.addAttribute("set", set);
        model.addAttribute("kpacs", set.getKpacs());
        return "set";
    }
}
