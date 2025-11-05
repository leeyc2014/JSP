package fileupload;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;

public class FileUtil {
	// 파일 업로드
	public static String uploadFile(HttpServletRequest req, String sDirectory) throws ServletException, IOException {
		Part part = req.getPart("ofile");								// Part 객체를 통해 서버로 전송된 파일명 읽어 오기
		String partHeader = part.getHeader("content-disposition");		// Part 객체의 헤더값 중 content-disposition 읽어 오기
		System.out.println("partHeader=" + partHeader);					// partHeader=form-data; name="attachedFile"; filename="파일명.jpg"
		String[] phArr = partHeader.split("filename=");					// 헤어 문자열에서 "filename="을 기준으로 문자열 분리
		String originalFileName = phArr[1].trim().replace("\"", "");	// 분리된 문자열 배열에서 파일명 추출
		if(!originalFileName.isEmpty()) {
			part.write(sDirectory + File.separator + originalFileName); // 파일명이 있으면 디렉토리에 파일을 저장
		}
		return originalFileName;	// 파일명 반환
	}
	
	// 파일명 변경
	public static String renameFile(String sDirectory, String fileName) {
		String ext = fileName.substring(fileName.lastIndexOf("."));
		String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
		String newFileName = now + ext;
		File oldFile = new File(sDirectory + File.separator + fileName);
		File newFile = new File(sDirectory + File.separator + newFileName);
		oldFile.renameTo(newFile);
		
		return newFileName;
	}
	
	public static ArrayList<String> multipleFile(HttpServletRequest req, String sDirectory) throws ServletException, IOException {
		ArrayList<String> listFileName = new ArrayList<>();
		Collection<Part> parts = req.getParts();
		for(Part part : parts) {
			if(!part.getName().equals("ofile"))
				continue;
			
			String partHeader = part.getHeader("content-disposition");
			String[] phArr = partHeader.split("filename=");
			String originalFileName = phArr[1].trim().replace("\"", "");
			if(!originalFileName.isEmpty()) {
				part.write(sDirectory + File.separator + originalFileName);
			}
			listFileName.add(originalFileName);
		}
		return listFileName;
	}
}
