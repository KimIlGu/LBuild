package com.sbs.kig.lolBuild.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Reply {
	private int id;
	private String regDate;
	private String updateDate;
	private String delDate;
	private boolean delStatus;
	private boolean displayStatus;
	private String relTypeCode;
	private int relId;
	private int memberId;
	private String body;
	private Map<String, Object> extra;
}