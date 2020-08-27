<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="개인 계정" />
<%@ include file="../part/head.jspf"%>

<div class="con">
	<a class="btn btn-list" href="/usr/member/passwordForPrivate">- 비밀번호 재설정</a>
	<a class="btn btn-list" href="/usr/member/unsubscribe">- 계정 삭제</a>
</div>
<%@ include file="../part/foot.jspf"%> 