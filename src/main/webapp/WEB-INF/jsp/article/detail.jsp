<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${board.name} 게시물 상세보기" />
<%@ include file="../part/head.jspf"%>

<div class="table-box con">
	<table>
		<colgroup>
			<col width="100" />
		</colgroup>
		<thead>
			<tr>
				<th>제목</th>
				<td>${article.title}</td>
			</tr>
			<tr>
				<th>작성 날짜</th>
				<td>${article.regDate}</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${article.extra.writer}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>${article.body}</td>
			</tr>
			<tr>
				<th>조회수</th>
				<td>${article.hit}</td>
			</tr>
			
		</thead>
	</table>
</div>

<div class="btn-box con margin-top-20">
	<a class="btn btn-info" href="${listUrl}">리스트</a>
</div>

<%@ include file="../part/foot.jspf"%> 