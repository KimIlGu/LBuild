<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${board.name} 게시물 작성" />
<%@ include file="../part/head.jspf"%>
<%@ include file="../part/toastuiEditor.jspf"%>

<script>
	var ArticleWriterForm__submitDone = false;

	function ArticleWriteForm__submit(form) {
		if (ArticleWriterForm__submitDone) {
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

<form class="table-box table-box-vertical con form1" method="POST" action="${board.code}-doWrite"
	  onsubmit="ArticleWriteForm__submit(this); return false;">
	<input type="hidden" name="body"/>
	<input type="hidden" name="redirectUri" value="/usr/article/${board.code}-detail?id=#id">
	<table>
		<colgroup>
			<col class="table-first-col">
			<col />
		</colgroup>
		<tbody>
			<tr>
				<th>제목</th>
				<td>
					<div class="form-control-box">
						<input type="text" name="title" maxlength="100" placeholder="제목을 입력해주세요."/>
					</div>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<div class="form-control-box">
						<script type="text/x-template">
# 제목

## 이미지 첨부 사용법
![img](https://placekitten.com/200/287)


## 유투브 동영상 첨부 사용법

```youtube
https://www.youtube.com/watch?v=LmgWxezH7cc
```
                        </script>
                        <div data-relTypeCode="article" data-relId="0" class="toast-editor input-body"></div>
					</div>
				</td>
			</tr>

			<tr class="tr-do">
				<th>작성</th>
				<td>
					<button class="btn btn-primary" type="submit">작성</button>
					<a class="btn btn-info" href="${listUrl}">목록</a>
				</td>
			</tr>
		</tbody>
	</table>
</form>
<%@ include file="../part/foot.jspf"%>