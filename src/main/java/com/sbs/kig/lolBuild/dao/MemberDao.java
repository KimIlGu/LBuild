package com.sbs.kig.lolBuild.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.kig.lolBuild.dto.Member;

@Mapper
public interface MemberDao {
	
	Member getMemberById(String id);

	void join(Map<String, Object> param);

	int getLoginIdDupCount(@Param("loginId") String loginId);

	Member getMemberByLoginId(int id);

	Member getMemberByNameAndEmail(@Param("name") String name, @Param("email") String email);

	void modify(int loginedMemberId, String loginPw);

	void unsubscribe(int loginedMemberId);
	
	int getNicknameDupCount(String nickname);
	
	int getEmailDupCount(String email);

	

}
