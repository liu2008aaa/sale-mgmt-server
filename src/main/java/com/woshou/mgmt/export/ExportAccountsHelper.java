package com.woshou.mgmt.export;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Row;

import com.woshou.base.util.DateTool;
import com.woshou.mgmt.common.utils.excel.ExportExcel;
import com.woshou.mgmt.dto.CostStaResult;
import com.woshou.mgmt.entity.TabAccounts;

public class ExportAccountsHelper {
	//发货单位运费
	public static void export1(List<TabAccounts> dataList,CostStaResult costStaResult,HttpServletResponse response) throws IOException{
		//heads
		List<String> heads = createAccount1Head();
		ExportExcel resultExcel = new ExportExcel("巨野县广通达物流有限公司发货单位运费", null,
				heads);
		for (int i = 0; i < dataList.size(); i++) {
			Row row = resultExcel.addRow();
			int cell = 0;
			resultExcel.addCell(row, cell++, dataList.get(i).getDataIndex());
			resultExcel.addCell(row, cell++, dataList.get(i).getShippername());
			resultExcel.addCell(row, cell++, dataList.get(i).getReceivingname());
			resultExcel.addCell(row, cell++, dataList.get(i).getCarhome());
			resultExcel.addCell(row, cell++, dataList.get(i).getPlatenumber());
			resultExcel.addCell(row, cell++, dataList.get(i).getCoaltype());
			int vecturatype = dataList.get(i).getVecturatype();
			if(vecturatype == 1){
				resultExcel.addCell(row, cell++,"长途");
			}else if(vecturatype == 2){
				resultExcel.addCell(row, cell++, "短途");
				
			}
			resultExcel.addCell(row, cell++, dataList.get(i).getSgw());
			resultExcel.addCell(row, cell++, dataList.get(i).getStw());
			resultExcel.addCell(row, cell++, dataList.get(i).getSnw());
			resultExcel.addCell(row, cell++, dataList.get(i).getShipperprice());
			resultExcel.addCell(row, cell++, dataList.get(i).getShippercost());
			resultExcel.addCell(row, cell++, DateTool.getDate(dataList.get(i).getDatetime(), DateTool.sdfLong));
		}
		Row row = resultExcel.addRow();
		resultExcel.addCell(row,0,"统计：");
		resultExcel.addCell(row,1,"总发货"+costStaResult.getCount()+"次");
		resultExcel.addCell(row,2,"");
		resultExcel.addCell(row,3,"");
		resultExcel.addCell(row,4,"");
		resultExcel.addCell(row,5,"");
		resultExcel.addCell(row,6,"");
		resultExcel.addCell(row,7,"");
		resultExcel.addCell(row,8,"");
		resultExcel.addCell(row,9,costStaResult.getTotalSnw());
		resultExcel.addCell(row,10,"");
		resultExcel.addCell(row,11,costStaResult.getTotalShipperCostStr());
		resultExcel.addCell(row,12,"");
		String fileName = "发货单位运费" + DateTool.getDate(new Date(), DateTool.dtLong) + ".xlsx";
		resultExcel.write(response, fileName);
		resultExcel.dispose();
	}
	//司机运费
	public static void export2(List<TabAccounts> dataList,CostStaResult costStaResult,HttpServletResponse response) throws IOException{
		//heads
		List<String> heads = createAccount2Head();
		ExportExcel resultExcel = new ExportExcel("巨野县广通达运输有限公司司机运费", null,
				heads);
		for (int i = 0; i < dataList.size(); i++) {
			Row row = resultExcel.addRow();
			int cell = 0;
			resultExcel.addCell(row, cell++, dataList.get(i).getId()+"");
			resultExcel.addCell(row, cell++, dataList.get(i).getShippername());
			resultExcel.addCell(row, cell++, dataList.get(i).getReceivingname());
			resultExcel.addCell(row, cell++, dataList.get(i).getCarhome());
			resultExcel.addCell(row, cell++, dataList.get(i).getPlatenumber());
			resultExcel.addCell(row, cell++, dataList.get(i).getCoaltype());
			int vecturatype = dataList.get(i).getVecturatype();
			if(vecturatype == 1){
				resultExcel.addCell(row, cell++,"长途");
			}else if(vecturatype == 2){
				resultExcel.addCell(row, cell++, "短途");
				
			}
			resultExcel.addCell(row, cell++, dataList.get(i).getSgw());
			resultExcel.addCell(row, cell++, dataList.get(i).getStw());
			resultExcel.addCell(row, cell++, dataList.get(i).getSnw());
			resultExcel.addCell(row, cell++, dataList.get(i).getRnw());
			resultExcel.addCell(row, cell++, dataList.get(i).getLosston());
			resultExcel.addCell(row, cell++, dataList.get(i).getNormallosston());
			resultExcel.addCell(row, cell++, dataList.get(i).getBeyonds());
			resultExcel.addCell(row, cell++, dataList.get(i).getChauffeurprice());
			resultExcel.addCell(row, cell++, dataList.get(i).getChauffeurcost());
			resultExcel.addCell(row, cell++, DateTool.getDate(dataList.get(i).getDatetime(), DateTool.sdfLong));
		}
		Row row = resultExcel.addRow();
		resultExcel.addCell(row,0,"统计：");
		resultExcel.addCell(row,1,"总发货"+costStaResult.getCount()+"次");
		resultExcel.addCell(row,2,"");
		resultExcel.addCell(row,3,"");
		resultExcel.addCell(row,4,"");
		resultExcel.addCell(row,5,"");
		resultExcel.addCell(row,6,"");
		resultExcel.addCell(row,7,"");
		resultExcel.addCell(row,8,"");
		resultExcel.addCell(row,9,costStaResult.getTotalSnw());
		resultExcel.addCell(row,10,costStaResult.getTotalRnw());
		resultExcel.addCell(row,11,costStaResult.getTotalLosston());
		resultExcel.addCell(row,12,"");
		resultExcel.addCell(row,13,costStaResult.getTotalBeyonds());
		resultExcel.addCell(row,14,"");
		resultExcel.addCell(row,15,costStaResult.getTotalChauffeurCost());
		resultExcel.addCell(row,16,"");
		String fileName = "司机运费" + DateTool.getDate(new Date(), DateTool.dtLong) + ".xlsx";
		resultExcel.write(response, fileName);
		resultExcel.dispose();
	}
	
	private static List<String> createAccount1Head() {
		List<String> listmap = new ArrayList<>();
		listmap.add("编号");
		listmap.add("发货单位");
		listmap.add("收货单位");
		listmap.add("公司");
		listmap.add("车号");
		listmap.add("煤型");
		listmap.add("类型");
		listmap.add("毛重");
		listmap.add("皮重");
		listmap.add("净重");
		listmap.add("单价");
		listmap.add("运费");
		listmap.add("发货时间");
		return listmap;
	}
	private static List<String> createAccount2Head() {
		List<String> listmap = new ArrayList<>();
		listmap.add("编号");
		listmap.add("发货单位");
		listmap.add("收货单位");
		listmap.add("公司");
		listmap.add("车号");
		listmap.add("煤型");
		listmap.add("类型");
		listmap.add("毛重");
		listmap.add("皮重");
		listmap.add("净重");
		listmap.add("收货净重");
		listmap.add("亏吨");
		listmap.add("正常亏吨");
		listmap.add("超亏吨");
		listmap.add("单价");
		listmap.add("运费");
		listmap.add("发货时间");
		return listmap;
	}
}
