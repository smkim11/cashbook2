package dto;

public class Paging {
	private int currentPage;
	private int rowPerPage;
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getRowPerPage() {
		return rowPerPage;
	}
	public void setRowPerPage(int rowPerPage) {
		this.rowPerPage = rowPerPage;
	}
	
	public int getStartIdx() {
		return (this.currentPage-1)*this.rowPerPage;
	}
	public int getLastPage(int totalIdx) {
		int lastPage = totalIdx / this.rowPerPage;
		if(totalIdx % this.rowPerPage != 0) {
			lastPage++;
		}
		return lastPage;
	}
}
