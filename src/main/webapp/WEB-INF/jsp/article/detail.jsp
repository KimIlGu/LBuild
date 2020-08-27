<%@ page import="com.sbs.kig.lolBuild.util.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${board.name} 게시물 상세보기" />
<%@ include file="../part/head.jspf"%>
<%@ include file="../part/toastuiEditor.jspf"%>

<!-- 공통 CSS -->
<link rel="stylesheet" href="/resource/article/detail/detail.css" />

<div class="article-detail-box table-box table-box-vertical con">
	<table>
		<colgroup>
			<col class="table-first-col">
		</colgroup>
		<thead>
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
				<td>${article.title}</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${article.extra.writer}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td><script type="text/x-template">${article.body}</script>
					<div class="toast-editor toast-editor-viewer"></div></td>
			</tr>
			<tr>
				<th>조회수</th>
				<td>${article.hit}</td>
			</tr>
		</thead>
	</table>
</div>

<div class="btn-box con margin-top-20">
	<c:if test="${article.extra.actorCanModify}">
		<a class="btn btn-success"
			href="${board.code}-modify?id=${article.id}&listUrl=${Util.getUriEncoded(listUrl)}">수정</a>
	</c:if>
	<c:if test="${article.extra.actorCanDelete}">
		<a class="btn btn-danger"
			href="${board.code}-doDelete?id=${article.id}"
			onclick="if ( confirm('삭제하시겠습니까?') == false ) return false;">삭제</a>
	</c:if>

	<a class="btn btn-info" href="${listUrl}">목록</a>
</div>

<c:if test="${isLogined}">
	<h2 class="con">댓글 작성</h2>

	<script>
		var ArticleWriteReplyForm__submitDone = false;
		function ArticleWriteReplyForm__submit(form) {
			if (ArticleWriteReplyForm__submitDone) {
				alert('처리중입니다.');
			}
			form.body.value = form.body.value.trim();
			if (form.body.value.length == 0) {
				alert('댓글을 입력해주세요.');
				form.body.focus();
				return;
			}
			ArticleWriteReplyForm__submitDone = true;
			$.post('./../reply/doWriteReplyAjax', {
				relId : param.id,
				relTypeCode : form.relTypeCode.value,
				body : form.body.value
			}, function(data) {
				if (data.msg) {
					alert(data.msg);
				}
			}, 'json');
			form.body.value = '';
		}
	</script>

	<form class="table-box con form1"
		onsubmit="ArticleWriteReplyForm__submit(this); return false;">
		<input type="hidden" name="relTypeCode" value="article" /> <input
			type="hidden" name="relId" value="${article.id}" />

		<table>
			<colgroup>
				<col class="table-first-col">
			</colgroup>
			<tbody>
				<tr>
					<th>내용</th>
					<td>
						<div class="form-control-box">
							<textarea maxlength="300" name="body" placeholder="내용을 입력해주세요."
								class="height-300"></textarea>
						</div>
					</td>
				</tr>
				<tr>
					<th>작성</th>
					<td><input class="btn btn-primary" type="submit" value="작성">
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</c:if>

<h2 class="con">댓글 리스트</h2>

<div class="reply-list-box table-box con">
	<table>
		<colgroup>
			<col class="table-first-col table-first-col-tight">
			<col width="180" class="visible-on-md-up">
			<col width="180" class="visible-on-md-up">
			<col>
			<col width="200" class="visible-on-md-up">
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th class="visible-on-md-up">날짜</th>
				<th class="visible-on-md-up">작성자</th>
				<th>내용</th>
				<th class="visible-on-md-up">비고</th>
			</tr>
		</thead>
		<tbody>

		</tbody>
	</table>
</div>

<div class="reply-modify-form-modal">
	<div class="bg-white">
		<h1 class="text-align-center">댓글 수정</h1>
		<form action="" class="form1 padding-10"
			onsubmit="ReplyList__submitModifyForm(this); return false;">
			<input type="hidden" name="id" />
			<div class="form-row">
				<div class="form-control-label">내용</div>
				<div class="form-control-box">
					<textarea name="body" placeholder="내용을 입력해주세요."></textarea>
				</div>
			</div>
			<div class="form-row">
				<div class="form-control-label">수정</div>
				<div class="form-control-box">
					<button class="btn btn-success" type="submit">수정</button>
					<button class="btn btn-info" type="button"
						onclick="ReplyList__hideModifyFormModal();">취소</button>
				</div>
			</div>
		</form>
	</div>
</div>

<script>
	var ReplyList__$box = $('.reply-list-box');
	var ReplyList__$tbody = ReplyList__$box.find('tbody');
	var ReplyList__lastLodedId = 0;
	var ReplyList__submitModifyFormDone = false;
	function ReplyList__submitModifyForm(form) {
		if (ReplyList__submitModifyFormDone) {
			alert('처리중입니다.');
			return;
		}
		form.body.value = form.body.value.trim();
		if (form.body.value.length == 0) {
			alert('내용을 입력해주세요.');
			form.body.focus();
			return;
		}
		var id = form.id.value;
		var body = form.body.value;
		ReplyList__submitModifyFormDone = true;
		// 댓글 수정 시작
		$.post('../reply/doModifyReplyAjax', {
			id : id,
			body : body,
		}, function(data) {
			if (data.resultCode && data.resultCode.substr(0, 2) == 'S-') {
				// 성공시에는 기존에 그려진 내용을 수정해야 한다.!!
				var $tr = $('.reply-list-box tbody > tr[data-id="' + id
						+ '"] .reply-body');
				$tr.empty().append(body);
			}
			if (data.msg) {
				alert(data.msg);
			}
			ReplyList__hideModifyFormModal();
			ReplyList__submitModifyFormDone = false;
		}, 'json');
	}
	function ReplyList__showModifyFormModal(el) {
		$('html').addClass('reply-modify-form-modal-actived');
		var $tr = $(el).closest('tr');
		var originBody = $tr.data('data-originBody');
		var id = $tr.attr('data-id');
		var form = $('.reply-modify-form-modal form').get(0);
		$(form).find('[data-name]').each(function(index, el) {
			var $el = $(el);
			var name = $el.attr('data-name');
			name = name.replaceAll('__0__', '__' + id + '__');
			$el.attr('name', name);
		});
		form.id.value = id;
		form.body.value = originBody;
	}
	function ReplyList__hideModifyFormModal() {
		$('html').removeClass('reply-modify-form-modal-actived');
	}
	// 1초
	ReplyList__loadMoreInterval = 1 * 1000;
	function ReplyList__loadMoreCallback(data) {
		if (data.body.replies && data.body.replies.length > 0) {
			ReplyList__lastLodedId = data.body.replies[data.body.replies.length - 1].id;
			ReplyList__drawReplies(data.body.replies);
		}
		setTimeout(ReplyList__loadMore, ReplyList__loadMoreInterval);
	}
	function ReplyList__loadMore() {
		$.get('../reply/getForPrintReplies', {
			articleId : param.id,
			from : ReplyList__lastLodedId + 1
		}, ReplyList__loadMoreCallback, 'json');
	}
	function ReplyList__drawReplies(replies) {
		for (var i = 0; i < replies.length; i++) {
			var reply = replies[i];
			ReplyList__drawReply(reply);
		}
	}
	function ReplyList__delete(el) {
		if (confirm('삭제 하시겠습니까?') == false) {
			return;
		}
		var $tr = $(el).closest('tr');
		var id = $tr.attr('data-id');
		var relTypeCode = "article";
		
		$.post('./../reply/doDeleteReplyAjax', {
			id : id,
			relTypeCode : relTypeCode
		}, function(data) {
			if (data.msg) {
				alert(data.msg);
			}
			$tr.remove();
		}, 'json');
	}
	function ReplyList__drawReply(reply) {
		var html = '';
		html += '<tr data-id="' + reply.id + '">';
		html += '<td>' + reply.id + '</td>';
		html += '<td class="visible-on-md-up">' + reply.regDate + '</td>';
		html += '<td class="visible-on-md-up">' + reply.extra.writer + '</td>';
		html += '<td>';
		html += '<div class="reply-body">' + reply.body + '</div>';
		html += '<div class="visible-on-sm-down">날짜 : ' + reply.regDate
				+ '</div>';
		html += '<div class="visible-on-sm-down">작성 : ' + reply.extra.writer
				+ '</div>';
		html += '</td>';
		html += '<td class="visible-on-md-up">';
		if (reply.extra.actorCanModify) {
			html += '<button class="btn btn-success" type="button" onclick="ReplyList__showModifyFormModal(this);">수정</button>';
		}
		if (reply.extra.actorCanDelete) {
			html += '<button class="btn btn-danger" type="button" onclick="ReplyList__delete(this);">삭제</button>';
		}
		html += '</td>';
		html += '</tr>';
		var $tr = $(html);
		$tr.data('data-originBody', reply.body);
		ReplyList__$tbody.prepend($tr);
	}
	ReplyList__loadMore();
</script>

<%@ include file="../part/foot.jspf"%>
