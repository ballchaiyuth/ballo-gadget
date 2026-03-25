package com.ballogadget.bff.service;

import com.ballogadget.bff.model.Gadget;
import com.ballogadget.bff.model.GadgetStatus;
import com.ballogadget.bff.repository.GadgetRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Map;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class GadgetServiceTest {

    @Mock
    private GadgetRepository gadgetRepository;

    @InjectMocks
    private GadgetServiceImpl gadgetService;

    @Test
    @DisplayName("Should save a new gadget successfully (Alpaka Metro Crossbody)")
    void shouldSaveGadgetSuccessfully() {
        // Arrange
        Gadget gadget = Gadget.builder()
                .name("Alpaka Metro Crossbody")
                .brand("Alpaka")
                .model("Metro Crossbody")
                .category("Bags")
                .status(GadgetStatus.LOVED)
                .price(new BigDecimal("2100.00"))
                .description("Sling bag ไซส์ใหญ่หน่อย ใช้เวลาพกของเยอะ")
                .metadata(Map.of("material", "axoflux", "color", "green"))
                .purchaseDate(LocalDate.now())
                .build();

        UUID generatedId = UUID.randomUUID();
        Gadget savedGadget = gadget.toBuilder().id(generatedId).build();

        when(gadgetRepository.save(any(Gadget.class))).thenReturn(savedGadget);

        // Act
        Gadget result = gadgetService.saveGadget(gadget);

        // Assert
        assertNotNull(result);
        assertEquals(generatedId, result.getId());
        assertEquals("Alpaka Metro Crossbody", result.getName());
        assertEquals("Metro Crossbody", result.getModel());
        verify(gadgetRepository, times(1)).save(any(Gadget.class));
    }
}
