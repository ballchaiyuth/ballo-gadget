package com.ballogadget.bff.service;

import com.ballogadget.bff.model.Gadget;
import java.util.List;

public interface GadgetService {
    Gadget saveGadget(Gadget gadget);
    List<Gadget> getAllGadgets();
}
