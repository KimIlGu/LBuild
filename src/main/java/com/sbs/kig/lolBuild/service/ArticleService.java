package com.sbs.kig.lolBuild.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.kig.lolBuild.dao.ArticleDao;
import com.sbs.kig.lolBuild.dto.Article;
import com.sbs.kig.lolBuild.dto.Board;
import com.sbs.kig.lolBuild.dto.Member;
import com.sbs.kig.lolBuild.util.Util;

@Service
public class ArticleService {
	@Autowired
	private ArticleDao articleDao;

	public Board getBoardByCode(String boardCode) {
		return articleDao.getBoardByCode(boardCode);
	}

	public int write(Map<String, Object> param) {
		articleDao.write(param);
		int id = Util.getAsInt(param.get("id"));

		return id;
	}

	public List<Article> getForPrintArticles() {
		List<Article> articles = articleDao.getForPrintArticles();

		return articles;
	}

	public Article getForPrintArticle(int id, Member loginedMember) {
		Article article = articleDao.getForPrintArticle(id);
		
		updateArticleExtraDataForPrint(article, loginedMember);

		return article;
	}

	private void updateArticleExtraDataForPrint(Article article, Member actor) {
		Util.putExtraVal(article, "actorCanDelete", actorCanDelete(actor, article));
		Util.putExtraVal(article, "actorCanModify", actorCanModify(actor, article));
	}
	
	public boolean actorCanModify(Member actor, Article article) {
		return actor != null && actor.getId() == article.getMemberId() ? true : false;
	}

	public boolean actorCanDelete(Member actor, Article article) {
		return actorCanModify(actor, article);
	}

	public void hitUp(int id) {
		articleDao.hitUp(id);
	}
}
