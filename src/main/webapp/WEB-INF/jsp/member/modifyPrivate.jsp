<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="비밀번호 재설정"></c:set>
<%@ include file="../part/head.jspf"%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<style>
/* cus */
.modify-private-form-box {
	margin-top: 30px;
}
</style>

<script>
	function ModifyPrivateForm__submit(form) {
		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value.length == 0) {
			alert('로그인 비번을 입력해주세요.');
			form.loginPw.focus();
			return;
		}
		form.loginPwReal.value = sha256(form.loginPw.value);
		form.loginPw.value = '';
		form.submit();
	}
</script>

<form action="doModifyPrivate" method="POST" class="table-box con form1"
	onsubmit="ModifyPrivateForm__submit(this); return false;">
	<input type="hidden" name="authCode" value="${param.authCode}" />
	<input type="hidden" name="loginPwReal" />
	<input type="hidden" name="redirectUri" value="/usr/home/main">
	
	<table>
		<colgroup>
			<col width="100">
		</colgroup>
		<tbody>
			<tr>
				<th>새 로그인 비번</th>
				<td>
					<div class="form-control-box">
						<input type="password" placeholder="새 로그인 비번을 입력해주세요." name="loginPw"
							maxlength="30" />
					</div>
				</td>
			</tr>
			<tr>
				<th>새 로그인 비번 확인</th>
				<td>
					<div class="form-control-box">
						<input type="password" placeholder="새 로그인 비번을 입력해주세요." name="loginPwConfirm"
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