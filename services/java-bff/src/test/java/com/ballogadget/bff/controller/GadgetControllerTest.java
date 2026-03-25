package com.ballogadget.bff.controller;

import com.ballogadget.bff.model.Gadget;
import com.ballogadget.bff.model.GadgetStatus;
import com.ballogadget.bff.repository.GadgetRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.math.BigDecimal;
import java.util.Map;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
class GadgetControllerTest {

    private MockMvc mockMvc;

    @Autowired
    private WebApplicationContext webApplicationContext;

    @Autowired
    private GadgetRepository gadgetRepository;

    private final ObjectMapper objectMapper = new ObjectMapper().registerModule(new JavaTimeModule());

    @BeforeEach
    void setUp() {
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
        gadgetRepository.deleteAll();
    }

    @Test
    void shouldCreateGadgetViaApi() throws Exception {
        // Arrange
        Gadget gadget = Gadget.builder()
                .name("Alpaka Metro Crossbody")
                .brand("Alpaka")
                .model("Metro Crossbody")
                .status(GadgetStatus.LOVED)
                .price(new BigDecimal("2100.00"))
                .description("Sling bag ไซส์ใหญ่หน่อย ใช้เวลาพกของเยอะ")
                .metadata(Map.of("material", "axoflux", "color", "green"))
                .build();

        // Act & Assert
        mockMvc.perform(post("/api/v1/gadgets")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(gadget)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.name").value("Alpaka Metro Crossbody"))
                .andExpect(jsonPath("$.brand").value("Alpaka"))
                .andExpect(jsonPath("$.model").value("Metro Crossbody"))
                .andExpect(jsonPath("$.metadata.material").value("axoflux"))
                .andExpect(jsonPath("$.metadata.color").value("green"));
    }

    @Test
    void shouldGetAllGadgets() throws Exception {
        // Arrange
        Gadget gadget = Gadget.builder()
                .name("Alpaka Go Sling Mini v1")
                .brand("Alpaka")
                .model("Go Sling Mini v1")
                .status(GadgetStatus.LOVED)
                .price(new BigDecimal("1500.00"))
                .description("Sling bag ไซส์เล็ก อันนี้ใช้ประจำ")
                .metadata(Map.of("material", "xpac", "color", "black"))
                .build();
        gadgetRepository.save(gadget);

        // Act & Assert
        mockMvc.perform(get("/api/v1/gadgets"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isArray())
                .andExpect(jsonPath("$[0].name").value("Alpaka Go Sling Mini v1"));
    }
}
