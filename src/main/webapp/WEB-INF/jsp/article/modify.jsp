<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${board.name} 게시물 수정" />
<%@ include file="../part/head.jspf"%>
<%@ include file="../part/toastuiEditor.jspf"%>

<script>
	var ArticleModifyForm__submitDone = false;

	function ArticleModifyForm__submit(form) {
		if (ArticleModifyForm__submitDone) {
			alert('처리중입니다.');
			return;
		}
		
		form.title.value = form.title.value.trim();
		if (form.title.value.length == 0) {
			form.title.focus();
			alert('제목을 입력해주세요.');
			return;
		}
		
		var bodyEditor = $(form).find('.toast-editor.input-body').data('data-toast-editor');
		var body = bodyEditor.getMarkdown().trim();
		if (body.length == 0) {
			bodyEditor.focus();
			alert('특이사항을 입력해주세요.');
			return;
		}
		form.body.value = body;
		form.submit();
	}
</script>

<form class="table-box table-box-vertical con form1" method="POST" action="${board.code}-doModify" 
	  onsubmit="ArticleModifyForm__submit(this); return false;">
	<input type="hidden" name="body"/>
	<input type="hidden" name="redirectUri" value="/usr/article/${board.code}-detail?id=${article.id}" />
	<input type="hidden" name="id" value="${article.id}" />
	<table>
		<colgroup>
			<col class="table-first-col">
		</colgroup>
		<tbody>
			<tr>
				<th>번호</th>
				<td>${article.id}</td>
			</tr>
			<tr>
				<th>날짜</th>
				<td>${article.regDate}</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>
					<div class="form-control-box">
						<input type="text" value="${article.title}" name="title" placeholder="제목을 입력해주세요." />
					</div>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<div class="form-control-box">
						<script type="text/x-template">${article.body}</script>
						<div data-relTypeCode="article" data-relId="${article.id}" class="toast-editor input-body"></div>
					</div>
				</td>
			</tr>
		</tbody>
	</table>

	<div class="btn-box margin-top-20">
		<button class="btn btn-primary" type="submit">수정</button>
		<a class="btn btn-info" href="${listUrl}">목록</a>
	</div>
</form>

<%@ include file="../part/foot.jspf"%> 