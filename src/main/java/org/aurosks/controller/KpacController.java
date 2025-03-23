package org.aurosks.controller;

import org.aurosks.model.Kpac;
import org.aurosks.service.KpacService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/")
public class KpacController {

    private final KpacService kpacService;

    public KpacController(KpacService kpacService) {
        this.kpacService = kpacService;
    }

    @GetMapping("/")
    public String getMainPage() {
        return "main";
    }

    @GetMapping("/kpacs")
    public String getAllKpacs(Model model) {
        model.addAttribute("kpacs", kpacService.getAllKpacs());
        return "kpacs";
    }

    @PostMapping("/kpacs")
    public String addKpac(@ModelAttribute Kpac kpac) {
        kpacService.addKpac(kpac);
        return "redirect:/kpacs";
    }

    @DeleteMapping("/kpacs/{id}")
    public ResponseEntity<Void> deleteItem(@PathVariable("id") String id) {
        try {
            kpacService.deleteKpac(Integer.parseInt(id));
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }
}
