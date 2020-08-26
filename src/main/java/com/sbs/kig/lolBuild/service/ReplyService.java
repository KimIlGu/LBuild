package com.sbs.kig.lolBuild.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.kig.lolBuild.dao.ReplyDao;
import com.sbs.kig.lolBuild.dto.Member;
import com.sbs.kig.lolBuild.dto.Reply;
import com.sbs.kig.lolBuild.dto.ResultData;
import com.sbs.kig.lolBuild.util.Util;

@Service
public class ReplyService {
	@Autowired
	private ReplyDao replyDao;

	public List<Reply> getForPrintReplies(@RequestParam Map<String, Object> param) {
		List<Reply> replies = replyDao.getForPrintReplies(param);

		Member actor = (Member) param.get("actor");

		for (Reply reply : replies) {
			// 출력용 부가데이터를 추가한다.
			updateForPrintInfo(actor, reply);
		}

		return replies;
	}

	private void updateForPrintInfo(Member actor, Reply reply) {
		reply.getExtra().put("actorCanDelete", actorCanDelete(actor, reply));
		reply.getExtra().put("actorCanModify", actorCanModify(actor, reply));
	}

	// 액터가 해당 댓글을 수정할 수 있는지 알려준다.
	public boolean actorCanModify(Member actor, Reply reply) {
		return actor != null && actor.getId() == reply.getMemberId() ? true : false;
	}

	// 액터가 해당 댓글을 삭제할 수 있는지 알려준다.
	public boolean actorCanDelete(Member actor, Reply reply) {
		return actorCanModify(actor, reply);
	}

	public int writeReply(Map<String, Object> param) {
		replyDao.writeReply(param);
		int id = Util.getAsInt(param.get("id"));

		return id;
	}

	public void deleteReply(int id) {
		replyDao.deleteReply(id);
	}

	public Reply getForPrintReplyById(int id) {
		Reply reply = replyDao.getForPrintReplyById(id);

		return reply;
	}

	public void modfiyReply(Map<String, Object> param) {
		replyDao.modifyReply(param);
	}
}
