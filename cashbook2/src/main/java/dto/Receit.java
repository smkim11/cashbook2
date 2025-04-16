package dto;

public class Receit {
	private int cashNo;
	private String fileName;
	private String createdate;
	
	public int getCashNo() {
		return cashNo;
	}
	public void setCashNo(int cashNo) {
		this.cashNo = cashNo;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	@Override
	public String toString() {
		return "Receit [cashNo=" + cashNo + ", fileName=" + fileName + ", createdate=" + createdate + "]";
	}
	
	
}
