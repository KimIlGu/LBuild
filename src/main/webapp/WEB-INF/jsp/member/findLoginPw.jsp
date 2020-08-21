<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="비밀번호 찾기" />
<%@ include file="../part/head.jspf"%>

<style>
/* cus */

.find-loginPw-form-box {
	margin-top: 30px;
}
</style>

<script>
	var FindLoginPwForm__submitDone = false;
	function FindLoginPwForm__submit(form) {
		if (FindLoginPwForm__submitDone) {
			alert('처리중 입니다.');
			return;
		}
		form.loginId.value = form.loginId.value.trim();
		if (form.loginId.value.length == 0) {
			alert('이름을 입력해주세요.');
			form.loginId.focus();
			return;
		}
		form.email.value = form.email.value.trim();
		if (form.email.value.length == 0) {
			alert('이메일을 입력해주세요.');
			form.email.focus();
			return;
		}
		form.submit();
		FindLoginPwForm__submitDone = true;
	}
</script>

<form action="doFindLoginPw" method="POST" class="table-box con form1"
	onsubmit="FindLoginPwForm__submit(this); return false;">
	<input type="hidden" name="redirectUri" value="/usr/home/main">
	
	<table>
		<colgroup>
			<col width="100">
		</colgroup>
		<tbody>
			<tr>
				<th>로그인 아이디</th>
				<td>
					<div class="form-control-box">
						<input autofocus type="text" placeholder="로그인 아이디를 입력해주세요." name="loginId"
							maxlength="30" />
					</div>
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<div class="form-control-box">
						<input type="email" placeholder="이메일을 입력해주세요." name="email"
							maxlength="30" />
					</div>
				</td>
			</tr>
			
			<tr>
				<th>확인</th>
				<td>
					<button class="btn btn-primary" type="submit">확인</button>
				</td>
			</tr>
		</tbody>
	</table>
</form>
<%@ include file="../part/foot.jspf"%> 