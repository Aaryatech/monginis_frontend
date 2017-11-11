
package com.monginis.ops.model.grngvn;

import java.util.Date;

public class GetGrnItemConfig {

    private Integer billDetailNo;
    private Integer itemId;
    private Integer frId;
    private String itemName;
    private Integer grnType;
    private Integer billNo;
    private Integer rate;
    private Integer mrp;
    private Integer billQty;
    
    Date billDate;
    
    float sgstPer;
    float cgstPer;
    float igstPer;
    
    
  
	private int menuId;
	
	private int catId;
	
	private String invoiceNo;
	
   
    public int getMenuId() {
		return menuId;
	}

	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}

	public int getCatId() {
		return catId;
	}

	public void setCatId(int catId) {
		this.catId = catId;
	}

	public String getInvoiceNo() {
		return invoiceNo;
	}

	public void setInvoiceNo(String invoiceNo) {
		this.invoiceNo = invoiceNo;
	}

	public Integer getBillDetailNo() {
        return billDetailNo;
    }

    public void setBillDetailNo(Integer billDetailNo) {
        this.billDetailNo = billDetailNo;
    }

    public Integer getItemId() {
        return itemId;
    }

    public void setItemId(Integer itemId) {
        this.itemId = itemId;
    }

    public Integer getFrId() {
        return frId;
    }

    public void setFrId(Integer frId) {
        this.frId = frId;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public Integer getGrnType() {
        return grnType;
    }

    public void setGrnType(Integer grnType) {
        this.grnType = grnType;
    }

    public Integer getBillNo() {
        return billNo;
    }

    public void setBillNo(Integer billNo) {
        this.billNo = billNo;
    }

    public Integer getRate() {
        return rate;
    }

    public void setRate(Integer rate) {
        this.rate = rate;
    }

    public Integer getMrp() {
        return mrp;
    }

    public void setMrp(Integer mrp) {
        this.mrp = mrp;
    }

    public Integer getBillQty() {
        return billQty;
    }

    public void setBillQty(Integer billQty) {
        this.billQty = billQty;
    }

	
    

	
	
	
	public Date getBillDate() {
		return billDate;
	}

	public void setBillDate(Date billDate) {
		this.billDate = billDate;
	}

	public float getSgstPer() {
		return sgstPer;
	}

	public void setSgstPer(float sgstPer) {
		this.sgstPer = sgstPer;
	}

	public float getCgstPer() {
		return cgstPer;
	}

	public void setCgstPer(float cgstPer) {
		this.cgstPer = cgstPer;
	}

	public float getIgstPer() {
		return igstPer;
	}

	public void setIgstPer(float igstPer) {
		this.igstPer = igstPer;
	}

	
	
	@Override
	public String toString() {
		return "GetGrnItemConfig [billDetailNo=" + billDetailNo + ", itemId=" + itemId + ", frId=" + frId
				+ ", itemName=" + itemName + ", grnType=" + grnType + ", billNo=" + billNo + ", rate=" + rate + ", mrp="
				+ mrp + ", billQty=" + billQty + ", billDate=" + billDate + ", sgstPer=" + sgstPer + ", cgstPer="
				+ cgstPer + ", igstPer=" + igstPer + ", menuId=" + menuId + ", catId=" + catId + ", invoiceNo="
				+ invoiceNo + "]";
	}

	
	
}
