package servlets.admin.supplier;

public class WareLastMovementProduct {

	private String nameW;
	private String nameP;
	private int serialP;
	private String nameS;
	
	
	public WareLastMovementProduct(){
		nameW = null;
		nameP = null;
		serialP = 0;
		nameS = null;
	}
	
	
	public String getNameW() {
		return nameW;
	}
	public void setNameW(String nameW) {
		this.nameW = nameW;
	}
	public String getNameP() {
		return nameP;
	}
	public void setNameP(String nameP) {
		this.nameP = nameP;
	}
	public int getSerialP() {
		return serialP;
	}
	public void setSerialP(int serialP) {
		this.serialP = serialP;
	}
	public String getNameS() {
		return nameS;
	}
	public void setNameS(String nameS) {
		this.nameS = nameS;
	}

}
