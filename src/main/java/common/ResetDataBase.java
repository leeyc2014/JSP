package common;

public class ResetDataBase extends JDBConnect {

	public ResetDataBase() {
		super("com.mysql.cj.jdbc.Driver", "jdbc:mysql://localhost:3306/musthave", "musthave", "tiger");
	}

	private void deleteTableData() throws Exception {
		stmt = con.createStatement();
		// member 데이터 삭제
		stmt.executeUpdate("delete from member");
		// board 데이터 삭제
		stmt.executeUpdate("delete from board");
		// board num 번호 초기화
		stmt.executeUpdate("alter table board auto_increment=1");
	}
	
	private void insertMemberData() throws Exception {
		psmt = con.prepareStatement("INSERT INTO member(id,pass,name,regidate) VALUES (?,'1234',?,'2025-10-28')");
		
		String[][] vals = {
				{"musthave", "머스트해브"},
				{"dohave", "두해브"},
				{"willhave", "윌해브"}
		};
		for(String[] val : vals) {
			psmt.setString(1, val[0]);
			psmt.setString(2, val[1]);
			psmt.executeUpdate();	
		}
	}
	
	private void insertBoardData(int count) throws Exception {
		psmt = con.prepareStatement("INSERT INTO board(title,content,id,postdate,visitcount) "
									+ "VALUES (?,?,?,'2025-10-28',0)");

		String[] ids = { "musthave", "dohave", "willhave" };
		
		int idx = 1;
		for(String id : ids) {
			for(int i = 1 ; i <= count ; i++) {
				psmt.setString(1, "제목" + idx + "입니다.");
				psmt.setString(2, "내용" + idx + "입니다.");
				psmt.setString(3, id);
				psmt.executeUpdate();
				idx++;
			}
		}
	}
	
	public static void main(String[] args) throws Exception {
		
		ResetDataBase rd = new ResetDataBase();
		System.out.println("기존 테이블(board, member) 데이터 삭제");
		rd.deleteTableData();
		System.out.println("새로운 member 데이터 입력");
		rd.insertMemberData();
		System.out.println("새로운 board 데이터 입력");
		rd.insertBoardData(55);
		rd.close();
		System.out.println("Done");
	}
}
