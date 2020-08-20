package com.sbs.kig.lolBuild.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.kig.lolBuild.dao.AttrDao;

@Service
public class AttrService {
	@Autowired
	private AttrDao attrDao;

	public int setValue(String name, String value) {
		String[] nameBits = name.split("__");
		String relTypeCode = nameBits[0];
		int relId = Integer.parseInt(nameBits[1]);
		String typeCode = nameBits[2];
		String type2Code = nameBits[3];

		return setValue(relTypeCode, relId, typeCode, type2Code, value);
	}

	private int setValue(String relTypeCode, int relId, String typeCode, String type2Code, String value) {
		return attrDao.setValue(relTypeCode, relId, typeCode, type2Code, value);
	}

	public String getValue(String name) {
		String[] nameBits = name.split("__");
		String relTypeCode = nameBits[0];
		int relId = Integer.parseInt(nameBits[1]);
		String typeCode = nameBits[2];
		String type2Code = nameBits[3];

		return getValue(relTypeCode, relId, typeCode, type2Code);
	}

	private String getValue(String relTypeCode, int relId, String typeCode, String type2Code) {
		return attrDao.getValue(relTypeCode, relId, typeCode, type2Code);
	}

	public void remove(String relTypeCode, int relId, String typeCode, String type2Code) {
		attrDao.remove(relTypeCode, relId, typeCode, type2Code);
	}

}
