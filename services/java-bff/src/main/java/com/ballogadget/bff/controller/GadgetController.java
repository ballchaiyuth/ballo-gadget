package com.ballogadget.bff.controller;

import com.ballogadget.bff.model.Gadget;
import com.ballogadget.bff.service.GadgetService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/gadgets")
@RequiredArgsConstructor
@Tag(name = "Gadget Management", description = "Endpoints for managing tech gadgets and EDC gear.")
public class GadgetController {

    private final GadgetService gadgetService;

    @PostMapping
    @Operation(summary = "Create a new gadget", description = "Adds a new gadget to the inventory.")
    public ResponseEntity<Gadget> createGadget(@RequestBody Gadget gadget) {
        Gadget savedGadget = gadgetService.saveGadget(gadget);
        return new ResponseEntity<>(savedGadget, HttpStatus.CREATED);
    }

    @GetMapping
    @Operation(summary = "Get all gadgets", description = "Retrieves a list of all gadgets in the inventory.")
    public ResponseEntity<List<Gadget>> getAllGadgets() {
        return ResponseEntity.ok(gadgetService.getAllGadgets());
    }
}
