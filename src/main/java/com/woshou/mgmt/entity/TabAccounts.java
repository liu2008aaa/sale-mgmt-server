package com.woshou.mgmt.entity;

import java.util.Date;

import com.woshou.common.entity.BaseEntity;

public class TabAccounts extends BaseEntity<TabAccounts> {

	private static final long serialVersionUID = 1L;	
		private Integer id;//   	private Integer orderid;//   订单号 	private String shippername;//   发货单位名称 3	private String receivingname;//   收货单位 名称 4	private String carhome;//   车辆所属公司 5	private String platenumber;//   车牌号 6	private Integer vecturatype;//   货运类型 长途、短途	private String sgw;//   发货 毛重 8	private String stw;//   发货 皮重 10	private String snw;//   发货 净重 12	private String rnw;//   收货 净重 13	private String coaltype;//   煤型 14	private String losston;//   亏吨数 15	private String money;//   余额 16	private String coaltypeprice;//   煤型单价 17	private String lossratio;//   正常亏损率 18	private String normallosston;//   正常亏吨数 19	private String beyonds;//   超亏吨数 20	private String shipperprice;//   发货单位运费单价 21	private String shippercost;//   发货单位运费 22	private String chauffeurprice;//   司机运费单价 23	private String chauffeurcost;//   司机运费 24	private Integer status;//   结算状态 0:全部，1：未结算，2：已结算 25	private Date datetime;//   发货日期 26	private String dataIndex;//   	private String startDate;
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

	public Integer getId() {	    return this.id;	}	public void setId(Integer id) {	    this.id = id;	}	public Integer getOrderid() {	    return this.orderid;	}	public void setOrderid(Integer orderid) {	    this.orderid = orderid;	}	public String getShippername() {	    return this.shippername;	}	public void setShippername(String shippername) {	    this.shippername = shippername;	}	public String getReceivingname() {	    return this.receivingname;	}	public void setReceivingname(String receivingname) {	    this.receivingname = receivingname;	}	public String getCarhome() {	    return this.carhome;	}	public void setCarhome(String carhome) {	    this.carhome = carhome;	}	public String getPlatenumber() {	    return this.platenumber;	}	public void setPlatenumber(String platenumber) {	    this.platenumber = platenumber;	}	public Integer getVecturatype() {	    return this.vecturatype;	}	public void setVecturatype(Integer vecturatype) {	    this.vecturatype = vecturatype;	}	public String getSgw() {	    return this.sgw;	}	public void setSgw(String sgw) {	    this.sgw = sgw;	}	public String getStw() {	    return this.stw;	}	public void setStw(String stw) {	    this.stw = stw;	}	public String getSnw() {	    return this.snw;	}	public void setSnw(String snw) {	    this.snw = snw;	}	public String getRnw() {	    return this.rnw;	}	public void setRnw(String rnw) {	    this.rnw = rnw;	}	public String getCoaltype() {	    return this.coaltype;	}	public void setCoaltype(String coaltype) {	    this.coaltype = coaltype;	}	public String getLosston() {	    return this.losston;	}	public void setLosston(String losston) {	    this.losston = losston;	}	public String getMoney() {	    return this.money;	}	public void setMoney(String money) {	    this.money = money;	}	public String getCoaltypeprice() {	    return this.coaltypeprice;	}	public void setCoaltypeprice(String coaltypeprice) {	    this.coaltypeprice = coaltypeprice;	}	public String getLossratio() {	    return this.lossratio;	}	public void setLossratio(String lossratio) {	    this.lossratio = lossratio;	}	public String getNormallosston() {	    return this.normallosston;	}	public void setNormallosston(String normallosston) {	    this.normallosston = normallosston;	}	public String getBeyonds() {	    return this.beyonds;	}	public void setBeyonds(String beyonds) {	    this.beyonds = beyonds;	}	public String getShipperprice() {	    return this.shipperprice;	}	public void setShipperprice(String shipperprice) {	    this.shipperprice = shipperprice;	}	public String getShippercost() {	    return this.shippercost;	}	public void setShippercost(String shippercost) {	    this.shippercost = shippercost;	}	public String getChauffeurprice() {	    return this.chauffeurprice;	}	public void setChauffeurprice(String chauffeurprice) {	    this.chauffeurprice = chauffeurprice;	}	public String getChauffeurcost() {	    return this.chauffeurcost;	}	public void setChauffeurcost(String chauffeurcost) {	    this.chauffeurcost = chauffeurcost;	}	public Integer getStatus() {	    return this.status;	}	public void setStatus(Integer status) {	    this.status = status;	}	public Date getDatetime() {	    return this.datetime;	}	public void setDatetime(Date datetime) {	    this.datetime = datetime;	}	public String getDataIndex() {	    return this.dataIndex;	}	public void setDataIndex(String dataIndex) {	    this.dataIndex = dataIndex;	}
    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("TabAccounts [");   
        builder.append("id=");
        builder.append(id);
        builder.append(", orderid=");
        builder.append(orderid);
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
        builder.append(", money=");
        builder.append(money);
        builder.append(", coaltypeprice=");
        builder.append(coaltypeprice);
        builder.append(", lossratio=");
        builder.append(lossratio);
        builder.append(", normallosston=");
        builder.append(normallosston);
        builder.append(", beyonds=");
        builder.append(beyonds);
        builder.append(", shipperprice=");
        builder.append(shipperprice);
        builder.append(", shippercost=");
        builder.append(shippercost);
        builder.append(", chauffeurprice=");
        builder.append(chauffeurprice);
        builder.append(", chauffeurcost=");
        builder.append(chauffeurcost);
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

