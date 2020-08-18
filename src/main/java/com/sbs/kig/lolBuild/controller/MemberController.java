package com.sbs.kig.lolBuild.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.kig.lolBuild.dto.Member;
import com.sbs.kig.lolBuild.dto.ResultData;
import com.sbs.kig.lolBuild.service.MemberService;
import com.sbs.kig.lolBuild.util.Util;

@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;

	@RequestMapping("/usr/member/join")
	public String showWrite() {
		return "member/join";
	}

	@RequestMapping("/usr/member/doJoin")
	public String doWrite(@RequestParam Map<String, Object> param, Model model) {
		ResultData checkLoginIdJoinableResultData = memberService
				.checkLoginIdJoinable(Util.getAsStr(param.get("loginId")));

		if (checkLoginIdJoinableResultData.isFail()) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", checkLoginIdJoinableResultData.getMsg());
			return "common/redirect";
		}

		int newMemberId = memberService.join(param);

		String redirectUrl = (String) param.get("redirectUrl");
		model.addAttribute("redirectUrl", redirectUrl);

		return "common/redirect";
	}

	@RequestMapping("/usr/member/login")
	public String showLogin() {
		return "member/login";
	}
	
	@RequestMapping("/usr/member/doLogin")
	public String doLogin(String loginId, String loginPw, String redirectUri, Model model, HttpSession session) {
		String loginPwReal = loginPw;
		Member member = memberService.getMemberByLoginId(loginId);
		System.out.println("Member : " + member);
		if (member == null) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "존재하지 않는 회원입니다.");
			return "common/redirect";
		}

		if (member.getLoginPw().equals(loginPwReal) == false) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");
			return "common/redirect";
		}

		session.setAttribute("loginedMemberId", member.getId());

		if (redirectUri == null || redirectUri.length() == 0) {
			redirectUri = "/usr/home/main";
		}

		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", String.format("%s님 반갑습니다.", member.getNickname()));

		return "common/redirect";
	}

	@RequestMapping("/usr/member/doLogout")
	public String doLogout(HttpSession session, Model model, String redirectUri) {
		session.removeAttribute("loginedMemberId");

		if (redirectUri == null || redirectUri.length() == 0) {
			redirectUri = "/usr/home/main";
		}

		model.addAttribute("redirectUri", redirectUri);
		return "common/redirect";
	}
}
