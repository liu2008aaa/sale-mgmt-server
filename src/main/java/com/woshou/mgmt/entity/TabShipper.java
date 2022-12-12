package com.woshou.mgmt.entity;

import java.util.Date;

import com.woshou.common.entity.BaseEntity;

public class TabShipper extends BaseEntity<TabShipper> {

	private static final long serialVersionUID = 1L;	
	
	private String lessMoney;//余额少于
	private String endDate;
    public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getLessMoney() {
		return lessMoney;
	}

	public void setLessMoney(String lessMoney) {
		this.lessMoney = lessMoney;
	}

	@Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("TabShipper [");   
        builder.append("id=");
        builder.append(id);
        builder.append(", name=");
        builder.append(name);
        builder.append(", money=");
        builder.append(money);
        builder.append(", restriction=");
        builder.append(restriction);
        builder.append(", datetime=");
        builder.append(datetime);
        builder.append("]");
        return builder.toString();
    }
}
