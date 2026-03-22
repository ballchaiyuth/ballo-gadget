---
description: BalloGadget Development Standards
---

# 🎒 BalloGadget: Engineering Standards (v2026)

## 1. Tech Stack & Environment

- **BFF:** Java 25 (LTS) + Spring Boot 3.5.x.
- **AI Service:** Python 3.14 + FastAPI.
- **Loadout Service:** Go 1.26 (darwin/arm64).
- **IaC:** OpenTofu v1.11.5 (Modern Terraform).
- **CLI Tools:** AWS CLI v2.34+, Spring CLI v3.5+.
- **Frontend:** Vue.js 3 (Composition API) + Node v25.8.1.

## 2. Spring Boot Learning & Development Path

- **Keep it Simple:** Focus on core Spring concepts (Inversion of Control, Dependency Injection). Avoid over-engineering with complex Design Patterns unless necessary.
- **Modern Java:** Use Java 25 features effectively (Records for DTOs, Pattern Matching, Sealed Classes) to keep the code concise.
- **Explicit over Implicit:** Prefer constructor injection (`@RequiredArgsConstructor` via Lombok or manual constructors) over field injection (`@Autowired` on fields) for better testability.

## 3. Test-Driven Development (TDD)

- **Priority:** Always write JUnit 5 / Pytest / Go tests before implementation.
- **Workflow:** Red (Write failing test) -> Green (Write minimal code to pass) -> Refactor (Cleanup code and tests).
- **Mocking:** Use Mockito for Java to isolate layers (Controller -> Service -> Repository).

## 4. Documentation & Naming Conventions

- **English Only:** All code, comments, variable names, branch names, and documentation must be strictly in English.
- **Clean Naming:** - Variables/Methods: `camelCase` (e.g., `calculateTotalWeight`).
  - Classes/Interfaces: `PascalCase` (e.g., `GadgetService`).
  - Naming must be descriptive: Avoid `obj`, `data`, `info`. Use `runningShoes`, `slingBag`.
- **Minimal Comments:** - No "what" comments: If the code is readable, don't describe what it's doing.
  - Focus on "why": Only leave short, essential comments that explain the **context** or **reasoning** behind complex logic.
  - Code should be the primary documentation.

## 5. Infrastructure (AWS Thailand)

- **Region:** `ap-southeast-7` (Bangkok).
- **Profile:** Always use `ballo-gadget`.
- **Tool:** Use `tofu` (aliased as `tf`) for all infrastructure tasks.
- **IaC First:** No manual changes via AWS Console to maintain a clean audit trail.
