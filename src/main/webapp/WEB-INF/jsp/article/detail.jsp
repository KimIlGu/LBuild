<%@ page import="com.sbs.kig.lolBuild.util.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${board.name} 게시물 상세보기" />
<%@ include file="../part/head.jspf"%>
<%@ include file="../part/toastuiEditor.jspf"%>

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
				<td>
				    <script type="text/x-template">${article.body}</script>
                    <div class="toast-editor toast-editor-viewer"></div>
				</td>
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
		<a class="btn btn-success" href="${board.code}-modify?id=${article.id}&listUrl=${Util.getUriEncoded(listUrl)}">수정</a>
	</c:if>	
	<c:if test="${article.extra.actorCanDelete}">
		<a class="btn btn-danger" href="${board.code}-doDelete?id=${article.id}" onclick="if ( confirm('삭제하시겠습니까?') == false ) return false;">삭제</a>
	</c:if>

	<a class="btn btn-info" href="${listUrl}">목록</a>
</div>

<%@ include file="../part/foot.jspf"%> 