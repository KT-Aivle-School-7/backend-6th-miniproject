# MiniProject 5 - Book App

Spring Boot 기반 도서 관리 API 프로젝트입니다.  
패키지명: `com.aivle.bookapp`

---

## Mission 1 & 2 — 설계 및 스켈레톤

### 1. Domain — `Book` Entity

| 필드 | 타입 | 설명 |
|------|------|------|
| `id` | `Long` | PK, 자동 증가 |
| `title` | `String` | 도서 제목 (필수) |
| `author` | `String` | 저자 (필수) |
| `isbn` | `String` | ISBN |
| `price` | `Integer` | 가격 |
| `description` | `String` | 도서 설명 |

- 위치: `src/main/java/com/aivle/bookapp/domain/Book.java`
- JPA `@Entity`로 `books` 테이블과 매핑

### 2. Repository — `BookRepository`

- 위치: `src/main/java/com/aivle/bookapp/repository/BookRepository.java`
- `JpaRepository<Book, Long>` 상속
- Day 2에 커스텀 쿼리 메서드 추가 예정

### 3. Service — `BookService` (스켈레톤)

- 위치: `src/main/java/com/aivle/bookapp/service/BookService.java`
- 현재 구현: `findAll()`, `findById()`
- Day 2 예정: `create`, `update`, `delete` 비즈니스 로직

### 4. Controller — `BookController` (스켈레톤)

- 위치: `src/main/java/com/aivle/bookapp/controller/BookController.java`
- Base URL: `/api/books`

| Method | Path | 설명 |
|--------|------|------|
| `GET` | `/api/books` | 전체 도서 조회 |
| `GET` | `/api/books/{id}` | 단건 조회 |
| `POST` | `/api/books` | 등록 (Day 2) |
| `PUT` | `/api/books/{id}` | 수정 (Day 2) |
| `DELETE` | `/api/books/{id}` | 삭제 (Day 2) |

### 5. Integration

#### WebConfig (CORS)

- 위치: `src/main/java/com/aivle/bookapp/config/WebConfig.java`
- 프론트엔드 연동을 위해 `localhost:3000`, `localhost:5173` Origin 허용
- `GET`, `POST`, `PUT`, `DELETE`, `OPTIONS` 메서드 허용

#### application.yml

- 위치: `src/main/resources/application.yml`
- H2 인메모리 DB (`jdbc:h2:mem:bookdb`)
- H2 Console: `http://localhost:8080/h2-console`
- JPA `ddl-auto: update` — Day 2 연동 준비

---

## 프로젝트 구조

```
src/main/java/com/aivle/bookapp/
├── BookappApplication.java
├── config/
│   └── WebConfig.java
├── controller/
│   └── BookController.java
├── domain/
│   └── Book.java
├── repository/
│   └── BookRepository.java
└── service/
    └── BookService.java
```

---

## 실행 방법

```bash
./gradlew bootRun
```

H2 Console 접속 정보:
- JDBC URL: `jdbc:h2:mem:bookdb`
- Username: `sa`
- Password: (비어 있음)
