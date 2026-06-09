# MiniProject 5 - Book App

Spring Boot 기반 도서 관리 API 프로젝트입니다.  
패키지명: `com.aivle.bookapp`

---

## ERD

```
TBL_MEMBER (사용자) 1 ──── N books (책)
```

### TBL_MEMBER (사용자)

| 컬럼명 | 타입 | 키 | 논리명 |
|--------|------|-----|--------|
| `MEMBER_NAME` | `VARCHAR(255)` | PK | 이름 |
| `MEMBER_EMAIL` | `VARCHAR(255)` | | 아이디 |
| `MEMBER_PASSWORD` | `VARCHAR(255)` | | 비밀번호 |

- Entity: `src/main/java/com/aivle/bookapp/domain/Member.java`

### books (책)

| 컬럼명 | 타입 | 키 | 논리명 |
|--------|------|-----|--------|
| `id` | `BIGINT` | PK | (API용 JPA 자동 생성) |
| `BOOK_MEMBER_ID` | `NUMBER` | FK | 사용자 ID |
| `BOOK_NAME` | `TEXT` | | 책 제목 |
| `BOOK_DESCRIPTION` | `TEXT` | | 책 내용 |
| `BOOK_COVERIMAGEURL` | `TEXT` | | 표지 |
| `BOOK_FAVORITE` | `BOOLEAN` | | 즐겨찾기 |
| `BOOK_CREATEDAT` | `TIMESTAMP` | | 생성일 |
| `BOOK_UPDATEDAT` | `TIMESTAMP` | | 수정일 |

- Entity: `src/main/java/com/aivle/bookapp/domain/Book.java`
- `BOOK_MEMBER_ID` → `TBL_MEMBER` (1:N 관계, Day 2에서 사용자 매핑 구현 예정)
- `BOOK_CREATEDAT`, `BOOK_UPDATEDAT`는 저장·수정 시 자동 설정

---

## Mission 1 & 2 — 설계 및 스켈레톤

### 1. Domain

| Entity | 테이블 | 설명 |
|--------|--------|------|
| `Member` | `TBL_MEMBER` | 사용자 정보 |
| `Book` | `books` | 사용자별 책 정보 (`BOOK_MEMBER_ID`로 Member와 N:1) |

### 2. Repository

| 클래스 | 위치 |
|--------|------|
| `MemberRepository` | `repository/MemberRepository.java` |
| `BookRepository` | `repository/BookRepository.java` |

- `MemberRepository` : `JpaRepository<Member, String>` (PK: `memberName`)
- `BookRepository` : `JpaRepository<Book, Long>`

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

#### application.yml

- H2 인메모리 DB (`jdbc:h2:mem:bookdb`)
- H2 Console: `http://localhost:8080/h2-console`
- JPA `ddl-auto: update`

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
│   ├── Member.java
│   └── Book.java
├── repository/
│   ├── MemberRepository.java
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
