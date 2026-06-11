package com.aivle.bookapp.service;

import com.aivle.bookapp.domain.Member;
import com.aivle.bookapp.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class MemberService {

    private final MemberRepository memberRepository;

    // 특정 name 조회
    public Member findById(String memberName) {
        return memberRepository.findById(memberName)
                .orElseThrow(() -> new IllegalArgumentException("존재하지 않는 사용자입니다."));
    }

    // 회원가입
    @Transactional
    public Member signup(Member request) {
        if (request.getMemberName() == null || request.getMemberName().isBlank()) {
            throw new IllegalArgumentException("사용자 이름은 필수입니다.");
        }

        if (request.getMemberPassword() == null || request.getMemberPassword().isBlank()) {
            throw new IllegalArgumentException("비밀번호는 필수입니다.");
        }

        if (memberRepository.existsById(request.getMemberName())) {
            throw new IllegalArgumentException("이미 존재하는 사용자입니다.");
        }

        Member member = new Member();
        member.setMemberName(request.getMemberName());
        member.setMemberEmail(request.getMemberEmail());
        member.setMemberPassword(request.getMemberPassword());

        return memberRepository.save(member);
    }

    public Map<String, String> login(Member request) {
        if (request.getMemberName() == null || request.getMemberName().isBlank()) {
            throw new IllegalArgumentException("사용자 이름은 필수입니다.");
        }

        if (request.getMemberPassword() == null || request.getMemberPassword().isBlank()) {
            throw new IllegalArgumentException("비밀번호는 필수입니다.");
        }

        Member member = findById(request.getMemberName());

        if (!member.getMemberPassword().equals(request.getMemberPassword())) {
            throw new IllegalArgumentException("비밀번호가 일치하지 않습니다.");
        }

        return Map.of(
                "memberName", member.getMemberName(),
                "memberEmail", member.getMemberEmail() == null ? "" : member.getMemberEmail(),
                "message", "로그인 성공"
        );
    }
}
