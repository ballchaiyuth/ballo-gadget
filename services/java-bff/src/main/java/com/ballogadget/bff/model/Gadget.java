package com.ballogadget.bff.model;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Map;
import java.util.UUID;

@Entity
@Table(name = "gadgets")
@Data
@Builder(toBuilder = true)
@NoArgsConstructor
@AllArgsConstructor
public class Gadget {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(nullable = false)
    private String name;

    private String brand;
    private String model;
    private String category;

    @Enumerated(EnumType.STRING)
    private GadgetStatus status;

    private BigDecimal price;

    @Column(name = "purchase_date")
    private LocalDate purchaseDate;

    @Column(name = "shopee_link")
    private String shopeeLink;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(name = "ai_summary", columnDefinition = "TEXT")
    private String aiSummary;

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb")
    private Map<String, Object> metadata;
}
