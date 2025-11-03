package common;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Types;
import java.text.DecimalFormat;

import jakarta.servlet.jsp.JspWriter;

public class MyUtil {

	// 정수값을 구분기호(",")가 포함된 문자열로 생성하는 객체 
	private static DecimalFormat df = new DecimalFormat("#,###");
	
	// psmt의 sql문과 파라미터들이 결합한 최종 sql문을 출력한다. 
	public static void writeSQL(JspWriter out, PreparedStatement psmt) throws Exception {
		// psmt.toString()을 호출하면 아래 문자열을 반환한다.
		// ==> com.mysql.cj.jdbc.ClientPreparedStatement: select * from city where population > 1000000
		String str = psmt.toString();

		// str에서 공백을 찾아서 그 뒤 문자열을 잘라낸다.
		// ==> select * from city where population > 1000000
		String sql = str.substring(str.indexOf("PreparedStatement: ") + 19);
		
		// 브라우저에 sql문을 출력한다.
		out.println("<p>SQL : " + sql + "</p>");
	}
	
	// 정수값을 구분기호(",")가 포함된 문자열로 반환 
	public static String toFormatString(long val) {
		return df.format(val);
	}	
	
	// 타입이 정수형이면 true, 그렇기 않으면 false 반환
	private static boolean isIntegerType(int sqlType) {
	    return sqlType == Types.TINYINT || sqlType == Types.SMALLINT || sqlType == Types.INTEGER || sqlType == Types.BIGINT;
	}
	
	// 질의 결과를 테이블 형태로 출력
	public static void writeTableFromResultSet(JspWriter out, ResultSet rs) throws Exception {
		// 테이블 출력 시작
		out.println("<table>");
		
		// 질의 결과 메타 정보
		ResultSetMetaData md = rs.getMetaData();

		// 테이블 레코드 출력 시작
		out.println("\t<tr>");
		// 테이블 헤더들 출력
		// 질의 결과 테이블의 필드 수를 가져와서 반복 (1부터 시작)
		out.print("\t\t");
		for(int i = 1 ; i <= md.getColumnCount(); i++) {
			// 질의 결과 테이블의 i번째 필드명 출력
			out.print("<th>");
			out.print(md.getColumnName(i));
			out.print("</th>");
		}
		// 테이블 레코드 출력 종료
		out.println("\n\t</tr>");
		
		// 커서프로세싱 - 질의 결과 테이블 출력
		while(rs.next()) {
			// 테이블 레코드 출력 시작
			out.println("\t<tr>");
			// 질의 결과 테이블의 필드 수를 가져와서 반복 (1부터 시작)
			out.print("\t\t");
			for (int i = 1 ; i <= md.getColumnCount() ; i++) {
				// 테이블 데이터 출력
				out.print("<td>");
				if (isIntegerType(md.getColumnType(i))) {
					// 정수형이면 구분자를 포함한 문자열로 변환해서 출력
					out.print(MyUtil.toFormatString(rs.getLong(i)));
				} else {
					out.print(rs.getString(i));
				}
				out.print("</td>");
			}
			// 테이블 레코드 출력 종료
			out.println("\n\t</tr>");
		}
		// 테이블 출력 종료
		out.println("</table>");
	}
}
