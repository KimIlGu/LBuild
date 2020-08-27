package com.sbs.kig.lolBuild.service;

import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.sbs.kig.lolBuild.dao.MemberDao;
import com.sbs.kig.lolBuild.dto.Member;
import com.sbs.kig.lolBuild.dto.ResultData;
import com.sbs.kig.lolBuild.util.Util;

@Service
public class MemberService {
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private MailService mailService;
	@Autowired
	private AttrService attrService;
	@Value("${custom.siteMainUri}")
	private String siteMainUri;
	@Value("${custom.siteName}")
	private String siteName;
	
	public Member getMemberByLoginId(String id) {
		return memberDao.getMemberById(id);
	}

	public void join(Map<String, Object> param, String loginPw) {
		memberDao.join(param);
		int memberId = Util.getAsInt(param.get("id"));
		attrService.setValue("member__" + memberId + "__extra__useTempPassword", loginPw);
		
		sendJoinCompleteMail((String) param.get("email"));
	}
	
	private void sendJoinCompleteMail(String email) {
		String mailTitle = String.format("[%s] 가입이 완료되었습니다.", siteName);

		StringBuilder mailBodySb = new StringBuilder();
		mailBodySb.append("<h1>가입이 완료되었습니다.</h1>");
		mailBodySb.append(String.format("<p><a href=\"%s\" target=\"_blank\">%s</a>로 이동</p>", siteMainUri, siteName));

		mailService.send(email, mailTitle, mailBodySb.toString());
	}

	public ResultData checkLoginIdJoinable(String loginId) {
		int count = memberDao.getLoginIdDupCount(loginId);

		if (count == 0) {
			return new ResultData("S-1", "가입가능한 로그인 아이디 입니다.", "loginId", loginId);
		}

		return new ResultData("F-1", "이미 사용중인 로그인 아이디 입니다.", "loginId", loginId);
	}

	public Member getMemberById(int id) {
		return memberDao.getMemberByLoginId(id);
	}

	public Member getMemberByNameAndEmail(String name, String email) {
		return memberDao.getMemberByNameAndEmail(name, email);
	}

	public String getModifyPrivateAuthCode(int loginedMemberId) {
		String authCode = UUID.randomUUID().toString();
		attrService.setValue("member__" + loginedMemberId + "__extra__modifyPrivateAuthCode", authCode);

		return authCode;
	}

	public boolean isValidModifyPrivateAuthCode(int loginedMemberId, String authCode) {
		String authCodeOnDB = attrService.getValue("member__" + loginedMemberId + "__extra__modifyPrivateAuthCode");

		return authCodeOnDB.equals(authCode);
	}

	public void modify(int loginedMemberId, String loginPw) {
		memberDao.modify(loginedMemberId, loginPw);
		
		attrService.remove("member", loginedMemberId, "extra", "useTempPassword");
		
	}

	public void notifyTempLoginPw(Member member) {
		String to = member.getEmail();
		String tempPasswordOrigin = Util.getTempPassword(6);
		String tempPassword = Util.sha256(tempPasswordOrigin);
		
		modify(member.getId(), tempPassword);
		attrService.setValue("member", member.getId(), "extra", "useTempPassword", "1");
		
		String title = String.format("[%s] 임시패스워드 발송", siteName);
		String body = String.format("<div>임시 패스워드 : %s</div>\n", tempPasswordOrigin);
		mailService.send(to, title, body);
	}

	public void unsubscribe(int loginedMemberId) {
		memberDao.unsubscribe(loginedMemberId);
	}
}
