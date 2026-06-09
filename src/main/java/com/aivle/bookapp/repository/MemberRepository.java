package com.aivle.bookapp.repository;

import com.aivle.bookapp.domain.Member;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MemberRepository extends JpaRepository<Member, String> {
}
