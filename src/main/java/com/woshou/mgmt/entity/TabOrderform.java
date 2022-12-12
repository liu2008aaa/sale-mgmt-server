package com.woshou.mgmt.entity;

import java.util.Date;

import com.woshou.common.entity.BaseEntity;

public class TabOrderform extends BaseEntity<TabOrderform> {

	private static final long serialVersionUID = 1L;	
	
	
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

	public Integer getId() {
    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("TabOrderform [");   
        builder.append("id=");
        builder.append(id);
        builder.append(", shipperid=");
        builder.append(shipperid);
        builder.append(", shippername=");
        builder.append(shippername);
        builder.append(", receivingname=");
        builder.append(receivingname);
        builder.append(", carhome=");
        builder.append(carhome);
        builder.append(", platenumber=");
        builder.append(platenumber);
        builder.append(", vecturatype=");
        builder.append(vecturatype);
        builder.append(", sgw=");
        builder.append(sgw);
        builder.append(", stw=");
        builder.append(stw);
        builder.append(", snw=");
        builder.append(snw);
        builder.append(", rnw=");
        builder.append(rnw);
        builder.append(", coaltype=");
        builder.append(coaltype);
        builder.append(", losston=");
        builder.append(losston);
        builder.append(", status=");
        builder.append(status);
        builder.append(", datetime=");
        builder.append(datetime);
        builder.append(", dataIndex=");
        builder.append(dataIndex);
        builder.append("]");
        return builder.toString();
    }
}
