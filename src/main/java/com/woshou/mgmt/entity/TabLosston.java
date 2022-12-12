package com.woshou.mgmt.entity;

import java.sql.Timestamp;

import com.woshou.common.entity.BaseEntity;

public class TabLosston extends BaseEntity<TabLosston> {

	private static final long serialVersionUID = 1L;	
		private Integer id;//   	private Integer orderid;//   订单 编号	private String price;//   煤型单价	private String lossratio;//   正常亏损率	private String normallosston;//   正常亏吨数	private String beyonds;//   超亏吨数	private boolean checked;	private Timestamp datetime;//   时间	public Integer getId() {	    return this.id;	}	public void setId(Integer id) {	    this.id = id;	}	public Integer getOrderid() {	    return this.orderid;	}	public void setOrderid(Integer orderid) {	    this.orderid = orderid;	}	public String getPrice() {	    return this.price;	}	public void setPrice(String price) {	    this.price = price;	}	public String getLossratio() {	    return this.lossratio;	}	public void setLossratio(String lossratio) {	    this.lossratio = lossratio;	}	public String getNormallosston() {	    return this.normallosston;	}	public void setNormallosston(String normallosston) {	    this.normallosston = normallosston;	}	public String getBeyonds() {	    return this.beyonds;	}	public void setBeyonds(String beyonds) {	    this.beyonds = beyonds;	}	public Timestamp getDatetime() {	    return this.datetime;	}	public void setDatetime(Timestamp datetime) {	    this.datetime = datetime;	}

	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}

	@Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("TabLosston [");   
        builder.append("id=");
        builder.append(id);
        builder.append(", orderid=");
        builder.append(orderid);
        builder.append(", price=");
        builder.append(price);
        builder.append(", lossratio=");
        builder.append(lossratio);
        builder.append(", normallosston=");
        builder.append(normallosston);
        builder.append(", beyonds=");
        builder.append(beyonds);
        builder.append(", datetime=");
        builder.append(datetime);
        builder.append("]");
        return builder.toString();
    }
}

