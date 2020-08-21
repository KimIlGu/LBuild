package com.sbs.kig.lolBuild.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
		Util.changeMapKey(param, "loginPwReal", "loginPw");
		ResultData checkLoginIdJoinableResultData = memberService
				.checkLoginIdJoinable(Util.getAsStr(param.get("loginId")));

		if (checkLoginIdJoinableResultData.isFail()) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", checkLoginIdJoinableResultData.getMsg());
			return "common/redirect";
		}
		
		String loginPw = (String) param.get("loginPw");

		memberService.join(param, loginPw);

		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri", redirectUri);

		return "common/redirect";
	}

	@RequestMapping("/usr/member/login")
	public String showLogin() {
		return "member/login";
	}
	
	@RequestMapping("/usr/member/doLogin")
	public String doLogin(String loginId, String loginPwReal, String redirectUri, Model model, HttpSession session) {
		
		String loginPw = loginPwReal;
		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "존재하지 않는 회원입니다.");
			return "common/redirect";
		}

		if (member.getLoginPw().equals(loginPw) == false) {
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
	
	@RequestMapping("/usr/member/passwordForPrivate")
	public String showPasswordForPrivate() {
		return "member/passwordForPrivate";
	}
	
	@RequestMapping("/usr/member/doPasswordForPrivate") 
	public String doDoPasswordForPrivate(HttpServletRequest req, Model model, String redirectUri) {
		
		String loginPw = req.getParameter("loginPwReal");

		Member loginedMember = (Member) req.getAttribute("loginedMember");
		int loginedMemberId = loginedMember.getId();

		if (loginedMember.getLoginPw().equals(loginPw) == false) {
			req.setAttribute("historyBack", true);
			
			return "common/redirect";
		}
		
		String authCode = memberService.getModifyPrivateAuthCode(loginedMemberId);
		model.addAttribute("redirectUri", redirectUri + authCode);
		
		return "common/redirect";
	}
	
	@RequestMapping("/usr/member/modifyPrivate")
	public String showModifyPrivate(HttpServletRequest req, Model model, @RequestParam(value="authCode", required=false, defaultValue="0") String authCode) {
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		
		if (memberService.isValidModifyPrivateAuthCode(loginedMemberId, authCode) == false) {
			req.setAttribute("alertMsg", "비밀번호를 다시 체크해주세요.");
			model.addAttribute("redirectUri", "/usr/member/passwordForPrivate");
			
			return "common/redirect";
		}
		return "member/modifyPrivate";
	}
	
	@RequestMapping("/usr/member/doModifyPrivate") 
	public String doModifyPrivate(HttpServletRequest req, Model model, String redirectUri) {
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		String authCode = req.getParameter("authCode");

		if (memberService.isValidModifyPrivateAuthCode(loginedMemberId, authCode) == false) {
			req.setAttribute("alertMsg", "비밀번호를 다시 체크해주세요.");
			req.setAttribute("historyBack", true);
			
			return "common/redirect";
		}

		String loginPw = req.getParameter("loginPwReal");

		memberService.modify(loginedMemberId, loginPw);
		Member loginedMember = (Member) req.getAttribute("loginedMember");
		loginedMember.setLoginPw(loginPw);
		
		req.setAttribute("alertMsg", "개인정보가 수정되었습니다.");
		model.addAttribute("redirectUri", redirectUri);
		
		return "common/redirect";
	}
	
	@RequestMapping("/usr/member/findLoginId")
	public String showFindLoginId() {
		return "member/findLoginId";
	}
	
	@RequestMapping("/usr/member/doFindLoginId") 
	public String doFindLoginId(HttpServletRequest req, Model model, String redirectUri) {
		String name = Util.getString(req, "name");
		String email = Util.getString(req, "email");

		Member member = memberService.getMemberByNameAndEmail(name, email);
		model.addAttribute("redirectUri", redirectUri);
		
		if (member == null) {
			req.setAttribute("alertMsg", "일치하는 회원이 없습니다.");
			req.setAttribute("historyBack", true);
			return "common/redirect";
		}

		req.setAttribute("alertMsg", "일치하는 회원을 찾았습니다.\\n아이디 : " + member.getLoginId());
		req.setAttribute("historyBack", true);
		
		return "common/redirect";
	}
	
	@RequestMapping("/usr/member/findLoginPw")
	public String showFindLoginPw() {
		return "member/findLoginPw";
	}
	
	@RequestMapping("/usr/member/doFindLoginPw") 
	public String doFindLoginPw(HttpServletRequest req, Model model, String redirectUri) {
		String loginId = Util.getString(req, "loginId");
		String email = Util.getString(req, "email");

		Member member = memberService.getMemberByLoginId(loginId);
		
		if (member == null || member.getEmail().equals(email) == false) {
			req.setAttribute("alertMsg", "일치하는 회원이 없습니다.");
			req.setAttribute("historyBack", true);
			return "common/redirect";
		}

		memberService.notifyTempLoginPw(member);
		
		req.setAttribute("alertMsg", "메일로 임시패스워드가 발송되었습니다.");
		req.setAttribute("redirectUri", "../member/login");

		return "common/redirect";
	}
}
