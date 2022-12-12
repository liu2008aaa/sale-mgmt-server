package com.woshou.mgmt.entity;

import java.util.Date;

import com.woshou.common.entity.BaseEntity;

public class TabOrderform extends BaseEntity<TabOrderform> {

	private static final long serialVersionUID = 1L;	
		private Integer id;//   主键	private Integer shipperid;//   发货单位id	private String shippername;//   发货单位名称	private String receivingname;//   收货单位 名称	private String carhome;//   车辆所属公司	private String platenumber;//   车牌号	private Integer vecturatype;//   货运类型 长途、短途	private String sgw;//   发货 毛重	private String stw;//   发货 皮重	private String snw;//   发货 净重	private String rnw;//   收货 净重	private String coaltype;//   煤型	private String losston;//   亏吨数	private Integer status;//   操作状态--0:初始;1:已发货;2:已收货,3:已结算	private Date datetime;//   数据录入 日期	private String dataIndex;//   	private String startDate;	private String endDate;
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

	public Integer getId() {	    return this.id;	}	public void setId(Integer id) {	    this.id = id;	}	public Integer getShipperid() {	    return this.shipperid;	}	public void setShipperid(Integer shipperid) {	    this.shipperid = shipperid;	}	public String getShippername() {	    return this.shippername;	}	public void setShippername(String shippername) {	    this.shippername = shippername;	}	public String getReceivingname() {	    return this.receivingname;	}	public void setReceivingname(String receivingname) {	    this.receivingname = receivingname;	}	public String getCarhome() {	    return this.carhome;	}	public void setCarhome(String carhome) {	    this.carhome = carhome;	}	public String getPlatenumber() {	    return this.platenumber;	}	public void setPlatenumber(String platenumber) {	    this.platenumber = platenumber;	}	public Integer getVecturatype() {	    return this.vecturatype;	}	public void setVecturatype(Integer vecturatype) {	    this.vecturatype = vecturatype;	}	public String getSgw() {	    return this.sgw;	}	public void setSgw(String sgw) {	    this.sgw = sgw;	}	public String getStw() {	    return this.stw;	}	public void setStw(String stw) {	    this.stw = stw;	}	public String getSnw() {	    return this.snw;	}	public void setSnw(String snw) {	    this.snw = snw;	}	public String getRnw() {	    return this.rnw;	}	public void setRnw(String rnw) {	    this.rnw = rnw;	}	public String getCoaltype() {	    return this.coaltype;	}	public void setCoaltype(String coaltype) {	    this.coaltype = coaltype;	}	public String getLosston() {	    return this.losston;	}	public void setLosston(String losston) {	    this.losston = losston;	}	public Integer getStatus() {	    return this.status;	}	public void setStatus(Integer status) {	    this.status = status;	}	public Date getDatetime() {	    return this.datetime;	}	public void setDatetime(Date datetime) {	    this.datetime = datetime;	}	public String getDataIndex() {	    return this.dataIndex;	}	public void setDataIndex(String dataIndex) {	    this.dataIndex = dataIndex;	}
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

