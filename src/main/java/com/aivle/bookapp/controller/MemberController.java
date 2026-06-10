package com.aivle.bookapp.controller;

import com.aivle.bookapp.domain.Member;
import com.aivle.bookapp.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api/members")
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;

    // 회원가입
    @PostMapping("/signup")
    public ResponseEntity<Member> signup(@RequestBody Member request) {

        Member savedMember = memberService.signup(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedMember);
    }

    // 로그인
    @PostMapping("/login")
    public ResponseEntity<Map<String, String>> login(@RequestBody Member request) {

        Map<String, String> response = memberService.login(request);
        return ResponseEntity.ok(response);
    }
}
