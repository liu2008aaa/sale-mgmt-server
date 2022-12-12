package com.woshou.mgmt.dto;

import java.math.BigDecimal;
import java.text.DecimalFormat;

/**
 * 运费统计结果
 * @author liuyu
 *
 */
public class CostStaResult {
	private DecimalFormat df = new DecimalFormat("#.00");
	
	private int count;//总发货 次数
	private String totalSnw;//总发货净重
	private String totalRnw;//总收货净重
	private BigDecimal totalShipperCost = BigDecimal.ZERO;//发货单位总运费
	private BigDecimal totalChauffeurCost = BigDecimal.ZERO;//司机总运费
	private String totalLosston;//总亏吨
	private String totalBeyonds;//总超亏吨数
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getTotalSnw() {
		return toScale(totalSnw);
	}
	public void setTotalSnw(String totalSnw) {
		this.totalSnw = totalSnw;
	}
	public String getTotalRnw() {
		return toScale(totalRnw);
	}
	public void setTotalRnw(String totalRnw) {
		this.totalRnw = totalRnw;
	}
	public BigDecimal getTotalShipperCost() {
		return totalShipperCost;
	}
	public String getTotalShipperCostStr() {
		if(totalShipperCost!=null){
			return df.format(totalShipperCost);
		}
		return null;
	}
	public void setTotalShipperCost(BigDecimal totalShipperCost) {
		this.totalShipperCost = totalShipperCost;
	}

	public BigDecimal getTotalChauffeurCost() {
		return totalChauffeurCost;
	}
	public String getTotalChauffeurCostStr() {
		if(totalChauffeurCost!=null){
			return df.format(totalChauffeurCost);
		}
		return null;
	}
	public void setTotalChauffeurCost(BigDecimal totalChauffeurCost) {
		this.totalChauffeurCost = totalChauffeurCost;
	}
	public String getTotalLosston() {
		return toScale(totalLosston);
	}
	public void setTotalLosston(String totalLosston) {
		this.totalLosston = totalLosston;
	}
	public String getTotalBeyonds() {
		return toScale(totalBeyonds);
	}
	public void setTotalBeyonds(String totalBeyonds) {
		this.totalBeyonds = totalBeyonds;
	}
	private String toScale(String value){
		if(value!=null && value.length() > 0){
			BigDecimal bg = new BigDecimal(value);
			bg = bg.setScale(3, BigDecimal.ROUND_UP);
			return bg.toString();
		}
		return value;
	}
}
