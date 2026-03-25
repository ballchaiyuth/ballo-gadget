package com.ballogadget.bff.repository;

import com.ballogadget.bff.model.Gadget;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface GadgetRepository extends JpaRepository<Gadget, UUID> {
}
