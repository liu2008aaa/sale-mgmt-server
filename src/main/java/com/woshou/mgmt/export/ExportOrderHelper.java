package com.woshou.mgmt.export;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Row;

import com.woshou.base.util.DateTool;
import com.woshou.mgmt.common.utils.excel.ExportExcel;
import com.woshou.mgmt.dto.OrderStaResult;
import com.woshou.mgmt.entity.TabOrderform;

public class ExportOrderHelper {
	public static void export(List<TabOrderform> dataList,OrderStaResult orderStaResult,HttpServletResponse response) throws IOException{
		//heads
		List<String> heads = createOrderHead();
		ExportExcel resultExcel = new ExportExcel("巨野县广通达物流有限公司发货单统计", null,
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
			resultExcel.addCell(row, cell++, dataList.get(i).getSnw());
			int status = dataList.get(i).getStatus();
			String statusStr = "";
			switch(status){
				case 1:
					statusStr = "已发货";
					break;
				case 2:
					statusStr = "已收货";
					break;
				case 3:
					statusStr = "已计算";
					break;
			}
			resultExcel.addCell(row, cell++, statusStr);
			resultExcel.addCell(row, cell++, DateTool.getDate(dataList.get(i).getDatetime(), DateTool.sdfLong));
		}
		Row row = resultExcel.addRow();
		resultExcel.addCell(row,0,"统计：");
		resultExcel.addCell(row,1,"总发货"+orderStaResult.getCount()+"次");
		resultExcel.addCell(row,2,"");
		resultExcel.addCell(row,3,"");
		resultExcel.addCell(row,4,"");
		resultExcel.addCell(row,5,"");
		resultExcel.addCell(row,6,"");
		resultExcel.addCell(row,7,orderStaResult.getTotalSnw());
		resultExcel.addCell(row,8,"");
		resultExcel.addCell(row,9,"");
		String fileName = "发货单统计" + DateTool.getDate(new Date(), DateTool.dtLong) + ".xlsx";
		resultExcel.write(response, fileName);
		resultExcel.dispose();
	}
	private static List<String> createOrderHead() {
		List<String> listmap = new ArrayList<>();
		listmap.add("编号");
		listmap.add("发货单位");
		listmap.add("收货单位");
		listmap.add("公司");
		listmap.add("车号");
		listmap.add("煤型");
		listmap.add("类型");
		listmap.add("净重");
		listmap.add("状态");
		listmap.add("时间");
		return listmap;
	}
}
