package com.woshou.mgmt.dto;

import java.math.BigDecimal;

public class OrderStaResult implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	private int count;
	private String totalSnw;//总发货净重
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getTotalSnw() {
		if(totalSnw!=null && totalSnw.length() > 0){
			BigDecimal bg = new BigDecimal(totalSnw);
			bg = bg.setScale(3, BigDecimal.ROUND_UP);
			totalSnw = bg.toString();
		}
		return totalSnw;
	}
	public void setTotalSnw(String totalSnw) {
		this.totalSnw = totalSnw;
	}
	
	
}
