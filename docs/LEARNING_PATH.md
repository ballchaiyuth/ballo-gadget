# 📚 TDD & Java Interview Preparation Path

This document tracks your progress in mastering TDD and Spring Boot patterns for job interviews, using the **BalloGadget** project as a playground.

## 🎯 High-Level Goals

- Master the **Red-Green-Refactor** cycle.
- Deep dive into **JUnit 5**, **Mockito**, and **AssertJ**.
- Implement common **Design Patterns** used in enterprise Java.
- Practice **Clean Code** principles and SOLID.

## 📝 Learning Checklist

### 🏗 Phase 1: Testing Foundation

- [ ] Setup Maven/Gradle dependencies for Testing (JUnit 5, Mockito, AssertJ).
- [ ] **Challenge 1**: Unit test for a simple POJO (Basic validation).
- [ ] **Challenge 2**: Unit test for a Service using **Mock Objects** to isolate the DB.
- [ ] **Challenge 3**: Use `@ParameterizedTest` for multiple test cases.

### 🧪 Phase 2: TDD Cycle Mastery (Red-Green-Refactor)

- [ ] Implement `GadgetService.createGadget()` following strict TDD.
  - [ ] Write failing test (RED).
  - [ ] Write minimal implementation (GREEN).
  - [ ] Refactor code for readability/cleanliness (REFACTOR).
- [ ] Implement custom Exception handling with `@RestControllerAdvice` (TDD-first).

### 🏛 Phase 3: Architecture & Patterns

- [ ] Implement **DTO (Data Transfer Object)** pattern to separate API layer from Entity.
- [ ] Use **MapStruct** or manual mapping with comprehensive tests.
- [ ] Implement **Audit Logging** using Spring AOP or Interceptors.

### 🍱 Phase 4: Angular Frontend Integration
- [ ] Initialize Angular (Latest) in `web/`.
- [ ] Setup **Service Layer** to communicate with Java BFF.
- [ ] Implement Reactive Forms and Type-safe API calls.
- [ ] Practice Component Testing (Jasmine/Karma or Jest).

### 💼 Interview Specifics

- [ ] Practice **Handling Concurrency** in Spring Services (Locker patterns).
- [ ] Implement **Pagination and Sorting** (Spring Data JPA).
- [ ] Write **Integration Tests** using `@SpringBootTest` and H2 (or Testcontainers).

## 🚀 Recommended Routine

1. Pick a feature from the BalloGadget vision.
2. Write the **Test** before the implementation.
3. Don't move to Phase 2 until 80%+ coverage is reached on core logic.
