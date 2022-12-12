package com.woshou.mgmt.entity;

import java.sql.Timestamp;

import com.woshou.common.entity.BaseEntity;

public class TabLosston extends BaseEntity<TabLosston> {

	private static final long serialVersionUID = 1L;	
	

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
