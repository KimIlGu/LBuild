<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="lolBuild" />
<%@ include file="../part/head.jspf"%>

<h1 class="con">알파테스트 기간입니다.(v0.01)</h1>

<h2 class="con">기능 리스트</h1>

<div class="con">
	<ul>
		<li><a class="btn btn-primary" href="../member/join">- 회원가입</a></li>
		<li><a class="btn btn-primary" href="../member/login">- 로그인</a></li>
		<li><a class="btn btn-primary" href="/usr/member/doLogout">- 로그아웃</a></li>
		<li><a class="btn btn-primary" href="#">- 가입시 감사메일 발송</a></li>
		<li><a class="btn btn-primary" href="../member/passwordForPrivate">- 개인 계정 접속</a></li>
		<li><a class="btn btn-primary" href="../member/modifyPrivate">- 개인 계정 접속 후 정보수정</a></li>
		<li><a class="btn btn-primary" href="/usr/member/findLoginId">- 아이디 찾기</a></li>
		<li><a class="btn btn-primary" href="/usr/member/findLoginPw">- 비밀번호 찾기</a></li>
		<li><a class="btn btn-primary" href="../article/notice-write">- 공지사항 게시물 작성</a></li>
		<li><a class="btn btn-primary" href="../article/notice-list">- 공지사항 게시물 리스트</a></li>
		<li><a class="btn btn-primary" href="../article/free-write">- 자유 게시판 게시물 작성</a></li>
		<li><a class="btn btn-primary" href="../article/free-list">- 자유 게시판 게시물 리스트</a></li>
	</ul>
</div>

<style>
.con > ul > li {
	margin-top: 5px;	
}
</style>

<%@ include file="../part/foot.jspf"%>