package com.aivle.bookapp.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "books")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Book {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "BOOK_MEMBER_ID")
	private Long bookMemberId;

	@Column(name = "BOOK_NAME", columnDefinition = "TEXT")
	private String bookName;

	@Column(name = "BOOK_DESCRIPTION", columnDefinition = "TEXT")
	private String bookDescription;

	@Column(name = "BOOK_COVERIMAGEURL", columnDefinition = "TEXT")
	private String bookCoverImageUrl;

	@Column(name = "BOOK_FAVORITE")
	private Boolean bookFavorite;

	@Column(name = "BOOK_CREATEDAT")
	private LocalDateTime bookCreatedAt;

	@Column(name = "BOOK_UPDATEDAT")
	private LocalDateTime bookUpdatedAt;

	@PrePersist
	void onCreate() {
		LocalDateTime now = LocalDateTime.now();
		bookCreatedAt = now;
		bookUpdatedAt = now;
	}

	@PreUpdate
	void onUpdate() {
		bookUpdatedAt = LocalDateTime.now();
	}

}
