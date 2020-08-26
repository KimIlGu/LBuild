package com.sbs.kig.lolBuild.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.kig.lolBuild.dao.ArticleDao;
import com.sbs.kig.lolBuild.dto.Article;
import com.sbs.kig.lolBuild.dto.Board;
import com.sbs.kig.lolBuild.dto.Member;
import com.sbs.kig.lolBuild.dto.ResultData;
import com.sbs.kig.lolBuild.util.Util;

@Service
public class ArticleService {
	@Autowired
	private ArticleDao articleDao;

	public List<Article> getForPrintArticles() {
		List<Article> articles = articleDao.getForPrintArticles();

		return articles;
	}

	public Article getForPrintArticleById(int id, Member loginedMember) {
		Article article = articleDao.getForPrintArticleById(id);
		
		updateForPrintInfo(loginedMember, article);

		return article;
	}
	
	public Board getBoardByCode(String boardCode) {
		return articleDao.getBoardByCode(boardCode);
	}
	
	public int write(Map<String, Object> param) {
		articleDao.write(param);
		int id = Util.getAsInt(param.get("id"));

		return id;
	}
	
	public void hitUp(int id) {
		articleDao.hitUp(id);
	}

	private void updateForPrintInfo(Member actor, Article article) {
		Util.putExtraVal(article, "actorCanDelete", actorCanDelete(actor, article));
		Util.putExtraVal(article, "actorCanModify", actorCanModify(actor, article));
	}
	
	public boolean actorCanModify(Member actor, Article article) {
		return actor != null && actor.getId() == article.getMemberId() ? true : false;
	}

	public boolean actorCanDelete(Member actor, Article article) {
		return actorCanModify(actor, article);
	}

	public ResultData checkActorCanModify(Member actor, int id) {
		boolean actorCanModify = actorCanModify(actor, id);

		if (actorCanModify) {
			return new ResultData("S-1", "가능합니다.", "id", id);
		}

		return new ResultData("F-1", "권한이 없습니다.", "id", id);
	}
	
	private boolean actorCanModify(Member actor, int id) {
		Article article = articleDao.getArticleById(id);

		return actorCanModify(actor, article);
	}
	
	public void modify(Map<String, Object> param) {
		articleDao.modify(param);
	}

	public void delete(int id) {
		articleDao.delete(id);
	}
}
