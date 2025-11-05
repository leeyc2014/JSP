package fileupload;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.Collection;
import java.util.Enumeration;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet({"/RequestParser",				// RequestParserMain.jsp에서 호출할 때 URL
			"/13FileUpload/RequestParser"})	// /13FileUpload/FileUploadMain.jsp를 수정해서 호출할 때 URL
@MultipartConfig(
		maxFileSize = 1024*1024*10,		// 10M
		maxRequestSize = 1024*1024*50	// 50M
)
public class RequestParser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// 요청 라인 출력
	private void printGeneral(HttpServletRequest req, StringBuffer sb) {
		String method = req.getMethod().toUpperCase();
		String url = req.getRequestURL().toString();
		String qstr = req.getQueryString();
		String enctype = req.getContentType();
		if (enctype != null && enctype.contains("multipart"))
			enctype = "multipart/form-data";

		sb.append("<h3>요청 정보</h3>");
		sb.append("<hr/>");
		sb.append(method + " " + url);
        if (qstr != null && !qstr.isEmpty()) {
        	sb.append("?" + qstr);
        }
        sb.append(" " + req.getProtocol() + "<br/>");
        
        req.setAttribute("method", method);
        req.setAttribute("qstr", qstr);
        req.setAttribute("enctype", enctype);
        
        System.out.println("method:" + method);
        System.out.println("qstr:" + qstr);
        System.out.println("enctype:" + enctype);
	}

	// 요청 헤더 출력
	private String printHeaders(HttpServletRequest req, StringBuffer sb) {
		String bnd = "";
		Enumeration<String> headers = req.getHeaderNames();
		while(headers.hasMoreElements()) {
			String h = headers.nextElement();
			String v = req.getHeader(h);
			sb.append(h + ":" + v + "<br/>");

			if (h.equals("content-type") && v.contains("boundary=")) {
				String arr[] = v.split("boundary=");
				bnd = arr[1];
			}			
		}
		return bnd;
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		StringBuffer sb = new StringBuffer();
		String qstr = req.getQueryString();
		if (qstr != null) {
			printGeneral(req, sb);	// 요청 라인 출력
			printHeaders(req, sb);	// 요청 헤더 출력
		}
		req.setAttribute("returnmsg", sb.toString());
		req.getRequestDispatcher("/WEB-INF/RequestParserMain.jsp").forward(req,  resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		StringBuffer sb = new StringBuffer();
		printGeneral(req, sb);					// 요청 라인 출력
		String bnd = printHeaders(req, sb);		// 요청 헤더 출력 & 구분 문자열(boundary) 설정
		sb.append("<br/>");
		// 요청 본문 내용 출력
		String enctype = req.getContentType();
		if (enctype != null && enctype.toLowerCase().contains("multipart/form-data")) {
			// 파일 업로드 데이터 전송
			Collection<Part> parts = req.getParts();
			for(Part p : parts) {
				sb.append(bnd + "<br/>");
				sb.append("Content-Disposition: form-data; name=\"" + p.getName() + "\"");
				String submitName = p.getSubmittedFileName();
				if (submitName != null)
					sb.append(" filename=\"" + submitName + "\"");
				sb.append("<br/>");
				sb.append("Content-Type: application/octet-stream");
				sb.append("<br/>");
				sb.append("<br/>");
				sb.append(new String(p.getInputStream().readAllBytes()) + "<br/>");
			}
			sb.append(bnd + "<br/>");
		}
		else {
			// application/x-www-form-urlencoded : 기본 폼 데이터 전송
			// text/plain
			BufferedReader reader = req.getReader();
			String line;
			while ((line = reader.readLine()) != null) {
				sb.append(line + "<br/>");
			}
			reader.close();
		}
		req.setAttribute("returnmsg", sb.toString());
		req.getRequestDispatcher("/WEB-INF/RequestParserMain.jsp").forward(req,  resp);
	}
}
