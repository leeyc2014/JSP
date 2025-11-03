package servlet;

import java.io.IOException;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebInitParam;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import membership.MemberDAO;
import membership.MemberDTO;

@WebServlet(urlPatterns = "/12Servlet/MemberAuth2.mvc",
			initParams = {
				@WebInitParam(name="admin_id", value="nakja"),
				@WebInitParam(name="admin_pw", value="1234")
			})
public class MemberAuth2 extends HttpServlet{
	private static final long serialVersionUID = 1L;
	MemberDAO dao;
	
	@Override
	public void init() throws ServletException {
		// application 내장 객체 얻기
		ServletContext application = this.getServletContext();
		
		// web.xml에서 DB 연결 정보 얻기
		String driver = application.getInitParameter("MySQLDriver");
		String connectUrl = application.getInitParameter("MySQLURL");
		String oId = application.getInitParameter("MySQLId");
		String oPass = application.getInitParameter("MySQLPwd");
		
		// DAO 생성
		dao = new MemberDAO(driver, connectUrl, oId, oPass);
	}
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 서브릿 초기화 매개변수에서 관리자 ID 받기
		String admin_id = this.getInitParameter("admin_id");
		
		// 인증을 요청한 ID/패스워드
		String id = req.getParameter("id");
		String pass = req.getParameter("pass");
		
		// 회원 테이블에서 인증 요청한 ID/패스워드에 해당하는 회원 찾기
		MemberDTO memberDTO = dao.getMemberDTO(id, pass);
		
		// 찾은 회원의 이름에 따른 처리
		String memberName = memberDTO.getName();
		if(memberName != null) {	// 일치하는 회원 찾음
			req.setAttribute("authMessage", memberName + " 회원님 방가방가^^*");
		}
		else {		// 일치하는 회원 없음
			if(admin_id.equals(id))		// 관리자
				req.setAttribute("authMessage", admin_id + "는 최고 관리자입니다.");
			else		//  비회원
				req.setAttribute("authMessage", "귀하는 회원이 아닙니다.");
		}
		req.getRequestDispatcher("/12Servlet/MemberAuth.jsp").forward(req, resp);
	}
	
	@Override
	public void destroy() {
		dao.close();
	}
}
