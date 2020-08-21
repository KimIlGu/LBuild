<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="아이디 찾기" />
<%@ include file="../part/head.jspf"%>

<style>
/* cus */
.find-loginId-form-box {
	margin-top: 30px;
}
.find-loginPw-form-box {
	margin-top: 30px;
}
</style>

<script>
	var FindLoginIdForm__submitDone = false;
	function FindLoginIdForm__submit(form) {
		if (FindLoginIdForm__submitDone) {
			alert('처리중 입니다.');
			return;
		}
		form.name.value = form.name.value.trim();
		if (form.name.value.length == 0) {
			alert('이름을 입력해주세요.');
			form.name.focus();
			return;
		}
		form.email.value = form.email.value.trim();
		if (form.email.value.length == 0) {
			alert('이메일을 입력해주세요.');
			form.email.focus();
			return;
		}
		form.submit();
		FindLoginIdForm__submitDone = true;
	}
</script>

<form action="doFindLoginId" method="POST" class="table-box con form1"
	onsubmit="FindLoginIdForm__submit(this); return false;">
	<input type="hidden" name="redirectUri" value="/usr/home/main">
	
	<table>
		<colgroup>
			<col width="100">
		</colgroup>
		<tbody>
			<tr>
				<th>이름</th>
				<td>
					<div class="form-control-box">
						<input autofocus type="text" placeholder="이름을 입력해주세요." name="name"
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