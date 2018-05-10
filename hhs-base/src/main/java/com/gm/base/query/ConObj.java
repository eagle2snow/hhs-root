package com.gm.base.query;

import org.springframework.stereotype.Component;

/**
 * 条件项对象
 * 
 * @author ying
 *
 */
@Component
public class ConObj {
	private Object start;// 开始
	private Object end; // 结束

	public Object getEnd() {
		return end;
	}

	public void setEnd(Object end) {
		this.end = end;
	}

	public Object getStart() {
		return start;
	}

	public void setStart(Object start) {
		this.start = start;
	}

}
