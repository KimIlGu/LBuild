package com.sbs.kig.lolBuild.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sbs.kig.lolBuild.dto.Article;
import com.sbs.kig.lolBuild.dto.Board;

@Mapper
public interface ArticleDao {
	Board getBoardByCode(String boardCode);

	void write(Map<String, Object> param);

	List<Article> getForPrintArticles();

	Article getForPrintArticle(int id);

	void hitUp(int id);
}
