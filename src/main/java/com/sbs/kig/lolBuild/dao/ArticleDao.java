package com.sbs.kig.lolBuild.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.kig.lolBuild.dto.Article;
import com.sbs.kig.lolBuild.dto.Board;

@Mapper
public interface ArticleDao {
	
	List<Article> getForPrintArticles();

	Article getForPrintArticleById(@Param("id") int id);
	
	Article getArticleById(@Param("id") int id);
	
	Board getBoardByCode(String boardCode);
	
	void write(Map<String, Object> param);
	
	void hitUp(int id);
	
	void modify(Map<String, Object> param);

	void delete(int id);
}
