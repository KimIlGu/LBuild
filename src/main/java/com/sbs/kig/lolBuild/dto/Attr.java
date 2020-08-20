package com.sbs.kig.lolBuild.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Attr {
	private int id;
	private String regDate;
	private String updateDate;
	private String name;
	private String value;
}