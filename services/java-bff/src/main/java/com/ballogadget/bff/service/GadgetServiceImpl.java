package com.ballogadget.bff.service;

import com.ballogadget.bff.model.Gadget;
import com.ballogadget.bff.repository.GadgetRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class GadgetServiceImpl implements GadgetService {

    private final GadgetRepository gadgetRepository;

    @Override
    @Transactional
    public Gadget saveGadget(Gadget gadget) {
        return gadgetRepository.save(gadget);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Gadget> getAllGadgets() {
        return gadgetRepository.findAll();
    }
}
