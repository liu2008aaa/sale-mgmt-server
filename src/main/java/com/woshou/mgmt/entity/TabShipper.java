package com.woshou.mgmt.entity;

import java.util.Date;

import com.woshou.common.entity.BaseEntity;

public class TabShipper extends BaseEntity<TabShipper> {

	private static final long serialVersionUID = 1L;	
		private Integer id;//   	private String name;//   发货单位名称	private String money;//   余额
	private String lessMoney;//余额少于	private String restriction = "1000.00";//   超额限定	private Date datetime;//   日期	private String startDate;
	private String endDate;	public Integer getId() {	    return this.id;	}	public void setId(Integer id) {	    this.id = id;	}	public String getName() {	    return this.name;	}	public void setName(String name) {	    this.name = name;	}	public String getMoney() {	    return this.money;	}	public void setMoney(String money) {	    this.money = money;	}	public String getRestriction() {	    return this.restriction;	}	public void setRestriction(String restriction) {	    this.restriction = restriction;	}	public Date getDatetime() {	    return this.datetime;	}	public void setDatetime(Date datetime) {	    this.datetime = datetime;	}
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

