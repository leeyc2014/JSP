package fileupload;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/13FileUpload/DownloadProcess.do")

public class DownloadProcess extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String saveDirectory = getServletContext().getRealPath("/Uploads");
			String saveFilename = req.getParameter("sName");
			String originalFilename = req.getParameter("oName");
			// 파일을 찾아 입력 스트림 생성
			File file = new File(saveDirectory, saveFilename);
			InputStream inStream = new FileInputStream(file);
			
			// 한글 파일명 깨짐 방지
			originalFilename = new String(originalFilename.getBytes("UTF-8"), "ISO-8859-1");
			// 파일 다운로드용 응답 헤더 설정
			resp.reset();
			resp.setContentType("application/octet-stream");
			resp.setHeader("Content-Disposition", "attachment; filename=\"" + originalFilename + "\"");
			
			// response 내장 객체로부터 새로운 출력 스트림 생성
			OutputStream outStream = resp.getOutputStream();
			
			// 출력 스트림에 파일 내용 출력
			byte b[] = new byte[(int)file.length()];
			int readBuffer = 0;
			while((readBuffer = inStream.read(b)) > 0) {
				outStream.write(b, 0, readBuffer);
			}
			
			// 입/출력 스트림 닫음
			inStream.close();
			outStream.close();
		}
		catch(FileNotFoundException e) {
			System.out.println("파일을 찾을 수 없습니다.");
			e.printStackTrace();
		}
		catch(Exception e) {
			System.out.println("예외가 발생하였습니다.");
			e.printStackTrace();
		}
	}
}
