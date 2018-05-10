package com.gm.base.tree;

import java.io.Serializable;

/**
 * ztree
 * 
 * @author ying
 *
 */
public class ZTree implements Serializable {
	private int id;
	private int pId;
	private String name;
	private boolean checked = false;
	private boolean open = true;

	public ZTree(int id, int pId, String name, boolean checked) {
		super();
		this.id = id;
		this.pId = pId;
		this.name = name;
		this.checked = checked;
		this.setOpen(true);
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getpId() {
		return pId;
	}

	public void setpId(int pId) {
		this.pId = pId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}

	public boolean isOpen() {
		return open;
	}

	public void setOpen(boolean open) {
		this.open = open;
	}

}